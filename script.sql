USE [master]
GO
/****** Object:  Database [SWP2024_6]    Script Date: 2024-06-03 오후 6:12:28 ******/
CREATE DATABASE [SWP2024_6]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SWP2024_6', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER01\MSSQL\DATA\SWP2024_6.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SWP2024_6_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER01\MSSQL\DATA\SWP2024_6_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [SWP2024_6] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SWP2024_6].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SWP2024_6] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SWP2024_6] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SWP2024_6] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SWP2024_6] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SWP2024_6] SET ARITHABORT OFF 
GO
ALTER DATABASE [SWP2024_6] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SWP2024_6] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SWP2024_6] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SWP2024_6] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SWP2024_6] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SWP2024_6] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SWP2024_6] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SWP2024_6] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SWP2024_6] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SWP2024_6] SET  ENABLE_BROKER 
GO
ALTER DATABASE [SWP2024_6] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SWP2024_6] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SWP2024_6] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SWP2024_6] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SWP2024_6] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SWP2024_6] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SWP2024_6] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SWP2024_6] SET RECOVERY FULL 
GO
ALTER DATABASE [SWP2024_6] SET  MULTI_USER 
GO
ALTER DATABASE [SWP2024_6] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SWP2024_6] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SWP2024_6] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SWP2024_6] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SWP2024_6] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SWP2024_6] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'SWP2024_6', N'ON'
GO
ALTER DATABASE [SWP2024_6] SET QUERY_STORE = ON
GO
ALTER DATABASE [SWP2024_6] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [SWP2024_6]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 2024-06-03 오후 6:12:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[password] [varchar](50) NOT NULL,
	[address] [nvarchar](255) NULL,
	[phone] [nvarchar](20) NULL,
	[email] [nvarchar](50) NULL,
	[roleId] [int] NULL,
	[status] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Admin]    Script Date: 2024-06-03 오후 6:12:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admin](
	[admin_id] [int] IDENTITY(1,1) NOT NULL,
	[account_id] [int] NULL,
	[adminNumber] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[admin_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Attendance]    Script Date: 2024-06-03 오후 6:12:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attendance](
	[attendance_id] [int] IDENTITY(1,1) NOT NULL,
	[userClass_id] [int] NULL,
	[date] [date] NULL,
	[status] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[attendance_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Class]    Script Date: 2024-06-03 오후 6:12:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Class](
	[class_id] [int] IDENTITY(1,1) NOT NULL,
	[class_name] [varchar](255) NOT NULL,
	[lecturer_id] [int] NULL,
	[status] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[class_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Code]    Script Date: 2024-06-03 오후 6:12:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Code](
	[code_id] [int] IDENTITY(1,1) NOT NULL,
	[task_id] [int] NULL,
	[code] [text] NOT NULL,
	[version] [int] NULL,
	[status] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[code_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comment]    Script Date: 2024-06-03 오후 6:12:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comment](
	[comment_id] [int] IDENTITY(1,1) NOT NULL,
	[task_id] [int] NULL,
	[student_id] [int] NULL,
	[comment] [text] NOT NULL,
	[timestamp] [datetime] NULL,
	[lecturer_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[comment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lecturer]    Script Date: 2024-06-03 오후 6:12:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lecturer](
	[lecturer_id] [int] IDENTITY(1,1) NOT NULL,
	[account_id] [int] NULL,
	[fullName] [nvarchar](50) NULL,
	[employeeNumber] [nvarchar](50) NULL,
	[department] [nvarchar](50) NULL,
	[specialization] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[lecturer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Objective]    Script Date: 2024-06-03 오후 6:12:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Objective](
	[objective_id] [int] IDENTITY(1,1) NOT NULL,
	[description] [text] NOT NULL,
	[create_at] [date] NULL,
	[status] [varchar](50) NULL,
	[createBy] [int] NULL,
	[class_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[objective_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Report]    Script Date: 2024-06-03 오후 6:12:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Report](
	[report_id] [int] IDENTITY(1,1) NOT NULL,
	[student_id] [int] NULL,
	[content] [text] NOT NULL,
	[timestamp] [datetime] NULL,
	[task_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[report_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 2024-06-03 오후 6:12:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[role_id] [int] IDENTITY(1,1) NOT NULL,
	[role_name] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 2024-06-03 오후 6:12:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[student_id] [int] IDENTITY(1,1) NOT NULL,
	[account_id] [int] NULL,
	[fullName] [nvarchar](50) NULL,
	[rollNumber] [varchar](50) NULL,
	[birthDate] [date] NULL,
	[schoolYear] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[student_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Task]    Script Date: 2024-06-03 오후 6:12:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Task](
	[task_id] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](255) NOT NULL,
	[description] [text] NOT NULL,
	[objective_id] [int] NULL,
	[status] [varchar](50) NULL,
	[start_date] [date] NULL,
	[end_date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[task_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userClass]    Script Date: 2024-06-03 오후 6:12:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userClass](
	[userClass_id] [int] IDENTITY(1,1) NOT NULL,
	[student_id] [int] NULL,
	[class_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[userClass_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Account] ON 

INSERT [dbo].[Account] ([id], [username], [password], [address], [phone], [email], [roleId], [status]) VALUES (1, N'admin_user', N'password123', N'123 Admin St', N'555-1234', N'admin@example.com', 1, N'active')
INSERT [dbo].[Account] ([id], [username], [password], [address], [phone], [email], [roleId], [status]) VALUES (2, N'student_user', N'password123', N'456 Student St', N'555-5678', N'student@example.com', 2, N'active')
INSERT [dbo].[Account] ([id], [username], [password], [address], [phone], [email], [roleId], [status]) VALUES (3, N'lecturer_user', N'password123', N'789 Lecturer St', N'555-9012', N'lecturer@example.com', 3, N'active')
INSERT [dbo].[Account] ([id], [username], [password], [address], [phone], [email], [roleId], [status]) VALUES (4, N'student_user2', N'password123', N'456 Student St', N'555-5678', N'student2@example.com', 2, N'active')
INSERT [dbo].[Account] ([id], [username], [password], [address], [phone], [email], [roleId], [status]) VALUES (5, N'lecturer_user2', N'password123', N'789 Lecturer St', N'555-9012', N'lecturer2@example.com', 3, N'active')
INSERT [dbo].[Account] ([id], [username], [password], [address], [phone], [email], [roleId], [status]) VALUES (12, N'thaidt15@gmail.com', N'_*4(ljB8', NULL, NULL, N'thaidt15@gmail.com', 2, N'active')
INSERT [dbo].[Account] ([id], [username], [password], [address], [phone], [email], [roleId], [status]) VALUES (13, N'thaijunny@gmail.com', N'2RO<N9_J', NULL, NULL, N'thaijunny@gmail.com', 2, N'active')
INSERT [dbo].[Account] ([id], [username], [password], [address], [phone], [email], [roleId], [status]) VALUES (14, N'student3@example.com', N'!YTkK&;F', NULL, NULL, N'student3@example.com', 2, N'active')
SET IDENTITY_INSERT [dbo].[Account] OFF
GO
SET IDENTITY_INSERT [dbo].[Admin] ON 

INSERT [dbo].[Admin] ([admin_id], [account_id], [adminNumber]) VALUES (1, 1, N'ADM001')
SET IDENTITY_INSERT [dbo].[Admin] OFF
GO
SET IDENTITY_INSERT [dbo].[Class] ON 

INSERT [dbo].[Class] ([class_id], [class_name], [lecturer_id], [status]) VALUES (1, N'Math101', 1, N'ACTIVE')
INSERT [dbo].[Class] ([class_id], [class_name], [lecturer_id], [status]) VALUES (2, N'Physics101', 1, N'ACTIVE')
INSERT [dbo].[Class] ([class_id], [class_name], [lecturer_id], [status]) VALUES (3, N'Doan Trong thais', 2, N'ACTIVE')
SET IDENTITY_INSERT [dbo].[Class] OFF
GO
SET IDENTITY_INSERT [dbo].[Code] ON 

INSERT [dbo].[Code] ([code_id], [task_id], [code], [version], [status]) VALUES (1, 1, N'print("Hello, world!")', 1, N'uploaded')
INSERT [dbo].[Code] ([code_id], [task_id], [code], [version], [status]) VALUES (2, 2, N'def sum(a, b): return a + b', 1, N'reviewed')
SET IDENTITY_INSERT [dbo].[Code] OFF
GO
SET IDENTITY_INSERT [dbo].[Comment] ON 

INSERT [dbo].[Comment] ([comment_id], [task_id], [student_id], [comment], [timestamp], [lecturer_id]) VALUES (1, 1, 1, N'I have started reading the pages.', CAST(N'2024-05-28T10:15:20.573' AS DateTime), NULL)
INSERT [dbo].[Comment] ([comment_id], [task_id], [student_id], [comment], [timestamp], [lecturer_id]) VALUES (2, 2, 1, N'The summary is in progress.???', CAST(N'2024-05-31T15:06:56.630' AS DateTime), NULL)
INSERT [dbo].[Comment] ([comment_id], [task_id], [student_id], [comment], [timestamp], [lecturer_id]) VALUES (3, 2, NULL, N'Sao mày ngu the Jane?', CAST(N'2024-05-31T01:57:44.720' AS DateTime), 1)
INSERT [dbo].[Comment] ([comment_id], [task_id], [student_id], [comment], [timestamp], [lecturer_id]) VALUES (4, 1, NULL, N'Làm nhanh len', CAST(N'2024-05-31T01:56:00.000' AS DateTime), 1)
INSERT [dbo].[Comment] ([comment_id], [task_id], [student_id], [comment], [timestamp], [lecturer_id]) VALUES (5, 1, NULL, N'tao cho 1 diem bay gio', CAST(N'2024-05-31T01:56:09.460' AS DateTime), 1)
INSERT [dbo].[Comment] ([comment_id], [task_id], [student_id], [comment], [timestamp], [lecturer_id]) VALUES (6, 2, 1, N'Thay oi an buoi chua khong ?', CAST(N'2024-05-31T15:07:07.880' AS DateTime), NULL)
INSERT [dbo].[Comment] ([comment_id], [task_id], [student_id], [comment], [timestamp], [lecturer_id]) VALUES (7, 1, 1, N'Bình tõm', CAST(N'2024-05-31T15:30:06.770' AS DateTime), NULL)
INSERT [dbo].[Comment] ([comment_id], [task_id], [student_id], [comment], [timestamp], [lecturer_id]) VALUES (8, 13, NULL, N'Yeu em', CAST(N'2024-06-03T15:59:10.347' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Comment] OFF
GO
SET IDENTITY_INSERT [dbo].[Lecturer] ON 

INSERT [dbo].[Lecturer] ([lecturer_id], [account_id], [fullName], [employeeNumber], [department], [specialization]) VALUES (1, 3, N'John Doe', N'EMP001', N'Computer Science', N'Artificial Intelligence')
INSERT [dbo].[Lecturer] ([lecturer_id], [account_id], [fullName], [employeeNumber], [department], [specialization]) VALUES (2, 5, N'John Thai', N'EMP011', N'Computer Science', N'Artificial Intelligence')
SET IDENTITY_INSERT [dbo].[Lecturer] OFF
GO
SET IDENTITY_INSERT [dbo].[Objective] ON 

INSERT [dbo].[Objective] ([objective_id], [description], [create_at], [status], [createBy], [class_id]) VALUES (1, N'Complete Chapter 1', CAST(N'2024-05-30' AS Date), N'approved', 1, 1)
INSERT [dbo].[Objective] ([objective_id], [description], [create_at], [status], [createBy], [class_id]) VALUES (2, N'Complete Chapter 2', CAST(N'2024-05-30' AS Date), N'rejected', 1, 1)
INSERT [dbo].[Objective] ([objective_id], [description], [create_at], [status], [createBy], [class_id]) VALUES (10, N'd', CAST(N'2024-06-03' AS Date), N'approved', 1, 1)
INSERT [dbo].[Objective] ([objective_id], [description], [create_at], [status], [createBy], [class_id]) VALUES (1010, N'Thai Day', CAST(N'2024-06-03' AS Date), NULL, 1, 2)
SET IDENTITY_INSERT [dbo].[Objective] OFF
GO
SET IDENTITY_INSERT [dbo].[Report] ON 

INSERT [dbo].[Report] ([report_id], [student_id], [content], [timestamp], [task_id]) VALUES (1, 1, N'Daily progress: Read pages 1-3.', CAST(N'2024-05-28T10:15:20.580' AS DateTime), 1)
INSERT [dbo].[Report] ([report_id], [student_id], [content], [timestamp], [task_id]) VALUES (2, 1, N'Daily progress: Wrote the introduction.', CAST(N'2024-05-28T10:15:20.580' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Report] OFF
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([role_id], [role_name]) VALUES (1, N'Admin')
INSERT [dbo].[Role] ([role_id], [role_name]) VALUES (2, N'Student')
INSERT [dbo].[Role] ([role_id], [role_name]) VALUES (3, N'Lecturer')
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
SET IDENTITY_INSERT [dbo].[Student] ON 

INSERT [dbo].[Student] ([student_id], [account_id], [fullName], [rollNumber], [birthDate], [schoolYear]) VALUES (1, 2, N'Jane Smith', N'STU001', CAST(N'2000-01-01' AS Date), 2023)
INSERT [dbo].[Student] ([student_id], [account_id], [fullName], [rollNumber], [birthDate], [schoolYear]) VALUES (2, 4, N'Jane Smith', N'STU001', CAST(N'2000-01-01' AS Date), 2023)
INSERT [dbo].[Student] ([student_id], [account_id], [fullName], [rollNumber], [birthDate], [schoolYear]) VALUES (9, 12, N'Student One', N'R02', NULL, NULL)
INSERT [dbo].[Student] ([student_id], [account_id], [fullName], [rollNumber], [birthDate], [schoolYear]) VALUES (10, 13, N'Student Two', N'R04', NULL, NULL)
INSERT [dbo].[Student] ([student_id], [account_id], [fullName], [rollNumber], [birthDate], [schoolYear]) VALUES (11, 14, N'Student Three', N'R009', NULL, NULL)
SET IDENTITY_INSERT [dbo].[Student] OFF
GO
SET IDENTITY_INSERT [dbo].[Task] ON 

INSERT [dbo].[Task] ([task_id], [title], [description], [objective_id], [status], [start_date], [end_date]) VALUES (1, N'Read pages 1-10', N'Read the first 10 pages of the textbook', 1, N'done', CAST(N'2024-06-03' AS Date), CAST(N'2024-06-04' AS Date))
INSERT [dbo].[Task] ([task_id], [title], [description], [objective_id], [status], [start_date], [end_date]) VALUES (2, N'Write summary', N'Write a summary of Chapter 1', 1, N'done', CAST(N'2024-06-03' AS Date), CAST(N'2024-06-04' AS Date))
INSERT [dbo].[Task] ([task_id], [title], [description], [objective_id], [status], [start_date], [end_date]) VALUES (5, N'SSS', N'SSSS', 1, N'in progress', CAST(N'2024-06-03' AS Date), CAST(N'2024-06-04' AS Date))
INSERT [dbo].[Task] ([task_id], [title], [description], [objective_id], [status], [start_date], [end_date]) VALUES (13, N'', N'', 1, N'done', CAST(N'1900-01-01' AS Date), CAST(N'1900-01-01' AS Date))
INSERT [dbo].[Task] ([task_id], [title], [description], [objective_id], [status], [start_date], [end_date]) VALUES (15, N'OK', N'OK', 1, N'not started', CAST(N'2024-07-05' AS Date), CAST(N'2024-09-05' AS Date))
SET IDENTITY_INSERT [dbo].[Task] OFF
GO
SET IDENTITY_INSERT [dbo].[userClass] ON 

INSERT [dbo].[userClass] ([userClass_id], [student_id], [class_id]) VALUES (6, 9, 2)
INSERT [dbo].[userClass] ([userClass_id], [student_id], [class_id]) VALUES (7, 10, 2)
INSERT [dbo].[userClass] ([userClass_id], [student_id], [class_id]) VALUES (8, 11, 2)
INSERT [dbo].[userClass] ([userClass_id], [student_id], [class_id]) VALUES (9, 1, 1)
INSERT [dbo].[userClass] ([userClass_id], [student_id], [class_id]) VALUES (10, 2, 2)
SET IDENTITY_INSERT [dbo].[userClass] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Account__F3DBC572E712EFB9]    Script Date: 2024-06-03 오후 6:12:28 ******/
ALTER TABLE [dbo].[Account] ADD UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Class] ADD  DEFAULT ('ACTIVE') FOR [status]
GO
ALTER TABLE [dbo].[Comment] ADD  DEFAULT (getdate()) FOR [timestamp]
GO
ALTER TABLE [dbo].[Comment] ADD  DEFAULT (NULL) FOR [lecturer_id]
GO
ALTER TABLE [dbo].[Objective] ADD  DEFAULT (getdate()) FOR [create_at]
GO
ALTER TABLE [dbo].[Report] ADD  DEFAULT (getdate()) FOR [timestamp]
GO
ALTER TABLE [dbo].[Task] ADD  DEFAULT (getdate()) FOR [start_date]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD FOREIGN KEY([roleId])
REFERENCES [dbo].[Role] ([role_id])
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD FOREIGN KEY([roleId])
REFERENCES [dbo].[Role] ([role_id])
GO
ALTER TABLE [dbo].[Admin]  WITH CHECK ADD FOREIGN KEY([account_id])
REFERENCES [dbo].[Account] ([id])
GO
ALTER TABLE [dbo].[Admin]  WITH CHECK ADD FOREIGN KEY([account_id])
REFERENCES [dbo].[Account] ([id])
GO
ALTER TABLE [dbo].[Attendance]  WITH CHECK ADD FOREIGN KEY([userClass_id])
REFERENCES [dbo].[userClass] ([userClass_id])
GO
ALTER TABLE [dbo].[Class]  WITH CHECK ADD FOREIGN KEY([lecturer_id])
REFERENCES [dbo].[Lecturer] ([lecturer_id])
GO
ALTER TABLE [dbo].[Code]  WITH CHECK ADD FOREIGN KEY([task_id])
REFERENCES [dbo].[Task] ([task_id])
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD FOREIGN KEY([lecturer_id])
REFERENCES [dbo].[Lecturer] ([lecturer_id])
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD FOREIGN KEY([student_id])
REFERENCES [dbo].[Student] ([student_id])
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD FOREIGN KEY([task_id])
REFERENCES [dbo].[Task] ([task_id])
GO
ALTER TABLE [dbo].[Lecturer]  WITH CHECK ADD FOREIGN KEY([account_id])
REFERENCES [dbo].[Account] ([id])
GO
ALTER TABLE [dbo].[Objective]  WITH CHECK ADD FOREIGN KEY([class_id])
REFERENCES [dbo].[Class] ([class_id])
GO
ALTER TABLE [dbo].[Objective]  WITH CHECK ADD FOREIGN KEY([createBy])
REFERENCES [dbo].[Lecturer] ([lecturer_id])
GO
ALTER TABLE [dbo].[Report]  WITH CHECK ADD FOREIGN KEY([student_id])
REFERENCES [dbo].[Student] ([student_id])
GO
ALTER TABLE [dbo].[Report]  WITH CHECK ADD FOREIGN KEY([task_id])
REFERENCES [dbo].[Task] ([task_id])
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD FOREIGN KEY([account_id])
REFERENCES [dbo].[Account] ([id])
GO
ALTER TABLE [dbo].[Task]  WITH CHECK ADD FOREIGN KEY([objective_id])
REFERENCES [dbo].[Objective] ([objective_id])
GO
ALTER TABLE [dbo].[userClass]  WITH CHECK ADD FOREIGN KEY([class_id])
REFERENCES [dbo].[Class] ([class_id])
GO
ALTER TABLE [dbo].[userClass]  WITH CHECK ADD FOREIGN KEY([student_id])
REFERENCES [dbo].[Student] ([student_id])
GO
USE [master]
GO
ALTER DATABASE [SWP2024_6] SET  READ_WRITE 
GO
