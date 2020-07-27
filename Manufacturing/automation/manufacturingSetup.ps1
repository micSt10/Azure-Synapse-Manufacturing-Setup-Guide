param (
    [Parameter(Mandatory = $false)][string]$iot_hub_car,
    [Parameter(Mandatory = $false)][string]$iot_hub_telemetry,
    [Parameter(Mandatory = $false)][string]$iot_hub,
    [Parameter(Mandatory = $false)][string]$iot_hub_sendtohub,
	[Parameter(Mandatory = $false)][string]$synapseWorkspaceName,
	[Parameter(Mandatory = $false)][string]$wsId,
	[Parameter(Mandatory = $false)][string]$sqlPoolName,
	[Parameter(Mandatory = $false)][string]$dataLakeAccountName,
	[Parameter(Mandatory = $false)][string]$sqlUser,
	[Parameter(Mandatory = $false)][string]$sqlPassword,
	[Parameter(Mandatory = $false)][string]$resourceGroup,
	[Parameter(Mandatory = $false)][string]$mfgasaName,
	[Parameter(Mandatory = $false)][string]$carasaName,
	[Parameter(Mandatory = $false)][string]$cosmos_account_name_mfgdemo,
	[Parameter(Mandatory = $false)][string]$cosmos_database_name_mfgdemo_manufacturing	
	)

# Install Az cli
Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'; rm .\AzureCLI.msi

#refresh environment variables
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")


# login using identity
az login --identity

#install iot hub extension
az extension add --name azure-cli-iot-ext

