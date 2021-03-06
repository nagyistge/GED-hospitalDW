BEGIN -- Setting up for new database
	DROP DATABASE HOSPITALDW
	CREATE DATABASE HOSPITALDW
	USE HOSPITALDW
END

BEGIN -- Cleaning up for new tables
	DROP TABLE [dbo].[PKadrowe] 
	DROP TABLE [dbo].[PPlacowe_zasad]
	DROP TABLE [dbo].[PPlacowe_brutto]
	DROP TABLE [dbo].[PPracownicy]
	DROP TABLE [dbo].[POddzial]
	DROP TABLE [dbo].[PPozycja]
	DROP TABLE [dbo].[PCzas]
	
END

BEGIN -- Creating dimension tables
	CREATE TABLE [dbo].[PCzas](
	[Id] [int] NOT NULL,
	[Miesiac] [int] NULL,
	[Kwartal] [int] NULL,
	[Rok] [int] NULL,
 CONSTRAINT [Key10] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
 
	CREATE TABLE [dbo].[PPozycja](
	[Id] [int] NOT NULL,
	[Grupa_zawodowa] [varchar] NULL,
	[Stanowisko] [varchar] NULL,
 CONSTRAINT [Key9] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

	CREATE TABLE [dbo].[POddzial](
	[Id] [int] NOT NULL,
	[Oddzial] [varchar] NOT NULL,
 CONSTRAINT [Key8] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

	CREATE TABLE [dbo].[PPracownicy](
	[Id] [int] NOT NULL,
	[Oddzial] [varchar] NULL,
	[Wyksztalcenie] [varchar] NULL,
	[Przedzial_wiekowy] [char](3) NULL,
	[Plec] [char](1) NOT NULL,
 CONSTRAINT [Key7] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END


BEGIN -- Creating fact tables

	CREATE TABLE [dbo].[PPlacowe_brutto](
	[Placa_avg] [float] NULL,
	[Placa_max] [float] NULL,
	[Placa_min] [float] NULL,
	[Placa_sum] [float] NULL,
	[Chorobowe_szp_sum] [float] NULL,
	[Chorobowe_zus_sum] [float] NULL,
	[Nadgodziny_avg] [float] NULL,
	[Oddzial_Id] [int] NOT NULL,
	[Pozycja_Id] [int] NOT NULL,
	[Czas_Id] [int] NOT NULL,
	[Pracownicy_Id] [int] NOT NULL,
 CONSTRAINT [Key6] PRIMARY KEY CLUSTERED 
(
	[Oddzial_Id] ASC,
	[Pozycja_Id] ASC,
	[Czas_Id] ASC,
	[Pracownicy_Id] ASC
) WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

	CREATE TABLE [dbo].[PPlacowe_zasad](
	[Placa_avg] [float] NULL,
	[Placa_max] [float] NULL,
	[Placa_min] [float] NULL,
	[Placa_sum] [float] NULL,
	[Oddzial_Id] [int] NOT NULL,
	[Pozycja_Id] [int] NOT NULL,
	[Czas_Id] [int] NOT NULL,
 CONSTRAINT [Key5] PRIMARY KEY CLUSTERED 
(
	[Oddzial_Id] ASC,
	[Pozycja_Id] ASC,
	[Czas_Id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

	CREATE TABLE [dbo].[PKadrowe](
	[Ilosc] [int] NULL,
	[Procent] [int] NULL,
	[Pozycja_Id] [int] NOT NULL,
	[Pracownicy_Id] [int] NOT NULL,
 CONSTRAINT [Key4] PRIMARY KEY CLUSTERED 
(
	[Pozycja_Id] ASC,
	[Pracownicy_Id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END


GO

BEGIN -- Adding relations
	ALTER TABLE [dbo].[PPlacowe_brutto]  WITH CHECK ADD  CONSTRAINT [Relationship9] FOREIGN KEY([Oddzial_Id])
REFERENCES [dbo].[POddzial] ([Id])

	ALTER TABLE [dbo].[PPlacowe_brutto]  WITH CHECK ADD  CONSTRAINT [Relationship8] FOREIGN KEY([Pozycja_Id])
REFERENCES [dbo].[PPozycja] ([Id])

	ALTER TABLE [dbo].[PPlacowe_brutto]  WITH CHECK ADD  CONSTRAINT [Relationship7] FOREIGN KEY([Czas_Id])
REFERENCES [dbo].[PCzas] ([Id])

	ALTER TABLE [dbo].[PPlacowe_brutto]  WITH CHECK ADD  CONSTRAINT [Relationship6] FOREIGN KEY([Pracownicy_Id])
REFERENCES [dbo].[PPracownicy] ([Id])

END

GO
ALTER TABLE [dbo].[PPlacowe_zasad]  WITH CHECK ADD  CONSTRAINT [Relationship5] FOREIGN KEY([Oddzial_Id])
REFERENCES [dbo].[POddzial] ([Id])
GO
ALTER TABLE [dbo].[PPlacowe_zasad]  WITH CHECK ADD  CONSTRAINT [Relationship4] FOREIGN KEY([Pozycja_Id])
REFERENCES [dbo].[PPozycja] ([Id])
GO
ALTER TABLE [dbo].[PPlacowe_zasad]  WITH CHECK ADD  CONSTRAINT [Relationship3] FOREIGN KEY([Czas_Id])
REFERENCES [dbo].[PCzas] ([Id])


GO
ALTER TABLE [dbo].[PKadrowe]  WITH CHECK ADD  CONSTRAINT [Relationship2] FOREIGN KEY([Pozycja_Id])
REFERENCES [dbo].[PPozycja] ([Id])
GO
ALTER TABLE [dbo].[PKadrowe]  WITH CHECK ADD  CONSTRAINT [Relationship1] FOREIGN KEY([Pracownicy_Id])
REFERENCES [dbo].[PPracownicy] ([Id])

