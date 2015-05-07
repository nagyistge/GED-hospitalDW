CREATE DATABASE HOSPITALDW
GO

USE HOSPITALDW
GO

--
CREATE TABLE [dbo].[Czas](
	[Id] [int] COLLATE Polish_CI_AS NOT NULL,
	[Miesiac] [int] NULL,
	[Kwartal] [int] NULL,
	[Rok] [int] NULL,
 CONSTRAINT [Key10] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
 
 CREATE TABLE [dbo].[Pozycja](
	[Id] [int] COLLATE Polish_CI_AS NOT NULL,
	[Grupa_zawodowa] [varchar] NULL,
	[Stanowisko] [varchar] NULL,
 CONSTRAINT [Key9] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

CREATE TABLE [dbo].[Oddzial](
	[Id] [int] COLLATE Polish_CI_AS NOT NULL,
	[Oddzial] [varchar] NOT NULL,
 CONSTRAINT [Key8] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

CREATE TABLE [dbo].[Pracownicy](
	[Id] [int] COLLATE Polish_CI_AS NOT NULL,
	[Oddzial] [varchar] NULL,
	[Wyksztalcenie] [varchar] NULL,
	[Przedzial_wiekowy] [char](3) NULL,
	[Plec] [char](1) NOT NULL,
 CONSTRAINT [Key7] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


--Tabele faktów

CREATE TABLE [dbo].[Placowe_brutto](
	[Placa_avg] [float] NULL,
	[Placa_max] [float] NULL,
	[Placa_min] [float] NULL,
	[Placa_sum] [float] NULL,
	[Chorobowe_szp_sum] [float] NULL,
	[Chorobowe_zus_sum] [float] NULL,
	[Nadgodziny_avg] [float] NULL,
	[Oddzial_Id] [int] NULL,
	[Pozaycja_Id] [int] NULL,
	[Czas_Id] [int] NULL,
	[Pracownicy_Id] [int] NULL,
 CONSTRAINT [Key6] PRIMARY KEY CLUSTERED 
(
	[Oddzial_Id] ASC
	[Pozacja_Id] ASC
	[Czas_Id] ASC
	[Pracownicy_Id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

CREATE TABLE [dbo].[Placowe_zasad](
	[Placa_avg] [float] NULL,
	[Placa_max] [float] NULL,
	[Placa_min] [float] NULL,
	[Placa_sum] [float] NULL,
	[Oddzial_Id] [int] NULL,
	[Pozycja_Id] [int] NULL,
	[Czas_Id] [int] NULL,
 CONSTRAINT [Key5] PRIMARY KEY CLUSTERED 
(
	[Oddzial_Id] ASC
	[Pozycja_Id] ASC
	[Czas_Id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

CREATE TABLE [dbo].[Kadrowe](
	[Ilosc] [int] NULL,
	[Procent] [int] NULL,
	[Pozacja_Id] [int] NULL,
	[Pracownicy_Id] [int] NULL,
 CONSTRAINT [Key4] PRIMARY KEY CLUSTERED 
(
	[Pozycja_Id] ASC
	[Pracownicy_Id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


-- relacje
GO
ALTER TABLE [dbo].[Placowe_brutto]  WITH CHECK ADD  CONSTRAINT [Relationship9] FOREIGN KEY([Oddzial_Id])
REFERENCES [dbo].[Oddzial] ([Id])
GO
ALTER TABLE [dbo].[Placowe_brutto]  WITH CHECK ADD  CONSTRAINT [Relationship8] FOREIGN KEY([Pozycja_Id])
REFERENCES [dbo].[Pozacja] ([Id])
GO
ALTER TABLE [dbo].[Placowe_brutto]  WITH CHECK ADD  CONSTRAINT [Relationship7] FOREIGN KEY([Czas_Id])
REFERENCES [dbo].[Czas] ([Id])
GO
ALTER TABLE [dbo].[Placowe_brutto]  WITH CHECK ADD  CONSTRAINT [Relationship6] FOREIGN KEY([Pracownicy_Id])
REFERENCES [dbo].[Pracownicy] ([Id])


GO
ALTER TABLE [dbo].[Placowe_zasad]  WITH CHECK ADD  CONSTRAINT [Relationship5] FOREIGN KEY([Oddzial_Id])
REFERENCES [dbo].[Oddzial] ([Id])
GO
ALTER TABLE [dbo].[Placowe_zasad]  WITH CHECK ADD  CONSTRAINT [Relationship4] FOREIGN KEY([Pozycja_Id])
REFERENCES [dbo].[Pozacja] ([Id])
GO
ALTER TABLE [dbo].[Placowe_zasad]  WITH CHECK ADD  CONSTRAINT [Relationship3] FOREIGN KEY([Czas_Id])
REFERENCES [dbo].[Czas] ([Id])


GO
ALTER TABLE [dbo].[Kadrowe]  WITH CHECK ADD  CONSTRAINT [Relationship2] FOREIGN KEY([Oddzial_Id])
REFERENCES [dbo].[Pozycje] ([Id])
GO
ALTER TABLE [dbo].[Kadrowe]  WITH CHECK ADD  CONSTRAINT [Relationship1] FOREIGN KEY([Pozycja_Id])
REFERENCES [dbo].[Pracownicy] ([Id])
