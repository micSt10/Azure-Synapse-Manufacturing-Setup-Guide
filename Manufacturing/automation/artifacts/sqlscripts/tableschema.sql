
/****** Object:  Table [dbo].[Anomaly Detection XYZ Job Movement Data]    Script Date: 8/30/2020 11:35:32 AM ******/
SET ANSI_NULLS ON
GO 
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Anomaly Detection XYZ Job Movement Data]
(
              [Date_Time] [nvarchar](4000) NULL,
              [X-Axis Job Movement ] [nvarchar](4000) NULL,
              [Y-Axis Job Movement ] [nvarchar](4000) NULL,
              [Z-Axis Job Movement ] [nvarchar](4000) NULL,
              [Longitude] [nvarchar](4000) NULL,
              [Latitude] [nvarchar](4000) NULL,
              [InstanceNum] [nvarchar](4000) NULL,
              [PC1] [nvarchar](4000) NULL,
              [PC2] [nvarchar](4000) NULL,
              [Anomaly Detected ] [nvarchar](4000) NULL,
              [Scored Probabilities] [nvarchar](4000) NULL,
              [X-Movement] [nvarchar](4000) NULL,
              [Y-Movement] [nvarchar](4000) NULL,
              [Z-Movement] [nvarchar](4000) NULL,
              [url] [nvarchar](4000) NULL,
              [Location] [nvarchar](4000) NULL,
              [Row Num] [nvarchar](4000) NULL,
              [Probability Goal] [nvarchar](4000) NULL
)
WITH
(
              DISTRIBUTION = ROUND_ROBIN,
              CLUSTERED COLUMNSTORE INDEX
)
GO

