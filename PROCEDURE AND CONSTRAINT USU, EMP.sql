USE [DBArticulosEncargos]

GO

CREATE OR ALTER PROCEDURE UDP_ROLES_INSERT
@rol_Descripcion NVARCHAR(100)
AS
BEGIN

INSERT INTO [dbo].[tblRoles]([rol_Descripcion])
VALUES (@rol_Descripcion)

END


EXEC UDP_ROLES_INSERT 'Digitador'
EXEC UDP_ROLES_INSERT 'Visualizador'

GO

--------------PRIMERO SE AGREGAN ESTOS 


-------- LUEGO SE HACE EL UDP DE USUARIOS Y SE INSERTA SOLO UN USUARIO
CREATE PROCEDURE UDP_USUARIOS_INSERT
@usu_Usuario   NVARCHAR(200),
@emp_Id			INT,
@rol_ID			INT,
@usu_Clave		NVARCHAR(MAX), 
@usu_EsAdmin       BIT,
@usu_UsuarioCreador INT


 AS 
 BEGIN

 DECLARE  @usu_FechaCreacion  DATETIME = GETDATE(); 
 DECLARE  @usu_UsuarioMod     INT = NULL; 
 DECLARE  @usu_FechaMod      DATETIME = NULL; 
 DECLARE  @usu_Estado        BIT = 1;

DECLARE @Pass NVARCHAR(MAX) = CONVERT(NVARCHAR(MAX), HASHBYTES('SHA2_512', @usu_Clave),2);

INSERT INTO tbUsuarios([usu_Usuario], [emp_Id], [rol_ID], [usu_Clave], [usu_UsuarioCreador], [usu_FechaCreacion], [usu_UsuarioMod], [usu_FechaMod], [usu_Estado], [usu_EsAdmin])
VALUES (@usu_Usuario,@emp_Id,@rol_ID,@Pass,@usu_UsuarioCreador,@usu_FechaCreacion, @usu_UsuarioMod, @usu_FechaMod, @usu_Estado, @usu_EsAdmin)

END



--ALTER TABLE [dbo].[tbUsuarios]
--ALTER COLUMN [rol_ID] INT NULL;

--TRUNCATE TABLE [dbo].[tbUsuarios];

EXEC UDP_USUARIOS_INSERT 'Admin', 1,null,'123',1,1

SELECT*FROM tbUsuarios
------ LUEGO SE HACE EL UDP PARA EMPLEADOS Y SE INSERTAN EMPELADOS

------CUANDO YA SE HAN INSERTADO EMPELADOS, HACER ESTOS CONSTRAINT

ALTER TABLE [dbo].[tbUsuarios]
ADD CONSTRAINT FK_tbUsuarios_tbEmpleados FOREIGN KEY(emp_Id) REFERENCES [dbo].[tbEmpleados] (emp_Id)

