USE [master]
GO
/****** Object:  Database [TestDemo]    Script Date: 19-08-2016 16:10:58 ******/
CREATE DATABASE [TestDemo]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TestDemo', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\TestDemo.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'TestDemo_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\TestDemo_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [TestDemo] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TestDemo].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TestDemo] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TestDemo] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TestDemo] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TestDemo] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TestDemo] SET ARITHABORT OFF 
GO
ALTER DATABASE [TestDemo] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TestDemo] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [TestDemo] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TestDemo] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TestDemo] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TestDemo] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TestDemo] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TestDemo] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TestDemo] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TestDemo] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TestDemo] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TestDemo] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TestDemo] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TestDemo] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TestDemo] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TestDemo] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TestDemo] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TestDemo] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TestDemo] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [TestDemo] SET  MULTI_USER 
GO
ALTER DATABASE [TestDemo] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TestDemo] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TestDemo] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TestDemo] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [TestDemo]
GO
/****** Object:  Table [dbo].[tblDesignation]    Script Date: 19-08-2016 16:10:58 ******/
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
/****** Object:  Table [dbo].[tblEmployee]    Script Date: 19-08-2016 16:10:58 ******/
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
 CONSTRAINT [PK_tblEmployee] PRIMARY KEY CLUSTERED 
