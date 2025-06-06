USE [master]
GO
/****** Object:  Database [StudentRecords]    Script Date: 04/06/2025 8:00:57 pm ******/
CREATE DATABASE [StudentRecords]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'StudentRecords', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\StudentRecords.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'StudentRecords_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\StudentRecords_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [StudentRecords] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [StudentRecords].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [StudentRecords] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [StudentRecords] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [StudentRecords] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [StudentRecords] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [StudentRecords] SET ARITHABORT OFF 
GO
ALTER DATABASE [StudentRecords] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [StudentRecords] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [StudentRecords] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [StudentRecords] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [StudentRecords] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [StudentRecords] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [StudentRecords] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [StudentRecords] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [StudentRecords] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [StudentRecords] SET  DISABLE_BROKER 
GO
ALTER DATABASE [StudentRecords] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [StudentRecords] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [StudentRecords] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [StudentRecords] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [StudentRecords] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [StudentRecords] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [StudentRecords] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [StudentRecords] SET RECOVERY FULL 
GO
ALTER DATABASE [StudentRecords] SET  MULTI_USER 
GO
ALTER DATABASE [StudentRecords] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [StudentRecords] SET DB_CHAINING OFF 
GO
ALTER DATABASE [StudentRecords] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [StudentRecords] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [StudentRecords] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [StudentRecords] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'StudentRecords', N'ON'
GO
ALTER DATABASE [StudentRecords] SET QUERY_STORE = ON
GO
ALTER DATABASE [StudentRecords] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [StudentRecords]
GO
/****** Object:  Table [dbo].[ACADEMIC_YEAR]    Script Date: 04/06/2025 8:00:57 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ACADEMIC_YEAR](
	[academic_year_ID] [int] IDENTITY(1,1) NOT NULL,
	[academic_name] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[academic_year_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[alembic_version]    Script Date: 04/06/2025 8:00:58 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[alembic_version](
	[version_num] [varchar](32) NOT NULL,
 CONSTRAINT [alembic_version_pkc] PRIMARY KEY CLUSTERED 
(
	[version_num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ATTENDANCE]    Script Date: 04/06/2025 8:00:58 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ATTENDANCE](
	[attendance_ID] [int] IDENTITY(1,1) NOT NULL,
	[student_ID] [int] NOT NULL,
	[class_ID] [int] NOT NULL,
	[attendance_date] [date] NOT NULL,
	[status] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[attendance_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CLASS]    Script Date: 04/06/2025 8:00:58 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CLASS](
	[class_ID] [int] IDENTITY(1,1) NOT NULL,
	[class_name] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[class_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CLASS_COURSE]    Script Date: 04/06/2025 8:00:58 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CLASS_COURSE](
	[course_ID] [int] NOT NULL,
	[class_ID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[course_ID] ASC,
	[class_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[COURSES]    Script Date: 04/06/2025 8:00:58 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COURSES](
	[course_ID] [int] IDENTITY(1,1) NOT NULL,
	[course_name] [varchar](100) NOT NULL,
	[course_desc] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[course_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EVALUATION]    Script Date: 04/06/2025 8:00:58 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EVALUATION](
	[evaluation_ID] [int] IDENTITY(1,1) NOT NULL,
	[evaluation_type_ID] [int] NOT NULL,
	[course_ID] [int] NOT NULL,
	[submission_date] [date] NOT NULL,
	[max_marks] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[evaluation_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EVALUATION_STUDENT_RESULT]    Script Date: 04/06/2025 8:00:58 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EVALUATION_STUDENT_RESULT](
	[evaluation_ID] [int] NOT NULL,
	[student_ID] [int] NOT NULL,
	[result_ID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[evaluation_ID] ASC,
	[student_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EVALUATION_TYPE]    Script Date: 04/06/2025 8:00:58 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EVALUATION_TYPE](
	[evaluation_type_ID] [int] IDENTITY(1,1) NOT NULL,
	[type_name] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[evaluation_type_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FEES]    Script Date: 04/06/2025 8:00:58 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FEES](
	[fees_ID] [int] IDENTITY(1,1) NOT NULL,
	[student_ID] [int] NOT NULL,
	[amount_due] [decimal](10, 2) NOT NULL,
	[amount_paid] [decimal](10, 2) NOT NULL,
	[due_date] [date] NOT NULL,
	[payment_status] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[fees_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RESULTS]    Script Date: 04/06/2025 8:00:58 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RESULTS](
	[result_ID] [int] IDENTITY(1,1) NOT NULL,
	[student_ID] [int] NOT NULL,
	[evaluation_ID] [int] NOT NULL,
	[marks_obtained] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[result_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[STUDENT_ATTENDANCE]    Script Date: 04/06/2025 8:00:58 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[STUDENT_ATTENDANCE](
	[attendance_ID] [int] NOT NULL,
	[student_ID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[attendance_ID] ASC,
	[student_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[STUDENTS]    Script Date: 04/06/2025 8:00:58 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[STUDENTS](
	[student_ID] [int] IDENTITY(1,1) NOT NULL,
	[first_name] [varchar](50) NOT NULL,
	[last_name] [varchar](50) NOT NULL,
	[gender] [varchar](10) NOT NULL,
	[date_of_birth] [date] NOT NULL,
	[class_ID] [int] NOT NULL,
	[academic_year_ID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[student_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[ACADEMIC_YEAR] ON 

INSERT [dbo].[ACADEMIC_YEAR] ([academic_year_ID], [academic_name]) VALUES (1, N'2024–2025')
INSERT [dbo].[ACADEMIC_YEAR] ([academic_year_ID], [academic_name]) VALUES (2, N'2025–2026')
SET IDENTITY_INSERT [dbo].[ACADEMIC_YEAR] OFF
GO
INSERT [dbo].[alembic_version] ([version_num]) VALUES (N'329ac577aad9')
GO
SET IDENTITY_INSERT [dbo].[ATTENDANCE] ON 

INSERT [dbo].[ATTENDANCE] ([attendance_ID], [student_ID], [class_ID], [attendance_date], [status]) VALUES (1, 1, 1, CAST(N'2024-11-01' AS Date), N'Present')
INSERT [dbo].[ATTENDANCE] ([attendance_ID], [student_ID], [class_ID], [attendance_date], [status]) VALUES (2, 2, 1, CAST(N'2024-11-01' AS Date), N'Absent')
INSERT [dbo].[ATTENDANCE] ([attendance_ID], [student_ID], [class_ID], [attendance_date], [status]) VALUES (3, 3, 2, CAST(N'2025-06-01' AS Date), N'Present')
INSERT [dbo].[ATTENDANCE] ([attendance_ID], [student_ID], [class_ID], [attendance_date], [status]) VALUES (4, 4, 2, CAST(N'2025-06-01' AS Date), N'Late')
SET IDENTITY_INSERT [dbo].[ATTENDANCE] OFF
GO
SET IDENTITY_INSERT [dbo].[CLASS] ON 

INSERT [dbo].[CLASS] ([class_ID], [class_name]) VALUES (1, N'Grade 10')
INSERT [dbo].[CLASS] ([class_ID], [class_name]) VALUES (2, N'Grade 11')
SET IDENTITY_INSERT [dbo].[CLASS] OFF
GO
INSERT [dbo].[CLASS_COURSE] ([course_ID], [class_ID]) VALUES (1, 1)
INSERT [dbo].[CLASS_COURSE] ([course_ID], [class_ID]) VALUES (1, 2)
INSERT [dbo].[CLASS_COURSE] ([course_ID], [class_ID]) VALUES (2, 1)
INSERT [dbo].[CLASS_COURSE] ([course_ID], [class_ID]) VALUES (2, 2)
INSERT [dbo].[CLASS_COURSE] ([course_ID], [class_ID]) VALUES (3, 1)
INSERT [dbo].[CLASS_COURSE] ([course_ID], [class_ID]) VALUES (3, 2)
GO
SET IDENTITY_INSERT [dbo].[COURSES] ON 

INSERT [dbo].[COURSES] ([course_ID], [course_name], [course_desc]) VALUES (1, N'Mathematics', NULL)
INSERT [dbo].[COURSES] ([course_ID], [course_name], [course_desc]) VALUES (2, N'English', NULL)
INSERT [dbo].[COURSES] ([course_ID], [course_name], [course_desc]) VALUES (3, N'Science', NULL)
SET IDENTITY_INSERT [dbo].[COURSES] OFF
GO
SET IDENTITY_INSERT [dbo].[EVALUATION] ON 

INSERT [dbo].[EVALUATION] ([evaluation_ID], [evaluation_type_ID], [course_ID], [submission_date], [max_marks]) VALUES (1, 1, 1, CAST(N'2024-10-10' AS Date), 10)
INSERT [dbo].[EVALUATION] ([evaluation_ID], [evaluation_type_ID], [course_ID], [submission_date], [max_marks]) VALUES (2, 3, 1, CAST(N'2024-11-10' AS Date), 20)
INSERT [dbo].[EVALUATION] ([evaluation_ID], [evaluation_type_ID], [course_ID], [submission_date], [max_marks]) VALUES (3, 4, 2, CAST(N'2025-03-20' AS Date), 50)
INSERT [dbo].[EVALUATION] ([evaluation_ID], [evaluation_type_ID], [course_ID], [submission_date], [max_marks]) VALUES (4, 2, 3, CAST(N'2025-02-15' AS Date), 20)
INSERT [dbo].[EVALUATION] ([evaluation_ID], [evaluation_type_ID], [course_ID], [submission_date], [max_marks]) VALUES (5, 2, 1, CAST(N'2024-10-15' AS Date), 20)
INSERT [dbo].[EVALUATION] ([evaluation_ID], [evaluation_type_ID], [course_ID], [submission_date], [max_marks]) VALUES (6, 4, 1, CAST(N'2024-12-10' AS Date), 50)
INSERT [dbo].[EVALUATION] ([evaluation_ID], [evaluation_type_ID], [course_ID], [submission_date], [max_marks]) VALUES (7, 1, 2, CAST(N'2025-01-10' AS Date), 10)
INSERT [dbo].[EVALUATION] ([evaluation_ID], [evaluation_type_ID], [course_ID], [submission_date], [max_marks]) VALUES (8, 2, 2, CAST(N'2025-01-20' AS Date), 20)
INSERT [dbo].[EVALUATION] ([evaluation_ID], [evaluation_type_ID], [course_ID], [submission_date], [max_marks]) VALUES (9, 3, 2, CAST(N'2025-02-01' AS Date), 20)
INSERT [dbo].[EVALUATION] ([evaluation_ID], [evaluation_type_ID], [course_ID], [submission_date], [max_marks]) VALUES (10, 1, 3, CAST(N'2025-01-15' AS Date), 10)
INSERT [dbo].[EVALUATION] ([evaluation_ID], [evaluation_type_ID], [course_ID], [submission_date], [max_marks]) VALUES (11, 3, 3, CAST(N'2025-02-20' AS Date), 20)
INSERT [dbo].[EVALUATION] ([evaluation_ID], [evaluation_type_ID], [course_ID], [submission_date], [max_marks]) VALUES (12, 4, 3, CAST(N'2025-04-05' AS Date), 50)
SET IDENTITY_INSERT [dbo].[EVALUATION] OFF
GO
INSERT [dbo].[EVALUATION_STUDENT_RESULT] ([evaluation_ID], [student_ID], [result_ID]) VALUES (1, 1, 1)
INSERT [dbo].[EVALUATION_STUDENT_RESULT] ([evaluation_ID], [student_ID], [result_ID]) VALUES (1, 2, 2)
INSERT [dbo].[EVALUATION_STUDENT_RESULT] ([evaluation_ID], [student_ID], [result_ID]) VALUES (2, 1, 3)
INSERT [dbo].[EVALUATION_STUDENT_RESULT] ([evaluation_ID], [student_ID], [result_ID]) VALUES (2, 2, 4)
INSERT [dbo].[EVALUATION_STUDENT_RESULT] ([evaluation_ID], [student_ID], [result_ID]) VALUES (3, 3, 5)
INSERT [dbo].[EVALUATION_STUDENT_RESULT] ([evaluation_ID], [student_ID], [result_ID]) VALUES (3, 4, 6)
INSERT [dbo].[EVALUATION_STUDENT_RESULT] ([evaluation_ID], [student_ID], [result_ID]) VALUES (4, 3, 7)
INSERT [dbo].[EVALUATION_STUDENT_RESULT] ([evaluation_ID], [student_ID], [result_ID]) VALUES (4, 4, 8)
INSERT [dbo].[EVALUATION_STUDENT_RESULT] ([evaluation_ID], [student_ID], [result_ID]) VALUES (5, 1, 9)
INSERT [dbo].[EVALUATION_STUDENT_RESULT] ([evaluation_ID], [student_ID], [result_ID]) VALUES (5, 2, 10)
INSERT [dbo].[EVALUATION_STUDENT_RESULT] ([evaluation_ID], [student_ID], [result_ID]) VALUES (6, 1, 11)
INSERT [dbo].[EVALUATION_STUDENT_RESULT] ([evaluation_ID], [student_ID], [result_ID]) VALUES (6, 2, 12)
INSERT [dbo].[EVALUATION_STUDENT_RESULT] ([evaluation_ID], [student_ID], [result_ID]) VALUES (7, 3, 13)
INSERT [dbo].[EVALUATION_STUDENT_RESULT] ([evaluation_ID], [student_ID], [result_ID]) VALUES (7, 4, 14)
INSERT [dbo].[EVALUATION_STUDENT_RESULT] ([evaluation_ID], [student_ID], [result_ID]) VALUES (8, 3, 15)
INSERT [dbo].[EVALUATION_STUDENT_RESULT] ([evaluation_ID], [student_ID], [result_ID]) VALUES (8, 4, 16)
INSERT [dbo].[EVALUATION_STUDENT_RESULT] ([evaluation_ID], [student_ID], [result_ID]) VALUES (9, 3, 17)
INSERT [dbo].[EVALUATION_STUDENT_RESULT] ([evaluation_ID], [student_ID], [result_ID]) VALUES (9, 4, 18)
INSERT [dbo].[EVALUATION_STUDENT_RESULT] ([evaluation_ID], [student_ID], [result_ID]) VALUES (10, 3, 19)
INSERT [dbo].[EVALUATION_STUDENT_RESULT] ([evaluation_ID], [student_ID], [result_ID]) VALUES (10, 4, 20)
INSERT [dbo].[EVALUATION_STUDENT_RESULT] ([evaluation_ID], [student_ID], [result_ID]) VALUES (11, 3, 21)
INSERT [dbo].[EVALUATION_STUDENT_RESULT] ([evaluation_ID], [student_ID], [result_ID]) VALUES (11, 4, 22)
INSERT [dbo].[EVALUATION_STUDENT_RESULT] ([evaluation_ID], [student_ID], [result_ID]) VALUES (12, 3, 23)
INSERT [dbo].[EVALUATION_STUDENT_RESULT] ([evaluation_ID], [student_ID], [result_ID]) VALUES (12, 4, 24)
GO
SET IDENTITY_INSERT [dbo].[EVALUATION_TYPE] ON 

INSERT [dbo].[EVALUATION_TYPE] ([evaluation_type_ID], [type_name]) VALUES (2, N'Assignment')
INSERT [dbo].[EVALUATION_TYPE] ([evaluation_type_ID], [type_name]) VALUES (4, N'Final Exam')
INSERT [dbo].[EVALUATION_TYPE] ([evaluation_type_ID], [type_name]) VALUES (3, N'Midterm')
INSERT [dbo].[EVALUATION_TYPE] ([evaluation_type_ID], [type_name]) VALUES (1, N'Quiz')
SET IDENTITY_INSERT [dbo].[EVALUATION_TYPE] OFF
GO
SET IDENTITY_INSERT [dbo].[FEES] ON 

INSERT [dbo].[FEES] ([fees_ID], [student_ID], [amount_due], [amount_paid], [due_date], [payment_status]) VALUES (1, 1, CAST(10000.00 AS Decimal(10, 2)), CAST(10000.00 AS Decimal(10, 2)), CAST(N'2024-01-10' AS Date), N'Paid')
INSERT [dbo].[FEES] ([fees_ID], [student_ID], [amount_due], [amount_paid], [due_date], [payment_status]) VALUES (2, 2, CAST(10000.00 AS Decimal(10, 2)), CAST(5000.00 AS Decimal(10, 2)), CAST(N'2024-01-10' AS Date), N'Pending')
INSERT [dbo].[FEES] ([fees_ID], [student_ID], [amount_due], [amount_paid], [due_date], [payment_status]) VALUES (3, 3, CAST(12000.00 AS Decimal(10, 2)), CAST(12000.00 AS Decimal(10, 2)), CAST(N'2025-01-10' AS Date), N'Paid')
INSERT [dbo].[FEES] ([fees_ID], [student_ID], [amount_due], [amount_paid], [due_date], [payment_status]) VALUES (4, 4, CAST(12000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(N'2025-01-10' AS Date), N'Pending')
SET IDENTITY_INSERT [dbo].[FEES] OFF
GO
SET IDENTITY_INSERT [dbo].[RESULTS] ON 

INSERT [dbo].[RESULTS] ([result_ID], [student_ID], [evaluation_ID], [marks_obtained]) VALUES (1, 1, 1, 9)
INSERT [dbo].[RESULTS] ([result_ID], [student_ID], [evaluation_ID], [marks_obtained]) VALUES (2, 2, 1, 7)
INSERT [dbo].[RESULTS] ([result_ID], [student_ID], [evaluation_ID], [marks_obtained]) VALUES (3, 1, 2, 18)
INSERT [dbo].[RESULTS] ([result_ID], [student_ID], [evaluation_ID], [marks_obtained]) VALUES (4, 2, 2, 15)
INSERT [dbo].[RESULTS] ([result_ID], [student_ID], [evaluation_ID], [marks_obtained]) VALUES (5, 3, 3, 42)
INSERT [dbo].[RESULTS] ([result_ID], [student_ID], [evaluation_ID], [marks_obtained]) VALUES (6, 4, 3, 45)
INSERT [dbo].[RESULTS] ([result_ID], [student_ID], [evaluation_ID], [marks_obtained]) VALUES (7, 3, 4, 17)
INSERT [dbo].[RESULTS] ([result_ID], [student_ID], [evaluation_ID], [marks_obtained]) VALUES (8, 4, 4, 20)
INSERT [dbo].[RESULTS] ([result_ID], [student_ID], [evaluation_ID], [marks_obtained]) VALUES (9, 1, 5, 18)
INSERT [dbo].[RESULTS] ([result_ID], [student_ID], [evaluation_ID], [marks_obtained]) VALUES (10, 2, 5, 14)
INSERT [dbo].[RESULTS] ([result_ID], [student_ID], [evaluation_ID], [marks_obtained]) VALUES (11, 1, 6, 46)
INSERT [dbo].[RESULTS] ([result_ID], [student_ID], [evaluation_ID], [marks_obtained]) VALUES (12, 2, 6, 42)
INSERT [dbo].[RESULTS] ([result_ID], [student_ID], [evaluation_ID], [marks_obtained]) VALUES (13, 3, 7, 9)
INSERT [dbo].[RESULTS] ([result_ID], [student_ID], [evaluation_ID], [marks_obtained]) VALUES (14, 4, 7, 10)
INSERT [dbo].[RESULTS] ([result_ID], [student_ID], [evaluation_ID], [marks_obtained]) VALUES (15, 3, 8, 19)
INSERT [dbo].[RESULTS] ([result_ID], [student_ID], [evaluation_ID], [marks_obtained]) VALUES (16, 4, 8, 20)
INSERT [dbo].[RESULTS] ([result_ID], [student_ID], [evaluation_ID], [marks_obtained]) VALUES (17, 3, 9, 18)
INSERT [dbo].[RESULTS] ([result_ID], [student_ID], [evaluation_ID], [marks_obtained]) VALUES (18, 4, 9, 20)
INSERT [dbo].[RESULTS] ([result_ID], [student_ID], [evaluation_ID], [marks_obtained]) VALUES (19, 3, 10, 10)
INSERT [dbo].[RESULTS] ([result_ID], [student_ID], [evaluation_ID], [marks_obtained]) VALUES (20, 4, 10, 9)
INSERT [dbo].[RESULTS] ([result_ID], [student_ID], [evaluation_ID], [marks_obtained]) VALUES (21, 3, 11, 19)
INSERT [dbo].[RESULTS] ([result_ID], [student_ID], [evaluation_ID], [marks_obtained]) VALUES (22, 4, 11, 20)
INSERT [dbo].[RESULTS] ([result_ID], [student_ID], [evaluation_ID], [marks_obtained]) VALUES (23, 3, 12, 47)
INSERT [dbo].[RESULTS] ([result_ID], [student_ID], [evaluation_ID], [marks_obtained]) VALUES (24, 4, 12, 50)
SET IDENTITY_INSERT [dbo].[RESULTS] OFF
GO
INSERT [dbo].[STUDENT_ATTENDANCE] ([attendance_ID], [student_ID]) VALUES (1, 1)
INSERT [dbo].[STUDENT_ATTENDANCE] ([attendance_ID], [student_ID]) VALUES (2, 2)
INSERT [dbo].[STUDENT_ATTENDANCE] ([attendance_ID], [student_ID]) VALUES (3, 3)
INSERT [dbo].[STUDENT_ATTENDANCE] ([attendance_ID], [student_ID]) VALUES (4, 4)
GO
SET IDENTITY_INSERT [dbo].[STUDENTS] ON 

INSERT [dbo].[STUDENTS] ([student_ID], [first_name], [last_name], [gender], [date_of_birth], [class_ID], [academic_year_ID]) VALUES (1, N'Ali', N'Khan', N'Male', CAST(N'2010-05-15' AS Date), 1, 1)
INSERT [dbo].[STUDENTS] ([student_ID], [first_name], [last_name], [gender], [date_of_birth], [class_ID], [academic_year_ID]) VALUES (2, N'Sara', N'Ahmed', N'Female', CAST(N'2010-08-22' AS Date), 1, 1)
INSERT [dbo].[STUDENTS] ([student_ID], [first_name], [last_name], [gender], [date_of_birth], [class_ID], [academic_year_ID]) VALUES (3, N'Hassan', N'Raza', N'Male', CAST(N'2009-11-10' AS Date), 2, 2)
INSERT [dbo].[STUDENTS] ([student_ID], [first_name], [last_name], [gender], [date_of_birth], [class_ID], [academic_year_ID]) VALUES (4, N'Aisha', N'Naseer', N'Female', CAST(N'2009-03-03' AS Date), 2, 2)
SET IDENTITY_INSERT [dbo].[STUDENTS] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__ACADEMIC__8C6DB97A3BFEE45B]    Script Date: 04/06/2025 8:00:58 pm ******/
ALTER TABLE [dbo].[ACADEMIC_YEAR] ADD UNIQUE NONCLUSTERED 
(
	[academic_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__CLASS__7DC4C39DDB2128F9]    Script Date: 04/06/2025 8:00:58 pm ******/
ALTER TABLE [dbo].[CLASS] ADD UNIQUE NONCLUSTERED 
(
	[class_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__COURSES__B5B2A66AA89DAD0E]    Script Date: 04/06/2025 8:00:58 pm ******/
ALTER TABLE [dbo].[COURSES] ADD UNIQUE NONCLUSTERED 
(
	[course_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__EVALUATI__543C4FD9E9B57468]    Script Date: 04/06/2025 8:00:58 pm ******/
ALTER TABLE [dbo].[EVALUATION_TYPE] ADD UNIQUE NONCLUSTERED 
(
	[type_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ATTENDANCE] ADD  DEFAULT ('Present') FOR [status]
GO
ALTER TABLE [dbo].[FEES] ADD  DEFAULT ('Pending') FOR [payment_status]
GO
ALTER TABLE [dbo].[ATTENDANCE]  WITH CHECK ADD FOREIGN KEY([class_ID])
REFERENCES [dbo].[CLASS] ([class_ID])
GO
ALTER TABLE [dbo].[ATTENDANCE]  WITH CHECK ADD FOREIGN KEY([student_ID])
REFERENCES [dbo].[STUDENTS] ([student_ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CLASS_COURSE]  WITH CHECK ADD FOREIGN KEY([class_ID])
REFERENCES [dbo].[CLASS] ([class_ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CLASS_COURSE]  WITH CHECK ADD FOREIGN KEY([course_ID])
REFERENCES [dbo].[COURSES] ([course_ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EVALUATION]  WITH CHECK ADD FOREIGN KEY([course_ID])
REFERENCES [dbo].[COURSES] ([course_ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EVALUATION]  WITH CHECK ADD FOREIGN KEY([evaluation_type_ID])
REFERENCES [dbo].[EVALUATION_TYPE] ([evaluation_type_ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EVALUATION_STUDENT_RESULT]  WITH NOCHECK ADD FOREIGN KEY([evaluation_ID])
REFERENCES [dbo].[EVALUATION] ([evaluation_ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EVALUATION_STUDENT_RESULT]  WITH NOCHECK ADD FOREIGN KEY([result_ID])
REFERENCES [dbo].[RESULTS] ([result_ID])
GO
ALTER TABLE [dbo].[EVALUATION_STUDENT_RESULT]  WITH NOCHECK ADD FOREIGN KEY([student_ID])
REFERENCES [dbo].[STUDENTS] ([student_ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FEES]  WITH CHECK ADD FOREIGN KEY([student_ID])
REFERENCES [dbo].[STUDENTS] ([student_ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RESULTS]  WITH CHECK ADD FOREIGN KEY([evaluation_ID])
REFERENCES [dbo].[EVALUATION] ([evaluation_ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RESULTS]  WITH CHECK ADD FOREIGN KEY([student_ID])
REFERENCES [dbo].[STUDENTS] ([student_ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[STUDENT_ATTENDANCE]  WITH NOCHECK ADD FOREIGN KEY([attendance_ID])
REFERENCES [dbo].[ATTENDANCE] ([attendance_ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[STUDENT_ATTENDANCE]  WITH NOCHECK ADD FOREIGN KEY([student_ID])
REFERENCES [dbo].[STUDENTS] ([student_ID])
GO
ALTER TABLE [dbo].[STUDENTS]  WITH CHECK ADD FOREIGN KEY([academic_year_ID])
REFERENCES [dbo].[ACADEMIC_YEAR] ([academic_year_ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[STUDENTS]  WITH CHECK ADD FOREIGN KEY([class_ID])
REFERENCES [dbo].[CLASS] ([class_ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ATTENDANCE]  WITH CHECK ADD CHECK  (([status]='Excused' OR [status]='Late' OR [status]='Absent' OR [status]='Present'))
GO
ALTER TABLE [dbo].[EVALUATION]  WITH CHECK ADD CHECK  (([max_marks]>=(0) AND [max_marks]<=(100)))
GO
ALTER TABLE [dbo].[FEES]  WITH CHECK ADD CHECK  (([amount_due]>=(0) AND [amount_due]<=(1000000)))
GO
ALTER TABLE [dbo].[FEES]  WITH CHECK ADD CHECK  (([amount_paid]>=(0) AND [amount_paid]<=(1000000)))
GO
ALTER TABLE [dbo].[RESULTS]  WITH CHECK ADD CHECK  (([marks_obtained]>=(0) AND [marks_obtained]<=(100)))
GO
ALTER TABLE [dbo].[STUDENTS]  WITH CHECK ADD CHECK  (([gender]='Female' OR [gender]='Male'))
GO
USE [master]
GO
ALTER DATABASE [StudentRecords] SET  READ_WRITE 
GO