---- LUEGO DE A;ADIR EL CONSTRAINT, IR A EMPLEADOS Y A;ADIR LOS CONSTRAINT DE ALL[A


----------------- CUANDO YA SE A;ADIERON LOS CONSTRAINT, HACER MAS INSERTS

EXEC UDP_USUARIOS_INSERT 'Meow', 2,null,'123',1,1
EXEC UDP_USUARIOS_INSERT 'Gatita Mala', 3,null,'1106',1,1
EXEC UDP_USUARIOS_INSERT 'Run', 4,null,'1401',1,1
EXEC UDP_USUARIOS_INSERT 'mcqueen', 5,null,'Qkjn',1,1
EXEC UDP_USUARIOS_INSERT 'Ovner', 6,null,'Qwe14',1,1
EXEC UDP_USUARIOS_INSERT 'Emil', 7,null,'JsJs',1,1
EXEC UDP_USUARIOS_INSERT 'XXX', 8,null,'XxXxX',1,1


UPDATE [dbo].[tbUsuarios] SET [usu_EsAdmin] = 0,[rol_ID] = 2 WHERE [usu_ID] = 4
UPDATE [dbo].[tbUsuarios] SET [usu_EsAdmin] = 0,[rol_ID] = 2 WHERE [usu_ID] = 5
UPDATE [dbo].[tbUsuarios] SET [usu_EsAdmin] = 0,[rol_ID] = 2 WHERE [usu_ID] = 6
UPDATE [dbo].[tbUsuarios] SET [usu_EsAdmin] = 0,[rol_ID] = 2 WHERE [usu_ID] = 7

UPDATE [dbo].[tbUsuarios] SET [rol_ID] = 1 WHERE [usu_ID] = 1
UPDATE [dbo].[tbUsuarios] SET [rol_ID] = 1 WHERE [usu_ID] = 2
UPDATE [dbo].[tbUsuarios] SET [rol_ID] = 1 WHERE [usu_ID] = 3
UPDATE [dbo].[tbUsuarios] SET [rol_ID] = 1 WHERE [usu_ID] = 8



GO




-------------------ESTADOS CIVILES----------------------------------------


ALTER TABLE [dbo].[tbEstadosCiviles]
ADD est_Estado		BIT NOT NULL;

GO

CREATE OR ALTER PROCEDURE UDP_EstadosCiviles_INSERT 
(@est_ID					CHAR(1),
@est_Description		NVARCHAR(100),
@est_UsuCrea			INT)
AS BEGIN

DECLARE @Estado			BIT = 1;
DECLARE @FechaCrea		DATETIME = GETDATE();
DECLARE @UsuModif		INT = NULL;
DECLARE @FechaModi		DATETIME = NULL;

INSERT INTO[dbo].[tbEstadosCiviles] ([est_ID], [est_Descripcion], [est_UsuCrea], [est_FechaCrea], [est_UsuMod], [est_FechaMod],est_Estado)
VALUES (@est_ID,
		@est_Description,
		@est_UsuCrea,
		@FechaCrea,
		@UsuModif,
		@FechaModi,
		@Estado);
END 
GO



/*Datos de los estados civiles ejecutados desde el prco insertar*/
EXEC UDP_EstadosCiviles_INSERT 'S','Soltero',1
EXEC UDP_EstadosCiviles_INSERT 'C','Casado',1
EXEC UDP_EstadosCiviles_INSERT 'D','Divorciado',1
EXEC UDP_EstadosCiviles_INSERT 'U','Union Libre',1
EXEC UDP_EstadosCiviles_INSERT 'V','Viudo',1
GO

-------------------------------------------------------------------------







------------------------------------- EMPLEADOS--------------------------


CREATE OR ALTER PROCEDURE UDP_DEPARTAMENTOS_INSERT
@depto_Description NVARCHAR(100),
@depto_Usucrea	INT
AS BEGIN

DECLARE @FechaCrea  DATETIME = GETDATE();
DECLARE @UsuModif   INT = NULL;
DECLARE @FechaModif	DATETIME = NULL;

INSERT INTO[dbo].[tbDepartamentos] ( [depto_Descripcion], [usu_UsuarioCreador], [usu_FechaCreacion], [usu_UsuarioMod], [depto_FechaMod])
VALUES (@depto_Description, 
		@depto_Usucrea, 
		@FechaCrea, 
		@UsuModif, 
		@FechaModif)
END 




/*Datos de los 18 departamentos ejecutados desde el proc de insertar*/
EXEC UDP_DEPARTAMENTOS_INSERT 'Atl�ntida', 1
EXEC UDP_DEPARTAMENTOS_INSERT 'Choluteca', 1
EXEC UDP_DEPARTAMENTOS_INSERT 'Col�n', 1
EXEC UDP_DEPARTAMENTOS_INSERT 'Comayagua', 1
EXEC UDP_DEPARTAMENTOS_INSERT 'Cop�n', 1
EXEC UDP_DEPARTAMENTOS_INSERT 'Cort�s', 1
EXEC UDP_DEPARTAMENTOS_INSERT 'El Para�so', 1
EXEC UDP_DEPARTAMENTOS_INSERT 'Francisco Moraz�n', 1
EXEC UDP_DEPARTAMENTOS_INSERT 'Gracias a Dios', 1
EXEC UDP_DEPARTAMENTOS_INSERT 'Intibuc�', 1
EXEC UDP_DEPARTAMENTOS_INSERT 'Islas de la Bah�a', 1
EXEC UDP_DEPARTAMENTOS_INSERT 'La Paz', 1
EXEC UDP_DEPARTAMENTOS_INSERT 'Lempira', 1
EXEC UDP_DEPARTAMENTOS_INSERT 'Ocotepeque', 1
EXEC UDP_DEPARTAMENTOS_INSERT 'Olancho', 1
EXEC UDP_DEPARTAMENTOS_INSERT 'Santa B�rbara', 1
EXEC UDP_DEPARTAMENTOS_INSERT 'Valle', 1
EXEC UDP_DEPARTAMENTOS_INSERT 'Yoro', 1


GO

-------------------------------------------------------------------------



------------------------------------- CIUDADES--------------------------



CREATE OR ALTER PROCEDURE UDP_CIUDADES_INSERT
(
@ciu_ID				INT,
@ciu_Decription		NVARCHAR(100),
@ciu_IdDepto        INT,
@UsuCrea			INT)

AS BEGIN

DECLARE		@FechaCrea  DATETIME = GETDATE();
DECLARE		@UsuModi    INT = NULL;
DECLARE		@FechaModi	DATETIME = NULL;

INSERT INTO [dbo].[tbCiudades] ([ciu_ID],[ciu_Descripcion], [ciu_DeptoID], [ciu_UsuarioCreador], [ciu_FechaCreacion], [ciu_UsuarioMod], [ciu_FechaMod])
VALUES (@ciu_ID,
		@ciu_Decription, 
		@ciu_IdDepto, 
		@UsuCrea, 
		@FechaCrea, 
		@UsuModi,
		@FechaModi)
END 





	   EXEC UDP_CIUDADES_INSERT 1,'LA CEIBA', 1,1
	   EXEC UDP_CIUDADES_INSERT 2,'EL PORVENIR', 1,1
	   EXEC UDP_CIUDADES_INSERT 3,'ESPARTA', 1,1
	   EXEC UDP_CIUDADES_INSERT 4,'JUTIAPA', 1,1
	   EXEC UDP_CIUDADES_INSERT 5,'LA MASICA', 1,1
	   EXEC UDP_CIUDADES_INSERT 6,'SAN FRANCISCO', 1,1
	   EXEC UDP_CIUDADES_INSERT 7,'TELA', 1,1
	   EXEC UDP_CIUDADES_INSERT 8,'ARIZONA', 1,1



	   --(0101,'LA CEIBA', 1,1,GETDATE(),NULL,NULL),
	   --(0102,'EL PORVENIR', 1,1,GETDATE(),NULL,NULL),
	   --(0103,'ESPARTA', 1,1,GETDATE(),NULL,NULL),
	   --(0104,'JUTIAPA', 1,1,GETDATE(),NULL,NULL),
	   --(0105,'LA MASICA', 1,1,GETDATE(),NULL,NULL),
	   --(0106,'SAN FRANCISCO', 1,1,GETDATE(),NULL,NULL),
	   --(0107,'TELA', 1,1,GETDATE(),NULL,NULL),
	   --(0108,'ARIZONA', 1,1,GETDATE(),NULL,NULL),

INSERT INTO [dbo].[tbCiudades]
VALUES 
	   (0201,'TRUJILLO', 2,1,GETDATE(),NULL,NULL),
	   (0202,'BALFATE', 2,1,GETDATE(),NULL,NULL),
	   (0203,'IRIONA', 2,1,GETDATE(),NULL,NULL),
	   (0204,'LIM�N', 2,1,GETDATE(),NULL,NULL),
	   (0205,'SAB�', 2,1,GETDATE(),NULL,NULL),
	   (0206,'SANTA FE', 2,1,GETDATE(),NULL,NULL),
	   (0207,'STA. ROSA DE AGU�N', 2,1,GETDATE(),NULL,NULL),
	   (0208,'SONAGUERA', 2,1,GETDATE(),NULL,NULL),
	   (0209,'TOCOA', 2,1,GETDATE(),NULL,NULL),
	   (0210,'BONITO ORIENTAL', 2,1,GETDATE(),NULL,NULL),
	   (0301,'COMAYAGUA', 3,1,GETDATE(),NULL,NULL),
	   (0302,'AJUTERIQUE', 3,1,GETDATE(),NULL,NULL),
	   (0303,'EL ROSARIO', 3,1,GETDATE(),NULL,NULL),
	   (0304,'ESQU�AS', 3,1,GETDATE(),NULL,NULL),
	   (0305,'SAB�', 3,1,GETDATE(),NULL,NULL),
	   (0306,'SANTA FE', 3,1,GETDATE(),NULL,NULL),
	   (0307,'STA. ROSA DE AGU�N', 3,1,GETDATE(),NULL,NULL),
	   (0308,'SONAGUERA', 3,1,GETDATE(),NULL,NULL),
	   (0309,'TOCOA', 3,1,GETDATE(),NULL,NULL),
	   (0310,'BONITO ORIENTAL', 3,1,GETDATE(),NULL,NULL),
	   (0311,'MINAS DE ORO', 3,1,GETDATE(),NULL,NULL),
	   (0312,'OJOS DE AGUA', 3,1,GETDATE(),NULL,NULL),
	   (0313,'SAN JER�NIMO', 3,1,GETDATE(),NULL,NULL),
	   (0314,'S. JOSE DE COMAYAGUA', 3,1,GETDATE(),NULL,NULL),
	   (0315,'S. JOSE DEL POTRERO', 3,1,GETDATE(),NULL,NULL),
	   (0316,'SAN LUIS', 3,1,GETDATE(),NULL,NULL),
	   (0317,'SAN SEBASTI�N', 3,1,GETDATE(),NULL,NULL),
	   (0318,'SIGUATEPEQUE', 3,1,GETDATE(),NULL,NULL),
	   (0319,'VILLA DE S. ANTONIO', 3,1,GETDATE(),NULL,NULL),
	   (0320,'LAJAS', 3,1,GETDATE(),NULL,NULL),
	   (0321,'TAULAB�', 3,1,GETDATE(),NULL,NULL),
	   (0401,'STA. ROSA DE COP�N', 4,1,GETDATE(),NULL,NULL),
	   (0402,'CABA�AS', 4,1,GETDATE(),NULL,NULL),
	   (0403,'CONCEPCI�N', 4,1,GETDATE(),NULL,NULL),
	   (0404,'COP�N RUINAS', 4,1,GETDATE(),NULL,NULL),
	   (0405,'CORQU�N', 4,1,GETDATE(),NULL,NULL),
	   (0406,'CUCUYAGUA', 4,1,GETDATE(),NULL,NULL),
	   (0407,'DOLORES', 4,1,GETDATE(),NULL,NULL),
	   (0408,'DULCE NOMBRE', 4,1,GETDATE(),NULL,NULL),
	   (0409,'EL PARA�SO', 4,1,GETDATE(),NULL,NULL),
	   (0410,'FLORIDA', 4,1,GETDATE(),NULL,NULL),
	   (0411,'LA JIGUA', 4,1,GETDATE(),NULL,NULL),
	   (0412,'LA UNI�N', 4,1,GETDATE(),NULL,NULL),
	   (0413,'NUEVA ARCADIA', 4,1,GETDATE(),NULL,NULL),
	   (0414,'SAN AGUST�N', 4,1,GETDATE(),NULL,NULL),
	   (0415,'SAN ANTONIO', 4,1,GETDATE(),NULL,NULL),
	   (0416,'SAN JER�NIMO', 4,1,GETDATE(),NULL,NULL),
	   (0417,'SAN JOS�', 4,1,GETDATE(),NULL,NULL),
	   (0418,'SAN JUAN DE OPOA', 4,1,GETDATE(),NULL,NULL),
	   (0419,'SAN NICOL�S', 4,1,GETDATE(),NULL,NULL),
	   (0420,'SAN PEDRO', 4,1,GETDATE(),NULL,NULL),
	   (0421,'SANTA RITA', 4,1,GETDATE(),NULL,NULL),
	   (0422,'TRINIDAD', 4,1,GETDATE(),NULL,NULL),
	   (0423,'VERACRUZ', 4,1,GETDATE(),NULL,NULL),
	   (0501,'SAN PEDRO SULA', 5,1,GETDATE(),NULL,NULL),
	   (0502,'CHOLOMA', 5,1,GETDATE(),NULL,NULL),
	   (0503,'OMOA', 5,1,GETDATE(),NULL,NULL),
	   (0504,'PIMIENTA', 5,1,GETDATE(),NULL,NULL),
	   (0505,'POTRERILLOS', 5,1,GETDATE(),NULL,NULL),
	   (0506,'PUERTO CORT�S', 5,1,GETDATE(),NULL,NULL),
	   (0507,'S. ANTONIO DE CORT�S', 5,1,GETDATE(),NULL,NULL),
	   (0508,'SAN FCO. DE YOJOA', 5,1,GETDATE(),NULL,NULL),
	   (0509,'SAN MANUEL', 5,1,GETDATE(),NULL,NULL),
	   (0510,'STA. CRUZ DE YOJOA', 5,1,GETDATE(),NULL,NULL),
	   (0511,'VILLANUEVA', 5,1,GETDATE(),NULL,NULL),
	   (0512,'LA LIMA', 5,1,GETDATE(),NULL,NULL),
	   (0601,'CHOLUTECA', 6,1,GETDATE(),NULL,NULL),
	   (0602,'APACILAGUA', 6,1,GETDATE(),NULL,NULL),
	   (0603,'CONCEPCI�N DE MAR�A', 6,1,GETDATE(),NULL,NULL),
	   (0604,'DUYURE', 6,1,GETDATE(),NULL,NULL),
	   (0605,'EL CORPUS', 6,1,GETDATE(),NULL,NULL),
	   (0606,'EL TRIUNFO', 6,1,GETDATE(),NULL,NULL),
	   (0607,'MARCOVIA', 6,1,GETDATE(),NULL,NULL),
	   (0608,'MOROLICA', 6,1,GETDATE(),NULL,NULL),
	   (0609,'NAMASIGUE', 6,1,GETDATE(),NULL,NULL),
	   (0610,'OROCUINA', 6,1,GETDATE(),NULL,NULL),
	   (0611,'PESPIRE', 6,1,GETDATE(),NULL,NULL),
	   (0612,'SAN ANTONIO DE FLORES', 6,1,GETDATE(),NULL,NULL),
	   (0613,'SAN ISIDRO', 6,1,GETDATE(),NULL,NULL),
	   (0614,'SAN JOSE', 6,1,GETDATE(),NULL,NULL),
	   (0615,'SAN MARCOS DE COL�N', 6,1,GETDATE(),NULL,NULL),
	   (0616,'SANTA ANA DE YUSGUARE,', 6,1,GETDATE(),NULL,NULL),
	   (0701,'YUSCAR�N', 7,1,GETDATE(),NULL,NULL),
	   (0702,'ALAUCA', 7,1,GETDATE(),NULL,NULL),
	   (0703,'DANL�', 7,1,GETDATE(),NULL,NULL),
	   (0704,'EL PARA�SO', 7,1,GETDATE(),NULL,NULL),
	   (0705,'"GUINOPE', 7,1,GETDATE(),NULL,NULL),
	   (0706,'JACALEAPA', 7,1,GETDATE(),NULL,NULL),
	   (0707,'LIURE', 7,1,GETDATE(),NULL,NULL),
	   (0708,'MOROCEL�', 7,1,GETDATE(),NULL,NULL),
	   (0709,'OROPOL�', 7,1,GETDATE(),NULL,NULL),
	   (0710,'POTRERILLOS', 7,1,GETDATE(),NULL,NULL),
	   (0711,'S. ANTONIO DE FLORES', 7,1,GETDATE(),NULL,NULL),
	   (0712,'SAN LUCAS', 7,1,GETDATE(),NULL,NULL),
	   (0713,'SAN MAT�AS', 7,1,GETDATE(),NULL,NULL),
	   (0714,'SOLEDAD', 7,1,GETDATE(),NULL,NULL),
	   (0715,'TEUPASENTI', 7,1,GETDATE(),NULL,NULL),
	   (0716,'TEXIGUAT', 7,1,GETDATE(),NULL,NULL),
	   (0717,'VADO ANCHO', 7,1,GETDATE(),NULL,NULL),
	   (0718,'YAUYUPE', 7,1,GETDATE(),NULL,NULL),
	   (0719,'TROJES', 7,1,GETDATE(),NULL,NULL),
	   (0801,'DISTRITO CENTRAL', 8,1,GETDATE(),NULL,NULL),
	   (0802,'ALUBAR?N', 8,1,GETDATE(),NULL,NULL),
	   (0803,'CEDROS', 8,1,GETDATE(),NULL,NULL),
	   (0804,'CURAR�N', 8,1,GETDATE(),NULL,NULL),
	   (0805,'EL PROVENIR', 8,1,GETDATE(),NULL,NULL),
	   (0806,'GUAIMACA', 8,1,GETDATE(),NULL,NULL),
	   (0807,'LA LIBERTAD', 8,1,GETDATE(),NULL,NULL),
	   (0808,'LA VENTA', 8,1,GETDATE(),NULL,NULL),
	   (0809,'LEPATERIQUE', 8,1,GETDATE(),NULL,NULL),
	   (0810,'MARAITA', 8,1,GETDATE(),NULL,NULL),
	   (0811,'MARALE', 8,1,GETDATE(),NULL,NULL),
	   (0812,'NUEVA AREMNIA', 8,1,GETDATE(),NULL,NULL),
	   (0813,'OJOJONA', 8,1,GETDATE(),NULL,NULL),
	   (0814,'ORICA', 8,1,GETDATE(),NULL,NULL),
	   (0815,'REITOCA', 8,1,GETDATE(),NULL,NULL),
	   (0816,'SABANA GRANDE', 8,1,GETDATE(),NULL,NULL),
	   (0817,'S. ANTONIO DE ORIENTE', 8,1,GETDATE(),NULL,NULL),
	   (0818,'SAN BUENAVENTURA', 8,1,GETDATE(),NULL,NULL),
	   (0819,'SAN IGNACIO', 8,1,GETDATE(),NULL,NULL),
	   (0820,'SAN JUAN DE FLORES', 8,1,GETDATE(),NULL,NULL),
	   (0821,'SAN MIGUELITO', 8,1,GETDATE(),NULL,NULL),
	   (0822,'SANTA ANA', 8,1,GETDATE(),NULL,NULL),
	   (0823,'SANTA LUC�A', 8,1,GETDATE(),NULL,NULL),
	   (0824,'TALANGA', 8,1,GETDATE(),NULL,NULL),
	   (0825,'TATUMBLA', 8,1,GETDATE(),NULL,NULL),
	   (0826,'VALLE DE �NGELES', 8,1,GETDATE(),NULL,NULL),
	   (0827,'VILLA DE SAN FRANCISCO', 8,1,GETDATE(),NULL,NULL),
	   (0828,'VALLECILLO', 8,1,GETDATE(),NULL,NULL),
	   (0901,'PUERTO LEMPIRA', 9,1,GETDATE(),NULL,NULL),
	   (0902,'BRUS LAGUNA', 9,1,GETDATE(),NULL,NULL),
	   (0903,'AHUAS', 9,1,GETDATE(),NULL,NULL),
	   (0904,'JUAN FRANCISCO BULNES', 9,1,GETDATE(),NULL,NULL),
	   (0905,'VILLEDA MORALES', 9,1,GETDATE(),NULL,NULL),
	   (0906,'WAMPUSIRPE', 9,1,GETDATE(),NULL,NULL),
	   (1001,'LA ESPERANZA', 10,1,GETDATE(),NULL,NULL),
	   (1002,'CAMASCA', 10,1,GETDATE(),NULL,NULL),
	   (1003,'COLOMONCAGUA', 10,1,GETDATE(),NULL,NULL),
	   (1004,'CONCEPCI�N', 10,1,GETDATE(),NULL,NULL),
	   (1005,'DOLORES', 10,1,GETDATE(),NULL,NULL),
	   (1006,'INTIBUC�', 10,1,GETDATE(),NULL,NULL),
	   (1007,'JES�S DE OTORO', 10,1,GETDATE(),NULL,NULL),
	   (1008,'MAGDALENA', 10,1,GETDATE(),NULL,NULL),
	   (1009,'MASAGUARA', 10,1,GETDATE(),NULL,NULL),
	   (1010,'SAN ANTONIO', 10,1,GETDATE(),NULL,NULL),
	   (1011,'SAN ISIDRO', 10,1,GETDATE(),NULL,NULL),
	   (1012,'SAN JUAN DE FLORES', 10,1,GETDATE(),NULL,NULL),
	   (1013,'SAN MARCOS DE LA SIERRA', 10,1,GETDATE(),NULL,NULL),
	   (1014,'SAN MIGUEL GUANCAPLA', 10,1,GETDATE(),NULL,NULL),
	   (1015,'SANTA LUC�A', 10,1,GETDATE(),NULL,NULL),
	   (1016,'YAMARANGUILA', 10,1,GETDATE(),NULL,NULL),
	   (1017,'S. FRANCISCO OPALACA', 10,1,GETDATE(),NULL,NULL),
	   (1101,'ROAT�N', 11,1,GETDATE(),NULL,NULL),
	   (1102,'GUANAJA', 11,1,GETDATE(),NULL,NULL),
	   (1103,'JOS� SANTO GUARDIOLA', 11,1,GETDATE(),NULL,NULL),
	   (1104,'UTILA', 11,1,GETDATE(),NULL,NULL),
	   (1201,'LA PAZ', 12,1,GETDATE(),NULL,NULL),
	   (1202,'AGUANQUETERIQUE', 12,1,GETDATE(),NULL,NULL),
	   (1203,'CABA�AS', 12,1,GETDATE(),NULL,NULL),
	   (1204,'CANE', 12,1,GETDATE(),NULL,NULL),
	   (1205,'CHINACLA', 12,1,GETDATE(),NULL,NULL),
	   (1206,'GUAJIQUIRO', 12,1,GETDATE(),NULL,NULL),
	   (1207,'LAUTERIQUE', 12,1,GETDATE(),NULL,NULL),
	   (1208,'MARCALA', 12,1,GETDATE(),NULL,NULL),
	   (1209,'MERCEDES DE ORIENTE', 12,1,GETDATE(),NULL,NULL),
	   (1210,'OPATORO', 12,1,GETDATE(),NULL,NULL),
	   (1211,'S. ANTONIO DEL NORTE', 12,1,GETDATE(),NULL,NULL),
	   (1212,'SAN JOS�', 12,1,GETDATE(),NULL,NULL),
	   (1213,'SAN JUAN', 12,1,GETDATE(),NULL,NULL),
	   (1214,'SAN PEDRO DE TUTULE', 12,1,GETDATE(),NULL,NULL),
	   (1215,'SANTA ANA', 12,1,GETDATE(),NULL,NULL),
	   (1216,'SANTA ELENA', 12,1,GETDATE(),NULL,NULL),
	   (1217,'SANTA MAR�A', 12,1,GETDATE(),NULL,NULL),
	   (1218,'SANTIA PURINGLA', 12,1,GETDATE(),NULL,NULL),
	   (1219,'YARULA', 12,1,GETDATE(),NULL,NULL),
	   (1301,'GRACIAS', 13,1,GETDATE(),NULL,NULL),
	   (1302,'BEL�N', 13,1,GETDATE(),NULL,NULL),
	   (1303,'CANDELARIA', 13,1,GETDATE(),NULL,NULL),
	   (1304,'COLOLACA', 13,1,GETDATE(),NULL,NULL),
	   (1305,'ERANDIQUE', 13,1,GETDATE(),NULL,NULL),
	   (1306,'GUALCINSE', 13,1,GETDATE(),NULL,NULL),
	   (1307,'GUARITA', 13,1,GETDATE(),NULL,NULL),
	   (1308,'LA CAMPA', 13,1,GETDATE(),NULL,NULL),
	   (1309,'LA IGUALA', 13,1,GETDATE(),NULL,NULL),
	   (1310,'LAS FLORES', 13,1,GETDATE(),NULL,NULL),
	   (1311,'LA UNI�N', 13,1,GETDATE(),NULL,NULL),
	   (1312,'LA VIRTUD', 13,1,GETDATE(),NULL,NULL),
	   (1313,'LEPAERA', 13,1,GETDATE(),NULL,NULL),
	   (1314,'MAPULACA', 13,1,GETDATE(),NULL,NULL),
	   (1315,'PIRAERA', 13,1,GETDATE(),NULL,NULL),
	   (1316,'SAN ANDR�S', 13,1,GETDATE(),NULL,NULL),
	   (1317,'SAN FRANCISCO', 13,1,GETDATE(),NULL,NULL),
	   (1318,'SAN JUAN GUARITA', 13,1,GETDATE(),NULL,NULL),
	   (1319,'SAN MANUEL COLOHETE', 13,1,GETDATE(),NULL,NULL),
	   (1320,'SAN RAFAEL', 13,1,GETDATE(),NULL,NULL),
	   (1321,'SAN SEBASTI�N', 13,1,GETDATE(),NULL,NULL),
	   (1322,'SANTA CRUZ', 13,1,GETDATE(),NULL,NULL),
	   (1323,'TALGUA', 13,1,GETDATE(),NULL,NULL),
	   (1324,'TAMBLA', 13,1,GETDATE(),NULL,NULL),
	   (1325,'TOMALA', 13,1,GETDATE(),NULL,NULL),
	   (1326,'VALLADOLID', 13,1,GETDATE(),NULL,NULL),
	   (1327,'VIRGINIA', 13,1,GETDATE(),NULL,NULL),
	   (1328,'S. MARCOS DE CAIQU�N', 13,1,GETDATE(),NULL,NULL),
	   (1401,'NUEVA OCOTEPEQUE', 14,1,GETDATE(),NULL,NULL),
	   (1402,'BEL�N GUALCHO', 14,1,GETDATE(),NULL,NULL),
	   (1403,'CONCEPCI�N', 14,1,GETDATE(),NULL,NULL),
	   (1404,'DOLORES MEREND�N', 14,1,GETDATE(),NULL,NULL),
	   (1405,'FRATERNIDAD', 14,1,GETDATE(),NULL,NULL),
	   (1406,'LA ENCARNACI�N', 14,1,GETDATE(),NULL,NULL),
	   (1407,'LA LABOR', 14,1,GETDATE(),NULL,NULL),
	   (1408,'LUCERNA', 14,1,GETDATE(),NULL,NULL),
	   (1409,'MERCEDES', 14,1,GETDATE(),NULL,NULL),
	   (1410,'MERCEDES', 14,1,GETDATE(),NULL,NULL),
	   (1411,'S. FRANCISCO DEL VALLE', 14,1,GETDATE(),NULL,NULL),
	   (1412,'SAN JORGE', 14,1,GETDATE(),NULL,NULL),
	   (1413,'SAN MARCOS', 14,1,GETDATE(),NULL,NULL),
	   (1414,'SANTA FE', 14,1,GETDATE(),NULL,NULL),
	   (1415,'SENSENTI', 14,1,GETDATE(),NULL,NULL),
	   (1416,'SINUAPA', 14,1,GETDATE(),NULL,NULL),
	   (1501,'JUTICALPA', 15,1,GETDATE(),NULL,NULL),
	   (1502,'CAMPAMENTO', 15,1,GETDATE(),NULL,NULL),
	   (1503,'CATACAMAS', 15,1,GETDATE(),NULL,NULL),
	   (1504,'CONCORDIA', 15,1,GETDATE(),NULL,NULL),
	   (1505,'DULCE NOMBRE DE CULM�', 15,1,GETDATE(),NULL,NULL),
	   (1506,'EL ROSARIO', 15,1,GETDATE(),NULL,NULL),
	   (1507,'ESQUIPULAS DEL NORTE', 15,1,GETDATE(),NULL,NULL),
	   (1508,'GUALACO', 15,1,GETDATE(),NULL,NULL),
	   (1509,'GUARIZAMA', 15,1,GETDATE(),NULL,NULL),
	   (1510,'GUATA', 15,1,GETDATE(),NULL,NULL),
	   (1511,'GUAYAPE', 15,1,GETDATE(),NULL,NULL),
	   (1512,'JANO', 15,1,GETDATE(),NULL,NULL),
	   (1513,'LA UNI�N', 15,1,GETDATE(),NULL,NULL),
	   (1514,'MANGULILE', 15,1,GETDATE(),NULL,NULL),
	   (1515,'MANTO', 15,1,GETDATE(),NULL,NULL),
	   (1516,'SALAM�', 15,1,GETDATE(),NULL,NULL),
	   (1517,'SAN ESTEBAN', 15,1,GETDATE(),NULL,NULL),
	   (1518,'S. FRANCISCO DE BECERRA', 15,1,GETDATE(),NULL,NULL),
	   (1519,'S. FRANCISCO DE LA PAZ', 15,1,GETDATE(),NULL,NULL),
	   (1520,'SANTA MAR�A DEL REAL', 15,1,GETDATE(),NULL,NULL),
	   (1521,'SILCA', 15,1,GETDATE(),NULL,NULL),
	   (1522,'YOC�N', 15,1,GETDATE(),NULL,NULL),
	   (1523,'FROYLAN TURCIOS', 15,1,GETDATE(),NULL,NULL),
	   (1601,'SANTA B�RBARA', 16,1,GETDATE(),NULL,NULL),
	   (1602,'ARADA', 16,1,GETDATE(),NULL,NULL),
	   (1603,'ATIMA', 16,1,GETDATE(),NULL,NULL),
	   (1604,'AZACUALPA', 16,1,GETDATE(),NULL,NULL),
	   (1605,'CEGUACA', 16,1,GETDATE(),NULL,NULL),
	   (1606,'COLINAS', 16,1,GETDATE(),NULL,NULL),
	   (1607,'CONCEPCI�N DEL NORTE', 16,1,GETDATE(),NULL,NULL),
	   (1608,'CONCEPCI�N DEL SUR', 16,1,GETDATE(),NULL,NULL),
	   (1609,'CHINDA', 16,1,GETDATE(),NULL,NULL),
	   (1610,'EL N�SPERO', 16,1,GETDATE(),NULL,NULL),
	   (1611,'GUALALA', 16,1,GETDATE(),NULL,NULL),
	   (1612,'ILAMA', 16,1,GETDATE(),NULL,NULL),
	   (1613,'MACUELIZO', 16,1,GETDATE(),NULL,NULL),
	   (1614,'NARANJITO', 16,1,GETDATE(),NULL,NULL),
	   (1615,'NUEVA CELILAC', 16,1,GETDATE(),NULL,NULL),
	   (1616,'PETOA', 16,1,GETDATE(),NULL,NULL),
	   (1617,'PROTECCI�N', 16,1,GETDATE(),NULL,NULL),
	   (1618,'QUIMIST�N', 16,1,GETDATE(),NULL,NULL),
	   (1619,'S. FRANCISCO DE OJUERA', 16,1,GETDATE(),NULL,NULL),
	   (1620,'SAN LUIS', 16,1,GETDATE(),NULL,NULL),
	   (1621,'SAN MARCOS', 16,1,GETDATE(),NULL,NULL),
	   (1622,'SAN NICOL�S', 16,1,GETDATE(),NULL,NULL),
	   (1623,'SAN PEDRO ZACAPA', 16,1,GETDATE(),NULL,NULL),
	   (1624,'SANTA RITA', 16,1,GETDATE(),NULL,NULL),
	   (1625,'SAN VICENTE SENTENARIO', 16,1,GETDATE(),NULL,NULL),
	   (1626,'TRINIDAD', 16,1,GETDATE(),NULL,NULL),
	   (1627,'LAS VEGAS', 16,1,GETDATE(),NULL,NULL),
	   (1628,'NUEVA FRONTERA', 16,1,GETDATE(),NULL,NULL),
	   (1701,'NACAOME', 17,1,GETDATE(),NULL,NULL),
	   (1702,'ALIANZA', 17,1,GETDATE(),NULL,NULL),
	   (1703,'AMAPALA', 17,1,GETDATE(),NULL,NULL),
	   (1704,'ARAMECINA', 17,1,GETDATE(),NULL,NULL),
	   (1705,'CARIDAD', 17,1,GETDATE(),NULL,NULL),
	   (1706,'ASCOR�N', 17,1,GETDATE(),NULL,NULL),
	   (1707,'LANGUE', 17,1,GETDATE(),NULL,NULL),
	   (1708,'SAN FCO. DE CORAY', 17,1,GETDATE(),NULL,NULL),
	   (1709,'SAN LORENZO', 17,1,GETDATE(),NULL,NULL),
	   (1801,'YORO', 18,1,GETDATE(),NULL,NULL),
	   (1802,'ARENAL', 18,1,GETDATE(),NULL,NULL),
	   (1803,'EL NEGRITA', 18,1,GETDATE(),NULL,NULL),
	   (1804,'EL PROGRESO', 18,1,GETDATE(),NULL,NULL),
	   (1805,'JOC�N', 18,1,GETDATE(),NULL,NULL),
	   (1806,'MORAZ�N', 18,1,GETDATE(),NULL,NULL),
	   (1807,'OLANCHITO', 18,1,GETDATE(),NULL,NULL),
	   (1808,'SANTA RITA', 18,1,GETDATE(),NULL,NULL),
	   (1809,'SULACO', 18,1,GETDATE(),NULL,NULL),
	   (1810,'VICTORIA', 18,1,GETDATE(),NULL,NULL),
	   (1811,'YORITO', 18,1,GETDATE(),NULL,NULL);
	  


GO



-------------------------------------------------------------------------



------------------------------------- EMPLEADOS--------------------------


CREATE OR ALTER PROCEDURE UDP_CARGOS_INSERT
@carg_Description NVARCHAR(200),
@rep_UsuarioCreador  INT 

AS
BEGIN

DECLARE @rep_FechaCreacion DATETIME = GETDATE();
DECLARE @rep_UsuarioMod INT = NULL; 
DECLARE @rep_FechaMod DATETIME = NULL; 
DECLARE @rep_Estado BIT = 1;

INSERT INTO [dbo].[tbCargos] ([carg_Description], [rep_UsuarioCreador], [rep_FechaCreacion], [rep_UsuarioMod], [rep_FechaMod], [rep_Estado])
VALUES (@carg_Description, @rep_UsuarioCreador, @rep_FechaCreacion, @rep_UsuarioMod, @rep_FechaMod, @rep_Estado)
END


EXEC UDP_CARGOS_INSERT 'Jefe de carga',1
EXEC UDP_CARGOS_INSERT 'Jefe de Empaques',1
EXEC UDP_CARGOS_INSERT 'Empacador',1
EXEC UDP_CARGOS_INSERT 'Supervisor de Operaciones SR.',1
EXEC UDP_CARGOS_INSERT 'Supervisor Sr. de Entrenamiento',1
EXEC UDP_CARGOS_INSERT 'Coordinador de Transporte',1
EXEC UDP_CARGOS_INSERT 'Supervisor de Operaciones Log�sticas',1
EXEC UDP_CARGOS_INSERT 'Analista de Servicio al Cliente',1
EXEC UDP_CARGOS_INSERT 'Supervisor de Recursos Humanos',1
EXEC UDP_CARGOS_INSERT 'Becario (Adm�n. o Psicolog�a Organizacional)',1
EXEC UDP_CARGOS_INSERT 'Analista de Transporte',1
EXEC UDP_CARGOS_INSERT 'Coordinador de Log�stica (e-commerce)',1
EXEC UDP_CARGOS_INSERT 'Almacenista',1
EXEC UDP_CARGOS_INSERT 'Coordinador de Inventarios',1
EXEC UDP_CARGOS_INSERT 'Ayudante General',1
EXEC UDP_CARGOS_INSERT 'Auxiliar de Rampa',1
EXEC UDP_CARGOS_INSERT 'Chofer Repartidor',1
EXEC UDP_CARGOS_INSERT 'Especialista en Marketing',1
EXEC UDP_CARGOS_INSERT 'Coordinador de Log�stica y Distribuci�n',1
EXEC UDP_CARGOS_INSERT 'Ejecutivo de Ventas',1
EXEC UDP_CARGOS_INSERT 'Gerente de Operaciones Log�sticas',1
EXEC UDP_CARGOS_INSERT 'Programador Java',1
EXEC UDP_CARGOS_INSERT 'Auxiliar de Almac�n',1
EXEC UDP_CARGOS_INSERT 'Ejecutivo de Cuentas por Cobrar',1
EXEC UDP_CARGOS_INSERT 'Analista Financiero',1
EXEC UDP_CARGOS_INSERT 'Delivery Station Manager',1
EXEC UDP_CARGOS_INSERT 'IT Support Associate',1
EXEC UDP_CARGOS_INSERT 'Global Trade HTS Classification Program Manager',1
EXEC UDP_CARGOS_INSERT 'Supervisor de Aduanas',1
EXEC UDP_CARGOS_INSERT 'Ejecutivo de Ventas',1
EXEC UDP_CARGOS_INSERT 'Ejecutivo de Tr�fico Internacional',1

GO


-------------------------------------------------------------------------


------------------------------------- EMPLEADOS--------------------------

CREATE OR ALTER PROCEDURE UDP_EMPLEADOS_INSERT

@emp_Name NVARCHAR(150), 
@emp_Apellido NVARCHAR(150),
@emp_DNI  VARCHAR(13),
@emp_FechaNac  DATE, 
@ciu_ID INT, 
@est_ID CHAR(1), 
@emp_Sexo CHAR(1), 
@carg_Id  INT,
@emp_UsuarioCrea INT 

AS
BEGIN

DECLARE @emp_FechaCrea DATETIME = GETDATE();
DECLARE @emp_UsuModif INT = NULL;
DECLARE @emp_FechaModif DATE = NULL;
DECLARE @emp_Estado BIT = 1;


INSERT INTO tbEmpleados( [emp_Name], [emp_Apellido], [emp_DNI], [emp_FechaNac], [ciu_ID], [est_ID], 
[emp_Sexo], [carg_Id], [emp_UsuarioCrea], [emp_FechaCrea], [emp_UsuModif], [emp_FechaModif], [emp_Estado])

VALUES (@emp_Name,@emp_Apellido,@emp_DNI,@emp_FechaNac,@ciu_ID,@est_ID,@emp_Sexo,@carg_Id,@emp_UsuarioCrea,@emp_FechaCrea, @emp_UsuModif,@emp_FechaModif,@emp_Estado)
 END
 

GO

EXEC UDP_EMPLEADOS_INSERT 'Karla','Alejandro','0502200302729','01-14-2003',1,'C','F',1,1
EXEC UDP_EMPLEADOS_INSERT 'Dania','Baca','0502200001459','01-14-2003',1,'S','F',1,1
EXEC UDP_EMPLEADOS_INSERT 'Andrea','Paz','0502200189657','01-19-2002',2,'S','F',1,1
EXEC UDP_EMPLEADOS_INSERT 'Katerin','Rivas','0501200385476','02-24-2001',3,'S','F',1,1
EXEC UDP_EMPLEADOS_INSERT 'Amelia','Gomez','0501199512346','03-17-2000',4,'S','F',1,1
EXEC UDP_EMPLEADOS_INSERT 'Genifer','Lopez','0502200069874','05-22-2002',5,'S','F',1,1
EXEC UDP_EMPLEADOS_INSERT 'Carlos','Umanzor','0502200136547','10-14-2001',201,'D','M',1,1
EXEC UDP_EMPLEADOS_INSERT 'Allam','Sosa','050274128','01-30-1998',202,'D','M',1,1
EXEC UDP_EMPLEADOS_INSERT 'Daniel','Perdomo','05011999369125','12-15-1999',203,'D','M',1,1
EXEC UDP_EMPLEADOS_INSERT 'Oscar','Gutierrez','05012001789102','07-21-2001',204,'D','M',1,1
EXEC UDP_EMPLEADOS_INSERT 'Marvin','Amaya','05031998562471','11-18-2000',205,'D','M',1,1

---luego de haber agregado estos insert's ... ir a usuarios y crear los contarint de fkempelados



----- HACER LOS CONSTRAINT LUEGO DE HABER HECHO EL CONSTRAINT DE USUARIOS

ALTER TABLE [dbo].[tbEmpleados]
ADD CONSTRAINT FK_tbEmpleados_UsuCrea FOREIGN KEY (emp_UsuarioCrea) REFERENCES tbUsuarios (usu_ID)

ALTER TABLE [dbo].[tbEmpleados]
ADD CONSTRAINT FK_tbEmpleados_UsuModif FOREIGN KEY (emp_UsuModif) REFERENCES tbUsuarios (usu_ID)





---------------------------------------------------------------------------------

INSERT INTO [dbo].[tblPantallas]
VALUES ('Usuarios');
INSERT INTO [dbo].[tblPantallas]
VALUES ('Articulos');
INSERT INTO [dbo].[tblPantallas]
VALUES ('Cargos');
INSERT INTO [dbo].[tblPantallas]
VALUES ('Ciudades');
INSERT INTO [dbo].[tblPantallas]
VALUES ('Departamentos');
INSERT INTO [dbo].[tblPantallas]
VALUES ('Clientes');
INSERT INTO [dbo].[tblPantallas]
VALUES ('Direcciones');
INSERT INTO [dbo].[tblPantallas]
VALUES ('Empleados');
INSERT INTO [dbo].[tblPantallas]
VALUES ('EstadosCiviles');
INSERT INTO [dbo].[tblPantallas]
VALUES ('Fabricas');
INSERT INTO [dbo].[tblPantallas]
VALUES ('Pedidos');
INSERT INTO [dbo].[tblPantallas]
VALUES ('PedidosDetalles');
INSERT INTO [dbo].[tblPantallas]
VALUES ('Principal');





INSERT INTO [dbo].[tblRolPantallas]
VALUES (1,1);
INSERT INTO [dbo].[tblRolPantallas]
VALUES (1,2);
INSERT INTO [dbo].[tblRolPantallas]
VALUES (1,3);
INSERT INTO [dbo].[tblRolPantallas]
VALUES (1,4);
INSERT INTO [dbo].[tblRolPantallas]
VALUES (1,5);
INSERT INTO [dbo].[tblRolPantallas]
VALUES (1,6);
INSERT INTO [dbo].[tblRolPantallas]
VALUES (1,7);
INSERT INTO [dbo].[tblRolPantallas]
VALUES (1,8);
INSERT INTO [dbo].[tblRolPantallas]
VALUES (1,9);
INSERT INTO [dbo].[tblRolPantallas]
VALUES (1,10);
INSERT INTO [dbo].[tblRolPantallas]
VALUES (1,11);
INSERT INTO [dbo].[tblRolPantallas]
VALUES (1,12);
INSERT INTO [dbo].[tblRolPantallas]
VALUES (2,13);