(
	[EmpId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblHobby]    Script Date: 19-08-2016 16:10:58 ******/
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

INSERT [dbo].[tblEmployee] ([EmpId], [EmpName], [EmpAddress], [EmpGender], [EmpHobby], [EmpDesignation], [IsDelete], [IsActive], [DeletedDate], [CreatedDate], [ModifiedDate], [EmpEmail]) VALUES (1, N'test', N'asdasd', N'Male', N'1,2,3', 1, 0, NULL, NULL, CAST(0x0000A66400B9FA56 AS DateTime), CAST(0x0000A66400B9FA56 AS DateTime), N'test@test.test')
INSERT [dbo].[tblEmployee] ([EmpId], [EmpName], [EmpAddress], [EmpGender], [EmpHobby], [EmpDesignation], [IsDelete], [IsActive], [DeletedDate], [CreatedDate], [ModifiedDate], [EmpEmail]) VALUES (2, N'ujval', N'ahmedabad', N'Male', N'1,5,7', 5, 0, NULL, NULL, CAST(0x0000A6640128E5D0 AS DateTime), CAST(0x0000A6640128E70C AS DateTime), N'ujjvalk@gmail.com')
INSERT [dbo].[tblEmployee] ([EmpId], [EmpName], [EmpAddress], [EmpGender], [EmpHobby], [EmpDesignation], [IsDelete], [IsActive], [DeletedDate], [CreatedDate], [ModifiedDate], [EmpEmail]) VALUES (3, N'tqwwqe', N'wqewq', N'Female', N'1,2,3', 4, 1, 1, CAST(0x0000A66401336ED7 AS DateTime), CAST(0x0000A6640132AEAB AS DateTime), CAST(0x0000A6640132AEAB AS DateTime), NULL)
INSERT [dbo].[tblEmployee] ([EmpId], [EmpName], [EmpAddress], [EmpGender], [EmpHobby], [EmpDesignation], [IsDelete], [IsActive], [DeletedDate], [CreatedDate], [ModifiedDate], [EmpEmail]) VALUES (4, N'tqwwqe', N'sdaasd', N'Female', N'1,2,3', 4, 0, NULL, NULL, CAST(0x0000A6640133C91E AS DateTime), CAST(0x0000A6640133C91E AS DateTime), N'tqwwqe@tqwwqe.in')
INSERT [dbo].[tblEmployee] ([EmpId], [EmpName], [EmpAddress], [EmpGender], [EmpHobby], [EmpDesignation], [IsDelete], [IsActive], [DeletedDate], [CreatedDate], [ModifiedDate], [EmpEmail]) VALUES (5, N'dwqw', N'wqeqwewq', N'Female', N'1,2,3', 3, 1, 1, CAST(0x0000A66401346189 AS DateTime), CAST(0x0000A664013433EB AS DateTime), CAST(0x0000A664013433EB AS DateTime), NULL)
INSERT [dbo].[tblEmployee] ([EmpId], [EmpName], [EmpAddress], [EmpGender], [EmpHobby], [EmpDesignation], [IsDelete], [IsActive], [DeletedDate], [CreatedDate], [ModifiedDate], [EmpEmail]) VALUES (6, N'ronak', N'asadas', N'Male', N'1,2,3', 6, 0, NULL, NULL, CAST(0x0000A66401357305 AS DateTime), CAST(0x0000A66401357305 AS DateTime), N'Ronak@test.co')
INSERT [dbo].[tblEmployee] ([EmpId], [EmpName], [EmpAddress], [EmpGender], [EmpHobby], [EmpDesignation], [IsDelete], [IsActive], [DeletedDate], [CreatedDate], [ModifiedDate], [EmpEmail]) VALUES (7, N'dhruv', N'asdsa', N'Male', N'1,2,6', 3, 0, NULL, NULL, CAST(0x0000A66500AAB739 AS DateTime), CAST(0x0000A66500AAB739 AS DateTime), N'Dhruv@gmail.com')
INSERT [dbo].[tblEmployee] ([EmpId], [EmpName], [EmpAddress], [EmpGender], [EmpHobby], [EmpDesignation], [IsDelete], [IsActive], [DeletedDate], [CreatedDate], [ModifiedDate], [EmpEmail]) VALUES (8, N'asdasd', NULL, N'Male', N'1,2,3', NULL, 1, 1, CAST(0x0000A66500B590B2 AS DateTime), CAST(0x0000A66500B546AF AS DateTime), CAST(0x0000A66500B546AF AS DateTime), NULL)
INSERT [dbo].[tblEmployee] ([EmpId], [EmpName], [EmpAddress], [EmpGender], [EmpHobby], [EmpDesignation], [IsDelete], [IsActive], [DeletedDate], [CreatedDate], [ModifiedDate], [EmpEmail]) VALUES (9, N'asdsa', NULL, N'Male', N'1,2,3', NULL, 1, 1, CAST(0x0000A66500B6E7A4 AS DateTime), CAST(0x0000A66500B6DCE9 AS DateTime), CAST(0x0000A66500B6DCE9 AS DateTime), NULL)
INSERT [dbo].[tblEmployee] ([EmpId], [EmpName], [EmpAddress], [EmpGender], [EmpHobby], [EmpDesignation], [IsDelete], [IsActive], [DeletedDate], [CreatedDate], [ModifiedDate], [EmpEmail]) VALUES (10, N'rinkesh', N'ankleshwar', N'Male', N'4,5,6', 7, 0, NULL, NULL, CAST(0x0000A66501114190 AS DateTime), CAST(0x0000A665011141C3 AS DateTime), N'Rinkesh@gmail.com')
INSERT [dbo].[tblEmployee] ([EmpId], [EmpName], [EmpAddress], [EmpGender], [EmpHobby], [EmpDesignation], [IsDelete], [IsActive], [DeletedDate], [CreatedDate], [ModifiedDate], [EmpEmail]) VALUES (11, N'tess', NULL, N'Male', NULL, NULL, 1, 1, CAST(0x0000A665012A5564 AS DateTime), CAST(0x0000A665012A2CDE AS DateTime), CAST(0x0000A665012A2D92 AS DateTime), NULL)
INSERT [dbo].[tblEmployee] ([EmpId], [EmpName], [EmpAddress], [EmpGender], [EmpHobby], [EmpDesignation], [IsDelete], [IsActive], [DeletedDate], [CreatedDate], [ModifiedDate], [EmpEmail]) VALUES (12, N'asdsada', NULL, N'Male', N'1', 1, 1, 1, CAST(0x0000A66700B0C2D6 AS DateTime), CAST(0x0000A66700AD9316 AS DateTime), CAST(0x0000A66700AD9316 AS DateTime), NULL)
INSERT [dbo].[tblEmployee] ([EmpId], [EmpName], [EmpAddress], [EmpGender], [EmpHobby], [EmpDesignation], [IsDelete], [IsActive], [DeletedDate], [CreatedDate], [ModifiedDate], [EmpEmail]) VALUES (13, N'sdasd', NULL, N'Male', N'1', 1, 1, 1, CAST(0x0000A66700BB8B4F AS DateTime), CAST(0x0000A66700BB819F AS DateTime), CAST(0x0000A66700BB819F AS DateTime), N'sdaasda')
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
ALTER TABLE [dbo].[tblEmployee] ADD  CONSTRAINT [DF_tblEmployee_IsDelete]  DEFAULT ((0)) FOR [IsDelete]
GO
ALTER TABLE [dbo].[tblEmployee] ADD  CONSTRAINT [DF_tblEmployee_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[tblEmployee] ADD  CONSTRAINT [DF_tblEmployee_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
USE [master]
GO
ALTER DATABASE [TestDemo] SET  READ_WRITE 
GO