/****** Object:  Table [dbo].[Campaign]    Script Date: 8/30/2020 11:35:35 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Campaign]
(
              [ID] [int] NOT NULL,
              [CampaignName] [varchar](50) NULL,
              [CampaignLaunchDate] [varchar](50) NULL,
              [SortOrder] [int] NULL,
              [RevenueTarget] [varchar](50) NULL
)
WITH
(
              DISTRIBUTION = ROUND_ROBIN,
              CLUSTERED COLUMNSTORE INDEX
)
GO

/****** Object:  Table [dbo].[CampaignData]    Script Date: 8/30/2020 11:35:36 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CampaignData]
(
              [ID] [bigint] NOT NULL,
              [CampaignName] [varchar](18) NOT NULL,
              [CampaignTactic] [varchar](16) NOT NULL,
              [CampaignStartDate] [datetime] NULL,
              [Expense] [decimal](10, 2) NULL,
              [MarketingCost] [decimal](10, 2) NULL,
              [Profit] [decimal](10, 2) NULL,
              [LocationID] [bigint] NULL,
              [Revenue] [decimal](10, 2) NULL,
              [RevenueTarget] [decimal](10, 2) NULL,
              [ROI] [decimal](10, 2) NULL,
              [Status] [varchar](13) NOT NULL,
              [ProductID] [bigint] NULL,
              [Sentiment] [nvarchar](20) NULL,
              [Response] [bigint] NULL,
              [CampaignID] [bigint] NULL,
              [CampaignRowKey] [bigint] NOT NULL
)
WITH
(
              DISTRIBUTION = ROUND_ROBIN,
              CLUSTERED COLUMNSTORE INDEX
)
GO

/****** Object:  Table [dbo].[CampaignData_Bubble]    Script Date: 8/30/2020 11:35:38 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CampaignData_Bubble]
(
              [ID] [int] NOT NULL,
              [CampaignName] [varchar](18) NOT NULL,
              [CampaignTactic] [varchar](16) NOT NULL,
              [Expense] [int] NOT NULL,
              [MarketingCost] [int] NOT NULL,
              [Profit] [int] NOT NULL,
              [LocationID] [int] NOT NULL,
              [Revenue] [numeric](9, 1) NOT NULL,
              [RevenueTarget] [int] NOT NULL,
              [ROI] [numeric](11, 5) NOT NULL,
              [Status] [varchar](13) NOT NULL,
              [ProductID] [int] NOT NULL,
              [Sentiment] [varchar](8) NOT NULL,
              [Response] [varchar](4) NOT NULL,
              [CampaignStartDate] [datetime] NULL
)
WITH
(
              DISTRIBUTION = ROUND_ROBIN,
              CLUSTERED COLUMNSTORE INDEX
)
GO

/****** Object:  Table [dbo].[CampaignData_exl]    Script Date: 8/30/2020 11:35:41 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CampaignData_exl]
(
              [ID] [nvarchar](4000) NULL,
              [CampaignName] [nvarchar](4000) NULL,
              [CampaignTactic] [nvarchar](4000) NULL,
              [CampaignStartDate] [nvarchar](4000) NULL,
              [Expense] [nvarchar](4000) NULL,
              [MarketingCost] [nvarchar](4000) NULL,
              [Profit] [nvarchar](4000) NULL,
              [LocationID] [nvarchar](4000) NULL,
              [Revenue] [nvarchar](4000) NULL,
              [RevenueTarget] [nvarchar](4000) NULL,
              [ROI] [nvarchar](4000) NULL,
              [Status] [nvarchar](4000) NULL,
              [ProductID] [nvarchar](4000) NULL,
              [Sentiment] [nvarchar](4000) NULL,
              [Response] [nvarchar](4000) NULL
)
WITH
(
              DISTRIBUTION = ROUND_ROBIN,
              CLUSTERED COLUMNSTORE INDEX
)
GO

/****** Object:  Table [dbo].[Campaignproducts]    Script Date: 8/30/2020 11:35:43 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Campaignproducts]
(
              [Campaign] [varchar](250) NULL,
              [ProductCategory] [varchar](250) NULL,
              [Hashtag] [varchar](250) NULL,
              [Counts] [varchar](250) NULL,
              [ProductID] [int] NULL,
              [CampaignRowKey] [bigint] NULL,
              [SelectedFlag] [varchar](40) NULL,
              [Sentiment] [varchar](20) NULL
)
WITH
(
              DISTRIBUTION = ROUND_ROBIN,
              CLUSTERED COLUMNSTORE INDEX
)
GO

/****** Object:  Table [dbo].[Campaignsales]    Script Date: 8/30/2020 11:35:44 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Campaignsales]
(
              [Date] [datetime] NOT NULL,
              [CustomerId] [bigint] NOT NULL,
              [DeliveryDate] [datetime] NULL,
              [ProductId] [bigint] NOT NULL,
              [Quantity] [decimal](18, 2) NOT NULL,
              [UnitPrice] [decimal](18, 2) NOT NULL,
              [TaxAmount] [decimal](18, 2) NOT NULL,
              [TotalExcludingTax] [decimal](18, 2) NOT NULL,
              [TotalIncludingTax] [decimal](18, 2) NOT NULL,
              [GrossPrice] [decimal](18, 2) NOT NULL,
              [Discount] [decimal](18, 2) NOT NULL,
              [NetPrice] [decimal](18, 2) NOT NULL,
              [GrossRevenue] [decimal](18, 2) NOT NULL,
              [NetRevenue] [decimal](18, 2) NOT NULL,
              [COGS_PER] [decimal](18, 2) NOT NULL,
              [COGS] [decimal](18, 2) NOT NULL,
              [GrossProfit] [decimal](18, 2) NOT NULL,
              [CampaignRowKey] [bigint] NULL
)
WITH
(
              DISTRIBUTION = HASH ( [ProductId] ),
              CLUSTERED COLUMNSTORE INDEX
)
GO

/****** Object:  Table [dbo].[Customer]    Script Date: 8/30/2020 11:35:47 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Customer]
(
              [Id] [bigint] NULL,
              [Age] [smallint] NULL,
              [Gender] [nvarchar](4000) NULL,
              [Pincode] [nvarchar](4000) NULL,
              [FirstName] [nvarchar](4000) NULL,
              [LastName] [nvarchar](4000) NULL,
              [FullName] [nvarchar](4000) NULL,
              [DateOfBirth] [nvarchar](4000) NULL,
              [Address] [nvarchar](4000) NULL,
              [Email] [nvarchar](4000) NULL,
              [Mobile] [nvarchar](4000) NULL,
              [UserName] [nvarchar](4000) NULL,
              [Customer_type] [varchar](3) NULL
)
WITH
(
              DISTRIBUTION = ROUND_ROBIN,
              CLUSTERED COLUMNSTORE INDEX
)
GO

/****** Object:  Table [dbo].[Date]    Script Date: 8/30/2020 11:35:49 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Date]
(
              [Date] [date] NULL,
              [Day] [int] NULL,
              [DaySuffix] [char](2) NULL,
              [DayName] [nvarchar](30) NULL,
              [DayOfWeek] [int] NULL,
              [DayOfWeekInMonth] [tinyint] NULL,
              [DayOfYear] [int] NULL,
              [IsWeekend] [int] NOT NULL,
              [Week] [int] NULL,
              [ISOweek] [int] NULL,
              [FirstOfWeek] [date] NULL,
              [LastOfWeek] [date] NULL,
              [WeekOfMonth] [tinyint] NULL,
              [Month] [int] NULL,
              [MonthName] [nvarchar](30) NULL,
              [FirstOfMonth] [date] NULL,
              [LastOfMonth] [date] NULL,
              [FirstOfNextMonth] [date] NULL,
              [LastOfNextMonth] [date] NULL,
              [Quarter] [int] NULL,
              [FirstOfQuarter] [date] NULL,
              [LastOfQuarter] [date] NULL,
              [Year] [int] NULL,
              [ISOYear] [int] NULL,
              [FirstOfYear] [date] NULL,
              [LastOfYear] [date] NULL,
              [IsLeapYear] [bit] NULL,
              [Has53Weeks] [int] NOT NULL,
              [Has53ISOWeeks] [int] NOT NULL,
              [MonthNumber] [int] NULL,
              [DateKey] [int] NULL
)
WITH
(
              DISTRIBUTION = ROUND_ROBIN,
              CLUSTERED COLUMNSTORE INDEX
)
GO

/****** Object:  Table [dbo].[FactoryOverviewTable]    Script Date: 8/30/2020 11:35:54 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[FactoryOverviewTable]
(
              [Prop_0] [nvarchar](4000) NULL,
              [Prop_1] [nvarchar](4000) NULL
)
WITH
(
              DISTRIBUTION = ROUND_ROBIN,
              CLUSTERED COLUMNSTORE INDEX
)
GO

/****** Object:  Table [dbo].[historical-data-adf]    Script Date: 8/30/2020 11:35:55 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[historical-data-adf]
(
              [Timestamp] [datetime] NULL,
              [Power] [float] NULL,
              [Temperature] [float] NULL,
              [SuctionPressure] [float] NULL,
              [Vibration] [float] NULL,
              [DischargePressure] [float] NULL,
              [VibrationVelocity] [float] NULL,
              [VibrationAcceleration] [float] NULL,
              [AnomalyDischargeCavitation] [float] NULL,
              [AnomalySealFailure] [float] NULL,
              [AnomalyCouplingFailure] [float] NULL
)
WITH
(
              DISTRIBUTION = ROUND_ROBIN,
              CLUSTERED COLUMNSTORE INDEX
)
GO

/****** Object:  Table [dbo].[Incident Probabilities Rio and Stuttgart]    Script Date: 8/30/2020 11:35:56 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Incident Probabilities Rio and Stuttgart]
(
              [FactoryName] [nvarchar](4000) NULL,
              [FactoryLocation] [nvarchar](4000) NULL,
              [AreaName] [nvarchar](4000) NULL,
              [FloorName] [nvarchar](4000) NULL,
              [Score] [nvarchar](4000) NULL,
              [P_Incident] [nvarchar](4000) NULL,
              [Risk Category] [nvarchar](4000) NULL,
              [Goal] [nvarchar](4000) NULL
)
WITH
(
              DISTRIBUTION = ROUND_ROBIN,
              CLUSTERED COLUMNSTORE INDEX
)
GO

/****** Object:  Table [dbo].[jobquality]    Script Date: 8/30/2020 11:35:58 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[jobquality]
(
              [jobId] [nvarchar](50) NULL,
              [good] [int] NULL,
              [snag] [int] NULL,
              [reject] [int] NULL,
              [timestamp] [datetime] NULL
)
WITH
(
              DISTRIBUTION = ROUND_ROBIN,
              CLUSTERED COLUMNSTORE INDEX
)
GO

/****** Object:  Table [dbo].[Location]    Script Date: 8/30/2020 11:35:59 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Location]
(
              [LocationId] [bigint] NULL,
              [LocationCode] [varchar](10) NULL,
              [LocationName] [varchar](2000) NULL,
              [Country] [nvarchar](50) NULL,
              [Region] [varchar](50) NULL
)
WITH
(
              DISTRIBUTION = ROUND_ROBIN,
              CLUSTERED COLUMNSTORE INDEX
)
GO

/****** Object:  Table [dbo].[mfg-AlertAlarm]    Script Date: 8/30/2020 11:36:00 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[mfg-AlertAlarm]
(
              [AlarmCodeId] [bigint] NOT NULL,
              [AlarmCode] [varchar](2000) NULL,
              [AlarmType] [varchar](2000) NULL,
              [Severity] [varchar](2000) NULL,
              [Description] [varchar](2000) NULL
)
WITH
(
              DISTRIBUTION = HASH ( [AlarmCodeId] ),
              CLUSTERED COLUMNSTORE INDEX
)
GO

/****** Object:  Table [dbo].[mfg-iot-lathe-peck-drill]    Script Date: 8/30/2020 11:36:01 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[mfg-iot-lathe-peck-drill]
(
              [EpochTime] [bigint] NULL,
              [StringDateTime] [varchar](50) NULL,
              [JobCode] [varchar](200) NULL,
              [OperationId] [int] NULL,
              [BatchCode] [varchar](2000) NULL,
              [MachineCode] [varchar](2000) NULL,
              [VibrationX] [float] NULL,
              [VibrationY] [float] NULL,
              [VibrationZ] [float] NULL,
              [SpindleSpeed] [bigint] NULL,
              [CoolantTemperature] [bigint] NULL,
              [zAxis] [float] NULL,
              [EventProcessedUtcTime] [datetime] NULL,
              [PartitionId] [bigint] NULL,
              [EventEnqueuedUtcTime] [datetime] NULL
)
WITH
(
              DISTRIBUTION = ROUND_ROBIN,
              CLUSTERED COLUMNSTORE INDEX
)
GO

ALTER TABLE [dbo].[Campaignproducts] ADD  DEFAULT ((0)) FOR [SelectedFlag]
GO


/****** Object:  Table [dbo].[mfg-iot-lathe-thread-cut]    Script Date: 8/30/2020 11:37:56 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[mfg-iot-lathe-thread-cut]
(
              [EpochTime] [bigint] NULL,
              [StringDateTime] [varchar](50) NULL,
              [JobCode] [varchar](200) NULL,
              [OperationId] [int] NULL,
              [BatchCode] [varchar](2000) NULL,
              [MachineCode] [varchar](2000) NULL,
              [VibrationX] [float] NULL,
              [VibrationY] [float] NULL,
              [VibrationZ] [float] NULL,
              [SpindleSpeed] [bigint] NULL,
              [CoolantTemperature] [bigint] NULL,
              [xAxis] [float] NULL,
              [zAxis] [float] NULL,
              [EventProcessedUtcTime] [datetime] NULL,
              [PartitionId] [bigint] NULL,
              [EventEnqueuedUtcTime] [datetime] NULL
)
WITH
(
              DISTRIBUTION = ROUND_ROBIN,
              CLUSTERED COLUMNSTORE INDEX
)
GO

/****** Object:  Table [dbo].[mfg-iot-milling-canning]    Script Date: 8/30/2020 11:37:59 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[mfg-iot-milling-canning]
(
              [EpochTime] [bigint] NULL,
              [StringDateTime] [varchar](50) NULL,
              [JobCode] [varchar](200) NULL,
              [OperationId] [int] NULL,
              [BatchCode] [varchar](2000) NULL,
              [MachineCode] [varchar](2000) NULL,
              [VibrationX] [float] NULL,
              [VibrationY] [float] NULL,
              [VibrationZ] [float] NULL,
              [SpindleSpeed] [bigint] NULL,
              [CoolantTemperature] [bigint] NULL,
              [xAxis] [float] NULL,
              [yAxis] [float] NULL,
              [zAxis] [float] NULL,
              [EventProcessedUtcTime] [datetime] NULL,
              [PartitionId] [bigint] NULL,
              [EventEnqueuedUtcTime] [datetime] NULL,
              [AnomalyTemperature] [bigint] NULL
)
WITH
(
              DISTRIBUTION = ROUND_ROBIN,
              CLUSTERED COLUMNSTORE INDEX
)
GO

/****** Object:  Table [dbo].[mfg-Location]    Script Date: 8/30/2020 11:38:01 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[mfg-Location]
(
              [LocationId] [bigint] NOT NULL,
              [LocationCode] [varchar](10) NULL,
              [LocationName] [varchar](2000) NULL,
              [Country] [nvarchar](50) NULL
)
WITH
(
              DISTRIBUTION = HASH ( [LocationId] ),
              CLUSTERED COLUMNSTORE INDEX
)
GO

/****** Object:  Table [dbo].[mfg-MachineAlert]    Script Date: 8/30/2020 11:38:02 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[mfg-MachineAlert]
(
              [RaisedTime] [datetime] NULL,
              [ClearedTime] [datetime] NULL,
              [JobCode] [varchar](100) NULL,
              [OperationId] [int] NULL,
              [MachineCode] [varchar](2000) NULL,
              [BatchCode] [varchar](2000) NULL,
              [AlarmCodeId] [bigint] NULL
)
WITH
(
              DISTRIBUTION = HASH ( [BatchCode] ),
              CLUSTERED COLUMNSTORE INDEX
)
GO

/****** Object:  Table [dbo].[mfg-OEE]    Script Date: 8/30/2020 11:38:03 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[mfg-OEE]
(
              [OEEId] [bigint] NULL,
              [Date] [datetime] NULL,
              [LocationId] [bigint] NULL,
              [Availability] [decimal](5, 2) NULL,
              [Performance] [decimal](5, 2) NULL,
              [Quality] [decimal](5, 2) NULL,
              [OEE] [decimal](5, 2) NULL
)
WITH
(
              DISTRIBUTION = ROUND_ROBIN,
              CLUSTERED COLUMNSTORE INDEX
)
GO

/****** Object:  Table [dbo].[mfg-OEE-Agg]    Script Date: 8/30/2020 11:38:05 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[mfg-OEE-Agg]
(
              [Date] [nvarchar](4000) NULL,
              [LocationID] [int] NULL,
              [Availability] [float] NULL,
              [Performance] [float] NULL,
              [Quality] [float] NULL,
              [OEE] [float] NULL
)
WITH
(
              DISTRIBUTION = ROUND_ROBIN,
              CLUSTERED COLUMNSTORE INDEX
)
GO

/****** Object:  Table [dbo].[mfg-ProductQuality]    Script Date: 8/30/2020 11:38:06 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[mfg-ProductQuality]
(
              [SKUs] [nvarchar](50) NULL,
              [good] [int] NULL,
              [snag] [int] NULL,
              [reject] [int] NULL,
              [OrderQty] [int] NULL
)
WITH
(
              DISTRIBUTION = ROUND_ROBIN,
              CLUSTERED COLUMNSTORE INDEX
)
GO

/****** Object:  Table [dbo].[MSFT mfg demo]    Script Date: 8/30/2020 11:38:07 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[MSFT mfg demo]
(
              [Timestamp] [nvarchar](4000) NULL,
              [Power] [nvarchar](4000) NULL,
              [Temperature] [nvarchar](4000) NULL,
              [SuctionPressure] [nvarchar](4000) NULL,
              [Vibration] [nvarchar](4000) NULL,
              [DischargePressure] [nvarchar](4000) NULL,
              [VibrationVelocity] [nvarchar](4000) NULL,
              [VibrationAcceleration] [nvarchar](4000) NULL,
              [AnomalyDischargeCavitation] [nvarchar](4000) NULL,
              [AnomalySealFailure] [nvarchar](4000) NULL,
              [AnomalyCouplingFailure] [nvarchar](4000) NULL,
              [UpdatedDate] [nvarchar](4000) NULL,
              [Date] [nvarchar](4000) NULL
)
WITH
(
              DISTRIBUTION = ROUND_ROBIN,
              CLUSTERED COLUMNSTORE INDEX
)
GO

/****** Object:  Table [dbo].[OperationsCaseData]    Script Date: 8/30/2020 11:38:09 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[OperationsCaseData]
(
              [City] [nvarchar](4000) NULL,
              [CasesCreated] [nvarchar](4000) NULL,
              [CasesResolved] [nvarchar](4000) NULL,
              [CasesCancelled] [nvarchar](4000) NULL,
              [CasesPending] [nvarchar](4000) NULL,
              [SLACompliance] [nvarchar](4000) NULL,
              [SLANonCompliance] [nvarchar](4000) NULL
)
WITH
(
              DISTRIBUTION = ROUND_ROBIN,
              CLUSTERED COLUMNSTORE INDEX
)
GO

/****** Object:  Table [dbo].[Product]    Script Date: 8/30/2020 11:38:10 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Product]
(
              [ProductID] [int] NOT NULL,
              [ProductCode] [nvarchar](50) NULL,
              [BarCode] [nvarchar](23) NULL,
              [Name] [nvarchar](100) NULL,
              [Description] [nvarchar](500) NULL,
              [Price] [decimal](10, 2) NULL,
              [Category] [nvarchar](20) NULL,
              [Thumbnail_FileName] [nvarchar](500) NULL,
              [AdImage_FileName] [nvarchar](500) NULL,
              [SoundFile_FileName] [nvarchar](500) NULL,
              [CreatedDate] [varchar](500) NULL,
              [Dimensions] [nvarchar](50) NULL,
              [Colour] [nvarchar](50) NULL,
              [Weight] [decimal](10, 2) NULL,
              [MaxLoad] [decimal](10, 2) NULL,
              [BasePrice] [int] NULL,
              [id] [int] NULL,
              [TaxRate] [int] NULL,
              [SellingPrice] [decimal](18, 2) NULL,
              [COGS_PER] [int] NULL
)
WITH
(
              DISTRIBUTION = ROUND_ROBIN,
              CLUSTERED COLUMNSTORE INDEX
)
GO

/****** Object:  Table [dbo].[Sales]    Script Date: 8/30/2020 11:38:13 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Sales]
(
              [Date] [date] NOT NULL,
              [CustomerId] [bigint] NOT NULL,
              [DeliveryDate] [date] NULL,
              [ProductId] [bigint] NULL,
              [Quantity] [decimal](18, 2) NOT NULL,
              [UnitPrice] [decimal](18, 2) NOT NULL,
              [TaxAmount] [decimal](18, 2) NOT NULL,
              [TotalExcludingTax] [decimal](18, 2) NOT NULL,
              [TotalIncludingTax] [decimal](18, 2) NOT NULL,
              [GrossPrice] [decimal](18, 2) NOT NULL,
              [Discount] [decimal](18, 2) NOT NULL,
              [NetPrice] [decimal](18, 2) NOT NULL,
              [GrossRevenue] [decimal](18, 2) NOT NULL,
              [NetRevenue] [decimal](18, 2) NOT NULL,
              [COGS_PER] [decimal](18, 2) NOT NULL,
              [COGS] [decimal](18, 2) NOT NULL,
              [GrossProfit] [decimal](18, 2) NOT NULL,
              [OrderKey] [nvarchar](50) NULL,
              [SaleKey] [nvarchar](100) NULL
)
WITH
(
              DISTRIBUTION = HASH ( [CustomerId] ),
              CLUSTERED COLUMNSTORE INDEX
)
GO

/****** Object:  Table [dbo].[vCampaignSales]    Script Date: 8/30/2020 11:38:17 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[vCampaignSales]
(
              [Year] [int] NULL,
              [Month] [int] NULL,
              [MonthName] [nvarchar](30) NULL,
              [CampaignRowKey] [int] NULL,
              [Profit] [decimal](38, 2) NULL,
              [Revenue] [decimal](38, 2) NULL,
              [QuantitySold] [decimal](38, 2) NULL,
              [cb] [bigint] NULL
)
WITH
(
              DISTRIBUTION = ROUND_ROBIN,
              CLUSTERED COLUMNSTORE INDEX
)
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mfg-BatchSummary]
( 
	[BatchCode] [varchar](500)  NOT NULL,
	[StartTime] [datetime]  NULL,
	[EndTime] [datetime]  NULL,
	[PreparationTime] [float]  NULL,
	[TotalIdleTime] [float]  NULL,
	[JobOutput] [float]  NULL,
	[PoweringOffTime] [float]  NULL
)
WITH
(
	DISTRIBUTION = HASH ( [BatchCode] ),
	CLUSTERED COLUMNSTORE INDEX
)
GO
CREATE TABLE [dbo].[mfg-Product-BatchMapping]
( 
	[batchcode] [varchar](500)  NOT NULL,
	[productid] [int]  NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)
GO
CREATE VIEW [dbo].[Vw_Mfg_batchSummary]
AS SELECT  SUM(jobOutput) AS ProducedQty,
                    BPM.ProductId
                          FROM [mfg-BatchSummary] AS BS
                    LEFT OUTER JOIN 
                    [mfg-Product-BatchMapping] AS BPM ON BPM.BatchCode = BS.BatchCode
                    GROUP BY BPM.ProductId  HAVING ProductId IS NOT NULL;
GO

/****** Object:  Table [dbo].[mfg-iot-json]    Script Date: 9/2/2020 5:51:41 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[mfg-iot-json]
(
       [IoTData] [nvarchar](4000) NULL
)
WITH
(
       DISTRIBUTION = ROUND_ROBIN,
       CLUSTERED COLUMNSTORE INDEX
)
GO

/****** Object:  Table [dbo].[CustomerInformation]    Script Date: 9/2/2020 5:53:31 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CustomerInformation]
(
       [UserName] [nvarchar](4000) NULL,
       [Gender] [nvarchar](4000) NULL,
       [Phone] [nvarchar](4000) NULL,
       [Email] [nvarchar](4000) NULL,
       [CreditCard] [nvarchar](19) NULL
)
WITH
(
       DISTRIBUTION = ROUND_ROBIN,
       CLUSTERED COLUMNSTORE INDEX
)
GO

/****** Object:  Table [dbo].[MFG-FactSales]    Script Date: 9/2/2020 5:55:49 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[MFG-FactSales]
(
       [ProductID] [nvarchar](4000) NULL,
       [Analyst] [nvarchar](4000) NULL,
       [Product] [nvarchar](4000) NULL,
       [CampaignName] [nvarchar](4000) NULL,
       [Qty] [nvarchar](4000) NULL,
       [Region] [nvarchar](4000) NULL,
       [State] [nvarchar](4000) NULL,
       [City] [nvarchar](4000) NULL,
       [Revenue] [nvarchar](4000) NULL,
       [RevenueTarget] [nvarchar](4000) NULL
)
WITH
(
       DISTRIBUTION = ROUND_ROBIN,
       CLUSTERED COLUMNSTORE INDEX
)

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[mfg-EmergencyEvent]
( 
	[EmergencyEventId] [bigint]  NULL,
	[LocationAreaId] [bigint]  NULL,
	[OccurredOn] [date]  NULL,
	[Type] [varchar](200)  NULL,
	[Category] [varchar](200)  NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[mfg-EmergencyEventPerson]
( 
	[EmergencyEventPersonId] [bigint]  NULL,
	[EmergencyEventId] [bigint]  NULL,
	[PersonName] [nvarchar](2000)  NULL,
	[AbsenceStartDate] [date]  NULL,
	[AbsenceEndDate] [date]  NULL,
	[LostManHours] [int]  NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[milling-canning]
( 
	[anomalytemperature] [nvarchar](4000)  NULL,
	[batchcode] [nvarchar](4000)  NULL,
	[coolanttemperature] [nvarchar](4000)  NULL,
	[epochtime] [nvarchar](4000)  NULL,
	[eventenqueuedutctime] [nvarchar](4000)  NULL,
	[eventprocessedutctime] [nvarchar](4000)  NULL,
	[jobcode] [nvarchar](4000)  NULL,
	[machinecode] [nvarchar](4000)  NULL,
	[operationid] [nvarchar](4000)  NULL,
	[partitionid] [nvarchar](4000)  NULL,
	[spindlespeed] [nvarchar](4000)  NULL,
	[stringdatetime] [nvarchar](4000)  NULL,
	[vibrationx] [nvarchar](4000)  NULL,
	[vibrationy] [nvarchar](4000)  NULL,
	[vibrationz] [nvarchar](4000)  NULL,
	[xaxis] [nvarchar](4000)  NULL,
	[yaxis] [nvarchar](4000)  NULL,
	[zaxis] [nvarchar](4000)  NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[racingcars]
( 
	[ActiveSensors] [nvarchar](4000)  NULL,
	[AlarmsIncidents] [nvarchar](4000)  NULL,
	[AverageRPM] [nvarchar](4000)  NULL,
	[AverageRPMEnd] [nvarchar](4000)  NULL,
	[AverageRPMR1] [nvarchar](4000)  NULL,
	[AverageRPMR2] [nvarchar](4000)  NULL,
	[AverageRPMR3] [nvarchar](4000)  NULL,
	[AverageRPMStart] [nvarchar](4000)  NULL,
	[axCG] [nvarchar](4000)  NULL,
	[ayCG] [nvarchar](4000)  NULL,
	[azCG] [nvarchar](4000)  NULL,
	[brake] [nvarchar](4000)  NULL,
	[CallsCountAverageResponseTime] [nvarchar](4000)  NULL,
	[chassisAccelFL] [nvarchar](4000)  NULL,
	[chassisAccelFR] [nvarchar](4000)  NULL,
	[chassisAccelRL] [nvarchar](4000)  NULL,
	[chassisAccelRR] [nvarchar](4000)  NULL,
	[clutch] [nvarchar](4000)  NULL,
	[distance] [nvarchar](4000)  NULL,
	[engineSpeed] [nvarchar](4000)  NULL,
	[EpochTime] [nvarchar](4000)  NULL,
	[EventEnqueuedUtcTime] [nvarchar](4000)  NULL,
	[EventProcessedUtcTime] [nvarchar](4000)  NULL,
	[horizontalSpeed] [nvarchar](4000)  NULL,
	[IoTHub] [nvarchar](4000)  NULL,
	[MachineStatus] [nvarchar](4000)  NULL,
	[PartitionId] [nvarchar](4000)  NULL,
	[StringDateTime] [nvarchar](4000)  NULL,
	[throttle] [nvarchar](4000)  NULL,
	[time] [nvarchar](4000)  NULL,
	[vxCG] [nvarchar](4000)  NULL,
	[vyCG] [nvarchar](4000)  NULL,
	[vzCG] [nvarchar](4000)  NULL,
	[wheelAccelFL] [nvarchar](4000)  NULL,
	[wheelAccelFR] [nvarchar](4000)  NULL,
	[wheelAccelRL] [nvarchar](4000)  NULL,
	[wheelAccelRR] [nvarchar](4000)  NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[mfg-MaintenanceCode]
( 
	[MaintenanceCodeId] [bigint]  NOT NULL,
	[MaintenanceCode] [varchar](200)  NULL,
	[MaintenanceType] [varchar](200)  NULL,
	[ActivityName] [varchar](2000)  NULL,
	[MaxTime] [int]  NULL,
	[ScheduleInterval] [varchar](200)  NULL
)
WITH
(
	DISTRIBUTION = HASH ( [MaintenanceCodeId] ),
	CLUSTERED COLUMNSTORE INDEX
)
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[mfg-MaintenanceCost]
( 
	[MaintenanceCostId] [int]  NULL,
	[AggregatedFor] [date]  NULL,
	[EnergyConsumptionKwH] [decimal](20,2)  NULL,
	[EnergyCharge] [decimal](20,2)  NULL,
	[MaintenanceCharge] [decimal](20,2)  NULL
)
WITH
(
	DISTRIBUTION = HASH ( [AggregatedFor] ),
	CLUSTERED COLUMNSTORE INDEX
)
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[mfg-PlannedMaintenanceActivity]
( 
	[PlannedMaintenanceActivityId] [bigint]  NOT NULL,
	[MaintenanceId] [bigint]  NULL,
	[MaintenanceCodeId] [bigint]  NULL,
	[StartTime] [datetime]  NULL,
	[EndTime] [datetime]  NULL
)
WITH
(
	DISTRIBUTION = HASH ( [PlannedMaintenanceActivityId] ),
	CLUSTERED COLUMNSTORE INDEX
)
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[mfg-UnplannedMaintenanceActivity]
( 
	[UnplannedMaintenanceActivityId] [bigint]  NOT NULL,
	[MaintenanceId] [bigint]  NULL,
	[MaintenanceCodeId] [bigint]  NULL,
	[StartTime] [datetime]  NULL,
	[EndTime] [datetime]  NULL
)
WITH
(
	DISTRIBUTION = HASH ( [UnplannedMaintenanceActivityId] ),
	CLUSTERED COLUMNSTORE INDEX
)
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role]
(
	[RoleID] [int] NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[Email] [varchar](100) NULL,
	[Roles] [varchar](128) NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Campaign_Analytics_New]
(
	[Region] [varchar](50) NULL,
	[Country] [varchar](50) NULL,
	[Product_Category] [varchar](50) NULL,
	[Campaign_Name] [varchar](50) NULL,
	[Revenue] [varchar](50) NULL,
	[Revenue_Target] [varchar](50) NULL,
	[RoleID] [int] NULL,
	[City] [nvarchar](100) NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Campaign_Analytics]
(
	[Region] [varchar](50) NULL,
	[Country] [varchar](50) NULL,
	[Product_Category] [varchar](50) NULL,
	[Campaign_Name] [varchar](50) NULL,
	[Revenue] [varchar](50) NULL,
	[Revenue_Target] [varchar](50) NULL,
	[City] [varchar](50) NULL,
	[State] [varchar](50) NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[CLS_DAM_AC_New] AS 
GRANT SELECT ON Campaign_Analytics([Region],[Country],[Product_Category],[Campaign_Name],[Revenue_Target],[City],[State]) TO SalesStaff;
EXECUTE AS USER ='SalesStaff'
select [Region],[Country],[Product_Category],[Campaign_Name],[Revenue_Target],[City],[State] from Campaign_Analytics
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[CLS_DAM_F_New] AS 
BEGIN TRY
-- Generate a divide-by-zero error  
	
		GRANT SELECT ON Campaign_Analytics([Region],[Country],[Product_Category],[Campaign_Name],[Revenue_Target],[CITY],[State]) TO SalesStaff;
		EXECUTE AS USER ='SalesStaff'
		select * from Campaign_Analytics
END TRY
BEGIN CATCH
	SELECT
		ERROR_NUMBER() AS ErrorNumber,
		ERROR_STATE() AS ErrorState,
		ERROR_SEVERITY() AS ErrorSeverity,
		ERROR_PROCEDURE() AS ErrorProcedure,
		
		ERROR_MESSAGE() AS ErrorMessage;
END CATCH;
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[CLS_CEONew] AS 
Revert;
GRANT SELECT ON Campaign_Analytics TO InventoryManager;  --Full access to all columns.
-- Step:6 Let us check if our CEO user can see all the information that is present. Assign Current User As 'CEO' and the execute the query
EXECUTE AS USER ='InventoryManager'
select * from Campaign_Analytics
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[Sp_MFGRLS] AS 
Begin  
       -- After creating the users, read access is provided to all three users on FactSales table
       GRANT SELECT ON FactSales TO InventoryManager, SalesStaffMiami, SalesStaffSanDiego;  

       IF EXISts (SELECT 1 FROM sys.security_predicates sp where sp.predicate_definition='([Security].[fn_securitypredicate]([SalesRep]))')
       BEGIN
              DROP SECURITY POLICY SalesFilter;
              DROP FUNCTION Security.fn_securitypredicate;
       END
       
       IF  EXISTS (SELECT * FROM sys.schemas where name='Security')
       BEGIN  
       DROP SCHEMA Security;
       End
       
       /* Moving ahead, we Create a new schema, and an inline table-valued function. 
       The function returns 1 when a row in the SalesRep column is the same as the user executing the query (@SalesRep = USER_NAME())
       or if the user executing the query is the Manager user (USER_NAME() = 'InventoryManager').
       */
