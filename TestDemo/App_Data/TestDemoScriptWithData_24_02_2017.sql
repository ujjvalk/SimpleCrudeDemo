USE [TestDemo]
GO
/****** Object:  UserDefinedFunction [dbo].[ufnLeadingZeros]    Script Date: 02/24/2017 17:19:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ufnLeadingZeros](
@Value int
) 
RETURNS varchar(8) 
WITH SCHEMABINDING 
AS 

BEGIN
DECLARE @ReturnValue varchar(8);
SET @ReturnValue = CONVERT(varchar(8), @Value);
SET @ReturnValue = REPLICATE('0', 8 - DATALENGTH(@ReturnValue)) + @ReturnValue;
RETURN (@ReturnValue);
END;
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 02/24/2017 17:19:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Customer](
	[CustomerID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[PersonID] [int] NULL,
	[StoreID] [int] NULL,
	[TerritoryID] [int] NULL,
	[AccountNumber]  AS (isnull('AW'+[dbo].[ufnLeadingZeros]([CustomerID]),'')),
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Customer_CustomerID] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BankAcount]    Script Date: 02/24/2017 17:19:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BankAcount](
	[AcountId] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[TotalBalance] [decimal](12, 2) NULL,
 CONSTRAINT [PK_BankAcount] PRIMARY KEY CLUSTERED 
(
	[AcountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cities]    Script Date: 02/24/2017 17:19:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cities](
	[cityID] [int] NOT NULL,
	[cityName] [varchar](50) NOT NULL,
	[stateID] [int] NOT NULL,
	[countryID] [varchar](3) NOT NULL,
	[latitude] [float] NOT NULL,
	[longitude] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[cityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[countries]    Script Date: 02/24/2017 17:19:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[countries](
	[countryID] [varchar](3) NOT NULL,
	[countryName] [varchar](52) NOT NULL,
	[localName] [varchar](45) NOT NULL,
	[webCode] [varchar](2) NOT NULL,
	[region] [varchar](26) NOT NULL,
	[continent] [varchar](15) NOT NULL,
	[latitude] [float] NOT NULL,
	[longitude] [float] NOT NULL,
	[surfaceArea] [float] NOT NULL,
	[population] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[countryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DateRange]    Script Date: 02/24/2017 17:19:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DateRange](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[FromDate] [datetime] NULL,
	[Todate] [datetime] NULL,
 CONSTRAINT [PK_DateRange] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GeoLocation]    Script Date: 02/24/2017 17:19:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GeoLocation](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[GeoLocationAddress] [nvarchar](500) NULL,
	[Latitude] [nvarchar](50) NULL,
	[Longiude] [nvarchar](50) NULL,
 CONSTRAINT [PK_GeoLocation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[states]    Script Date: 02/24/2017 17:19:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[states](
	[stateID] [int] NOT NULL,
	[stateName] [varchar](50) NOT NULL,
	[countryID] [varchar](3) NOT NULL,
	[latitude] [float] NOT NULL,
	[longitude] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[stateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Student]    Script Date: 02/24/2017 17:19:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[studentId] [int] IDENTITY(1,1) NOT NULL,
	[studentName] [nvarchar](50) NULL,
	[studentAge] [int] NULL,
	[studentAddress] [nvarchar](max) NULL,
	[BirthDate] [date] NULL,
	[ClassId] [int] NULL,
	[Standard] [int] NULL,
	[Photo] [nvarchar](300) NULL,
	[hobby] [nvarchar](300) NULL,
PRIMARY KEY CLUSTERED 
(
	[studentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StudentClass]    Script Date: 02/24/2017 17:19:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentClass](
	[ClassId] [int] IDENTITY(1,1) NOT NULL,
	[Class] [nvarchar](5) NULL,
	[Description] [nvarchar](max) NULL,
 CONSTRAINT [PK_StudentClass] PRIMARY KEY CLUSTERED 
(
	[ClassId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StudentCourse]    Script Date: 02/24/2017 17:19:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentCourse](
	[CourseId] [int] IDENTITY(1,1) NOT NULL,
	[CourseName] [nvarchar](50) NULL,
 CONSTRAINT [PK_StudentCourse] PRIMARY KEY CLUSTERED 
(
	[CourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StudentCourseMapping]    Script Date: 02/24/2017 17:19:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentCourseMapping](
	[StuCourseMapId] [bigint] IDENTITY(1,1) NOT NULL,
	[studentId] [int] NOT NULL,
	[courseId] [int] NOT NULL,
 CONSTRAINT [PK_StudentCourseMapping] PRIMARY KEY CLUSTERED 
(
	[StuCourseMapId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblDesignation]    Script Date: 02/24/2017 17:19:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblDesignation](
	[DesignationId] [bigint] IDENTITY(1,1) NOT NULL,
	[DesName] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblDesignation] PRIMARY KEY CLUSTERED 
(
	[DesignationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblEmployee]    Script Date: 02/24/2017 17:19:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblEmployee](
	[EmpId] [bigint] IDENTITY(1,1) NOT NULL,
	[EmpName] [nvarchar](50) NULL,
	[EmpAddress] [nvarchar](max) NULL,
	[EmpGender] [varchar](10) NULL,
	[EmpHobby] [nvarchar](50) NULL,
	[EmpDesignation] [bigint] NULL,
	[IsDelete] [bit] NULL,
	[IsActive] [bit] NULL,
	[DeletedDate] [datetime] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[EmpEmail] [nvarchar](100) NULL,
	[EmpImage] [nvarchar](200) NULL,
	[Birthdate] [datetime] NULL,
 CONSTRAINT [PK_tblEmployee] PRIMARY KEY CLUSTERED 
(
	[EmpId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblHobby]    Script Date: 02/24/2017 17:19:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblHobby](
	[HobbyId] [bigint] IDENTITY(1,1) NOT NULL,
	[HName] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblHobby] PRIMARY KEY CLUSTERED 
(
	[HobbyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblRole]    Script Date: 02/24/2017 17:19:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRole](
	[RoleId] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Description] [nvarchar](max) NULL,
 CONSTRAINT [PK_tblRole] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblSlider]    Script Date: 02/24/2017 17:19:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblSlider](
	[SliderId] [int] IDENTITY(1,1) NOT NULL,
	[SImage] [nvarchar](200) NULL,
	[IsActive] [bit] NULL,
	[IsDelete] [bit] NULL,
 CONSTRAINT [PK_tblSlider] PRIMARY KEY CLUSTERED 
(
	[SliderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Transaction]    Script Date: 02/24/2017 17:19:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transaction](
	[TransactionId] [bigint] IDENTITY(1,1) NOT NULL,
	[AcountId] [bigint] NULL,
	[Type] [nchar](10) NULL,
	[Amount] [decimal](12, 2) NULL,
	[AvailBalance] [decimal](12, 2) NULL,
 CONSTRAINT [PK_Transaction] PRIMARY KEY CLUSTERED 
(
	[TransactionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[BankAcount] ON 

INSERT [dbo].[BankAcount] ([AcountId], [Name], [TotalBalance]) VALUES (1, N'ujval', CAST(11500.00 AS Decimal(12, 2)))
INSERT [dbo].[BankAcount] ([AcountId], [Name], [TotalBalance]) VALUES (2, N'Ronak', CAST(100.00 AS Decimal(12, 2)))
SET IDENTITY_INSERT [dbo].[BankAcount] OFF
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (7, N'Mountain View', 5, N'USA', 37.42, -122.06)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (8, N'Beijing', 6, N'CHN', 39.93, 116.39)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (11, N'Ackworth', 9, N'USA', 41.36, -93.43)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (13, N'Far Rockaway', 10, N'USA', 40.61, -73.79)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (14, N'Hebei', 11, N'CHN', 39.89, 115.28)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (15, N'Los Angeles', 5, N'USA', 34.04, -118.25)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (16, N'Nanjing', 12, N'CHN', 32.06, 118.78)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (18, N'Sunnyvale', 5, N'USA', 37.42, -122.01)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (20, N'Newark', 14, N'USA', 40.74, -74.17)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (21, N'Malden', 15, N'USA', 42.43, -71.05)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (22, N'Trumbull', 16, N'USA', 41.26, -73.21)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (23, N'Guangzhou', 17, N'CHN', 23.12, 113.25)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (25, N'Cupertino', 5, N'USA', 37.3, -122.09)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (26, N'Fort Lauderdale', 19, N'USA', 26.1, -80.27)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (27, N'South Amboy', 14, N'USA', 40.48, -74.29)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (33, N'Keller', 24, N'USA', 32.93, -97.25)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (34, N'Long Island City', 10, N'USA', 40.74, -73.94)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (38, N'Brooklyn', 10, N'USA', 40.69, -73.99)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (39, N'Army Post Office', 28, N'USA', 56, -100)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (42, N'Mesquite', 24, N'USA', 32.76, -96.61)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (44, N'Mc Minnville', 32, N'USA', 35.65, -85.73)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (45, N'Flatwoods', 33, N'USA', 38.5, -82.73)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (46, N'Saint-maur-des-fossés', 34, N'FRA', 48.8, 2.5)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (47, N'Bogart', 35, N'USA', 33.91, -83.52)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (48, N'Cedar Hill', 24, N'USA', 32.59, -96.97)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (50, N'São Gonçalo', 37, N'BRA', -22.8, -43.03)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (51, N'Levittown', 10, N'USA', 40.72, -73.52)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (52, N'z.... TRIAL VERSION from MYIP.MS ....', 5, N'USA', 33.84, -118.35)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (53, N'Cornelia', 35, N'USA', 34.5, -83.58)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (61, N'Des Plaines', 44, N'USA', 42, -87.9)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (63, N'Fortaleza', 46, N'BRA', -3.32, -41.42)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (64, N'Denver', 47, N'USA', 39.75, -105)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (65, N'Shenzhen', 17, N'CHN', 22.53, 114.13)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (66, N'Wenzhou', 48, N'CHN', 28.02, 120.65)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (67, N'Riverton', 49, N'USA', 40.48, -112.01)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (72, N'Shenyang', 52, N'CHN', 41.79, 123.43)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (77, N'Gurgaon', 56, N'IND', 28.47, 77.03)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (78, N'Glen Burnie', 57, N'USA', 39.16, -76.6)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (79, N'z.... TRIAL VERSION from MYIP.MS ....', 10, N'USA', 40.8, -73.97)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (81, N'Miami', 19, N'USA', 25.81, -80.24)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (83, N'Chicago', 44, N'USA', 41.88, -87.63)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (87, N'Shanghai', 62, N'CHN', 31, 121.41)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (90, N'Tianjin', 64, N'CHN', 39.14, 117.18)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (99, N'Evansdale', 9, N'USA', 42.49, -92.29)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (102, N'Houston', 24, N'USA', 29.8, -95.42)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (103, N'z.... TRIAL VERSION from MYIP.MS ....', 24, N'USA', 32.78, -96.8)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (106, N'Dongguan', 17, N'CHN', 23.05, 113.74)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (107, N'Anderson', 72, N'USA', 34.48, -82.68)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (108, N'Bozeman', 73, N'USA', 45.71, -111.06)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (112, N'Marksville', 76, N'USA', 31.18, -92.02)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (113, N'Xiamen', 77, N'CHN', 24.47, 118.09)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (114, N'Billerica', 15, N'USA', 42.55, -71.26)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (116, N'Florianópolis', 78, N'BRA', -27.58, -48.57)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (118, N'Vitória', 80, N'BRA', -20.32, -40.35)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (121, N'Memphis', 32, N'USA', 35.03, -89.78)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (125, N'Seattle', 84, N'USA', 47.58, -122.3)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (126, N'Hyderabad', 85, N'IND', 17.38, 78.47)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (128, N'Prospect', 87, N'USA', 40.9, -80.08)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (132, N'Nanning', 90, N'CHN', 22.82, 108.32)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (133, N'Bellevue', 84, N'USA', 47.6, -122.16)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (135, N'Apollo Beach', 19, N'USA', 27.77, -82.41)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (138, N'Elgin', 44, N'USA', 42.03, -88.3)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (139, N'Cherryville', 93, N'USA', 35.39, -81.39)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (141, N'Jiazhuang', 94, N'CHN', 37.26, 117.08)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (144, N'Chongqing', 97, N'CHN', 29.56, 106.55)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (145, N'Jinan', 94, N'CHN', 36.67, 117)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (146, N'Grand Blanc', 98, N'USA', 42.92, -83.65)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (147, N'Indiana', 87, N'USA', 40.62, -79.15)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (148, N'Wuhan', 99, N'CHN', 30.58, 114.27)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (149, N'Delhi', 100, N'IND', 28.67, 77.22)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (150, N'Morrilton', 101, N'USA', 35.17, -92.74)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (154, N'Sharon', 15, N'USA', 42.11, -71.18)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (155, N'Pompton Lakes', 14, N'USA', 41, -74.28)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (158, N'Eau Claire', 107, N'USA', 44.79, -91.54)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (160, N'Saint Petersburg', 19, N'USA', 27.63, -82.7)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (162, N'Hangzhou', 48, N'CHN', 30.26, 120.17)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (165, N'Mount Holly', 14, N'USA', 39.99, -74.79)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (166, N'Gindou', 112, N'FRA', 44.63, 1.27)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (167, N'Chaoyang', 52, N'CHN', 41.57, 120.46)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (172, N'z.... TRIAL VERSION from MYIP.MS ....', 19, N'USA', 30.47, -84.22)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (174, N'Daqing', 52, N'CHN', 41.72, 123.2)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (176, N'Meulan', 116, N'FRA', 49.02, 1.9)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (184, N'Salvador', 121, N'BRA', -12.98, -38.52)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (187, N'Atlanta', 35, N'USA', 33.8, -84.39)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (188, N'Harbin', 123, N'CHN', 45.75, 126.65)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (190, N'Hopkins', 72, N'USA', 33.91, -80.83)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (197, N'Paris', 101, N'USA', 35.28, -93.72)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (198, N'Cary', 93, N'USA', 35.78, -78.82)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (200, N'Southgate', 98, N'USA', 42.21, -83.21)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (201, N'Madras', 128, N'IND', 13.08, 80.28)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (202, N'Viola', 101, N'USA', 36.38, -92)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (203, N'Euclid', 129, N'USA', 41.57, -81.53)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (204, N'Benton', 101, N'USA', 34.59, -92.67)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (205, N'z.... TRIAL VERSION from MYIP.MS ....', 14, N'USA', 40.85, -74.02)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (208, N'Rio Rancho', 132, N'USA', 35.25, -106.72)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (210, N'Hutchinson', 133, N'USA', 38.13, -97.93)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (212, N'Montgomery', 87, N'USA', 41.18, -76.95)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (213, N'Colorado Springs', 47, N'USA', 38.83, -104.74)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (214, N'Moriarty', 132, N'USA', 34.96, -106)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (218, N'Vail', 47, N'USA', 39.64, -106.32)
GO
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (219, N'z.... TRIAL VERSION from MYIP.MS ....', 101, N'USA', 35.14, -90.15)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (221, N'Sandy', 136, N'USA', 45.38, -122.18)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (223, N'Fennville', 98, N'USA', 42.57, -86.11)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (224, N'Agra', 138, N'IND', 27.18, 78.02)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (227, N'Kearney', 140, N'USA', 40.76, -99.02)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (230, N'Kittanning', 87, N'USA', 40.81, -79.42)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (233, N'Ripley', 143, N'USA', 38.79, -81.68)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (234, N'Norwood', 15, N'USA', 42.18, -71.2)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (235, N'z.... TRIAL VERSION from MYIP.MS ....', 15, N'USA', 42.28, -71.12)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (237, N'z.... TRIAL VERSION from MYIP.MS ....', 87, N'USA', 40.79, -77.87)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (238, N'Alexandria', 144, N'USA', 38.81, -77.13)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (244, N'Richmond', 144, N'USA', 37.54, -77.48)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (245, N'Belton', 145, N'USA', 38.78, -94.55)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (250, N'Laurel', 148, N'USA', 31.7, -89.11)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (252, N'Lolo', 73, N'USA', 46.73, -114.36)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (253, N'Peoria', 44, N'USA', 40.69, -89.59)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (257, N'Iowa City', 9, N'USA', 41.64, -91.46)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (258, N'Pawtucket', 151, N'USA', 41.87, -71.39)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (259, N'Madison', 107, N'USA', 43.07, -89.39)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (260, N'Toledo', 129, N'USA', 41.71, -83.54)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (269, N'Woodbridge', 144, N'USA', 38.65, -77.31)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (270, N'Suzhou', 12, N'CHN', 31.31, 120.62)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (272, N'São Paulo', 155, N'BRA', -23.53, -46.62)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (273, N'Henan', 156, N'CHN', 37.9, 112.19)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (276, N'Lishui', 48, N'CHN', 28.11, 119.56)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (278, N'Bangalore', 160, N'IND', 12.98, 77.58)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (280, N'Zhongxin', 161, N'CHN', 26.97, 109.77)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (283, N'Rolla', 145, N'USA', 37.93, -91.78)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (284, N'z.... TRIAL VERSION from MYIP.MS ....', 44, N'USA', 41.88, -87.88)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (285, N'Shelby', 93, N'USA', 35.36, -81.57)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (286, N'Carbondale', 47, N'USA', 39.18, -107.23)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (287, N'Decatur', 35, N'USA', 33.69, -84.25)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (290, N'Baltimore', 57, N'USA', 39.34, -76.69)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (291, N'Kokomo', 163, N'USA', 40.44, -86.09)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (296, N'Broken Arrow', 164, N'USA', 36.06, -95.81)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (300, N'Taiyüan', 156, N'CHN', 37.73, 112.47)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (304, N'z.... TRIAL VERSION from MYIP.MS ....', 47, N'USA', 39.96, -105.17)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (312, N'Raleigh', 93, N'USA', 35.93, -78.72)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (313, N'Greenville', 72, N'USA', 34.86, -82.25)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (317, N'Saint Paul', 175, N'USA', 45.07, -93.19)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (318, N'Fort Mitchell', 176, N'USA', 32.29, -84.97)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (319, N'Akron', 129, N'USA', 41.07, -81.54)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (321, N'Zhongyuan', 178, N'CHN', 19.14, 110.48)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (327, N'Stamford', 16, N'USA', 41.08, -73.54)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (328, N'Phoenix', 181, N'USA', 33.43, -112.2)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (330, N'Viroflay', 34, N'FRA', 48.8, 2.17)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (331, N'Chengdu', 182, N'CHN', 30.67, 104.07)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (332, N'Putian', 77, N'CHN', 25.44, 119.01)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (334, N'New Palestine', 163, N'USA', 39.73, -85.89)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (336, N'Caldwell', 129, N'USA', 39.73, -81.51)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (337, N'Dundalk', 57, N'USA', 39.26, -76.5)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (340, N'Minneapolis', 175, N'USA', 45.03, -93.3)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (344, N'Brookings', 186, N'USA', 44.33, -96.81)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (348, N'Las Cruces', 132, N'USA', 32.35, -106.77)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (349, N'Mumbai', 187, N'IND', 18.98, 72.83)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (354, N'z.... TRIAL VERSION from MYIP.MS ....', 129, N'USA', 40.04, -82.96)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (362, N'Las Vegas', 192, N'USA', 36.08, -115.09)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (366, N'Fuzhou', 77, N'CHN', 26.06, 119.31)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (367, N'Hazelwood', 145, N'USA', 38.79, -90.38)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (368, N'Moncks Corner', 72, N'USA', 33.12, -80.04)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (372, N'Xian', 11, N'CHN', 40.29, 117.65)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (374, N'Bothell', 84, N'USA', 47.84, -122.2)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (376, N'Changge', 196, N'CHN', 34.22, 113.77)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (378, N'Qingdao', 94, N'CHN', 36.1, 120.37)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (379, N'Gilbert', 181, N'USA', 33.32, -111.76)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (392, N'Sioux Falls', 186, N'USA', 43.52, -96.73)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (398, N'Jinhua', 48, N'CHN', 29.11, 119.65)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (400, N'Richmond', 33, N'USA', 37.77, -84.3)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (404, N'Thana', 187, N'IND', 19.2, 72.97)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (405, N'Thiruvananthapuram', 206, N'IND', 8.51, 76.96)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (408, N'Huntsville', 176, N'USA', 34.64, -86.75)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (409, N'z.... TRIAL VERSION from MYIP.MS ....', 93, N'USA', 34.74, -76.77)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (410, N'Carter Lake', 9, N'USA', 41.29, -95.92)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (411, N'Tupelo', 148, N'USA', 34.22, -88.77)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (413, N'Menomonie', 107, N'USA', 44.85, -92)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (422, N'Weare', 215, N'USA', 43.08, -71.72)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (427, N'Amite', 76, N'USA', 30.73, -90.61)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (428, N'Norfolk', 144, N'USA', 36.89, -76.27)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (432, N'Portland', 218, N'USA', 43.69, -70.29)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (439, N'Honolulu', 220, N'USA', 21.3, -157.79)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (443, N'Overland Park', 133, N'USA', 38.92, -94.7)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (445, N'z.... TRIAL VERSION from MYIP.MS ....', 35, N'USA', 33.44, -82.05)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (452, N'Durg', 225, N'IND', 21.18, 81.28)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (456, N'Williamston', 98, N'USA', 42.68, -84.27)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (459, N'Tempe', 181, N'USA', 33.44, -111.92)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (460, N'Kennewick', 84, N'USA', 46.08, -119.09)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (463, N'Birmingham', 176, N'USA', 33.51, -86.8)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (468, N'z.... TRIAL VERSION from MYIP.MS ....', 98, N'USA', 42.5, -83.41)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (477, N'Coquille', 136, N'USA', 43.2, -124.12)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (479, N'Hefei', 236, N'CHN', 31.86, 117.28)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (480, N'Gardnerville', 192, N'USA', 38.92, -119.8)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (483, N'Changsha', 161, N'CHN', 28.18, 113.11)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (485, N'Salt Lake City', 49, N'USA', 40.71, -111.86)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (491, N'Quitman', 76, N'USA', 32.35, -92.72)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (493, N'Windsor', 16, N'USA', 41.86, -72.68)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (498, N'Paris', 34, N'FRA', 48.87, 2.33)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (503, N'Fort Wayne', 163, N'USA', 40.98, -85.12)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (505, N'Moulton', 176, N'USA', 34.46, -87.3)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (510, N'Sierra Vista', 181, N'USA', 31.59, -110.17)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (511, N'Valparaiso', 163, N'USA', 41.46, -87.14)
GO
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (518, N'Washington', 249, N'USA', 38.91, -77.08)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (527, N'Gatlinburg', 32, N'USA', 35.67, -83.46)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (530, N'Dover', 254, N'USA', 39.16, -75.49)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (533, N'Lexington', 33, N'USA', 37.99, -84.49)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (536, N'Olney', 57, N'USA', 39.15, -77.08)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (547, N'z.... TRIAL VERSION from MYIP.MS ....', 144, N'USA', 38.84, -77.47)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (548, N'Calcutta', 258, N'IND', 22.57, 88.37)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (551, N'Knoxville', 32, N'USA', 36.06, -83.91)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (556, N'z.... TRIAL VERSION from MYIP.MS ....', 176, N'USA', 32.36, -86.27)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (567, N'Nasik', 187, N'IND', 19.98, 73.8)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (578, N'New Delhi', 100, N'IND', 28.6, 77.2)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (582, N'Xian', 268, N'CHN', 34.26, 108.94)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (595, N'z.... TRIAL VERSION from MYIP.MS ....', 32, N'USA', 36.14, -86.73)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (597, N'Fraziers Bottom', 143, N'USA', 38.6, -82.03)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (599, N'Pune', 187, N'IND', 18.53, 73.87)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (601, N'Indore', 274, N'IND', 22.72, 75.83)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (622, N'Foshan', 17, N'CHN', 23.03, 113.12)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (625, N'Ahmadabad', 284, N'IND', 23.03, 72.62)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (631, N'Lawrence', 133, N'USA', 39.04, -95.21)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (640, N'z.... TRIAL VERSION from MYIP.MS ....', 84, N'USA', 47.68, -122.12)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (642, N'New Orleans', 76, N'USA', 29.96, -90.08)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (647, N'Columbia', 145, N'USA', 39.04, -92.27)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (655, N'Lucknow', 138, N'IND', 26.85, 80.92)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (660, N'Waukesha', 107, N'USA', 42.94, -88.3)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (663, N'z.... TRIAL VERSION from MYIP.MS ....', 57, N'USA', 39.34, -76.5)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (666, N'z.... TRIAL VERSION from MYIP.MS ....', 72, N'USA', 33.7, -80.44)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (667, N'Belfort', 296, N'FRA', 47.63, 6.87)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (669, N'z.... TRIAL VERSION from MYIP.MS ....', 48, N'CHN', 30, 120.58)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (678, N'z.... TRIAL VERSION from MYIP.MS ....', 181, N'USA', 34.05, -109.2)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (683, N'Bhopal', 274, N'IND', 23.27, 77.4)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (690, N'Middleton', 305, N'USA', 43.74, -116.58)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (691, N'Jaipur', 306, N'IND', 26.92, 75.82)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (692, N'Tiruchchirappalli', 128, N'IND', 10.81, 78.69)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (695, N'Lenexa', 133, N'USA', 38.95, -94.75)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (696, N'Hulun', 307, N'CHN', 49.2, 119.7)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (711, N'Strasbourg', 315, N'FRA', 48.58, 7.75)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (712, N'Pahala', 220, N'USA', 19.2, -155.5)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (718, N'Cuttack', 317, N'IND', 20.5, 85.83)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (722, N'Visakhapatnam', 85, N'IND', 17.7, 83.3)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (723, N'Pocatello', 305, N'USA', 42.91, -112.4)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (735, N'Vanceburg', 33, N'USA', 38.51, -83.41)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (737, N'z.... TRIAL VERSION from MYIP.MS ....', 145, N'USA', 39.11, -94.57)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (739, N'Bristol', 16, N'USA', 41.68, -72.94)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (748, N'Rajkot', 284, N'IND', 22.3, 70.78)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (752, N'Meerut', 138, N'IND', 28.98, 77.7)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (758, N'z.... TRIAL VERSION from MYIP.MS ....', 107, N'USA', 44.26, -88.51)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (771, N'Muzaffarnagar', 138, N'IND', 29.47, 77.68)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (776, N'Changchun', 334, N'CHN', 43.88, 125.32)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (780, N'Suri', 258, N'IND', 23.92, 87.53)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (784, N'Vijayawada', 85, N'IND', 16.52, 80.62)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (787, N'z.... TRIAL VERSION from MYIP.MS ....', 9, N'USA', 41.24, -95.79)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (788, N'Saint Cloud', 175, N'USA', 45.49, -94.23)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (796, N'z.... TRIAL VERSION from MYIP.MS ....', 187, N'IND', 19.22, 73.15)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (801, N'Madurai', 128, N'IND', 9.93, 78.12)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (803, N'Ewa Beach', 220, N'USA', 21.35, -158.02)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (811, N'Vadodara', 284, N'IND', 22.3, 73.2)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (830, N'Ranchi', 355, N'IND', 23.35, 85.33)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (834, N'z.... TRIAL VERSION from MYIP.MS ....', 16, N'USA', 41.14, -73.41)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (848, N'Chandigarh', 363, N'IND', 30.74, 76.79)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (858, N'Montrouge', 34, N'FRA', 48.82, 2.32)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (861, N'Tulsa', 164, N'USA', 36.14, -95.94)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (867, N'Newalla', 164, N'USA', 35.35, -97.2)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (871, N'z.... TRIAL VERSION from MYIP.MS ....', 138, N'IND', 28.67, 77.43)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (873, N'z.... TRIAL VERSION from MYIP.MS ....', 34, N'FRA', 48.58, 2.22)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (878, N'Ludhiana', 377, N'IND', 30.9, 75.85)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (907, N'Surat', 284, N'IND', 20.97, 72.9)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (909, N'Karimnagar', 85, N'IND', 18.43, 79.15)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (923, N'Hillsboro', 136, N'USA', 45.51, -122.94)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (930, N'Thanjavur', 128, N'IND', 10.8, 79.15)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (935, N'z.... TRIAL VERSION from MYIP.MS ....', 284, N'IND', 23.22, 72.68)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (947, N'Sète', 409, N'FRA', 43.4, 3.68)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (952, N'Kapurthala', 377, N'IND', 31.38, 75.38)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (960, N'Silchar', 416, N'IND', 24.82, 92.8)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (987, N'Bourges', 431, N'FRA', 47.08, 2.4)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (988, N'Zhengzhou', 196, N'CHN', 34.68, 113.53)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (994, N'Portland', 136, N'USA', 45.59, -122.71)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (997, N'z.... TRIAL VERSION from MYIP.MS ....', 33, N'USA', 38.22, -85.62)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1018, N'Bhubaneswar', 317, N'IND', 20.23, 85.83)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1044, N'Keaau', 220, N'USA', 19.58, -155.02)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1047, N'Tours', 431, N'FRA', 47.38, 0.68)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1060, N'Faridabad', 56, N'IND', 28.43, 77.32)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1063, N'Jacareí', 155, N'BRA', -23.32, -45.97)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1068, N'Celles-sur-ource', 469, N'FRA', 48.08, 4.4)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1072, N'Trébeurden', 471, N'FRA', 48.77, -3.57)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1088, N'Haora', 258, N'IND', 22.59, 88.31)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1121, N'Sacy-le-grand', 116, N'FRA', 49.35, 2.55)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1126, N'Langfang', 11, N'CHN', 39.51, 116.69)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1142, N'z.... TRIAL VERSION from MYIP.MS ....', 136, N'USA', 44.53, -122.82)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1157, N'Lamorlaye', 116, N'FRA', 49.15, 2.43)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1163, N'Brewer', 218, N'USA', 44.78, -68.74)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1174, N'z.... TRIAL VERSION from MYIP.MS ....', 128, N'IND', 11.35, 77.73)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1197, N'Niederroedern', 315, N'FRA', 48.9, 8.05)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1214, N'Beauvais', 116, N'FRA', 49.43, 2.08)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1221, N'Kolkata', 258, N'IND', 22.57, 88.37)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1242, N'Lyon', 544, N'FRA', 45.75, 4.85)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1257, N'Henderson', 192, N'USA', 36.03, -115.07)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1258, N'Coursan', 409, N'FRA', 43.23, 3.07)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1275, N'Zudausques', 555, N'FRA', 50.75, 2.15)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1279, N'Nancy', 556, N'FRA', 48.68, 6.2)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1288, N'Piracicaba', 155, N'BRA', -22.72, -47.63)
GO
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1291, N'Porto Alegre', 561, N'BRA', -30.03, -51.2)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1293, N'Nogent-le-roi', 431, N'FRA', 48.65, 1.53)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1296, N'z.... TRIAL VERSION from MYIP.MS ....', 116, N'FRA', 49.25, 3.55)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1297, N'Grillon', 563, N'FRA', 44.4, 4.93)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1300, N'Haryana', 56, N'IND', 29.62, 76.98)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1345, N'Rennes', 471, N'FRA', 48.08, -1.68)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1353, N'Cuzieu', 544, N'FRA', 45.62, 4.27)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1361, N'Haikou', 178, N'CHN', 20.05, 110.34)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1364, N'Tassin-la-demi-lune', 544, N'FRA', 45.77, 4.78)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1372, N'Cuers', 563, N'FRA', 43.23, 6.07)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1374, N'Belo Horizonte', 586, N'BRA', -19.92, -43.93)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1376, N'Kota', 306, N'IND', 25.18, 75.83)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1380, N'Mieussy', 544, N'FRA', 46.15, 6.53)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1390, N'Amritsar', 377, N'IND', 31.63, 74.87)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1393, N'Kochi', 206, N'IND', 9.97, 76.23)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1410, N'Bauru', 155, N'BRA', -22.32, -49.07)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1414, N'z.... TRIAL VERSION from MYIP.MS ....', 544, N'FRA', 45.77, 4.88)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1418, N'Circle Pines', 175, N'USA', 45.17, -93.12)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1423, N'Limoges', 598, N'FRA', 45.85, 1.25)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1432, N'Guiyang', 600, N'CHN', 26.58, 106.72)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1474, N'z.... TRIAL VERSION from MYIP.MS ....', 163, N'USA', 39.47, -87.4)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1479, N'Lille', 555, N'FRA', 50.63, 3.07)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1506, N'Martigues', 563, N'FRA', 43.4, 5.05)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1507, N'Fleury-les-aubrais', 431, N'FRA', 47.93, 1.92)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1523, N'Aubevoye', 635, N'FRA', 49.15, 1.33)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1533, N'Thalassery', 206, N'IND', 11.75, 75.49)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1545, N'z.... TRIAL VERSION from MYIP.MS ....', 155, N'BRA', -23.52, -46.83)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1575, N'Angoulême', 649, N'FRA', 45.65, 0.15)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1584, N'Guwahati', 416, N'IND', 26.18, 91.73)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1611, N'Kannur', 206, N'IND', 11.87, 75.37)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1618, N'Pauvres', 469, N'FRA', 49.42, 4.5)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1627, N'Dubois', 667, N'USA', 43.49, -109.64)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1641, N'Mangaluru', 160, N'IND', 12.86, 74.84)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1659, N'Wilmington', 254, N'USA', 39.72, -75.53)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1662, N'Beausoleil', 563, N'FRA', 43.75, 7.43)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1663, N'Vapi', 676, N'IND', 20.37, 72.9)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1686, N'Bruguières', 112, N'FRA', 43.73, 1.42)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1687, N'Olive Branch', 148, N'USA', 34.92, -89.82)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1713, N'Wheeling', 143, N'USA', 40.06, -80.64)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1720, N'z.... TRIAL VERSION from MYIP.MS ....', 431, N'FRA', 47.03, 2.92)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1758, N'Joinville', 78, N'BRA', -26.3, -48.83)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1760, N'Raymond', 215, N'USA', 43.03, -71.2)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1761, N'Altamira', 701, N'BRA', -3.2, -52.2)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1763, N'Nashua', 215, N'USA', 42.73, -71.46)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1770, N'Valady', 112, N'FRA', 44.45, 2.43)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1778, N'Taizhou', 12, N'CHN', 32.49, 119.91)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1785, N'z.... TRIAL VERSION from MYIP.MS ....', 85, N'IND', 13.2, 79.12)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1786, N'Lisieux', 708, N'FRA', 49.15, 0.23)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1789, N'Hampstead', 215, N'USA', 42.88, -71.17)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1808, N'z.... TRIAL VERSION from MYIP.MS ....', 175, N'USA', 44.93, -93.42)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1822, N'Sigean', 409, N'FRA', 43.03, 2.98)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1851, N'Rio De Janeiro', 37, N'BRA', -22.9, -43.23)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1856, N'Patna', 728, N'IND', 25.6, 85.12)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1857, N'Laruscade', 729, N'FRA', 45.12, -0.33)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1867, N'Niterói', 37, N'BRA', -22.88, -43.09)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1899, N'São Leopoldo', 561, N'BRA', -29.77, -51.15)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1902, N'Biddeford', 218, N'USA', 43.5, -70.49)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1906, N'Balma', 112, N'FRA', 43.62, 1.5)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1908, N'Le Recoux', 409, N'FRA', 44.33, 3.15)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1917, N'Dewas', 274, N'IND', 22.97, 76.07)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1939, N'La Chapelle', 469, N'FRA', 48.33, 4.05)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1962, N'z.... TRIAL VERSION from MYIP.MS ....', 112, N'FRA', 42.87, 1.2)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1976, N'Fernley', 192, N'USA', 39.67, -119.07)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1982, N'Camps', 598, N'FRA', 44.98, 2)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (1996, N'z.... TRIAL VERSION from MYIP.MS ....', 563, N'FRA', 43.3, 5.4)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2003, N'Delhi Paharganj', 100, N'IND', 28.62, 77.22)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2007, N'Lambersart', 555, N'FRA', 50.65, 3.03)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2022, N'Dole', 296, N'FRA', 47.1, 5.5)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2023, N'z.... TRIAL VERSION from MYIP.MS ....', 133, N'USA', 37.69, -97.5)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2026, N'Irati', 773, N'BRA', -25.48, -50.65)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2058, N'z.... TRIAL VERSION from MYIP.MS ....', 192, N'USA', 36.22, -115.17)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2067, N'Arras', 555, N'FRA', 50.28, 2.78)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2103, N'Brive-la-gaillarde', 598, N'FRA', 45.15, 1.53)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2126, N'z.... TRIAL VERSION from MYIP.MS ....', 555, N'FRA', 51.05, 2.37)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2133, N'Servilly', 798, N'FRA', 46.28, 3.6)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2150, N'z.... TRIAL VERSION from MYIP.MS ....', 76, N'USA', 30.23, -93.2)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2165, N'z.... TRIAL VERSION from MYIP.MS ....', 220, N'USA', 21.41, -158.02)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2182, N'Baltic', 186, N'USA', 43.74, -96.76)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2188, N'Olinda', 808, N'BRA', -8.02, -34.85)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2194, N'Yellapur', 160, N'IND', 14.97, 74.72)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2202, N'z.... TRIAL VERSION from MYIP.MS ....', 215, N'USA', 43.43, -70.98)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2209, N'Berwick', 218, N'USA', 43.3, -70.84)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2221, N'Norman', 164, N'USA', 35.25, -97.46)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2224, N'z.... TRIAL VERSION from MYIP.MS ....', 164, N'USA', 35.71, -97.43)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2235, N'Metzeral', 315, N'FRA', 48.02, 7.07)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2240, N'Claymont', 254, N'USA', 39.8, -75.46)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2274, N'Angers', 822, N'FRA', 47.47, -0.55)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2285, N'Sandpoint', 305, N'USA', 48.34, -116.45)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2290, N'Uberlândia', 586, N'BRA', -18.92, -48.3)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2321, N'z.... TRIAL VERSION from MYIP.MS ....', 218, N'USA', 44.3, -70.37)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2328, N'z.... TRIAL VERSION from MYIP.MS ....', 206, N'IND', 10.11, 76.36)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2338, N'Boise', 305, N'USA', 43.55, -116.29)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2372, N'Manaus', 838, N'BRA', -3.11, -60.03)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2374, N'Sonipat', 56, N'IND', 28.98, 77.02)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2385, N'Laramie', 667, N'USA', 41.43, -105.52)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2395, N'Besançon', 296, N'FRA', 47.25, 6.03)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2400, N'Brasília', 842, N'BRA', -15.78, -47.92)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2456, N'São José', 78, N'BRA', -27.63, -48.65)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2526, N'Jackson', 148, N'USA', 32.33, -90.2)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2568, N'Santa Fe', 132, N'USA', 35.68, -105.96)
GO
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2572, N'z.... TRIAL VERSION from MYIP.MS ....', 409, N'FRA', 43.37, 3.15)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2604, N'z.... TRIAL VERSION from MYIP.MS ....', 305, N'USA', 43.44, -116.32)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2643, N'z.... TRIAL VERSION from MYIP.MS ....', 148, N'USA', 30.42, -88.65)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2681, N'Rezonville', 556, N'FRA', 49.1, 6)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2725, N'Ogden', 49, N'USA', 41.22, -111.97)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2741, N'Fleet Post Office', 28, N'USA', 57, -100)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2766, N'Orem', 49, N'USA', 40.29, -111.72)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2864, N'Jandun', 469, N'FRA', 49.65, 4.55)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2882, N'z.... TRIAL VERSION from MYIP.MS ....', 132, N'USA', 32.68, -108.51)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2908, N'Blumenau', 78, N'BRA', -26.93, -49.05)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2973, N'Bismarck', 924, N'USA', 46.82, -100.71)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (2990, N'Prigonrieux', 729, N'FRA', 44.85, 0.4)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (3024, N'Bédée', 471, N'FRA', 48.18, -1.95)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (3029, N'Clermont-ferrand', 798, N'FRA', 45.78, 3.08)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (3045, N'Lincoln', 140, N'USA', 40.83, -96.67)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (3057, N'Woonsocket', 186, N'USA', 44.05, -98.3)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (3071, N'Guérande', 822, N'FRA', 47.33, -2.43)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (3073, N'Curitiba', 773, N'BRA', -25.42, -49.25)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (3079, N'Recife', 808, N'BRA', -8.05, -34.9)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (3082, N'Auxerre', 937, N'FRA', 47.8, 3.57)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (3093, N'Jaboatão', 808, N'BRA', -8.12, -35.02)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (3104, N'Omaha', 140, N'USA', 41.29, -96.17)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (3107, N'Cariacica', 80, N'BRA', -20.27, -40.42)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (3122, N'Anshan', 52, N'CHN', 41.12, 122.99)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (3138, N'z.... TRIAL VERSION from MYIP.MS ....', 49, N'USA', 41.69, -111.81)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (3145, N'Metz', 556, N'FRA', 49.13, 6.17)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (3162, N'Belém', 701, N'BRA', -1.45, -48.48)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (3202, N'Zaozhuang', 94, N'CHN', 34.86, 117.55)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (3239, N'Kalispell', 73, N'USA', 48.2, -114.39)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (3253, N'Beatrice', 140, N'USA', 40.26, -96.71)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (3260, N'z.... TRIAL VERSION from MYIP.MS ....', 140, N'USA', 40.87, -97.6)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (3275, N'Jackson', 667, N'USA', 43.46, -110.51)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (3281, N'Ferrisburg', 959, N'USA', 44.21, -73.22)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (3324, N'Scott Depot', 143, N'USA', 38.45, -81.89)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (3344, N'z.... TRIAL VERSION from MYIP.MS ....', 143, N'USA', 39.31, -78.05)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (3366, N'z.... TRIAL VERSION from MYIP.MS ....', 258, N'IND', 23.48, 87.32)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (3397, N'Westerly', 151, N'USA', 41.36, -71.8)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (3400, N'Goiânia', 970, N'BRA', -16.67, -49.27)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (3416, N'Jalandhar', 377, N'IND', 31.33, 75.58)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (3464, N'z.... TRIAL VERSION from MYIP.MS ....', 377, N'IND', 31.19, 75.99)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (3514, N'Mulhouse', 315, N'FRA', 47.75, 7.33)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (3552, N'z.... TRIAL VERSION from MYIP.MS ....', 17, N'CHN', 23.08, 114.4)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (3568, N'Jilin', 334, N'CHN', 43.85, 126.56)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (3620, N'Valdoie', 296, N'FRA', 47.67, 6.85)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (3660, N'z.... TRIAL VERSION from MYIP.MS ....', 315, N'FRA', 48.77, 7.98)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (3668, N'Shimla', 1008, N'IND', 31.1, 77.17)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (3682, N'Nagar', 306, N'IND', 27.43, 77.1)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (3685, N'Aracaju', 1011, N'BRA', -10.92, -37.07)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (3703, N'z.... TRIAL VERSION from MYIP.MS ....', 56, N'IND', 28.18, 76.62)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (3778, N'Itaboraí', 37, N'BRA', -22.75, -42.87)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (3792, N'Guipavas', 471, N'FRA', 48.43, -4.4)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (3873, N'z.... TRIAL VERSION from MYIP.MS ....', 471, N'FRA', 48.57, 2.3)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (3893, N'Daman', 676, N'IND', 20.42, 72.85)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (3897, N'Camden Wyoming', 254, N'USA', 39.08, -75.61)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (3991, N'Nantes', 822, N'FRA', 47.22, -1.55)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (4008, N'Eagle River', 1061, N'USA', 61.21, -149.26)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (4017, N'Montreuil-bellay', 822, N'FRA', 47.13, -0.15)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (4042, N'z.... TRIAL VERSION from MYIP.MS ....', 822, N'FRA', 48, 0.2)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (4046, N'Juziers', 635, N'FRA', 49, 1.85)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (4071, N'Flers', 708, N'FRA', 48.75, -0.57)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (4087, N'Raipur', 225, N'IND', 21.23, 81.63)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (4103, N'Viamão', 561, N'BRA', -30.08, -51.03)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (4116, N'Saint-pierre-du-palais', 649, N'FRA', 45.17, -0.15)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (4158, N'Chalon-sur-saône', 937, N'FRA', 46.78, 4.85)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (4166, N'Hebei', 6, N'CHN', 39.82, 115.94)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (4219, N'Woonsocket', 151, N'USA', 42, -71.49)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (4274, N'Rouen', 635, N'FRA', 49.43, 1.08)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (4282, N'Gillette', 667, N'USA', 43.9, -105.55)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (4290, N'Rai', 708, N'FRA', 48.75, 0.58)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (4324, N'Ponta Porã', 1102, N'BRA', -22.53, -55.72)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (4331, N'Bellême', 708, N'FRA', 48.37, 0.57)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (4365, N'z.... TRIAL VERSION from MYIP.MS ....', 667, N'USA', 42.65, -105.87)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (4370, N'Le Havre', 635, N'FRA', 49.5, 0.13)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (4384, N'Beawar', 306, N'IND', 26.1, 74.32)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (4388, N'z.... TRIAL VERSION from MYIP.MS ....', 296, N'FRA', 46.9, 6.37)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (4435, N'Hombourg-haut', 556, N'FRA', 49.13, 6.77)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (4446, N'Dijon', 937, N'FRA', 47.32, 5.02)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (4490, N'Lamarche-sur-saône', 937, N'FRA', 47.27, 5.38)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (4533, N'Gulbarga', 160, N'IND', 17.33, 76.83)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (4573, N'z.... TRIAL VERSION from MYIP.MS ....', 469, N'FRA', 48.3, 4.05)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (4670, N'z.... TRIAL VERSION from MYIP.MS ....', 306, N'IND', 26.29, 73.03)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (4674, N'Lajeado', 561, N'BRA', -29.45, -51.97)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (4717, N'Livingston', 73, N'USA', 45.71, -110.54)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (4777, N'z.... TRIAL VERSION from MYIP.MS ....', 937, N'FRA', 47.32, 5.12)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (4795, N'Seward', 1061, N'USA', 60.06, -149.34)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (4810, N'Providence', 151, N'USA', 41.83, -71.4)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (4820, N'Caruaru', 808, N'BRA', -8.28, -35.97)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (4823, N'z.... TRIAL VERSION from MYIP.MS ....', 160, N'IND', 14.85, 74.43)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (4827, N'Castelo', 80, N'BRA', -20.6, -41.2)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (4833, N'z.... TRIAL VERSION from MYIP.MS ....', 151, N'USA', 41.96, -71.43)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (4861, N'z.... TRIAL VERSION from MYIP.MS ....', 254, N'USA', 39.48, -75.67)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (4894, N'Ychoux', 729, N'FRA', 44.33, -0.95)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (4912, N'Marsac', 729, N'FRA', 45.05, -0.68)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (4958, N'Juneau', 1061, N'USA', 58.58, -134.77)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (4977, N'Paranoá', 842, N'BRA', -15.83, -47.82)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (4978, N'Perpezac-le-noir', 598, N'FRA', 45.32, 1.55)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (4992, N'z.... TRIAL VERSION from MYIP.MS ....', 186, N'USA', 42.94, -97.44)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (5012, N'Issoire', 798, N'FRA', 45.55, 3.25)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (5015, N'z.... TRIAL VERSION from MYIP.MS ....', 635, N'FRA', 49.52, 0.55)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (5119, N'Thouars', 649, N'FRA', 46.97, -0.22)
GO
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (5152, N'Kunming', 1178, N'CHN', 25.04, 102.72)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (5273, N'Beihai', 90, N'CHN', 21.48, 109.1)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (5436, N'Fairbanks', 1061, N'USA', 64.82, -147.72)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (5483, N'Saint-julien-l''ars', 649, N'FRA', 46.55, 0.5)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (5496, N'Wuxi', 12, N'CHN', 31.58, 120.29)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (5509, N'z.... TRIAL VERSION from MYIP.MS ....', 649, N'FRA', 45.75, -0.63)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (5510, N'Dehra Dun', 1200, N'IND', 30.32, 78.03)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (5537, N'Shillong', 1203, N'IND', 25.58, 91.87)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (5602, N'Chambre', 798, N'FRA', 45.2, 2.37)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (5607, N'z.... TRIAL VERSION from MYIP.MS ....', 1061, N'USA', 61.08, -149.71)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (5644, N'z.... TRIAL VERSION from MYIP.MS ....', 729, N'FRA', 43.48, -1.48)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (5713, N'Cachoeiro De Itapemirim', 80, N'BRA', -20.85, -41.1)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (5753, N'z.... TRIAL VERSION from MYIP.MS ....', 556, N'FRA', 48.38, 5.48)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (5793, N'z.... TRIAL VERSION from MYIP.MS ....', 37, N'BRA', -22.51, -43.18)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (5809, N'Nanchang', 1231, N'CHN', 28.55, 115.93)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (5936, N'Londrina', 773, N'BRA', -23.3, -51.15)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (6013, N'Lyndonville', 959, N'USA', 44.53, -72.05)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (6119, N'z.... TRIAL VERSION from MYIP.MS ....', 708, N'FRA', 49.18, -0.35)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (6122, N'Sibsagar', 416, N'IND', 26.98, 94.63)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (6239, N'z.... TRIAL VERSION from MYIP.MS ....', 561, N'BRA', -29.03, -51.18)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (6246, N'Barre', 959, N'USA', 44.18, -72.47)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (6263, N'z.... TRIAL VERSION from MYIP.MS ....', 73, N'USA', 46.38, -112.72)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (6325, N'Natal', 1269, N'BRA', -5.78, -35.22)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (6409, N'Kumar', 1008, N'IND', 33.03, 76.45)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (6537, N'Contagem', 586, N'BRA', -19.92, -44.1)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (6720, N'z.... TRIAL VERSION from MYIP.MS ....', 798, N'FRA', 46.38, 3.77)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (6724, N'Cajàzeiras', 1293, N'BRA', -6.9, -38.57)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (6740, N'z.... TRIAL VERSION from MYIP.MS ....', 78, N'BRA', -26.88, -48.65)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (6780, N'Simões', 1297, N'BRA', -7.6, -40.82)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (6781, N'Qinghai', 600, N'CHN', 25.81, 106.07)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (6821, N'z.... TRIAL VERSION from MYIP.MS ....', 12, N'CHN', 31.38, 120.95)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (6868, N'Shangdi', 77, N'CHN', 26.13, 117.98)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (6906, N'Devils Lake', 924, N'USA', 48.14, -98.89)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (6988, N'Lanzhou', 1310, N'CHN', 36.06, 103.79)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (7006, N'Jatni', 317, N'IND', 20.17, 85.7)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (7024, N'Kundan', 1312, N'IND', 33.8, 74.26)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (7055, N'Hubei', 1231, N'CHN', 26.89, 114.53)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (7105, N'Jamshedpur', 355, N'IND', 22.8, 86.18)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (7235, N'Teresina', 1297, N'BRA', -5.08, -42.82)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (7245, N'z.... TRIAL VERSION from MYIP.MS ....', 808, N'BRA', -7.83, -34.9)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (7251, N'Colva', 1334, N'IND', 15.27, 73.92)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (7311, N'São Luís', 1335, N'BRA', -2.52, -44.27)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (7349, N'Itabira', 586, N'BRA', -19.62, -43.22)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (7496, N'Shelburne', 959, N'USA', 44.4, -73.21)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (7604, N'z.... TRIAL VERSION from MYIP.MS ....', 598, N'FRA', 45.9, 1.32)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (7688, N'West Fargo', 924, N'USA', 46.89, -96.93)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (7720, N'Fargo', 924, N'USA', 46.93, -96.83)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (7747, N'União Da Victoria', 773, N'BRA', -26.22, -51.08)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (7790, N'z.... TRIAL VERSION from MYIP.MS ....', 773, N'BRA', -25.87, -49.37)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (7907, N'z.... TRIAL VERSION from MYIP.MS ....', 959, N'USA', 44.49, -73.23)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (7915, N'z.... TRIAL VERSION from MYIP.MS ....', 586, N'BRA', -19.58, -46.92)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (8089, N'Pôrto Seguro', 121, N'BRA', -16.43, -39.08)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (8200, N'Barpeta', 416, N'IND', 26.32, 91)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (8304, N'Solon', 1008, N'IND', 30.92, 77.12)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (8479, N'Haldwani', 1200, N'IND', 29.22, 79.52)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (8747, N'Campina Grande', 1293, N'BRA', -7.22, -35.88)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (8828, N'João Pessoa', 1293, N'BRA', -7.12, -34.87)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (8881, N'Campo Grande', 1102, N'BRA', -20.45, -54.62)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (8953, N'z.... TRIAL VERSION from MYIP.MS ....', 924, N'USA', 48.14, -101.34)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (9077, N'Jiaozuo', 196, N'CHN', 35.24, 113.23)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (9299, N'Tongzhou', 6, N'CHN', 39.91, 116.6)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (9322, N'Udhampur', 1312, N'IND', 32.93, 75.13)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (9351, N'z.... TRIAL VERSION from MYIP.MS ....', 52, N'CHN', 38.91, 121.6)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (9417, N'Panaji', 1334, N'IND', 15.48, 73.83)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (9446, N'Muzaffarpur', 728, N'IND', 26.12, 85.4)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (9548, N'Rondonópolis', 1457, N'BRA', -16.47, -54.63)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (9981, N'z.... TRIAL VERSION from MYIP.MS ....', 80, N'BRA', -19.82, -40.27)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (10162, N'Ajaccio', 1483, N'FRA', 41.92, 8.73)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (10196, N'Itanagar', 1334, N'IND', 27.1, 93.62)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (10354, N'Begusarai', 728, N'IND', 25.42, 86.13)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (10358, N'Jaypur', 317, N'IND', 18.85, 82.58)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (10739, N'Crato', 46, N'BRA', -7.23, -39.38)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (10936, N'Guarabira', 1293, N'BRA', -6.85, -35.48)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (11046, N'Biguglia', 1483, N'FRA', 42.62, 9.42)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (11180, N'Tabuleiro Do Norte', 46, N'BRA', -5.25, -38.12)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (11414, N'z.... TRIAL VERSION from MYIP.MS ....', 94, N'CHN', 36.79, 118.06)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (12462, N'Jiujiang', 1231, N'CHN', 29.62, 115.88)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (12661, N'Madgaon', 1334, N'IND', 15.3, 73.95)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (12805, N'Maceió', 1568, N'BRA', -9.67, -35.72)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (13251, N'z.... TRIAL VERSION from MYIP.MS ....', 317, N'IND', 22.2, 84.88)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (13310, N'Bhilai', 225, N'IND', 21.22, 81.43)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (13326, N'Rishikesh', 1200, N'IND', 30.12, 78.32)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (13333, N'Haridwar', 1200, N'IND', 29.97, 78.17)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (13413, N'Murici', 1568, N'BRA', -9.32, -35.93)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (13597, N'Pondicherry', 1596, N'IND', 11.93, 79.83)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (13652, N'Anápolis', 970, N'BRA', -16.33, -48.97)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (13669, N'Lichuan', 99, N'CHN', 30.3, 108.85)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (13687, N'Juazeiro Do Norte', 46, N'BRA', -7.2, -39.33)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (13749, N'Furiani', 1483, N'FRA', 42.65, 9.42)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (13880, N'Macau', 1269, N'BRA', -5.12, -36.63)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (13884, N'Xianyang', 268, N'CHN', 34.34, 108.71)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (14005, N'Hunyuan', 156, N'CHN', 39.7, 113.68)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (14207, N'z.... TRIAL VERSION from MYIP.MS ....', 1200, N'IND', 29.22, 78.95)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (14628, N'Speloncato', 1483, N'FRA', 42.57, 8.97)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (15367, N'Imphal', 1654, N'IND', 24.82, 93.95)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (15812, N'Jammu', 1312, N'IND', 32.73, 74.87)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (15961, N'Salvador', 1673, N'BRA', -10.17, -48.87)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (16094, N'Ananindeua', 701, N'BRA', -1.37, -48.38)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (16160, N'z.... TRIAL VERSION from MYIP.MS ....', 1334, N'IND', 15.4, 73.83)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (16190, N'Fengtai', 6, N'CHN', 39.85, 116.27)
GO
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (16259, N'Hengyang', 161, N'CHN', 26.89, 112.61)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (16264, N'Ujjain', 274, N'IND', 23.18, 75.77)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (16275, N'Dhanbad', 355, N'IND', 23.8, 86.45)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (16378, N'Itabuna', 121, N'BRA', -14.8, -39.27)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (17611, N'Nossa Senhora Do Socorro', 1011, N'BRA', -10.87, -37.12)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (17737, N'Bonfim', 1714, N'BRA', 3.08, -59.95)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (17979, N'Yalongwan', 178, N'CHN', 18.23, 109.7)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (18098, N'Luziânia', 970, N'BRA', -16.25, -47.93)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (18197, N'Ji-paraná', 1723, N'BRA', -10.83, -61.97)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (18404, N'z.... TRIAL VERSION from MYIP.MS ....', 274, N'IND', 26.22, 78.18)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (18582, N'z.... TRIAL VERSION from MYIP.MS ....', 77, N'CHN', 24.91, 118.59)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (18611, N'Bokaro', 355, N'IND', 23.78, 85.97)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (18695, N'Liaohe', 307, N'CHN', 43.73, 122.3)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (18796, N'Lhasa', 1736, N'CHN', 29.65, 91.1)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (18798, N'z.... TRIAL VERSION from MYIP.MS ....', 355, N'IND', 23.98, 85.35)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (18997, N'Yuzhou', 196, N'CHN', 34.16, 113.46)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (19012, N'Yinchuan', 1741, N'CHN', 38.47, 106.27)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (19021, N'Tongji', 182, N'CHN', 31.18, 103.5)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (19030, N'Jingzhou', 99, N'CHN', 30.35, 112.19)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (19032, N'Camaçari', 121, N'BRA', -12.48, -38.22)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (19039, N'Enshi', 99, N'CHN', 30.3, 109.48)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (19061, N'Kaitai', 600, N'CHN', 26.23, 109.13)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (19239, N'Ürümqi', 1751, N'CHN', 43.8, 87.58)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (19258, N'z.... TRIAL VERSION from MYIP.MS ....', 1293, N'BRA', -7.13, -34.93)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (19263, N'Delhi Sabzimandi', 100, N'IND', 28.68, 77.2)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (19269, N'Huangzhong', 1753, N'CHN', 36.5, 101.6)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (19498, N'Liaoyüan', 334, N'CHN', 43.51, 123.51)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (19523, N'Yünnan', 1178, N'CHN', 25.48, 100.58)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (19552, N'Brazlândia', 842, N'BRA', -15.68, -48.2)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (19663, N'z.... TRIAL VERSION from MYIP.MS ....', 99, N'CHN', 30.4, 114.83)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (19898, N'z.... TRIAL VERSION from MYIP.MS ....', 6, N'CHN', 39.98, 116.3)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (19925, N'z.... TRIAL VERSION from MYIP.MS ....', 100, N'IND', 28.57, 77.1)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (19935, N'z.... TRIAL VERSION from MYIP.MS ....', 196, N'CHN', 33.87, 113.07)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (19955, N'Samastipur', 728, N'IND', 25.85, 85.78)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (20013, N'Fortaleza', 1673, N'BRA', -5.98, -48.13)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (20245, N'Baotou', 178, N'CHN', 18.33, 109.53)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (20337, N'Nanping', 97, N'CHN', 29.09, 106.99)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (20370, N'Jiahe', 161, N'CHN', 25.55, 112.25)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (20435, N'Ning', 1310, N'CHN', 35.5, 107.92)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (20477, N'z.... TRIAL VERSION from MYIP.MS ....', 161, N'CHN', 26.23, 112.95)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (20537, N'Mandi', 1008, N'IND', 31.72, 76.92)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (20612, N'z.... TRIAL VERSION from MYIP.MS ....', 1483, N'FRA', 42.57, 8.75)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (20756, N'Mudanjiang', 123, N'CHN', 44.58, 129.6)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (20908, N'Chüan', 90, N'CHN', 25.95, 111.07)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (20937, N'Baodi', 64, N'CHN', 39.72, 117.3)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (21166, N'Aizawl', 1791, N'IND', 23.72, 92.72)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (21220, N'Srinagar', 1312, N'IND', 34.09, 74.8)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (21470, N'Kashi', 1751, N'CHN', 39.45, 75.98)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (21536, N'Japoatã', 1011, N'BRA', -10.33, -36.8)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (21544, N'Itumbiara', 970, N'BRA', -18.42, -49.22)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (21578, N'Youyi', 123, N'CHN', 46.78, 131.81)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (21700, N'Mianyang', 182, N'CHN', 31.47, 104.77)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (21729, N'Longnan', 1231, N'CHN', 24.9, 114.78)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (22001, N'z.... TRIAL VERSION from MYIP.MS ....', 46, N'BRA', -3.88, -40.38)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (22243, N'Shannan', 268, N'CHN', 33.53, 110.87)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (22740, N'São Bernardo', 1335, N'BRA', -3.37, -42.4)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (22772, N'Fenghua', 334, N'CHN', 43.3, 124.33)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (22793, N'Yongkang', 156, N'CHN', 37.63, 112.59)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (23177, N'z.... TRIAL VERSION from MYIP.MS ....', 1008, N'IND', 31.24, 77.04)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (23243, N'Tianheng', 90, N'CHN', 22.49, 110.04)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (23407, N'z.... TRIAL VERSION from MYIP.MS ....', 156, N'CHN', 37.1, 112.9)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (23661, N'z.... TRIAL VERSION from MYIP.MS ....', 90, N'CHN', 24.31, 109.39)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (23889, N'Wuwei', 1310, N'CHN', 37.93, 102.64)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (24182, N'Palmas', 1673, N'BRA', -10.22, -48.28)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (24330, N'z.... TRIAL VERSION from MYIP.MS ....', 1231, N'CHN', 27.8, 114.93)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (24394, N'z.... TRIAL VERSION from MYIP.MS ....', 121, N'BRA', -12.75, -38.17)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (24533, N'Baoding', 11, N'CHN', 38.85, 115.49)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (24777, N'Tefé', 838, N'BRA', -3.37, -64.7)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (24811, N'z.... TRIAL VERSION from MYIP.MS ....', 11, N'CHN', 38.32, 116.87)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (24819, N'Xiangshan', 182, N'CHN', 31.04, 105.19)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (25071, N'Haiyan', 1753, N'CHN', 36.89, 101)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (25097, N'Nova Olímpia', 1457, N'BRA', -14.82, -57.33)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (25359, N'Silvassa', 1846, N'IND', 20.27, 73.02)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (25466, N'Lasa', 1736, N'CHN', 29.65, 91.1)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (25620, N'z.... TRIAL VERSION from MYIP.MS ....', 970, N'BRA', -17.88, -51.72)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (25778, N'Huhehot', 307, N'CHN', 40.81, 111.65)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (25784, N'Karaikal', 1596, N'IND', 10.92, 79.83)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (25786, N'Korba', 225, N'IND', 22.35, 82.68)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (26150, N'Santo Antônio', 1269, N'BRA', -6.3, -35.45)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (26247, N'z.... TRIAL VERSION from MYIP.MS ....', 334, N'CHN', 43.92, 126.94)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (26490, N'z.... TRIAL VERSION from MYIP.MS ....', 182, N'CHN', 31.04, 105.98)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (26530, N'Shizuishan', 1741, N'CHN', 39.04, 106.4)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (26916, N'Xining', 1753, N'CHN', 36.62, 101.77)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (26930, N'Xinyuan', 1751, N'CHN', 43.45, 83.15)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (26936, N'Fengxiang', 268, N'CHN', 34.52, 107.39)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (28156, N'Hong', 1874, N'IND', 27.57, 93.85)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (28491, N'z.... TRIAL VERSION from MYIP.MS ....', 268, N'CHN', 34.65, 109.95)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (28562, N'Gannan', 123, N'CHN', 47.91, 123.5)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (28975, N'z.... TRIAL VERSION from MYIP.MS ....', 123, N'CHN', 50.25, 125.47)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (29140, N'Dong', 1178, N'CHN', 28.5, 98.87)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (29678, N'Santa Isabel Do Pará', 701, N'BRA', -1.27, -48.18)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (29753, N'z.... TRIAL VERSION from MYIP.MS ....', 416, N'IND', 26.33, 90.67)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (29818, N'Cuiabá', 1457, N'BRA', -15.58, -56.08)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (30109, N'z.... TRIAL VERSION from MYIP.MS ....', 728, N'IND', 25.25, 87)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (30346, N'z.... TRIAL VERSION from MYIP.MS ....', 701, N'BRA', -1.88, -48.77)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (30811, N'Jiayuguan', 1310, N'CHN', 39.82, 98.3)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (30820, N'z.... TRIAL VERSION from MYIP.MS ....', 1310, N'CHN', 35.54, 106.69)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (31103, N'Parnaíba', 1297, N'BRA', -2.91, -41.77)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (32167, N'Pudong', 62, N'CHN', 31.24, 121.5)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (32668, N'Agartala', 1918, N'IND', 23.84, 91.28)
GO
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (33109, N'São José De Ribamar', 1335, N'BRA', -2.55, -44.05)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (33134, N'z.... TRIAL VERSION from MYIP.MS ....', 178, N'CHN', 18.79, 109.77)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (33154, N'Ceilândia', 842, N'BRA', -15.82, -48.12)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (34046, N'Marechal Deodoro', 1568, N'BRA', -9.72, -35.9)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (34232, N'Kaiyuan', 1178, N'CHN', 23.71, 103.25)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (34757, N'Taiping', 97, N'CHN', 29.9, 106.04)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (35007, N'Eldorado', 1102, N'BRA', -23.78, -54.32)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (35293, N'Wuma', 600, N'CHN', 27.64, 106.25)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (35792, N'Pôrto Velho', 1723, N'BRA', -8.77, -63.9)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (37024, N'Jing', 1751, N'CHN', 44.65, 82.83)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (37198, N'Daan', 97, N'CHN', 29.38, 106.01)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (37384, N'z.... TRIAL VERSION from MYIP.MS ....', 1178, N'CHN', 25.33, 103.63)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (37496, N'z.... TRIAL VERSION from MYIP.MS ....', 600, N'CHN', 26, 105.08)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (37696, N'z.... TRIAL VERSION from MYIP.MS ....', 97, N'CHN', 29.57, 106)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (41443, N'Huochezhan', 1741, N'CHN', 38.96, 106.47)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (41456, N'Zhangpu', 236, N'CHN', 32.76, 118.79)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (41598, N'z.... TRIAL VERSION from MYIP.MS ....', 1751, N'CHN', 43.88, 81.25)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (41651, N'Shou', 236, N'CHN', 32.57, 116.77)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (41664, N'Xiangyang', 236, N'CHN', 29.93, 117.94)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (41683, N'z.... TRIAL VERSION from MYIP.MS ....', 236, N'CHN', 32.9, 115.82)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (41822, N'Kecheng', 1753, N'CHN', 37.08, 97.69)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (41856, N'Lang', 1736, N'CHN', 29.05, 93.2)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (41872, N'Putuo', 62, N'CHN', 31.24, 121.42)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (41885, N'Yuan', 62, N'CHN', 31.53, 121.84)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (41907, N'Jianming', 64, N'CHN', 39, 117.31)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (41916, N'z.... TRIAL VERSION from MYIP.MS ....', 1753, N'CHN', 35.75, 100.25)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (47012, N'Tanggu', 64, N'CHN', 39.02, 117.65)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (62738, N'z.... TRIAL VERSION from MYIP.MS ....', 225, N'IND', 22.08, 82.15)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (62773, N'Tongliao', 307, N'CHN', 43.61, 122.27)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (62786, N'Huibei', 1741, N'CHN', 38.98, 106.65)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (62903, N'z.... TRIAL VERSION from MYIP.MS ....', 307, N'CHN', 40.81, 111.65)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (63008, N'z.... TRIAL VERSION from MYIP.MS ....', 1312, N'IND', 32.98, 74.86)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (63095, N'Nima', 1736, N'CHN', 31.92, 87.88)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (63097, N'z.... TRIAL VERSION from MYIP.MS ....', 1736, N'CHN', 29.38, 85.37)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (63186, N'z.... TRIAL VERSION from MYIP.MS ....', 1741, N'CHN', 39.04, 106.4)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (63323, N'Lagarto', 1011, N'BRA', -10.9, -37.68)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (63341, N'Rio Verde De Mato Grosso', 1102, N'BRA', -18.93, -54.87)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (64419, N'z.... TRIAL VERSION from MYIP.MS ....', 842, N'BRA', -15.83, -47.9)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (64681, N'São Miguel Dos Campos', 1568, N'BRA', -9.78, -36.08)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (66383, N'São Paulo', 2113, N'BRA', -23.53, -46.62)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (66490, N'Mercês', 2116, N'BRA', -9.52, -68.7)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (66621, N'Cacoal', 1723, N'BRA', -11.5, -61.42)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (66622, N'Rio Branco', 2116, N'BRA', -9.97, -67.8)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (66623, N'Ariquemes', 1723, N'BRA', -9.93, -63.07)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (66654, N'Imperatriz', 1335, N'BRA', -5.53, -47.48)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (66664, N'z.... TRIAL VERSION from MYIP.MS ....', 1102, N'BRA', -21.87, -56.53)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (66696, N'Barra Do Garças', 1457, N'BRA', -15.88, -52.25)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (66701, N'Mossoró', 1269, N'BRA', -5.19, -37.34)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (66702, N'Macapá', 2113, N'BRA', 0.03, -51.05)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (66706, N'z.... TRIAL VERSION from MYIP.MS ....', 1723, N'BRA', -12.31, -60.64)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (66713, N'Pádua', 838, N'BRA', -7.33, -62.92)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (66723, N'z.... TRIAL VERSION from MYIP.MS ....', 1335, N'BRA', -7.52, -46.03)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (66726, N'Caracaraí', 1714, N'BRA', 1.83, -61.13)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (66727, N'Boa Vista', 1714, N'BRA', 2.82, -60.67)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (66739, N'Araguaína', 1673, N'BRA', -7.16, -48.06)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (66740, N'z.... TRIAL VERSION from MYIP.MS ....', 1673, N'BRA', -11.72, -49.01)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (66741, N'Cocal', 1297, N'BRA', -3.47, -41.57)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (66752, N'Júlia', 838, N'BRA', -1.62, -67.98)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (66772, N'z.... TRIAL VERSION from MYIP.MS ....', 1457, N'BRA', -15.65, -56.13)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (66807, N'z.... TRIAL VERSION from MYIP.MS ....', 1011, N'BRA', -10.8, -37.17)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (66826, N'z.... TRIAL VERSION from MYIP.MS ....', 1269, N'BRA', -5.6, -35.62)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (66854, N'z.... TRIAL VERSION from MYIP.MS ....', 1568, N'BRA', -10.28, -36.4)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (66910, N'z.... TRIAL VERSION from MYIP.MS ....', 838, N'BRA', -4.07, -65.08)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (66921, N'z.... TRIAL VERSION from MYIP.MS ....', 1297, N'BRA', -4.48, -41.5)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (66936, N'Oiapoque', 2113, N'BRA', 3.83, -51.83)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (67011, N'Consolação', 1714, N'BRA', 3.93, -60.98)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (67207, N'z.... TRIAL VERSION from MYIP.MS ....', 62, N'CHN', 30.88, 121.87)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (67585, N'z.... TRIAL VERSION from MYIP.MS ....', 64, N'CHN', 39.14, 117.18)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (75660, N'z.... TRIAL VERSION from MYIP.MS ....', 1714, N'BRA', 3.83, -60.22)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (75883, N'Gangtok', 2320, N'IND', 27.33, 88.62)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (77715, N'Kohima', 2370, N'IND', 25.67, 94.12)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (79131, N'Minas Gerais', 2116, N'BRA', -8.97, -72.78)
INSERT [dbo].[cities] ([cityID], [cityName], [stateID], [countryID], [latitude], [longitude]) VALUES (79674, N'Washington D.c', 249, N'USA', 38.9, -77.04)
INSERT [dbo].[countries] ([countryID], [countryName], [localName], [webCode], [region], [continent], [latitude], [longitude], [surfaceArea], [population]) VALUES (N'BRA', N'Brazil', N'Brasil', N'BR', N'South America', N'South America', -10, -55, 8547403, 170115000)
INSERT [dbo].[countries] ([countryID], [countryName], [localName], [webCode], [region], [continent], [latitude], [longitude], [surfaceArea], [population]) VALUES (N'CHN', N'China', N'Zhongquo', N'CN', N'Eastern Asia', N'Asia', 35, 105, 9572900, 1277558000)
INSERT [dbo].[countries] ([countryID], [countryName], [localName], [webCode], [region], [continent], [latitude], [longitude], [surfaceArea], [population]) VALUES (N'FRA', N'France', N'', N'FR', N'Western Europe', N'Europe', 47, 2, 551500, 59225700)
INSERT [dbo].[countries] ([countryID], [countryName], [localName], [webCode], [region], [continent], [latitude], [longitude], [surfaceArea], [population]) VALUES (N'IND', N'India', N'Bharat/India', N'IN', N'Southern and Central Asia', N'Asia', 28.47, 77.03, 3287263, 1013662000)
INSERT [dbo].[countries] ([countryID], [countryName], [localName], [webCode], [region], [continent], [latitude], [longitude], [surfaceArea], [population]) VALUES (N'USA', N'USA', N'United States', N'US', N'North America', N'North America', 38, -97, 9363520, 278357000)
SET IDENTITY_INSERT [dbo].[DateRange] ON 

INSERT [dbo].[DateRange] ([Id], [FromDate], [Todate]) VALUES (1, CAST(0x0000A69400000000 AS DateTime), CAST(0x0000A69500000000 AS DateTime))
INSERT [dbo].[DateRange] ([Id], [FromDate], [Todate]) VALUES (10002, CAST(0x0000A6DB00000000 AS DateTime), CAST(0x0000A6DC00000000 AS DateTime))
INSERT [dbo].[DateRange] ([Id], [FromDate], [Todate]) VALUES (10003, CAST(0x0000A70D00000000 AS DateTime), CAST(0x0000A6EE00000000 AS DateTime))
INSERT [dbo].[DateRange] ([Id], [FromDate], [Todate]) VALUES (10004, CAST(0x0000A71D00000000 AS DateTime), CAST(0x0000A72800000000 AS DateTime))
SET IDENTITY_INSERT [dbo].[DateRange] OFF
SET IDENTITY_INSERT [dbo].[GeoLocation] ON 

INSERT [dbo].[GeoLocation] ([Id], [GeoLocationAddress], [Latitude], [Longiude]) VALUES (1, N'Gujarat, India', N'22.258652', N'71.19238050000001')
INSERT [dbo].[GeoLocation] ([Id], [GeoLocationAddress], [Latitude], [Longiude]) VALUES (2, N'Ahmedabad, Gujarat, India', N'23.022505', N'72.57136209999999')
INSERT [dbo].[GeoLocation] ([Id], [GeoLocationAddress], [Latitude], [Longiude]) VALUES (11, N'Asda Beckton Superstore, Tollgate Road, London, United Kingdom', N'51.5147501', N'0.05839560000003985')
SET IDENTITY_INSERT [dbo].[GeoLocation] OFF
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (5, N'California', N'USA', 37.42, -122.06)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (6, N'Beijing', N'CHN', 39.93, 116.39)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (9, N'Iowa', N'USA', 43.03, -96.09)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (10, N'New York', N'USA', 40.76, -73.97)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (11, N'Hebei', N'CHN', 39.89, 115.28)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (12, N'Jiangsu', N'CHN', 32.06, 118.78)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (14, N'New Jersey', N'USA', 39.82, -75.13)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (15, N'Massachusetts', N'USA', 42.56, -72.18)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (16, N'Connecticut', N'USA', 41.14, -73.26)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (17, N'Guangdong', N'CHN', 23.12, 113.25)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (19, N'Florida', N'USA', 28.05, -82.36)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (24, N'Texas', N'USA', 30.27, -97.74)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (28, N'Armed Forces US', N'USA', 60, -100)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (32, N'Tennessee', N'USA', 35.04, -89.93)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (33, N'Kentucky', N'USA', 39.02, -84.56)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (34, N'Ile-de-France', N'FRA', 48.8, 2.5)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (35, N'Georgia', N'USA', 33.84, -84.38)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (37, N'Rio de Janeiro', N'BRA', -22.9, -43.23)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (44, N'Illinois', N'USA', 42.05, -88.05)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (46, N'Ceara', N'BRA', -3.32, -41.42)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (47, N'Colorado', N'USA', 39.74, -104.98)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (48, N'Zhejiang', N'CHN', 28.02, 120.65)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (49, N'Utah', N'USA', 40.76, -111.89)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (52, N'Liaoning', N'CHN', 41.79, 123.43)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (56, N'Haryana', N'IND', 28.47, 77.03)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (57, N'Maryland', N'USA', 39.1, -76.88)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (62, N'Shanghai', N'CHN', 31, 121.41)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (64, N'Tianjin', N'CHN', 39.14, 117.18)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (72, N'South Carolina', N'USA', 33.92, -80.34)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (73, N'Montana', N'USA', 45.77, -110.93)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (76, N'Louisiana', N'USA', 29.91, -90.05)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (77, N'Fujian', N'CHN', 24.47, 118.09)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (78, N'Santa Catarina', N'BRA', -26.48, -49.07)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (80, N'Espirito Santo', N'BRA', -20.12, -40.3)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (84, N'Washington', N'USA', 47.09, -122.65)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (85, N'Andhra Pradesh', N'IND', 17.38, 78.47)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (87, N'Pennsylvania', N'USA', 40.45, -79.99)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (90, N'Guangxi', N'CHN', 22.82, 108.32)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (93, N'North Carolina', N'USA', 35.75, -78.72)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (94, N'Shandong', N'CHN', 37.26, 117.08)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (97, N'Chongqing', N'CHN', 29.56, 106.55)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (98, N'Michigan', N'USA', 43.93, -86.26)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (99, N'Hubei', N'CHN', 30.58, 114.27)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (100, N'Delhi', N'IND', 28.67, 77.22)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (101, N'Arkansas', N'USA', 36.19, -94.24)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (107, N'Wisconsin', N'USA', 44.63, -90.2)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (112, N'Midi-Pyrenees', N'FRA', 43.73, 1.42)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (116, N'Picardie', N'FRA', 49.02, 1.9)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (121, N'Bahia', N'BRA', -12.98, -38.52)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (123, N'Heilongjiang', N'CHN', 45.75, 126.65)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (128, N'Tamil Nadu', N'IND', 13.08, 80.28)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (129, N'Ohio', N'USA', 39.11, -84.5)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (132, N'New Mexico', N'USA', 35.78, -105.87)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (133, N'Kansas', N'USA', 37.69, -97.34)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (136, N'Oregon', N'USA', 45.44, -122.97)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (138, N'Uttar Pradesh', N'IND', 27.18, 78.02)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (140, N'Nebraska', N'USA', 41.11, -95.93)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (143, N'West Virginia', N'USA', 39.46, -77.95)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (144, N'Virginia', N'USA', 37.13, -76.45)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (145, N'Missouri', N'USA', 38.25, -94.31)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (148, N'Mississippi', N'USA', 32.37, -90.11)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (151, N'Rhode Island', N'USA', 41.82, -71.41)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (155, N'Sao Paulo', N'BRA', -23.95, -46.33)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (156, N'Shanxi', N'CHN', 37.9, 112.19)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (160, N'Karnataka', N'IND', 12.98, 77.58)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (161, N'Hunan', N'CHN', 26.97, 109.77)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (163, N'Indiana', N'USA', 39.79, -86.17)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (164, N'Oklahoma', N'USA', 34.66, -98.48)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (175, N'Minnesota', N'USA', 44.98, -93.27)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (176, N'Alabama', N'USA', 33.8, -87.28)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (178, N'Hainan', N'CHN', 19.14, 110.48)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (181, N'Arizona', N'USA', 33.46, -111.99)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (182, N'Sichuan', N'CHN', 30.67, 104.07)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (186, N'South Dakota', N'USA', 43.72, -98.03)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (187, N'Maharashtra', N'IND', 18.98, 72.83)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (192, N'Nevada', N'USA', 36.17, -115.28)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (196, N'Henan', N'CHN', 34.22, 113.77)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (206, N'Kerala', N'IND', 8.51, 76.96)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (215, N'New Hampshire', N'USA', 42.87, -71.39)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (218, N'Maine', N'USA', 44.08, -70.17)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (220, N'Hawaii', N'USA', 21.3, -157.79)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (225, N'Chhattisgarh', N'IND', 21.18, 81.28)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (236, N'Anhui', N'CHN', 31.86, 117.28)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (249, N'District of Columbia', N'USA', 38.9, -77.04)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (254, N'Delaware', N'USA', 39.62, -75.7)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (258, N'West Bengal', N'IND', 22.57, 88.37)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (268, N'Shaanxi', N'CHN', 34.26, 108.94)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (274, N'Madhya Pradesh', N'IND', 22.72, 75.83)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (284, N'Gujarat', N'IND', 23.03, 72.62)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (296, N'Franche-Comte', N'FRA', 47.63, 6.87)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (305, N'Idaho', N'USA', 48.39, -116.89)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (306, N'Rajasthan', N'IND', 26.92, 75.82)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (307, N'Nei Mongol', N'CHN', 49.2, 119.7)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (315, N'Alsace', N'FRA', 48.58, 7.75)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (317, N'Orissa', N'IND', 20.5, 85.83)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (334, N'Jilin', N'CHN', 43.88, 125.32)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (355, N'Jharkhand', N'IND', 23.35, 85.33)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (363, N'Chandigarh', N'IND', 30.74, 76.79)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (377, N'Punjab', N'IND', 30.9, 75.85)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (409, N'Languedoc-Roussillon', N'FRA', 43.4, 3.68)
GO
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (416, N'Assam', N'IND', 24.82, 92.8)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (431, N'Centre', N'FRA', 47.08, 2.4)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (469, N'Champagne-Ardenne', N'FRA', 49.42, 4.5)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (471, N'Bretagne', N'FRA', 48.77, 2.3)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (544, N'Rhone-Alpes', N'FRA', 45.75, 4.85)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (555, N'Nord-Pas-de-Calais', N'FRA', 50.75, 2.15)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (556, N'Lorraine', N'FRA', 48.68, 6.2)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (561, N'Rio Grande do Sul', N'BRA', -30.03, -51.2)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (563, N'Provence-Alpes-Cote d''Azur', N'FRA', 44.4, 4.93)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (586, N'Minas Gerais', N'BRA', -19.92, -43.93)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (598, N'Limousin', N'FRA', 45.85, 1.25)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (600, N'Guizhou', N'CHN', 26.58, 106.72)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (635, N'Haute-Normandie', N'FRA', 49.15, 1.33)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (649, N'Poitou-Charentes', N'FRA', 45.65, 0.15)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (667, N'Wyoming', N'USA', 44.78, -107.55)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (676, N'Daman and Diu', N'IND', 20.37, 72.9)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (701, N'Para', N'BRA', -1.27, -48.18)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (708, N'Basse-Normandie', N'FRA', 49.15, 0.23)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (728, N'Bihar', N'IND', 25.6, 85.12)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (729, N'Aquitaine', N'FRA', 45.12, 0.4)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (773, N'Parana', N'BRA', -25.42, -49.25)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (798, N'Auvergne', N'FRA', 46.28, 3.6)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (808, N'Pernambuco', N'BRA', -8.05, -34.9)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (822, N'Pays de la Loire', N'FRA', 47.47, 0.2)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (838, N'Amazonas', N'BRA', -3.11, -60.03)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (842, N'Distrito Federal', N'BRA', -15.78, -47.92)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (924, N'North Dakota', N'USA', 46.96, -97.68)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (937, N'Bourgogne', N'FRA', 47.8, 3.57)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (959, N'Vermont', N'USA', 44.49, -73.23)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (970, N'Goias', N'BRA', -15.93, -50.13)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (1008, N'Himachal Pradesh', N'IND', 31.1, 77.17)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (1011, N'Sergipe', N'BRA', -11.27, -37.43)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (1061, N'Alaska', N'USA', 61.52, -149.57)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (1102, N'Mato Grosso do Sul', N'BRA', -22.22, -54.8)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (1178, N'Yunnan', N'CHN', 25.04, 102.72)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (1200, N'Uttarakhand', N'IND', 30.32, 78.03)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (1203, N'Meghalaya', N'IND', 25.58, 91.87)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (1231, N'Jiangxi', N'CHN', 28.55, 115.93)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (1269, N'Rio Grande do Norte', N'BRA', -5.78, -35.22)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (1293, N'Paraiba', N'BRA', -7.22, -35.88)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (1297, N'Piaui', N'BRA', -5.08, -42.82)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (1310, N'Gansu', N'CHN', 36.06, 103.79)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (1312, N'Jammu and Kashmir', N'IND', 33.8, 74.26)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (1334, N'Goa', N'IND', 15.27, 73.92)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (1335, N'Maranhao', N'BRA', -2.52, -44.27)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (1457, N'Mato Grosso', N'BRA', -15.58, -56.08)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (1483, N'Corse', N'FRA', 41.92, 8.73)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (1568, N'Alagoas', N'BRA', -9.67, -35.72)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (1596, N'Puducherry', N'IND', 11.93, 79.83)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (1654, N'Manipur', N'IND', 24.82, 93.95)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (1673, N'Tocantins', N'BRA', -10.22, -48.28)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (1714, N'Roraima', N'BRA', 3.83, -60.22)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (1723, N'Rondonia', N'BRA', -10.67, -62.3)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (1736, N'Xizang', N'CHN', 29.65, 91.1)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (1741, N'Ningxia', N'CHN', 38.47, 106.27)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (1751, N'Xinjiang', N'CHN', 43.8, 87.58)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (1753, N'Qinghai', N'CHN', 36.5, 101.6)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (1791, N'Mizoram', N'IND', 23.72, 92.72)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (1846, N'Dadra and Nagar Haveli', N'IND', 20.27, 73.02)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (1874, N'Arunachal Pradesh', N'IND', 27.57, 93.85)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (1918, N'Tripura', N'IND', 23.84, 91.28)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (2113, N'Amapa', N'BRA', 0.03, -51.05)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (2116, N'Acre', N'BRA', -9.97, -67.8)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (2320, N'Sikkim', N'IND', 27.33, 88.62)
INSERT [dbo].[states] ([stateID], [stateName], [countryID], [latitude], [longitude]) VALUES (2370, N'Nagaland', N'IND', 25.67, 94.12)
SET IDENTITY_INSERT [dbo].[Student] ON 

INSERT [dbo].[Student] ([studentId], [studentName], [studentAge], [studentAddress], [BirthDate], [ClassId], [Standard], [Photo], [hobby]) VALUES (2, N'test1', 50, N'asdsad12321', CAST(0xA10E0B00 AS Date), 2, 12, N'/Upload/636233885012821824.jpg', N'Reading')
INSERT [dbo].[Student] ([studentId], [studentName], [studentAge], [studentAddress], [BirthDate], [ClassId], [Standard], [Photo], [hobby]) VALUES (3, N'test', 23, NULL, CAST(0xA30E0B00 AS Date), 1, 12, N'/Upload/24_02_2017_15_57_27.png', N'Music')
INSERT [dbo].[Student] ([studentId], [studentName], [studentAge], [studentAddress], [BirthDate], [ClassId], [Standard], [Photo], [hobby]) VALUES (4, N'Student', 12, N'asdas', CAST(0xB80E0B00 AS Date), 2, 12, N'/Upload/24_02_2017_12_39_14.png', N'Music,Reading')
SET IDENTITY_INSERT [dbo].[Student] OFF
SET IDENTITY_INSERT [dbo].[StudentClass] ON 

INSERT [dbo].[StudentClass] ([ClassId], [Class], [Description]) VALUES (1, N'A', N'Class A')
INSERT [dbo].[StudentClass] ([ClassId], [Class], [Description]) VALUES (2, N'B', N'Class B')
INSERT [dbo].[StudentClass] ([ClassId], [Class], [Description]) VALUES (3, N'C', N'Class C')
INSERT [dbo].[StudentClass] ([ClassId], [Class], [Description]) VALUES (4, N'D', N'Class D')
SET IDENTITY_INSERT [dbo].[StudentClass] OFF
SET IDENTITY_INSERT [dbo].[StudentCourse] ON 

INSERT [dbo].[StudentCourse] ([CourseId], [CourseName]) VALUES (1, N'IT')
INSERT [dbo].[StudentCourse] ([CourseId], [CourseName]) VALUES (2, N'Mech')
INSERT [dbo].[StudentCourse] ([CourseId], [CourseName]) VALUES (3, N'Computer')
INSERT [dbo].[StudentCourse] ([CourseId], [CourseName]) VALUES (4, N'EC')
SET IDENTITY_INSERT [dbo].[StudentCourse] OFF
SET IDENTITY_INSERT [dbo].[StudentCourseMapping] ON 

INSERT [dbo].[StudentCourseMapping] ([StuCourseMapId], [studentId], [courseId]) VALUES (6, 4, 1)
INSERT [dbo].[StudentCourseMapping] ([StuCourseMapId], [studentId], [courseId]) VALUES (7, 4, 3)
INSERT [dbo].[StudentCourseMapping] ([StuCourseMapId], [studentId], [courseId]) VALUES (8, 3, 1)
INSERT [dbo].[StudentCourseMapping] ([StuCourseMapId], [studentId], [courseId]) VALUES (9, 3, 3)
SET IDENTITY_INSERT [dbo].[StudentCourseMapping] OFF
SET IDENTITY_INSERT [dbo].[tblDesignation] ON 

INSERT [dbo].[tblDesignation] ([DesignationId], [DesName]) VALUES (1, N'SR')
INSERT [dbo].[tblDesignation] ([DesignationId], [DesName]) VALUES (2, N'JR')
INSERT [dbo].[tblDesignation] ([DesignationId], [DesName]) VALUES (3, N'MANAGER')
INSERT [dbo].[tblDesignation] ([DesignationId], [DesName]) VALUES (4, N'HR')
INSERT [dbo].[tblDesignation] ([DesignationId], [DesName]) VALUES (5, N'CEO')
INSERT [dbo].[tblDesignation] ([DesignationId], [DesName]) VALUES (6, N'ACCOUNTANT')
INSERT [dbo].[tblDesignation] ([DesignationId], [DesName]) VALUES (7, N'TEAMLEADER')
SET IDENTITY_INSERT [dbo].[tblDesignation] OFF
SET IDENTITY_INSERT [dbo].[tblEmployee] ON 

INSERT [dbo].[tblEmployee] ([EmpId], [EmpName], [EmpAddress], [EmpGender], [EmpHobby], [EmpDesignation], [IsDelete], [IsActive], [DeletedDate], [CreatedDate], [ModifiedDate], [EmpEmail], [EmpImage], [Birthdate]) VALUES (1, N'ujval', N'ahmedabad', N'Male', N'1,5,7', 5, 0, 1, NULL, CAST(0x0000A6640128E5D0 AS DateTime), CAST(0x0000A6640128E70C AS DateTime), N'ujjvalk@gmail.com', N'/Upload/636073105202394698.jpg', CAST(0x0000827700000000 AS DateTime))
INSERT [dbo].[tblEmployee] ([EmpId], [EmpName], [EmpAddress], [EmpGender], [EmpHobby], [EmpDesignation], [IsDelete], [IsActive], [DeletedDate], [CreatedDate], [ModifiedDate], [EmpEmail], [EmpImage], [Birthdate]) VALUES (2, N'tqwwqe', N'sdaasd', N'Female', N'1,2,3', 4, 0, 1, NULL, CAST(0x0000A6640133C91E AS DateTime), CAST(0x0000A6640133C91E AS DateTime), N'tqwwqe@tqwwqe.in', N'/Upload/636073105726759964.jpg', CAST(0x00006EC500000000 AS DateTime))
INSERT [dbo].[tblEmployee] ([EmpId], [EmpName], [EmpAddress], [EmpGender], [EmpHobby], [EmpDesignation], [IsDelete], [IsActive], [DeletedDate], [CreatedDate], [ModifiedDate], [EmpEmail], [EmpImage], [Birthdate]) VALUES (3, N'ronak', N'Gota', N'Male', N'1,2,3', 6, 1, 1, CAST(0x0000A6A600C8036C AS DateTime), CAST(0x0000A66401357305 AS DateTime), CAST(0x0000A66401357305 AS DateTime), N'Ronak@test.co', N'/Upload/636073105012436828.jpg', CAST(0x000084D000000000 AS DateTime))
INSERT [dbo].[tblEmployee] ([EmpId], [EmpName], [EmpAddress], [EmpGender], [EmpHobby], [EmpDesignation], [IsDelete], [IsActive], [DeletedDate], [CreatedDate], [ModifiedDate], [EmpEmail], [EmpImage], [Birthdate]) VALUES (4, N'dhruv', N'Gandhinagar', N'Male', N'1,5,6', 3, 0, 1, NULL, CAST(0x0000A66500AAB739 AS DateTime), CAST(0x0000A66500AAB739 AS DateTime), N'Dhruv@gmail.com', N'/Upload/636073104330105039.jpg', CAST(0x00005BAA00000000 AS DateTime))
INSERT [dbo].[tblEmployee] ([EmpId], [EmpName], [EmpAddress], [EmpGender], [EmpHobby], [EmpDesignation], [IsDelete], [IsActive], [DeletedDate], [CreatedDate], [ModifiedDate], [EmpEmail], [EmpImage], [Birthdate]) VALUES (5, N'rinkesh', N'ankleshwar', N'Male', N'4,5,6', 7, 0, 1, NULL, CAST(0x0000A66501114190 AS DateTime), CAST(0x0000A665011141C3 AS DateTime), N'Rinkesh@gmail.com', N'/Upload/636073104688192104.jpg', CAST(0x0000A58100000000 AS DateTime))
INSERT [dbo].[tblEmployee] ([EmpId], [EmpName], [EmpAddress], [EmpGender], [EmpHobby], [EmpDesignation], [IsDelete], [IsActive], [DeletedDate], [CreatedDate], [ModifiedDate], [EmpEmail], [EmpImage], [Birthdate]) VALUES (6, N'asdas', NULL, N'Male', N'1', 1, 1, 0, CAST(0x0000A6680118D517 AS DateTime), CAST(0x0000A66800B67FC0 AS DateTime), CAST(0x0000A66800B67FC0 AS DateTime), N'asd@asd.in', N'/Upload/636073093184599755.jpg', CAST(0x0000808100000000 AS DateTime))
INSERT [dbo].[tblEmployee] ([EmpId], [EmpName], [EmpAddress], [EmpGender], [EmpHobby], [EmpDesignation], [IsDelete], [IsActive], [DeletedDate], [CreatedDate], [ModifiedDate], [EmpEmail], [EmpImage], [Birthdate]) VALUES (8, N'Test', N'asdd11111', N'Male', N'1,7', 1, 0, 1, NULL, CAST(0x0000A66801172ADD AS DateTime), CAST(0x0000A66801172ADD AS DateTime), N'asd@asd.in', N'/Upload/636073105513896307.png', CAST(0x0000808100000000 AS DateTime))
INSERT [dbo].[tblEmployee] ([EmpId], [EmpName], [EmpAddress], [EmpGender], [EmpHobby], [EmpDesignation], [IsDelete], [IsActive], [DeletedDate], [CreatedDate], [ModifiedDate], [EmpEmail], [EmpImage], [Birthdate]) VALUES (9, N'sdsasasdas', N'asdsad', N'Male', N'1,2', 3, 1, 0, CAST(0x0000A66B0108BD95 AS DateTime), CAST(0x0000A66B0108B6EF AS DateTime), CAST(0x0000A66B0108B6EF AS DateTime), N'asd@asd.in', N'/Upload/636075650262043102.jpg', CAST(0x0000808100000000 AS DateTime))
INSERT [dbo].[tblEmployee] ([EmpId], [EmpName], [EmpAddress], [EmpGender], [EmpHobby], [EmpDesignation], [IsDelete], [IsActive], [DeletedDate], [CreatedDate], [ModifiedDate], [EmpEmail], [EmpImage], [Birthdate]) VALUES (10, N'fsff', N'sasssad', N'Female', N'1,6', 3, 1, 0, CAST(0x0000A68300C68934 AS DateTime), CAST(0x0000A68200EEF20A AS DateTime), CAST(0x0000A68200EEF20E AS DateTime), N'asd@asd.in', N'/Upload/636073105513896307.png', CAST(0x0000808100000000 AS DateTime))
INSERT [dbo].[tblEmployee] ([EmpId], [EmpName], [EmpAddress], [EmpGender], [EmpHobby], [EmpDesignation], [IsDelete], [IsActive], [DeletedDate], [CreatedDate], [ModifiedDate], [EmpEmail], [EmpImage], [Birthdate]) VALUES (11, N'angTest', N'angular Test1', N'Female', N'1,4,6', 4, 0, 1, NULL, CAST(0x0000A68300AF2161 AS DateTime), CAST(0x0000A68300AF2161 AS DateTime), N'asdsd@asd.in', N'\Uploads\30092016182842.jpg', CAST(0x0000647C00000000 AS DateTime))
INSERT [dbo].[tblEmployee] ([EmpId], [EmpName], [EmpAddress], [EmpGender], [EmpHobby], [EmpDesignation], [IsDelete], [IsActive], [DeletedDate], [CreatedDate], [ModifiedDate], [EmpEmail], [EmpImage], [Birthdate]) VALUES (12, N'ang test', N'ang test', N'Male', N'1', 3, 0, 1, NULL, CAST(0x0000A68300BAEAFB AS DateTime), CAST(0x0000A68300BAEAFB AS DateTime), N'angtest@test.com', N'\Uploads\30092016182826.jpg', CAST(0x000078ED00000000 AS DateTime))
INSERT [dbo].[tblEmployee] ([EmpId], [EmpName], [EmpAddress], [EmpGender], [EmpHobby], [EmpDesignation], [IsDelete], [IsActive], [DeletedDate], [CreatedDate], [ModifiedDate], [EmpEmail], [EmpImage], [Birthdate]) VALUES (13, N'Angular JS1', N'Angular JS1', N'Female', N'7', 7, 1, 0, CAST(0x0000A68300C97FC7 AS DateTime), CAST(0x0000A68300C957C7 AS DateTime), CAST(0x0000A68300C957C7 AS DateTime), N'asd1@asd.in', NULL, NULL)
INSERT [dbo].[tblEmployee] ([EmpId], [EmpName], [EmpAddress], [EmpGender], [EmpHobby], [EmpDesignation], [IsDelete], [IsActive], [DeletedDate], [CreatedDate], [ModifiedDate], [EmpEmail], [EmpImage], [Birthdate]) VALUES (16, N'test', N'test', NULL, N'1,2', 2, 1, 0, CAST(0x0000A6FF00C8FF0A AS DateTime), CAST(0x0000A6FF00C859A7 AS DateTime), CAST(0x0000A6FF00C859A7 AS DateTime), N'test@test.com', NULL, CAST(0x0000834800000000 AS DateTime))
INSERT [dbo].[tblEmployee] ([EmpId], [EmpName], [EmpAddress], [EmpGender], [EmpHobby], [EmpDesignation], [IsDelete], [IsActive], [DeletedDate], [CreatedDate], [ModifiedDate], [EmpEmail], [EmpImage], [Birthdate]) VALUES (17, N'testWebapplication', N'testWebapplication', N'Male', N'1,2', 1, 0, 1, NULL, CAST(0x0000A71D013AB8FE AS DateTime), CAST(0x0000A71D013AB8FE AS DateTime), N'testWebapplication', N'/Upload/636229551469219914.png', NULL)
SET IDENTITY_INSERT [dbo].[tblEmployee] OFF
SET IDENTITY_INSERT [dbo].[tblHobby] ON 

INSERT [dbo].[tblHobby] ([HobbyId], [HName]) VALUES (1, N'Music')
INSERT [dbo].[tblHobby] ([HobbyId], [HName]) VALUES (2, N'Cricket')
INSERT [dbo].[tblHobby] ([HobbyId], [HName]) VALUES (3, N'Football')
INSERT [dbo].[tblHobby] ([HobbyId], [HName]) VALUES (4, N'Reading')
INSERT [dbo].[tblHobby] ([HobbyId], [HName]) VALUES (5, N'Coding')
INSERT [dbo].[tblHobby] ([HobbyId], [HName]) VALUES (6, N'Teaching')
INSERT [dbo].[tblHobby] ([HobbyId], [HName]) VALUES (7, N'Gaming')
SET IDENTITY_INSERT [dbo].[tblHobby] OFF
SET IDENTITY_INSERT [dbo].[tblRole] ON 

INSERT [dbo].[tblRole] ([RoleId], [Name], [Description]) VALUES (4, N'Admin', N'Admin')
SET IDENTITY_INSERT [dbo].[tblRole] OFF
SET IDENTITY_INSERT [dbo].[tblSlider] ON 

INSERT [dbo].[tblSlider] ([SliderId], [SImage], [IsActive], [IsDelete]) VALUES (18, N'/Upload/Slider/636078082698131422.png', 1, 0)
INSERT [dbo].[tblSlider] ([SliderId], [SImage], [IsActive], [IsDelete]) VALUES (19, N'/Upload/Slider/636078082887451178.png', 1, 0)
INSERT [dbo].[tblSlider] ([SliderId], [SImage], [IsActive], [IsDelete]) VALUES (20, N'/Upload/Slider/636078084566314935.png', 1, 0)
INSERT [dbo].[tblSlider] ([SliderId], [SImage], [IsActive], [IsDelete]) VALUES (21, N'/Upload/Slider/636078084566375017.png', 1, 0)
INSERT [dbo].[tblSlider] ([SliderId], [SImage], [IsActive], [IsDelete]) VALUES (22, N'/Upload/Slider/636078085024014299.png', 1, 0)
INSERT [dbo].[tblSlider] ([SliderId], [SImage], [IsActive], [IsDelete]) VALUES (23, N'/Upload/Slider/636078085024074330.png', 1, 0)
INSERT [dbo].[tblSlider] ([SliderId], [SImage], [IsActive], [IsDelete]) VALUES (24, N'/Upload/Slider/636205103019064249.jpg', 1, 0)
SET IDENTITY_INSERT [dbo].[tblSlider] OFF
SET IDENTITY_INSERT [dbo].[Transaction] ON 

INSERT [dbo].[Transaction] ([TransactionId], [AcountId], [Type], [Amount], [AvailBalance]) VALUES (2, 1, N'Debit     ', CAST(500.00 AS Decimal(12, 2)), CAST(6500.00 AS Decimal(12, 2)))
INSERT [dbo].[Transaction] ([TransactionId], [AcountId], [Type], [Amount], [AvailBalance]) VALUES (3, 1, N'Credit    ', CAST(100.00 AS Decimal(12, 2)), CAST(6400.00 AS Decimal(12, 2)))
INSERT [dbo].[Transaction] ([TransactionId], [AcountId], [Type], [Amount], [AvailBalance]) VALUES (4, 1, N'Credit    ', CAST(1000.00 AS Decimal(12, 2)), CAST(5400.00 AS Decimal(12, 2)))
INSERT [dbo].[Transaction] ([TransactionId], [AcountId], [Type], [Amount], [AvailBalance]) VALUES (5, 2, N'Debit     ', CAST(100.00 AS Decimal(12, 2)), CAST(5100.00 AS Decimal(12, 2)))
INSERT [dbo].[Transaction] ([TransactionId], [AcountId], [Type], [Amount], [AvailBalance]) VALUES (6, 2, N'Credit    ', CAST(100.00 AS Decimal(12, 2)), CAST(5000.00 AS Decimal(12, 2)))
INSERT [dbo].[Transaction] ([TransactionId], [AcountId], [Type], [Amount], [AvailBalance]) VALUES (7, 2, N'Transfer  ', CAST(100.00 AS Decimal(12, 2)), CAST(4900.00 AS Decimal(12, 2)))
INSERT [dbo].[Transaction] ([TransactionId], [AcountId], [Type], [Amount], [AvailBalance]) VALUES (8, 1, N'Transfer  ', CAST(100.00 AS Decimal(12, 2)), CAST(5400.00 AS Decimal(12, 2)))
INSERT [dbo].[Transaction] ([TransactionId], [AcountId], [Type], [Amount], [AvailBalance]) VALUES (9, 2, N'Transfer  ', CAST(5000.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)))
INSERT [dbo].[Transaction] ([TransactionId], [AcountId], [Type], [Amount], [AvailBalance]) VALUES (10, 2, N'Debit     ', CAST(1000.00 AS Decimal(12, 2)), CAST(1000.00 AS Decimal(12, 2)))
INSERT [dbo].[Transaction] ([TransactionId], [AcountId], [Type], [Amount], [AvailBalance]) VALUES (11, 2, N'Transfer  ', CAST(1000.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)))
INSERT [dbo].[Transaction] ([TransactionId], [AcountId], [Type], [Amount], [AvailBalance]) VALUES (16, 2, N'Transfer  ', CAST(100.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)))
INSERT [dbo].[Transaction] ([TransactionId], [AcountId], [Type], [Amount], [AvailBalance]) VALUES (17, 1, N'Transfer  ', CAST(5000.00 AS Decimal(12, 2)), CAST(6600.00 AS Decimal(12, 2)))
INSERT [dbo].[Transaction] ([TransactionId], [AcountId], [Type], [Amount], [AvailBalance]) VALUES (18, 2, N'Transfer  ', CAST(5000.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)))
INSERT [dbo].[Transaction] ([TransactionId], [AcountId], [Type], [Amount], [AvailBalance]) VALUES (19, 1, N'Transfer  ', CAST(5000.00 AS Decimal(12, 2)), CAST(6600.00 AS Decimal(12, 2)))
INSERT [dbo].[Transaction] ([TransactionId], [AcountId], [Type], [Amount], [AvailBalance]) VALUES (20, 2, N'Transfer  ', CAST(4900.00 AS Decimal(12, 2)), CAST(100.00 AS Decimal(12, 2)))
SET IDENTITY_INSERT [dbo].[Transaction] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__cities__66F2B3B997F3D491]    Script Date: 02/24/2017 17:19:43 ******/
ALTER TABLE [dbo].[cities] ADD UNIQUE NONCLUSTERED 
(
	[countryID] ASC,
	[stateID] ASC,
	[cityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__countrie__0756ED8CAF37E283]    Script Date: 02/24/2017 17:19:43 ******/
ALTER TABLE [dbo].[countries] ADD UNIQUE NONCLUSTERED 
(
	[countryName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__countrie__B1F47F05AF8F87C5]    Script Date: 02/24/2017 17:19:43 ******/
ALTER TABLE [dbo].[countries] ADD UNIQUE NONCLUSTERED 
(
	[webCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__states__DB990C0BEB836ACF]    Script Date: 02/24/2017 17:19:43 ******/
ALTER TABLE [dbo].[states] ADD UNIQUE NONCLUSTERED 
(
	[countryID] ASC,
	[stateName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblEmployee] ADD  CONSTRAINT [DF_tblEmployee_IsDelete]  DEFAULT ((0)) FOR [IsDelete]
GO
ALTER TABLE [dbo].[tblEmployee] ADD  CONSTRAINT [DF_tblEmployee_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[tblEmployee] ADD  CONSTRAINT [DF_tblEmployee_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [FK_Student_StudentClass] FOREIGN KEY([ClassId])
REFERENCES [dbo].[StudentClass] ([ClassId])
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [FK_Student_StudentClass]
GO
ALTER TABLE [dbo].[Transaction]  WITH CHECK ADD  CONSTRAINT [FK_Transaction_BankAcount] FOREIGN KEY([AcountId])
REFERENCES [dbo].[BankAcount] ([AcountId])
GO
ALTER TABLE [dbo].[Transaction] CHECK CONSTRAINT [FK_Transaction_BankAcount]
GO
