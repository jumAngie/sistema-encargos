---------------------------------------- FABRICA----------------------------------------------

INSERT INTO tbFabricas	(fab_Descripcion, fab_Telefono, fab_UsuarioCreador, fab_FechaCreacion, fab_UsuarioMod, fab_FechaMod, fab_Estado)
VALUES					('Planta manufacturera',		'80902090', 1, '02-02-2023', NULL, NULL, 1 ),
						('Industria mundial',			'99789045', 1, '02-02-2023', NULL, NULL, 1 ),
						('Industria primordial',		'33490237', 1, '02-02-2023', NULL, NULL, 1 ),
						('International Trek Center',	'88490231', 1, '02-02-2023', NULL, NULL, 1 ),
						('G & K Bicycle Corp.',			'33322222', 1, '02-02-2023', NULL, NULL, 1 ),
						('Australia Bike Retailer',		'99809980', 1, '02-02-2023', NULL, NULL, 1 ),
						('Compete Enterprises, Inc',	'97809980', 1, '02-02-2023', NULL, NULL, 1 ),
						('SUPERSALES INC.',				'92803980', 1, '02-02-2023', NULL, NULL, 1 ),
						('Litware, Inc.',				'93463980', 1, '02-02-2023', NULL, NULL, 1 ),
						('Electronic Bike Co.',			'33433380', 1, '02-02-2023', NULL, NULL, 1 ),
						('Business Equipment Center',	'88488383', 1, '02-02-2023', NULL, NULL, 1 ),
						('Touring Equipment Center',	'33488384', 1, '02-02-2023', NULL, NULL, 1 )
---------------------------------------- UDP_DE FABRICA (INSERT) ----------------------------------------
GO
CREATE OR ALTER PROCEDURE UDP_InsertFabrica
		@fab_Descripcion		NVARCHAR(200), 
		@fab_Telefono			NVARCHAR(250), 
		@fab_UsuarioCreador		INT
AS
BEGIN
		INSERT INTO tbFabricas
								(fab_Descripcion, 
								fab_Telefono, 
								fab_UsuarioCreador, 
								fab_FechaCreacion, 
								fab_UsuarioMod, 
								fab_FechaMod, 
								fab_Estado)
VALUES							(@fab_Descripcion,
								 @fab_Telefono,
								 @fab_UsuarioCreador,
								GETDATE(),
								NULL,
								NULL,
								1)
END

---------------------------------------- ARTICULOS ----------------------------------------------

INSERT INTO tbArticulos (art_Descripcion, fab_ID, art_Stock, art_UsuarioCreador, art_FechaCreacion, art_UsuarioMod, art_FechaMod, art_Estado)
VALUES				('Guantes',						'1',	150, 1, '02-02-20230', NULL, NULL, 1),
					('Lentes',						'1',	150, 1, '02-02-20230', NULL, NULL, 1),
					('Cascos',						'1',	150, 1, '02-02-20230', NULL, NULL, 1),
					('Pantaloncillos',				'1',	150, 1, '02-02-20230', NULL, NULL, 1),
					('Lavaplatos',					'2',	150, 1, '02-02-20230', NULL, NULL, 1),
					('Refrigerador',				'2',	150, 1, '02-02-20230', NULL, NULL, 1),
					('Lavadora',					'2',	150, 1, '02-02-20230', NULL, NULL, 1),
					('Secadora',					'2',	150, 1, '02-02-20230', NULL, NULL, 1),
					('Bicicletas de Monta�a',		'3',	150, 1, '02-02-20230', NULL, NULL, 1),
					('Bicicletas de Carretera',		'3',	150, 1, '02-02-20230', NULL, NULL, 1),
					('Bicicletas de Turismo',		'3',	150, 1, '02-02-20230', NULL, NULL, 1),
					('Chalecos',					'4',	150, 1, '02-02-20230', NULL, NULL, 1),
					('Headsets',					'4',	150, 1, '02-02-20230', NULL, NULL, 1),
					('Cadenas',						'4',	150, 1, '02-02-20230', NULL, NULL, 1),
					('Ruedas',						'4',	150, 1, '02-02-20230', NULL, NULL, 1),
					('Camisetas',					'5',	150, 1, '02-02-20230', NULL, NULL, 1),
					('Shorts',						'5',	150, 1, '02-02-20230', NULL, NULL, 1),
					('Gorras',						'5',	150, 1, '02-02-20230', NULL, NULL, 1),
					('Calcetines',					'5',	150, 1, '02-02-20230', NULL, NULL, 1),
					('Manillas',					'6',	150, 1, '02-02-20230', NULL, NULL, 1),
					('Frenos',						'6',	150, 1, '02-02-20230', NULL, NULL, 1),
					('Sillones',					'6',	150, 1, '02-02-20230', NULL, NULL, 1),
					('Pedales',						'6',	150, 1, '02-02-20230', NULL, NULL, 1),
					('Sillas',						'7',	150, 1, '02-02-20230', NULL, NULL, 1),
					('Escritorios',					'7',	150, 1, '02-02-20230', NULL, NULL, 1),
					('Archiveros',					'7',	150, 1, '02-02-20230', NULL, NULL, 1),
					('Tijeras',						'7',	150, 1, '02-02-20230', NULL, NULL, 1),
					('Estantes',					'7',	150, 1, '02-02-20230', NULL, NULL, 1),
					('Platos',						'8',	150, 1, '02-02-20230', NULL, NULL, 1),
					('Cucharas',					'8',	150, 1, '02-02-20230', NULL, NULL, 1),
					('Tenedores',					'8',	150, 1, '02-02-20230', NULL, NULL, 1),
					('Cuchillos',					'8',	150, 1, '02-02-20230', NULL, NULL, 1),
					('Laptop',						'9',	150, 1, '02-02-20230', NULL, NULL, 1),
					('Computadora Escritorio',		'9',	150, 1, '02-02-20230', NULL, NULL, 1),
					('Computadora Personal',		'9',	150, 1, '02-02-20230', NULL, NULL, 1),
					('Tabletas',					'9',	150, 1, '02-02-20230', NULL, NULL, 1),
					('Jarrones',					'10',	150, 1, '02-02-20230', NULL, NULL, 1),
					('Canastas',					'10',	150, 1, '02-02-20230', NULL, NULL, 1),
					('Botellas',					'11',	150, 1, '02-02-20230', NULL, NULL, 1),
					('Bolsones',					'11',	150, 1, '02-02-20230', NULL, NULL, 1),
					('Sneakers',					'12',	150, 1, '02-02-20230', NULL, NULL, 1),
					('Abrigos',						'12',	150, 1, '02-02-20230', NULL, NULL, 1)

---------------------------------------- UDP_DE ARTICULO (INSERT) ----------------------------------------
GO
CREATE OR ALTER PROCEDURE UDP_InsertArticulos
		@art_Descripcion		NVARCHAR(200), 
		@fab_ID					INT, 
		@art_Stock				INT, 
		@art_UsuarioCreador		INT	
AS	
BEGIN
		INSERT INTO tbArticulos 
		(art_Descripcion, 
		fab_ID, 
		art_Stock, 
		art_UsuarioCreador, 
		art_FechaCreacion, 
		art_UsuarioMod, 
		art_FechaMod, 
		art_Estado)
VALUES	(@art_Descripcion,
		 @fab_ID,
		 @art_Stock,
		 @art_UsuarioCreador,
		 GETDATE(),
		 NULL,
		 NULL,
		 1)
END