end
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_RLS_InventoryManager] AS
EXECUTE AS USER = 'InventoryManager';  
SELECT * FROM [MFG-FactSales];
revert;
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_RLS_SalesStaffMiami] AS
EXECUTE AS USER = 'SalesStaffMiami' 
SELECT * FROM [MFG-FactSales];
revert;
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_RLS_SalesStaffSanDiego] AS
EXECUTE AS USER = 'SalesStaffSanDiego'; 
SELECT * FROM [MFG-FactSales];
revert;
GO

CREATE TABLE [dbo].[FactSales]
(
	[OrderID] [int] NULL,
	[SalesRep] [sysname] NULL,
	[Product] [varchar](50) NULL,
	[Qty] [int] NULL,
	[RoleID] [int] NULL,
	[QtySold] [int] NULL,
	[Analyst] [varchar](50) NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)
GO

CREATE TABLE [dbo].[MfgMesQuality1]
(
	[ProductionMonth] [datetime] NOT NULL,
	[MachineInstance] [varchar](30) NULL,
	[MachineName] [varchar](30) NULL,
	[Good] [int] NULL,
	[Snag] [int] NULL,
	[Reject] [int] NULL,
	[Avg] [float] NULL
)
WITH
(
	DISTRIBUTION = HASH ( [MachineInstance] ),
	CLUSTERED COLUMNSTORE INDEX
)



