USE [master]
GO
/****** Object:  Database [Library_Db]    Script Date: 16.01.2022 16:10:06 ******/
CREATE DATABASE [Library_Db]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Library_Db', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Library_Db.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Library_Db_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Library_Db_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Library_Db] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Library_Db].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Library_Db] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Library_Db] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Library_Db] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Library_Db] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Library_Db] SET ARITHABORT OFF 
GO
ALTER DATABASE [Library_Db] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Library_Db] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Library_Db] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Library_Db] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Library_Db] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Library_Db] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Library_Db] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Library_Db] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Library_Db] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Library_Db] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Library_Db] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Library_Db] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Library_Db] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Library_Db] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Library_Db] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Library_Db] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [Library_Db] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Library_Db] SET RECOVERY FULL 
GO
ALTER DATABASE [Library_Db] SET  MULTI_USER 
GO
ALTER DATABASE [Library_Db] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Library_Db] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Library_Db] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Library_Db] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Library_Db] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Library_Db] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Library_Db', N'ON'
GO
ALTER DATABASE [Library_Db] SET QUERY_STORE = OFF
GO
USE [Library_Db]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 16.01.2022 16:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Auths]    Script Date: 16.01.2022 16:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Auths](
	[AuthId] [int] IDENTITY(1,1) NOT NULL,
	[AuthName] [nvarchar](max) NULL,
	[AuthPassword] [nvarchar](max) NULL,
	[AuthMail] [nvarchar](max) NULL,
 CONSTRAINT [PK_Auths] PRIMARY KEY CLUSTERED 
(
	[AuthId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Books]    Script Date: 16.01.2022 16:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Books](
	[BookId] [int] IDENTITY(1,1) NOT NULL,
	[BookName] [nvarchar](max) NULL,
	[BookWriter] [nvarchar](max) NULL,
	[BookPublisher] [nvarchar](max) NULL,
	[BookNumberOfPage] [int] NOT NULL,
	[UserId] [int] NULL,
	[IsBorrowed] [bit] NOT NULL,
	[BarrowDate] [datetime2](7) NOT NULL,
	[ReturnDate] [datetime2](7) NOT NULL,
	[BookCoverUrl] [nvarchar](max) NULL,
 CONSTRAINT [PK_Books] PRIMARY KEY CLUSTERED 
(
	[BookId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 16.01.2022 16:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](max) NULL,
	[UserPassword] [nvarchar](max) NULL,
	[UserMail] [nvarchar](max) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20211211101006_mig1', N'5.0.9')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20211211101222_mig2', N'5.0.9')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20211211101247_mig3', N'5.0.9')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20211212164946_mig4', N'5.0.9')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20211222114903_mig5', N'5.0.9')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20211227184558_mig6', N'5.0.9')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20220104190209_mig7', N'5.0.9')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20220108160134_mig8', N'5.0.9')
GO
SET IDENTITY_INSERT [dbo].[Auths] ON 

INSERT [dbo].[Auths] ([AuthId], [AuthName], [AuthPassword], [AuthMail]) VALUES (2009, N'admin', N'8C6976E5B5410415BDE908BD4DEE15DFB167A9C873FC4BB8A81F6F2AB448A918', N'admin@gmail.com')
INSERT [dbo].[Auths] ([AuthId], [AuthName], [AuthPassword], [AuthMail]) VALUES (2010, N'admin2', N'1C142B2D01AA34E9A36BDE480645A57FD69E14155DACFAB5A3F9257B77FDC8D8', N'admin2@gmail.com')
SET IDENTITY_INSERT [dbo].[Auths] OFF
GO
SET IDENTITY_INSERT [dbo].[Books] ON 

