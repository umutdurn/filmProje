USE [master]
GO
/****** Object:  Database [filmSitesi]    Script Date: 17.12.2017 15:10:15 ******/
CREATE DATABASE [filmSitesi]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'filmSitesi', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\filmSitesi.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'filmSitesi_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\filmSitesi_log.ldf' , SIZE = 3840KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [filmSitesi] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [filmSitesi].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [filmSitesi] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [filmSitesi] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [filmSitesi] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [filmSitesi] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [filmSitesi] SET ARITHABORT OFF 
GO
ALTER DATABASE [filmSitesi] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [filmSitesi] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [filmSitesi] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [filmSitesi] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [filmSitesi] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [filmSitesi] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [filmSitesi] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [filmSitesi] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [filmSitesi] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [filmSitesi] SET  DISABLE_BROKER 
GO
ALTER DATABASE [filmSitesi] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [filmSitesi] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [filmSitesi] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [filmSitesi] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [filmSitesi] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [filmSitesi] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [filmSitesi] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [filmSitesi] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [filmSitesi] SET  MULTI_USER 
GO
ALTER DATABASE [filmSitesi] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [filmSitesi] SET DB_CHAINING OFF 
GO
ALTER DATABASE [filmSitesi] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [filmSitesi] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [filmSitesi] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'filmSitesi', N'ON'
GO
ALTER DATABASE [filmSitesi] SET QUERY_STORE = OFF
GO
USE [filmSitesi]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [filmSitesi]
GO
/****** Object:  Table [dbo].[film_Filmler]    Script Date: 17.12.2017 15:10:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[film_Filmler](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Baslik] [nvarchar](max) NULL,
	[Icerik] [nvarchar](max) NULL,
	[Poster] [nvarchar](max) NULL,
	[Oyuncular] [nvarchar](max) NULL,
	[MetaDesc] [nvarchar](max) NULL,
	[URL] [nvarchar](max) NULL,
	[Kategoriler] [nvarchar](max) NULL,
	[YapimYili] [int] NULL,
	[IMDB] [nvarchar](max) NULL,
	[Yonetmenler] [nvarchar](max) NULL,
	[Ulke] [nvarchar](max) NULL,
	[Sure] [nvarchar](max) NULL,
	[OrjinalAdi] [nvarchar](max) NULL,
	[OlusturmaTarihi] [date] NULL,
	[Inceleme] [nvarchar](max) NULL,
 CONSTRAINT [PK_film_Filmler] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[film_Kategoriler]    Script Date: 17.12.2017 15:10:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[film_Kategoriler](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[KategoriAdi] [nvarchar](max) NULL,
	[URL] [nvarchar](max) NULL,
 CONSTRAINT [PK_film_Kategoriler] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[film_Kullanici]    Script Date: 17.12.2017 15:10:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[film_Kullanici](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[KullaniciAdi] [nvarchar](15) NULL,
	[Parola] [nvarchar](max) NULL,
	[Email] [nvarchar](max) NULL,
	[Admin] [int] NULL,
 CONSTRAINT [PK_film_Kullanici] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[film_Oylar]    Script Date: 17.12.2017 15:10:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[film_Oylar](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Oy] [int] NULL,
	[IpAdresi] [nvarchar](max) NULL,
	[Tarih] [date] NULL,
	[FilmUrl] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[film_Oyuncular]    Script Date: 17.12.2017 15:10:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[film_Oyuncular](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Oyuncu] [nvarchar](max) NULL,
	[OyuncuURL] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[film_Partlar]    Script Date: 17.12.2017 15:10:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[film_Partlar](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PartAdi] [nvarchar](max) NULL,
	[Iframe] [nvarchar](max) NULL,
	[FilmID] [int] NULL,
	[Kalitesi] [nvarchar](max) NULL,
	[Dil] [nvarchar](max) NULL,
 CONSTRAINT [PK_film_Partlar] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[film_Ulkeler]    Script Date: 17.12.2017 15:10:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[film_Ulkeler](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UlkeAdi] [varchar](255) NULL,
	[UlkeURL] [nvarchar](max) NULL,
 CONSTRAINT [PK_ulke] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[film_Yonetmenler]    Script Date: 17.12.2017 15:10:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[film_Yonetmenler](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Yonetmen] [nvarchar](max) NULL,
	[YonetmenURL] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[film_Filmler] ON 

INSERT [dbo].[film_Filmler] ([ID], [Baslik], [Icerik], [Poster], [Oyuncular], [MetaDesc], [URL], [Kategoriler], [YapimYili], [IMDB], [Yonetmenler], [Ulke], [Sure], [OrjinalAdi], [OlusturmaTarihi], [Inceleme]) VALUES (24, N'Star Wars 8 Son Jedi - Star Wars 8 Last Jedi Tek Parça Full HD izle', N'<p><strong>Star War 8 Son Jedi izle</strong> filmi 2017 yılı ABD yapımı bir bilimkurgu filmidir. Y&ouml;netmenliğini Rian Johnson&#39;un yaptığı filmde&nbsp;Daisy Ridley,&nbsp; Domhnall Gleeson,&nbsp; Adam Driver,&nbsp; Oscar Isaac,&nbsp; Billie Lourd gibi d&uuml;nyada &uuml;nl&uuml; bir &ccedil;ok isim yer almaktadır.</p>

<p>Star War 8 Son Jedi film konusu, Rey, Jedi d&uuml;nyasına adım atmıştır ve kendisinin yaşayan son Jedi olduğunu &ouml;ğrenmiştir. Artık bu yolda kendine yeni arkadaşlar edinmiştir. bunlar Luke Skywalker, Leila, Finn ve Poe&#39;dur. Rey arkadaşları ile birlikte g&uuml;&ccedil; ve ge&ccedil;mişinin sırlarını &ouml;ğrenmek i&ccedil;in zorlu ve b&uuml;y&uuml;k bir maceraya atılacaktır.</p>
', N'star-wars-8-son-jedi-izle.jpg', N',10,11,12,13,14,', N'Star Wars 8 Son Jedi izle filmi 2018 yılı ABD yapımı bir bilim kurgu filmidir. Bu filmi sitemizden tek parça ve 1080p kalitede izleyebilirsiniz.', N'star-wars-8-son-jedi-full-hd-tek-parca-izle', N',2,5,8,14,', 2017, N'8.0', N',25,', N'abd', N'152', N'Star Wars 8 Son Jedi', CAST(N'2017-12-16' AS Date), N'97')
INSERT [dbo].[film_Filmler] ([ID], [Baslik], [Icerik], [Poster], [Oyuncular], [MetaDesc], [URL], [Kategoriler], [YapimYili], [IMDB], [Yonetmenler], [Ulke], [Sure], [OrjinalAdi], [OlusturmaTarihi], [Inceleme]) VALUES (25, N'Barry Seal: Kaçakçı izle - American Made Tek Parça Türkçe Dublaj', N'<p>Barry Seal: Ka&ccedil;ak&ccedil;ı izle filmi 2017 yılı ABD yapımı bir aksiyon filmidir. Y&ouml;netmenliğini Doug Liman&#39;ın yaptığı filmde Tom Cruise,&nbsp; Jayma Mays,&nbsp; Domhnall Gleeson,&nbsp; Sarah Wright,&nbsp; Caleb Landry Jones gibi oyuncular yer almaktadır.</p>

<p>Film konusu, başarılı bir sivil havayolu pilotu olan Barry Seal, huzurlu ve mutlu bir hayat s&uuml;rmektedir. Fakat CIA&#39;den gelen bir teklif onu cezbeder ve kabul etmiş bulunur. Teklif ise Barry Seal&#39;in &uuml;lkesi i&ccedil;in silah taşıması istenmektedir. Fakat işler b&uuml;y&uuml;d&uuml;k&ccedil;e parada b&uuml;y&uuml;r. Durum bu olunca Barry Seal kendini Pablo Escobar gibi n&uuml;y&uuml;n uyuşturucu baronları i&ccedil;in uyuşturucu taşırken bulacaktır. Film 2017 yılı yapımı bir aksiyon filmidir.</p>
', N'barry-seal-kacakci-izle.jpg', N',15,16,11,17,18,', N'Barry Seal: Kaçakçı izle filmi 2017 yılı ABD yapımı bir aksiyon filmidir. Bu filmi sitemizden tek parça full hd kalitede izleyebilirsiniz.', N'barry-seal-kacakci-tek-parca-full-hd-izle', N',10,18,', 2017, N'7.2', N',26,', N'afganistan', N'120', N'Barry Seal: Kaçakçı', CAST(N'2017-12-16' AS Date), N'111')
SET IDENTITY_INSERT [dbo].[film_Filmler] OFF
SET IDENTITY_INSERT [dbo].[film_Kategoriler] ON 

INSERT [dbo].[film_Kategoriler] ([ID], [KategoriAdi], [URL]) VALUES (1, N'Aile', N'aile-filmleri')
INSERT [dbo].[film_Kategoriler] ([ID], [KategoriAdi], [URL]) VALUES (2, N'Aksiyon', N'aksiyon-filmleri')
INSERT [dbo].[film_Kategoriler] ([ID], [KategoriAdi], [URL]) VALUES (3, N'Animasyon', N'animasyon-filmleri')
INSERT [dbo].[film_Kategoriler] ([ID], [KategoriAdi], [URL]) VALUES (4, N'Belgesel', N'belgeseller')
INSERT [dbo].[film_Kategoriler] ([ID], [KategoriAdi], [URL]) VALUES (5, N'Bilimkurgu', N'bilimkurgu-filmleri')
INSERT [dbo].[film_Kategoriler] ([ID], [KategoriAdi], [URL]) VALUES (6, N'Biyografi', N'biyografi-filmleri')
INSERT [dbo].[film_Kategoriler] ([ID], [KategoriAdi], [URL]) VALUES (7, N'Dram', N'dram-filmleri')
INSERT [dbo].[film_Kategoriler] ([ID], [KategoriAdi], [URL]) VALUES (8, N'Fantastik', N'fantastik-filmler')
INSERT [dbo].[film_Kategoriler] ([ID], [KategoriAdi], [URL]) VALUES (9, N'Gençlik', N'genclik-filmleri')
INSERT [dbo].[film_Kategoriler] ([ID], [KategoriAdi], [URL]) VALUES (10, N'Gerilim', N'gerilim-filmleri')
INSERT [dbo].[film_Kategoriler] ([ID], [KategoriAdi], [URL]) VALUES (11, N'Gizem', N'gizem-filmleri')
INSERT [dbo].[film_Kategoriler] ([ID], [KategoriAdi], [URL]) VALUES (12, N'Komedi', N'komedi-filmleri')
INSERT [dbo].[film_Kategoriler] ([ID], [KategoriAdi], [URL]) VALUES (13, N'Korku', N'korku-filmleri')
INSERT [dbo].[film_Kategoriler] ([ID], [KategoriAdi], [URL]) VALUES (14, N'Macera', N'macera-filmleri')
INSERT [dbo].[film_Kategoriler] ([ID], [KategoriAdi], [URL]) VALUES (15, N'Müzikal', N'muzikaller')
INSERT [dbo].[film_Kategoriler] ([ID], [KategoriAdi], [URL]) VALUES (16, N'Romantik', N'romantik-filmler')
INSERT [dbo].[film_Kategoriler] ([ID], [KategoriAdi], [URL]) VALUES (17, N'Savaş', N'savas-filmleri')
INSERT [dbo].[film_Kategoriler] ([ID], [KategoriAdi], [URL]) VALUES (18, N'Suç', N'suc-filmleri')
INSERT [dbo].[film_Kategoriler] ([ID], [KategoriAdi], [URL]) VALUES (19, N'Tarih', N'tarih-filmleri')
INSERT [dbo].[film_Kategoriler] ([ID], [KategoriAdi], [URL]) VALUES (30, N'Hint', N'hint-filmleri')
SET IDENTITY_INSERT [dbo].[film_Kategoriler] OFF
SET IDENTITY_INSERT [dbo].[film_Kullanici] ON 

INSERT [dbo].[film_Kullanici] ([ID], [KullaniciAdi], [Parola], [Email], [Admin]) VALUES (1, N'umcoder', N'52f883aa26f33354ad18c99228824328', N'umut__duran@hotmail.com', 1)
SET IDENTITY_INSERT [dbo].[film_Kullanici] OFF
SET IDENTITY_INSERT [dbo].[film_Oylar] ON 

INSERT [dbo].[film_Oylar] ([ID], [Oy], [IpAdresi], [Tarih], [FilmUrl]) VALUES (15, 5, N'::1', CAST(N'2017-12-16' AS Date), N'star-wars-8-son-jedi-full-hd-tek-parca-izle')
INSERT [dbo].[film_Oylar] ([ID], [Oy], [IpAdresi], [Tarih], [FilmUrl]) VALUES (16, 4, N'::1', CAST(N'2017-12-16' AS Date), N'barry-seal--kacakci-tek-parca-full-hd-izle')
INSERT [dbo].[film_Oylar] ([ID], [Oy], [IpAdresi], [Tarih], [FilmUrl]) VALUES (17, 4, N'::1', CAST(N'2017-12-16' AS Date), N'barry-seal-kacakci-tek-parca-full-hd-izle')
INSERT [dbo].[film_Oylar] ([ID], [Oy], [IpAdresi], [Tarih], [FilmUrl]) VALUES (18, 5, N'::1', CAST(N'2017-12-16' AS Date), N'barry-seal-kacakci-tek-parca-full-hd-izle')
INSERT [dbo].[film_Oylar] ([ID], [Oy], [IpAdresi], [Tarih], [FilmUrl]) VALUES (19, 4, N'::1', CAST(N'2017-12-16' AS Date), N'star-wars-8-son-jedi-full-hd-tek-parca-izle')
INSERT [dbo].[film_Oylar] ([ID], [Oy], [IpAdresi], [Tarih], [FilmUrl]) VALUES (20, 5, N'::1', CAST(N'2017-12-16' AS Date), N'barry-seal-kacakci-tek-parca-full-hd-izle')
SET IDENTITY_INSERT [dbo].[film_Oylar] OFF
SET IDENTITY_INSERT [dbo].[film_Oyuncular] ON 

INSERT [dbo].[film_Oyuncular] ([ID], [Oyuncu], [OyuncuURL]) VALUES (10, N'Daisy Ridley', N'daisy-ridley')
INSERT [dbo].[film_Oyuncular] ([ID], [Oyuncu], [OyuncuURL]) VALUES (11, N'Domhnall Gleeson', N'domhnall-gleeson')
INSERT [dbo].[film_Oyuncular] ([ID], [Oyuncu], [OyuncuURL]) VALUES (12, N'Adam Driver', N'adam-driver')
INSERT [dbo].[film_Oyuncular] ([ID], [Oyuncu], [OyuncuURL]) VALUES (13, N'Oscar Isaac', N'oscar-isaac')
INSERT [dbo].[film_Oyuncular] ([ID], [Oyuncu], [OyuncuURL]) VALUES (14, N'Billie Lourd', N'billie-lourd')
INSERT [dbo].[film_Oyuncular] ([ID], [Oyuncu], [OyuncuURL]) VALUES (15, N'Tom Cruise', N'tom-cruise')
INSERT [dbo].[film_Oyuncular] ([ID], [Oyuncu], [OyuncuURL]) VALUES (16, N'Jayma Mays', N'jayma-mays')
INSERT [dbo].[film_Oyuncular] ([ID], [Oyuncu], [OyuncuURL]) VALUES (17, N'Sarah Wright', N'sarah-wright')
INSERT [dbo].[film_Oyuncular] ([ID], [Oyuncu], [OyuncuURL]) VALUES (18, N'Caleb Landry Jones', N'caleb-landry-jones')
SET IDENTITY_INSERT [dbo].[film_Oyuncular] OFF
SET IDENTITY_INSERT [dbo].[film_Partlar] ON 

INSERT [dbo].[film_Partlar] ([ID], [PartAdi], [Iframe], [FilmID], [Kalitesi], [Dil]) VALUES (39, N'Fragman', N'<iframe width="560" height="315" src="https://www.youtube.com/embed/zB4I68XVPzQ" frameborder="0" gesture="media" allow="encrypted-media" allowfullscreen></iframe>', 24, N'720p', N'Türkçe Dublaj')
INSERT [dbo].[film_Partlar] ([ID], [PartAdi], [Iframe], [FilmID], [Kalitesi], [Dil]) VALUES (40, N'OpenLoad', N'<iframe src="https://oload.tv/embed/MirEp6oc6PY/" scrolling="no" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen="" width="664" height="386" frameborder="0"></iframe>', 24, N'720p', N'Türkçe Dublaj')
INSERT [dbo].[film_Partlar] ([ID], [PartAdi], [Iframe], [FilmID], [Kalitesi], [Dil]) VALUES (41, N'Rapid', N'<iframe src="https://www.rapidvideo.com/e/FMHTOKYD1K" sandbox="allow-forms allow-pointer-lock allow-same-origin allow-scripts allow-top-navigation" allowfullscreen="" webkitallowfullscreen="" mozallowfullscreen="" scrolling="no" width="100%" height="350" frameborder="0"></iframe>', 24, N'720p', N'Türkçe Dublaj')
INSERT [dbo].[film_Partlar] ([ID], [PartAdi], [Iframe], [FilmID], [Kalitesi], [Dil]) VALUES (42, N'Fragman', N'<iframe width="560" height="315" src="https://www.youtube.com/embed/AEBIJRAkujM" frameborder="0" gesture="media" allow="encrypted-media" allowfullscreen></iframe>', 25, N'720p', N'Türkçe Dublaj')
INSERT [dbo].[film_Partlar] ([ID], [PartAdi], [Iframe], [FilmID], [Kalitesi], [Dil]) VALUES (43, N'Rapid', N'<iframe src="https://www.rapidvideo.com/e/FMGRJX3GG0" sandbox="allow-forms allow-pointer-lock allow-same-origin allow-scripts allow-top-navigation" allowfullscreen="" webkitallowfullscreen="" mozallowfullscreen="" scrolling="no" width="100%" height="350" frameborder="0"></iframe>', 25, N'720p', N'Türkçe Dublaj')
INSERT [dbo].[film_Partlar] ([ID], [PartAdi], [Iframe], [FilmID], [Kalitesi], [Dil]) VALUES (44, N'OpenLoad', N'<iframe src="https://oload.tv/embed/1j3sYc3UDVE/" scrolling="no" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen="" width="664" height="386" frameborder="0"></iframe>', 25, N'720p', N'Türkçe Dublaj')
SET IDENTITY_INSERT [dbo].[film_Partlar] OFF
SET IDENTITY_INSERT [dbo].[film_Ulkeler] ON 

INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (1, N'Afganistan', N'afganistan')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (2, N'Arnavutluk', N'arnavutluk')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (3, N'Cezayir', N'cezayir')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (4, N'ABD', N'abd')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (5, N'Andorra', N'andorra')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (6, N'Angora', N'angora')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (7, N'Anguilla', N'anguilla')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (8, N'Antarktika', N'antarktika')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (9, N'Antigua ve Barbuda', N'antigua-ve-barbuda')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (10, N'Arjantin', N'arjantin')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (11, N'Ermenistan', N'ermenistan')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (12, N'Aruba', N'aruba')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (13, N'Avustralya', N'avustralya')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (14, N'Avusturya', N'avusturya')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (15, N'Azerbaycan', N'azerbaycan')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (16, N'Bahamalar', N'bahamalar')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (17, N'Bahreyn', N'bahreyn')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (18, N'Bangladeş', N'banglades')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (19, N'Barbados', N'barbados')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (20, N'Belarus', N'belarus')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (21, N'Belçika', N'belcika')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (22, N'Belize', N'belize')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (23, N'Benin', N'benin')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (24, N'Bermuda', N'bermuda')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (25, N'Bhutan', N'bhutan')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (26, N'Bolivya', N'bolivya')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (27, N'Bosna-Hersek', N'bosna-hersek')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (28, N'Botsvana', N'botsvana')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (29, N'Brezilya', N'brezilya')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (30, N'İngiliz Virgin Adaları', N'ingiliz-virgin-adalari')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (31, N'Brunei', N'brunei')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (32, N'Bulgaristan', N'bulgaristan')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (33, N'Burkina Faso', N'burkina-faso')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (34, N'Burundi', N'burundi')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (35, N'Kamboçya', N'kambocya')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (36, N'Kamerun', N'kamerun')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (37, N'Kanada', N'kanada')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (38, N'Cape Verde', N'cape-verde')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (39, N'Cayman Adaları', N'cayman-adalari')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (40, N'Orta Afrika', N'orta-afrika')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (41, N'Chad', N'chad')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (42, N'Şili', N'sili')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (43, N'Çin', N'cin')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (44, N'Kolombiya', N'kolombiya')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (45, N'Komorlar', N'komorlar')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (46, N'Kongo', N'kongo')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (47, N'Kongo (Dem. Cumhuriyeti)', N'kongo-dem-cumhuriyeti')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (48, N'Cook Adaları', N'cook-adalari')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (49, N'Kostarika', N'kostarika')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (50, N'Hırvatistan', N'hirvatistan')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (51, N'Küba', N'kuba')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (52, N'Kıbrıs', N'kibris')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (53, N'Çek Cumhuriyeti', N'cek-cumhuriyeti')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (54, N'Danimarka', N'danimarka')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (55, N'Cibuti', N'cibuti')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (56, N'Dominika', N'dominika')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (57, N'Dominik Cumhuriyeti', N'dominik-cumhuriyeti')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (58, N'Doğu Timor', N'dogu-timor')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (59, N'Ekvador', N'ekvador')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (60, N'Mısır', N'misir')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (61, N'El Salvador', N'el-salvador')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (62, N'Ekvator Ginesi', N'ekvator-ginesi')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (63, N'Eritre', N'eritre')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (64, N'Estonya', N'estonya')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (65, N'Etiyopya', N'etiyopya')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (66, N'Ext. Territ. Avustralya', N'ext-territ-avustralya')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (67, N'Falkland Adaları', N'falkland-adalari')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (68, N'Faroe Adaları', N'faroe-adalari')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (69, N'Fiji', N'fiji')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (70, N'Finlandiya', N'finlandiya')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (71, N'Fransa', N'fransa')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (72, N'Fransız Guyanası', N'fransiz-guyanasi')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (73, N'Fransız Polinezyası', N'fransiz-polinezyasi')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (74, N'Gabon', N'gabon')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (75, N'Gambiya', N'gambiya')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (76, N'Georgia', N'georgia')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (77, N'Almanya', N'almanya')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (78, N'Gana', N'gana')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (79, N'Cebelitarık', N'cebelitarik')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (80, N'Yunanistan', N'yunanistan')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (81, N'Grönland', N'gronland')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (82, N'Grenada', N'grenada')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (83, N'Guadeloupe', N'guadeloupe')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (84, N'Guam', N'guam')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (85, N'Guatemala', N'guatemala')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (86, N'Guernsey ve Alderney', N'guernsey-ve-alderney')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (87, N'Gine', N'gine')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (88, N'Gine Bissau', N'gine-bissau')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (89, N'Guyana', N'guyana')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (90, N'Haiti', N'haiti')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (91, N'Honduras', N'honduras')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (92, N'Macaristan', N'macaristan')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (93, N'İzlanda', N'izlanda')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (94, N'Hindistan', N'hindistan')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (95, N'Endonezya', N'endonezya')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (96, N'İran', N'iran')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (97, N'Irak', N'irak')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (98, N'İrlanda', N'irlanda')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (99, N'İsrail', N'israil')
GO
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (100, N'İtalya', N'italya')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (101, N'Fildişi Sahili', N'fildisi-sahili')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (102, N'Jamaika', N'jamaika')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (103, N'Japonya', N'japonya')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (104, N'Jarse', N'jarse')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (105, N'Ürdün', N'urdun')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (106, N'Kazakistan', N'kazakistan')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (107, N'Kenya', N'kenya')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (108, N'Kiribati', N'kiribati')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (109, N'Kore (Kuzey)', N'kore-kuzey')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (110, N'Kore (Güney)', N'kore-guney')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (111, N'Kuveyt', N'kuveyt')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (112, N'Kırgızistan', N'kirgizistan')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (113, N'Laos', N'laos')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (114, N'Letonya', N'letonya')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (115, N'Lübnan', N'lubnan')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (116, N'Lesotho', N'lesotho')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (117, N'Liberya', N'liberya')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (118, N'Libya', N'libya')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (119, N'Liechtenstein', N'liechtenstein')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (120, N'Litvanya', N'litvanya')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (121, N'Lüksemburg', N'luksemburg')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (122, N'Makedonya', N'makedonya')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (123, N'Madagaskar', N'madagaskar')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (124, N'Malawi', N'malawi')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (125, N'Malezya', N'malezya')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (126, N'Maldivler', N'maldivler')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (127, N'Mali', N'mali')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (128, N'Malta', N'malta')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (129, N'Man Adası', N'man-adasi')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (130, N'Marshall Adaları', N'marshall-adalari')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (131, N'Martinik', N'martinik')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (132, N'Moritanya', N'moritanya')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (133, N'Mauritius', N'mauritius')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (134, N'Mayotte', N'mayotte')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (135, N'Meksika', N'meksika')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (136, N'Mikronezya', N'mikronezya')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (137, N'Moldova', N'moldova')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (138, N'Monako', N'monako')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (139, N'Moğolistan', N'mogolistan')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (140, N'Fas', N'fas')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (141, N'Mozambik', N'mozambik')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (142, N'Myanmar', N'myanmar')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (143, N'Namibya', N'namibya')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (144, N'Nauru', N'nauru')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (145, N'Nepal', N'nepal')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (146, N'Hollanda', N'hollanda')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (147, N'Hollanda Antilleri', N'hollanda-antilleri')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (148, N'Yeni Kaledonya', N'yeni-kaledonya')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (149, N'Yeni Zelanda', N'yeni-zelanda')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (150, N'Nikaragua', N'nikaragua')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (151, N'Nijer', N'nijer')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (152, N'Nijerya', N'nijerya')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (153, N'Niue', N'niue')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (154, N'Norfolk', N'norfolk')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (155, N'Kuzey Mariana Adaları', N'kuzey-mariana-adalari')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (156, N'Umman', N'umman')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (157, N'Pakistan', N'pakistan')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (158, N'Palau', N'palau')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (159, N'Filistin', N'filistin')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (160, N'Panama', N'panama')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (161, N'Papua Yeni Gine', N'papua-yeni-gine')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (162, N'Paraguay', N'paraguay')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (163, N'Peru', N'peru')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (164, N'Filipinler', N'filipinler')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (165, N'Polonya', N'polonya')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (166, N'Portekiz', N'portekiz')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (167, N'Porto Riko', N'porto-riko')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (168, N'Qatar', N'qatar')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (169, N'Réunion', N'réunion')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (170, N'Romanya', N'romanya')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (171, N'Rusya', N'rusya')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (172, N'Ruanda', N'ruanda')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (173, N'Sahara', N'sahara')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (174, N'Saint Helena', N'saint-helena')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (175, N'Saint Kitts ve Nevis', N'saint-kitts-ve-nevis')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (176, N'Saint Lucia', N'saint-lucia')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (177, N'Saint Pierre ve Miquelon', N'saint-pierre-ve-miquelon')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (178, N'St Vincent ve Grenadinler', N'st-vincent-ve-grenadinler')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (179, N'Samoa', N'samoa')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (180, N'San Marino', N'san-marino')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (181, N'Sao Tome ve Principe', N'sao-tome-ve-principe')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (182, N'Suudi Arabistan', N'suudi-arabistan')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (183, N'Senegal', N'senegal')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (184, N'Sırbistan ve Karadağ', N'sirbistan-ve-karadag')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (185, N'Seyşel Adaları', N'seysel-adalari')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (186, N'Sierra Leone', N'sierra-leone')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (187, N'Singapur', N'singapur')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (188, N'Slovakya', N'slovakya')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (189, N'Slovenya', N'slovenya')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (190, N'Smaller Territories of the UK', N'smaller-territories-of-the-uk')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (191, N'Solomon Adaları', N'solomon-adalari')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (192, N'Somali', N'somali')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (193, N'Güney Afrika', N'guney-afrika')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (194, N'İspanya', N'ispanya')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (195, N'Sri Lanka', N'sri-lanka')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (196, N'Sudan', N'sudan')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (197, N'Surinam', N'surinam')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (198, N'Svalbard ve Jan Mayen', N'svalbard-ve-jan-mayen')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (199, N'Svaziland', N'svaziland')
GO
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (200, N'Isveç', N'isvec')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (201, N'Isviçre', N'isvicre')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (202, N'Suriye', N'suriye')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (203, N'Tayvan', N'tayvan')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (204, N'Tacikistan', N'tacikistan')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (205, N'Tanzanya', N'tanzanya')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (206, N'Terres Australes', N'terres-australes')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (207, N'Tayland', N'tayland')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (208, N'Togo', N'togo')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (209, N'Tokelau', N'tokelau')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (210, N'Tonga', N'tonga')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (211, N'Trinidad ve Tobago', N'trinidad-ve-tobago')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (212, N'Tunus', N'tunus')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (213, N'Türkiye', N'turkiye')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (214, N'Türkmenistan', N'turkmenistan')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (215, N'Turks ve Caicos Adaları', N'turks-ve-caicos-adalari')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (216, N'Tuvalu', N'tuvalu')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (217, N'Uganda', N'uganda')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (218, N'Ukrayna', N'ukrayna')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (219, N'Birleşik Arap Emirlikleri', N'birlesik-arap-emirlikleri')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (220, N'İngiltere', N'ingiltere')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (221, N'Amerika Birleşik Devletleri', N'amerika-birlesik-devletleri')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (222, N'Uruguay', N'uruguay')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (223, N'Özbekistan', N'ozbekistan')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (224, N'Vanuatu', N'vanuatu')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (225, N'Vatikan', N'vatikan')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (226, N'Venezuela', N'venezuela')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (227, N'Vietnam', N'vietnam')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (228, N'Virgin Adaları', N'virgin-adalari')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (229, N'Wallis ve Futuna', N'wallis-ve-futuna')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (230, N'Yemen', N'yemen')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (231, N'Zambiya', N'zambiya')
INSERT [dbo].[film_Ulkeler] ([Id], [UlkeAdi], [UlkeURL]) VALUES (232, N'Zimbabve', N'zimbabve')
SET IDENTITY_INSERT [dbo].[film_Ulkeler] OFF
SET IDENTITY_INSERT [dbo].[film_Yonetmenler] ON 

INSERT [dbo].[film_Yonetmenler] ([ID], [Yonetmen], [YonetmenURL]) VALUES (25, N'Rian Johnson', N'rian-johnson')
INSERT [dbo].[film_Yonetmenler] ([ID], [Yonetmen], [YonetmenURL]) VALUES (26, N'Doug Liman', N'doug-liman')
SET IDENTITY_INSERT [dbo].[film_Yonetmenler] OFF
USE [master]
GO
ALTER DATABASE [filmSitesi] SET  READ_WRITE 
GO