$subscriptionId=az account show|ConvertFrom-Json
$subscriptionId=$subscriptionId.Id
$global:logindomain = (Get-AzContext).Tenant.Id
$tokenValue = ((az account get-access-token --resource https://analysis.windows.net/powerbi/api) | ConvertFrom-Json).accessToken
$powerbitoken = $tokenValue;
$tokenValue = ((az account get-access-token --resource https://dev.azuresynapse.net) | ConvertFrom-Json).accessToken
$synapseToken = $tokenValue;

#Create iot hub devices
az iot hub device-identity create -n $iot_hub_car -d race-car
az iot hub device-identity create -n $iot_hub_telemetry -d telemetry-data
az iot hub device-identity create -n $iot_hub -d data-device
az iot hub device-identity create -n $iot_hub_sendtohub -d send-to-hub

#get connection strings

$iot_device_connection_car = az iot hub device-identity show-connection-string --hub-name $iot_hub_car --device-id race-car | Out-String | ConvertFrom-Json
Write-Host $iot_device_connection_car.connectionString

$iot_device_connection_telemetry = az iot hub device-identity show-connection-string --hub-name $iot_hub_telemetry --device-id telemetry-data | Out-String | ConvertFrom-Json
Write-Host $iot_device_connection_telemetry.connectionString

$iot_device_connection_sku2 = az iot hub device-identity show-connection-string --hub-name $iot_hub --device-id data-device | Out-String | ConvertFrom-Json
Write-Host $iot_device_connection_sku2.connectionString

$iot_device_connection_sendtohub = az iot hub device-identity show-connection-string --hub-name $iot_hub_sendtohub --device-id send-to-hub | Out-String | ConvertFrom-Json
Write-Host $iot_device_connection_sendtohub.connectionString

#download the binary zip folders

Invoke-WebRequest https://publicassetstoragexor.blob.core.windows.net/assets/carTelemetry.zip -OutFile carTelemetry.zip
#extract
expand-archive -path "./carTelemetry.zip" -destinationpath "./carTelemetry"

Invoke-WebRequest https://publicassetstoragexor.blob.core.windows.net/assets/Telemetry.zip -OutFile Telemetry.zip
#extract
expand-archive -path "./Telemetry.zip" -destinationpath "./Telemetry"

Invoke-WebRequest https://publicassetstoragexor.blob.core.windows.net/assets/sku2.zip -OutFile sku2.zip
#extract
expand-archive -path "./sku2.zip" -destinationpath "./sku2"

Invoke-WebRequest https://publicassetstoragexor.blob.core.windows.net/assets/sendtohub.zip -OutFile sendtohub.zip
#extract
expand-archive -path "./sendtohub.zip" -destinationpath "./sendtohub"

Invoke-WebRequest https://publicassetstoragexor.blob.core.windows.net/assets/artifacts.zip -OutFile artifacts.zip
#extract
expand-archive -path "./artifacts.zip" -destinationpath "./artifacts"

#Replace connection string in config
(Get-Content -path carTelemetry/App.config -Raw) | Foreach-Object { $_ `
                -replace '#connection_string#', $iot_device_connection_car.connectionString`	
        } | Set-Content -Path carTelemetry/App.config
		
(Get-Content -path Telemetry/appsettings.json -Raw) | Foreach-Object { $_ `
                -replace '#connection_string#', $iot_device_connection_telemetry.connectionString`	
        } | Set-Content -Path Telemetry/appsettings.json
		
(Get-Content -path sku2/appsettings.json -Raw) | Foreach-Object { $_ `
                -replace '#connection_string#', $iot_device_connection_sku2.connectionString`	
        } | Set-Content -Path sku2/appsettings.json
		
(Get-Content -path sendtohub/App.config -Raw) | Foreach-Object { $_ `
                -replace '#connection_string#', $iot_device_connection_sendtohub.connectionString`	
        } | Set-Content -Path sendtohub/App.config

#run the 4 codes on the vm
cd carTelemetry
start-process SendMessageToIoTHub.exe
cd ..
cd sendtohub
start-process SendMessageToIoTHub.exe
cd ..
cd sku2
start-process DataGenerator.exe
cd ..
cd Telemetry
start-process DataGenerator.exe
cd ..

 




#connecting asa and powerbi
$principal=az resource show -g $resourceGroup -n $mfgasaName --resource-type "Microsoft.StreamAnalytics/streamingjobs"|ConvertFrom-Json
$principalId=$principal.identity.principalId
$uri="https://api.powerbi.com/v1.0/myorg/admin/groups/$wsId/users"
$body=@"
{
  "identifier": "$principalId",
  "principalType": "App",
  "groupUserAccessRight": "Admin"
}
"@
$result = Invoke-RestMethod  -Uri $uri -Method PUT -Body $body -Headers @{ Authorization="Bearer $synapseToken" } -ContentType "application/json"

$principal=az resource show -g $resourceGroup -n $raceasaName --resource-type "Microsoft.StreamAnalytics/streamingjobs"|ConvertFrom-Json
$principalId=$principal.identity.principalId
$uri="https://api.powerbi.com/v1.0/myorg/admin/groups/$wsId/users"
$body=@"
{
  "identifier": "$principalId",
  "principalType": "App",
  "groupUserAccessRight": "Admin"
}
"@
$result = Invoke-RestMethod  -Uri $uri -Method PUT -Body $body -Headers @{ Authorization="Bearer $synapseToken" } -ContentType "application/json"

#Creating spark notebooks
Write-Information "Creating Spark notebooks..."
$notebooks=Get-ChildItem "./artifacts/notebooks" | Select BaseName 
$cellParams = [ordered]@{
        "#SQL_POOL_NAME#"       = $sqlPoolName
        "#SUBSCRIPTION_ID#"     = $subscriptionId
        "#RESOURCE_GROUP_NAME#" = $resourceGroupName
        "#WORKSPACE_NAME#"  = $synapseWorkspaceName
        "#DATA_LAKE_NAME#" = $dataLakeAccountName
}
foreach($name in $notebooks)
	{
		$template=Get-Content -Raw -Path "./artifacts/templates/spark_notebook.json"
		foreach ($paramName in $cellParams.Keys) {
			$template = $template.Replace($paramName, $cellParams[$paramName])
		}
		$jsonItem = ConvertFrom-Json $template
	    $path="./artifacts/notebooks/"+$name+".ipynb"
		$notebook=Get-Content -Raw -Path $path
		$jsonNotebook = ConvertFrom-Json $notebook
		$jsonItem.properties.cells = $jsonNotebook.cells
		if ($CellParams) {
        foreach ($cellParamName in $cellParams.Keys) {
            foreach ($cell in $jsonItem.properties.cells) {
                for ($i = 0; $i -lt $cell.source.Count; $i++) {
                    $cell.source[$i] = $cell.source[$i].Replace($cellParamName, $CellParams[$cellParamName])
                }
            }
        }
    }
	$item = ConvertTo-Json $jsonItem -Depth 100
		$uri = "https://$($synapseWorkspaceName).dev.azuresynapse.net/notebooks/$($name)?api-version=2019-06-01-preview"
		$result = Invoke-RestMethod  -Uri $uri -Method PUT -Body $item -Headers @{ Authorization="Bearer $synapseToken" } -ContentType "application/json"
		#$result = Wait-ForOperation -WorkspaceName $workspaceName -OperationId $result.operationId
	}	



#creating sql schema
Write-Information "Create tables in $($sqlPoolName)"
$SQLScriptsPath="./artifacts/sqlscripts"
$sqlQuery = Get-Content -Raw -Path "$($SQLScriptsPath)/tableschema.sql"
$sqlEndpoint="$($synapseWorkspaceName).sql.azuresynapse.net"

$result=Invoke-SqlCmd -Query $sqlQuery -ServerInstance $sqlEndpoint -Database $sqlPoolName -Username $sqlUser -Password $sqlPassword


#creating Dataflows
$params = @{
        LOAD_TO_SYNAPSE = "AzureSynapseAnalyticsTable8"
        LOAD_TO_AZURE_SYNAPSE = "AzureSynapseAnalyticsTable9"
        DATA_FROM_SAP_HANA = "DelimitedText1"
}
$workloadDataflows = [ordered]@{
        ingest_data_from_sap_hana_to_azure_synapse = "ingest_data_from_sap_hana_to_azure_synapse"
}
$DataflowPath="./artifacts/dataflows"
foreach ($dataflow in $workloadDataflows.Keys) {
$Name=$workloadDataflows[$dataflow]
        Write-Information "Creating dataflow $($workloadDataflows[$dataflow])"
		 $item = Get-Content -Path "$($DataflowPath)/$($Name).json"
    
    if ($params -ne $null) {
        foreach ($key in $params.Keys) {
            $item = $item.Replace("#$($key)#", $params[$key])
        }
    }
	$uri = "https://$($synapseWorkspaceName).dev.azuresynapse.net/dataflows/$($Name)?api-version=2019-06-01-preview"
		 $result = Invoke-RestMethod  -Uri $uri -Method PUT -Body $item -Headers @{ Authorization="Bearer $synapseToken" } -ContentType "application/json"
        #Wait-ForOperation -WorkspaceName $workspaceName -OperationId $result.operationId
}

#uploading powerbi reports
Write-Information "Uploading power BI reports"
Connect-PowerBIServiceAccount
$reportList = New-Object System.Collections.ArrayList

 

$reportList.Add($temp)
$reports=Get-ChildItem "./artifacts/reports" | Select BaseName 
foreach($name in $reports)
{
        $FilePath="./artifacts/reports/"+$name+".pbix"
        #New-PowerBIReport -Path $FilePath -Name $name -WorkspaceId $wsId
        
        #write-host "Uploading PowerBI Report $name";
        $url = "https://api.powerbi.com/v1.0/myorg/groups/$wsId/imports?datasetDisplayName=$name&nameConflict=CreateOrOverwrite";
        $fileBytes = [System.IO.File]::ReadAllBytes($FilePath);
        $fileEnc = [system.text.encoding]::GetEncoding("ISO-8859-1").GetString($fileBytes);
        $boundary = [System.Guid]::NewGuid().ToString();
        $LF = "`r`n";
        $bodyLines = (
        "--$boundary",
        "Content-Disposition: form-data",
        "",
        $fileEnc,
        "--$boundary--$LF"
        ) -join $LF
        $result = Invoke-RestMethod -Uri $url -Method POST -Body $bodyLines -ContentType "multipart/form-data; boundary=`"$boundary`"" -Headers @{ Authorization="Bearer $powerbitoken" }
        #$reportId = $result.id;
        
        $temp = "" | select-object @{Name = "Name"; Expression = {$name}}, 
                                @{Name = "PowerBIDataSetId"; Expression = {""}},
                                @{Name = "SourceServer"; Expression = {"cdpvisionworkspace.sql.azuresynapse.net"}}, 
                                @{Name = "SourceDatabase"; Expression = {"AzureSynapseDW"}}
                                
        # get dataset                         
        $url = "https://api.powerbi.com/v1.0/myorg/groups/$wsid/datasets";
        $dataSets = Invoke-RestMethod -Uri $url -Method GET -Headers @{ Authorization="Bearer $powerbitoken" };
        foreach($res in $dataSets.value)
        {
        if($set.name -eq $name)
        {
            $temp.PowerBIDataSetId= $set.id;
        }
       }
                
        $reportList.Add($temp)
        Start-Sleep -s 5    
        
}



#creating Pipelines
Write-Information "Creating pipelines"
$pipelines=Get-ChildItem "./artifacts/reports" | Select BaseName
$pipelineList = New-Object System.Collections.ArrayList

$pipelineList.Add($temp)
foreach($name in $pipelines)
{
	$FilePath="./artifacts/pipelines/"+$name+".json"
	$temp = "" | select-object @{Name = "FileName"; Expression = {$name}} , @{Name = "Name"; Expression = {$name.ToUpper()}}, @{Name = "PowerBIReportName"; Expression = {""}}
	$pipelineList.Add($temp)
	 $item = Get-Content -Path $FilePath
	 $item=$item.Replace("#DATA_LAKE_STORAGE_NAME #",$dataLakeAccountName)
	 $defaultStorage=$synapseWorkspaceName + "-WorkspaceDefaultStorage"
	 $item=$item.Replace("#DEFAULT_STORAGE  #",$defaultStorage)
	 $uri = "https://$($synapseWorkspaceName).dev.azuresynapse.net/pipelines/$($name)?api-version=2019-06-01-preview"
     $result = Invoke-RestMethod  -Uri $uri -Method PUT -Body $item -Headers @{ Authorization="Bearer $synapseToken" } -ContentType "application/json"
	 #Wait-ForOperation -WorkspaceName $workspaceName -OperationId $result.operationId
	 
}



#Establish powerbi reports dataset connections
Write-Information "Uploading power BI reports"	
$powerBIDataSetConnectionTemplate = Get-Content -Path "./artifacts/templates/powerbi_dataset_connection.json"
$powerBIDataSetConnectionUpdateRequest = $powerBIDataSetConnectionTemplate.Replace("#TARGET_SERVER#", "$($synapseWorkspaceName).sql.azuresynapse.net").Replace("#TARGET_DATABASE#", $sqlPoolName) |Out-String
foreach($report in $reportList)
{
   Write-Information "Setting database connection for $($report.Name)"
   $powerBIReportDataSetConnectionUpdateRequest = $powerBIDataSetConnectionUpdateRequest.Replace("#SOURCE_SERVER#", $powerBIReport.SourceServer).Replace("#SOURCE_DATABASE#", $powerBIReport.SourceDatabase) |Out-String
   $url = "https://api.powerbi.com/v1.0/myorg/groups/$wsid/datasets/$report.PowerBIDataSetId/Default.UpdateDatasources";
    $result = Invoke-RestMethod -Uri $url -Method POST -Body $powerBIReportDataSetConnectionUpdateRequest -ContentType "application/json" -Headers @{ Authorization="Bearer $powerbitoken" };
   
}