INSERT [dbo].[Books] ([BookId], [BookName], [BookWriter], [BookPublisher], [BookNumberOfPage], [UserId], [IsBorrowed], [BarrowDate], [ReturnDate], [BookCoverUrl]) VALUES (1008, N'Otomatik Portakal', N'Anthony Burgess', N'İş Bankası', 171, 2013, 1, CAST(N'2022-01-06T15:13:00.4001781' AS DateTime2), CAST(N'2022-01-20T15:13:00.4006992' AS DateTime2), N'https://i.dr.com.tr/cache/600x600-0/originals/0001806049001-1.jpg')
INSERT [dbo].[Books] ([BookId], [BookName], [BookWriter], [BookPublisher], [BookNumberOfPage], [UserId], [IsBorrowed], [BarrowDate], [ReturnDate], [BookCoverUrl]) VALUES (1011, N'Fareler ve İnsanlar', N'John Steinbeck', N'Sel', 111, 2015, 1, CAST(N'2022-01-16T15:13:23.9081673' AS DateTime2), CAST(N'2022-01-15T15:13:23.9081709' AS DateTime2), N'https://cdn.akakce.com/-/fareler-ve-insanlar-john-steinbeck-z.jpg')
INSERT [dbo].[Books] ([BookId], [BookName], [BookWriter], [BookPublisher], [BookNumberOfPage], [UserId], [IsBorrowed], [BarrowDate], [ReturnDate], [BookCoverUrl]) VALUES (1012, N'1984', N'George Orwell', N'can', 352, 2016, 1, CAST(N'2022-01-16T15:14:34.6403557' AS DateTime2), CAST(N'2022-02-05T15:14:34.6403580' AS DateTime2), N'https://i.dr.com.tr/cache/600x600-0/originals/0000000064038-1.jpg')
INSERT [dbo].[Books] ([BookId], [BookName], [BookWriter], [BookPublisher], [BookNumberOfPage], [UserId], [IsBorrowed], [BarrowDate], [ReturnDate], [BookCoverUrl]) VALUES (1014, N'Küçük Prens', N'Antoine De Saint Exupery', N'Mavi Bulut', 96, NULL, 0, CAST(N'2022-01-15T20:09:32.9148455' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), N'https://i.dr.com.tr/cache/500x400-0/originals/0000000628979-1.jpg')
INSERT [dbo].[Books] ([BookId], [BookName], [BookWriter], [BookPublisher], [BookNumberOfPage], [UserId], [IsBorrowed], [BarrowDate], [ReturnDate], [BookCoverUrl]) VALUES (1015, N'Aylak Adam', N'Yusuf Atılgan', N'YKY', 156, NULL, 0, CAST(N'2022-01-15T20:12:13.1532284' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), N'https://images.kitapsepeti.com/Content/global/images/products/3/303048/aylak-adam.jpg')
INSERT [dbo].[Books] ([BookId], [BookName], [BookWriter], [BookPublisher], [BookNumberOfPage], [UserId], [IsBorrowed], [BarrowDate], [ReturnDate], [BookCoverUrl]) VALUES (1016, N'Tutunamayanlar', N'Oğuz Atay', N'İletişim', 724, NULL, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), N'https://i.dr.com.tr/cache/500x400-0/originals/0000000061424-1.jpg')
INSERT [dbo].[Books] ([BookId], [BookName], [BookWriter], [BookPublisher], [BookNumberOfPage], [UserId], [IsBorrowed], [BarrowDate], [ReturnDate], [BookCoverUrl]) VALUES (1017, N'Sol Ayağım', N'Christy Brown', N'Nemesis', 189, NULL, 0, CAST(N'2022-01-15T18:57:11.8138017' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), N'https://1k-cdn.com/resimler/kitaplar/270185_0f5a4_1588973881.jpg')
INSERT [dbo].[Books] ([BookId], [BookName], [BookWriter], [BookPublisher], [BookNumberOfPage], [UserId], [IsBorrowed], [BarrowDate], [ReturnDate], [BookCoverUrl]) VALUES (1018, N'Fahrenheit 451', N'Ray Bradbury', N'İthaki', 230, NULL, 0, CAST(N'2022-01-15T18:49:26.1176296' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), N'https://i.dr.com.tr/cache/500x400-0/originals/0001750151001-1.jpg')
INSERT [dbo].[Books] ([BookId], [BookName], [BookWriter], [BookPublisher], [BookNumberOfPage], [UserId], [IsBorrowed], [BarrowDate], [ReturnDate], [BookCoverUrl]) VALUES (1021, N'Suç ve Ceza', N'Fyodor Mihailoviç Dostoyevski', N'İş bankası', 643, NULL, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), N'https://i.dr.com.tr/cache/500x400-0/originals/0000000222779-1.jpg')
INSERT [dbo].[Books] ([BookId], [BookName], [BookWriter], [BookPublisher], [BookNumberOfPage], [UserId], [IsBorrowed], [BarrowDate], [ReturnDate], [BookCoverUrl]) VALUES (1022, N'Sefiller', N'Victor Hugo', N'İskele', 400, NULL, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), N'https://cdn.dsmcdn.com/mnresize/400/-/ty103/product/media/images/20210414/14/80089955/12432092/1/1_org.jpg')
INSERT [dbo].[Books] ([BookId], [BookName], [BookWriter], [BookPublisher], [BookNumberOfPage], [UserId], [IsBorrowed], [BarrowDate], [ReturnDate], [BookCoverUrl]) VALUES (1023, N'Hayvan Çiftliği', N'George Orwell', N'Can', 152, NULL, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), N'https://i.dr.com.tr/cache/600x600-0/originals/0000000105409-1.jpg')
INSERT [dbo].[Books] ([BookId], [BookName], [BookWriter], [BookPublisher], [BookNumberOfPage], [UserId], [IsBorrowed], [BarrowDate], [ReturnDate], [BookCoverUrl]) VALUES (1024, N'Olasılıksız', N'Adam Fawer', N'April', 472, NULL, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), N'https://cdn.akakce.com/-/olasiliksiz-adam-fawer-z.jpg')
INSERT [dbo].[Books] ([BookId], [BookName], [BookWriter], [BookPublisher], [BookNumberOfPage], [UserId], [IsBorrowed], [BarrowDate], [ReturnDate], [BookCoverUrl]) VALUES (1025, N'Kumarbaz', N'Fyodor Mihailoviç Dostoyevski', N'İş Bankası', 192, NULL, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), N'https://i.dr.com.tr/cache/500x400-0/originals/0000000438745-1.jpg')
INSERT [dbo].[Books] ([BookId], [BookName], [BookWriter], [BookPublisher], [BookNumberOfPage], [UserId], [IsBorrowed], [BarrowDate], [ReturnDate], [BookCoverUrl]) VALUES (1026, N'Dönüşüm', N'Franz Kafka', N'Can', 113, NULL, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), N'https://admin-7866.kxcdn.com/Upload/BooksImage//9789750719356_front_cover(5).jpg')
INSERT [dbo].[Books] ([BookId], [BookName], [BookWriter], [BookPublisher], [BookNumberOfPage], [UserId], [IsBorrowed], [BarrowDate], [ReturnDate], [BookCoverUrl]) VALUES (1027, N'Kürk Mantolu Madonna', N'Sabahattin Ali', N'YKY', 160, NULL, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), N'https://i.dr.com.tr/cache/500x400-0/originals/0000000058245-1.jpg')
INSERT [dbo].[Books] ([BookId], [BookName], [BookWriter], [BookPublisher], [BookNumberOfPage], [UserId], [IsBorrowed], [BarrowDate], [ReturnDate], [BookCoverUrl]) VALUES (1028, N'Şeker Portakalı', N'Jose Mauro De Vasconcelos', N'Can', 182, NULL, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), N'https://i.dr.com.tr/cache/500x400-0/originals/0000000064031-1.jpg')
INSERT [dbo].[Books] ([BookId], [BookName], [BookWriter], [BookPublisher], [BookNumberOfPage], [UserId], [IsBorrowed], [BarrowDate], [ReturnDate], [BookCoverUrl]) VALUES (1029, N'Bilinmeyen Bir Kadının Mektubu', N'Stefan Zweig', N'İş Bankası', 68, NULL, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), N'https://i.dr.com.tr/cache/500x400-0/originals/0000000411059-1.jpg')
INSERT [dbo].[Books] ([BookId], [BookName], [BookWriter], [BookPublisher], [BookNumberOfPage], [UserId], [IsBorrowed], [BarrowDate], [ReturnDate], [BookCoverUrl]) VALUES (1030, N'Satranç', N'Stefan Zweig', N'İş Bankası', 71, 2013, 1, CAST(N'2022-01-16T15:15:26.2228346' AS DateTime2), CAST(N'2022-02-05T15:15:26.2228369' AS DateTime2), N'https://m.media-amazon.com/images/I/41KXYhApcNS._AC_SY1000_.jpg')
SET IDENTITY_INSERT [dbo].[Books] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserId], [UserName], [UserPassword], [UserMail]) VALUES (2013, N'user', N'04F8996DA763B7A969B1028EE3007569EAF3A635486DDAB211D512C85B9DF8FB', N'user@gmail.com')
INSERT [dbo].[Users] ([UserId], [UserName], [UserPassword], [UserMail]) VALUES (2015, N'ismail', N'705301A7CA4C57FDCFD9F6312E10531025367A63D678D687A6BD4D5DB4A023CF', N'ismail@gmail.com')
INSERT [dbo].[Users] ([UserId], [UserName], [UserPassword], [UserMail]) VALUES (2016, N'ömer', N'790272C06DB5D329C92E4FB1BE244B2D6340C15286628852093B0A7F4E6292AA', N'omer@gmail.com')
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
/****** Object:  Index [IX_Books_UserId]    Script Date: 16.01.2022 16:10:06 ******/
CREATE NONCLUSTERED INDEX [IX_Books_UserId] ON [dbo].[Books]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Books] ADD  DEFAULT (CONVERT([bit],(0))) FOR [IsBorrowed]
GO
ALTER TABLE [dbo].[Books] ADD  DEFAULT ('0001-01-01T00:00:00.0000000') FOR [BarrowDate]
GO
ALTER TABLE [dbo].[Books] ADD  DEFAULT ('0001-01-01T00:00:00.0000000') FOR [ReturnDate]
GO
ALTER TABLE [dbo].[Books]  WITH CHECK ADD  CONSTRAINT [FK_Books_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Books] CHECK CONSTRAINT [FK_Books_Users_UserId]
GO
USE [master]
GO
ALTER DATABASE [Library_Db] SET  READ_WRITE 
GO
