CREATE DATABASE DBArticulosEncargos
GO

USE DBArticulosEncargos
GO

CREATE TABLE tblRoles 
(
	rol_ID								INT IDENTITY (1,1) NOT NULL,
	rol_Descripcion						NVARCHAR(100)	   NOT NULL

	CONSTRAINT PK_tblRoles_rol_ID		PRIMARY KEY (rol_ID)
);

CREATE TABLE tblPantallas
(
		p_ID								INT IDENTITY (1,1)	NOT NULL,
		p_Descripción						NVARCHAR(100)		NOT NULL

		CONSTRAINT PK_tblPantallas_p_ID		PRIMARY KEY(p_ID)	
);

CREATE TABLE tblRolPantallas
(
		rp_ID								INT IDENTITY(1,1)	NOT NULL,
		rp_RolID							INT,
		rp_PantallasID						INT

		CONSTRAINT PK_tblRolPantallas_rp_ID									PRIMARY KEY (rp_ID),
		CONSTRAINT FK_tblRolPantallas_rp_RolID_tblRoles_rol_ID				FOREIGN KEY (rp_RolID)			REFERENCES tblRoles (rol_ID),
		CONSTRAINT FK_tblRolPantallas_rp_PantallasID_tblPantallas_p_ID		FOREIGN KEY (rp_PantallasID)	REFERENCES tblPantallas (p_ID)
);

CREATE TABLE tbUsuarios(
	usu_ID				INT IDENTITY(1,1) PRIMARY KEY,
	usu_Usuario			NVARCHAR(200) NOT NULL, 
	emp_Id				INT,
	rol_ID				INT,
	usu_Clave			NVARCHAR(MAX) NOT NULL,
	usu_UsuarioCreador	INT,
	usu_FechaCreacion	DATE NOT NULL,
	usu_UsuarioMod		INT,
	usu_FechaMod		DATE,
	usu_Estado			BIT NOT NULL,
	usu_EsAdmin			BIT NOT  NULL,
CONSTRAINT FK_tbUsuarios_tbRoles FOREIGN KEY (rol_ID) REFERENCES  tblRoles (rol_ID)
);




CREATE TABLE tbDepartamentos(
	depto_ID			INT IDENTITY(1,1) NOT NULL,
	depto_Descripcion	NVARCHAR(255) NOT NULL,
	usu_UsuarioCreador	INT NOT NULL,
	usu_FechaCreacion	DATETIME NOT NULL,
	usu_UsuarioMod		INT,
	depto_FechaMod		DATETIME
	CONSTRAINT PK_dbo_tbDepartamentos_depto_DepartamentoId PRIMARY KEY(depto_ID),
	CONSTRAINT FK_tbDepartamentos_UsuarioCrea		FOREIGN KEY (usu_UsuarioCreador) REFERENCES tbUsuarios(usu_ID),
	CONSTRAINT FK_tbDepartamentos_UsuarioModif		FOREIGN KEY (usu_UsuarioMod) REFERENCES tbUsuarios(usu_ID)

);

CREATE TABLE tbCiudades(
	ciu_ID				INT IDENTITY(1,1),
	ciu_Descripcion		NVARCHAR(255) NOT NULL,
	ciu_DeptoID			INT NOT NULL,
	ciu_UsuarioCreador	INT NOT NULL,
	ciu_FechaCreacion	DATETIME NOT NULL,
	ciu_UsuarioMod		INT,
	ciu_FechaMod		DATETIME ,
	CONSTRAINT PK_db_tbCiudades_ciu_ID PRIMARY KEY(ciu_ID),
	CONSTRAINT FK_dbo_tbCiudades_dbo_tbDepartamentos_depto_ID FOREIGN KEY(ciu_DeptoID) REFERENCES tbDepartamentos(depto_ID),
    CONSTRAINT FK_tbCiudades_UsuarioCrea		FOREIGN KEY (ciu_UsuarioCreador) REFERENCES tbUsuarios(usu_ID),
	CONSTRAINT FK_tbCiudades_UsuarioModif		FOREIGN KEY (ciu_UsuarioMod) REFERENCES tbUsuarios(usu_ID)

);

CREATE TABLE tbEstadosCiviles(
    est_ID				CHAR(1) NOT NULL,
    est_Descripcion		NVARCHAR(100),
    est_UsuCrea			INT NOT NULL,
    est_FechaCrea		DATETIME NOT NULL,
    est_UsuMod			INT,
    est_FechaMod        DATETIME,
	est_Estado			BIT NOT NULL,
    CONSTRAINT PK_tbEstadoCivil_est_ID PRIMARY KEY(est_ID),
	CONSTRAINT FK_tbEstados_Civ_UsuarioCrea			FOREIGN KEY (est_UsuCrea) REFERENCES tbUsuarios(usu_ID),
	CONSTRAINT FK_tbEstados_Civ_UsuarioModif		FOREIGN KEY (est_UsuMod) REFERENCES tbUsuarios(usu_ID)


);

CREATE TABLE tbClientes(
	client_ID				INT IDENTITY(1,1),
	client_Nombre			NVARCHAR(250) NOT NULL,
	client_Identidad		NVARCHAR(30) UNIQUE NOT NULL,
	client_EstadoCivil		CHAR(1) NOT NULL,
	client_Sexo				CHAR(1) NOT NULL,
	client_Telefono			NVARCHAR(50) NOT NULL,
	client_Saldo			NVARCHAR(100),
	client_LimiteCredito	DECIMAL (20,2) NOT NULL,
	client_Descuento		NVARCHAR(100),
	client_UsuarioCreador	INT NOT NULL,
	client_FechaCreacion	DATETIME NOT NULL,
	client_UsuarioMod		INT,
	client_FechaMod			DATETIME ,
	client_Estado			BIT NOT NULL,
	CONSTRAINT PK_dbo_tbClientes_client_ID PRIMARY KEY(client_ID),
	CONSTRAINT FK_dbo_tbClientes_dbo_tbEstadosCiviles_est_ID FOREIGN KEY(client_EstadoCivil) REFERENCES tbEstadosCiviles(est_ID),
	CONSTRAINT CK_dbo_tbClientes_client_Sexo CHECK(client_Sexo IN('F', 'M')),
	CONSTRAINT FK_tbClientes_UsuarioCrea			FOREIGN KEY (client_UsuarioCreador) REFERENCES tbUsuarios(usu_ID),
	CONSTRAINT FK_tbClientes_UsuarioModif			FOREIGN KEY (client_UsuarioMod) REFERENCES tbUsuarios(usu_ID)

);


CREATE TABLE tbDirecciones(
	direc_ID				INT IDENTITY(1,1),
	direc_ClienteID			INT NOT NULL,
	direc_DireccionExacta	NVARCHAR(MAX) NOT NULL,
	direc_CiudadID			INT NOT NULL,
	direc_UsuarioCreador	INT NOT NULL,
	direc_FechaCreacion		DATETIME NOT NULL,
	direc_UsuarioMod		INT,
	direc_FechaMod			DATETIME ,
	direc_Estado			BIT NOT NULL,
	CONSTRAINT PK_dbo_tbDirecciones_direc_ID PRIMARY KEY(direc_ID),
	CONSTRAINT FK_dbo_tbDirecciones_tbClientes_client_ID FOREIGN KEY(direc_ClienteID) REFERENCES tbClientes(client_ID),
	CONSTRAINT FK_dbo_tbDirecciones_tbCiudades_ciu_ID FOREIGN KEY(direc_CiudadID) REFERENCES tbCiudades(ciu_ID),
	CONSTRAINT FK_tbDirecciones_UsuarioCrea			FOREIGN KEY (direc_UsuarioCreador) REFERENCES tbUsuarios(usu_ID),
	CONSTRAINT FK_tbDirecciones_UsuarioModif		 FOREIGN KEY (direc_UsuarioMod) REFERENCES tbUsuarios(usu_ID)

);


CREATE TABLE tbCargos
(
carg_Id					INT IDENTITY(1,1) PRIMARY KEY,
carg_Description		NVARCHAR(200) NOT NULL,
rep_UsuarioCreador		INT NOT NULL,
rep_FechaCreacion		DATETIME NOT NULL,
rep_UsuarioMod			INT,
rep_FechaMod			DATETIME ,
rep_Estado				BIT NOT NULL,
CONSTRAINT FK_tbCargos_UsuarioCrea	 FOREIGN KEY (rep_UsuarioCreador) REFERENCES tbUsuarios(usu_ID),
CONSTRAINT FK_tbCargos_UsuarioModif	 FOREIGN KEY (rep_UsuarioMod) REFERENCES tbUsuarios(usu_ID)
);




CREATE TABLE tbEmpleados
(
emp_Id				 INT IDENTITY(1,1) PRIMARY KEY,
emp_Name			 NVARCHAR(150) NOT NULL,
emp_Apellido		 NVARCHAR(150) NOT NULL,
emp_DNI			     VARCHAR(13) NOT NULL,
emp_FechaNac		 DATE,
ciu_ID				 INT NOT NULL,
est_ID			     CHAR(1) NOT NULL,
emp_Sexo			 CHAR(1) NOT NULL,
carg_Id				 INT NOT NULL,
emp_UsuarioCrea		 INT NOT NULL,
emp_FechaCrea	     DATETIME NOT NULL,
emp_UsuModif		 INT,
emp_FechaModif		 DATETIME,
emp_Estado			 BIT,
CONSTRAINT FK_Empleados_EstadoCivil  FOREIGN KEY(est_ID)  REFERENCES  tbEstadosCiviles(est_ID),
CONSTRAINT FK_Empleados_Ciudad		 FOREIGN KEY(ciu_ID) REFERENCES tbCiudades(ciu_ID),
CONSTRAINT CK_Empleados_Sexo		 CHECK (emp_Sexo IN ('F', 'M')),
CONSTRAINT UQ_Empleados_DNI			 UNIQUE(emp_DNI)
--CONSTRAINT FK_tbEmpleados_UsuarioCrea			FOREIGN KEY  REFERENCES tbUsuarios(usu_ID),
--CONSTRAINT FK_tbEmpleados_UsuarioModif		FOREIGN KEY  REFERENCES tbUsuarios(usu_ID)
);





CREATE TABLE tbFabricas(
	fab_ID				INT IDENTITY(1,1),
	fab_Descripcion		NVARCHAR(250) NOT NULL,
	fab_Telefono		NVARCHAR(100) NOT NULL,
	fab_UsuarioCreador	INT NOT NULL,
	fab_FechaCreacion	DATETIME NOT NULL,
	fab_UsuarioMod		INT,
	fab_FechaMod		DATETIME ,
	fab_Estado			BIT NOT NULL,
	CONSTRAINT PK_dbo_tbFabricas_fab_ID				PRIMARY KEY(fab_ID),
	CONSTRAINT FK_tbFabricas_UsuarioCrea			FOREIGN KEY (fab_UsuarioCreador) REFERENCES tbUsuarios(usu_ID),
	CONSTRAINT FK_tbFabricas_UsuarioModif			FOREIGN KEY (fab_UsuarioMod) REFERENCES tbUsuarios(usu_ID)

);



CREATE TABLE tbArticulos(
	art_ID				INT IDENTITY(1,1),
	art_Descripcion		NVARCHAR(200) NOT NULL,
	fab_ID				INT NOT NULL,
	art_Stock			INT NOT NULL,
	art_UsuarioCreador	INT NOT NULL,
	art_FechaCreacion	DATETIME NOT NULL,
	art_UsuarioMod		INT,
	art_FechaMod		DATETIME ,
	art_Estado			BIT NOT NULL,
	CONSTRAINT PK_dbo_tbArticulos_art_ID		PRIMARY KEY(art_ID),
	CONSTRAINT FK_tbArticulos_UsuarioCrea		FOREIGN KEY (art_UsuarioCreador) REFERENCES tbUsuarios(usu_ID),
	CONSTRAINT FK_tbArticulos_UsuarioModif		 FOREIGN KEY (art_UsuarioMod) REFERENCES tbUsuarios(usu_ID),
    CONSTRAINT FK_tbArticulos_tbFabrica     	 FOREIGN KEY (fab_ID) REFERENCES tbFabricas (fab_ID)

);



CREATE TABLE tbEstadoEnvios /*AYUDA DE TABLA PARA CREAR ORDEN */
(
 estv_Id			 INT IDENTITY (1,1) PRIMARY KEY,
 estv_Description	 NVARCHAR(150) NOT NULL,
);


CREATE TABLE tbPedidos(
	pedi_ID				INT IDENTITY(1,1),
	pedi_Code			VARCHAR(6) NOT NULL,
	pedi_DireccionID	INT NOT NULL,
	pedi_CostoEnvio		DECIMAL(18,2) NOT NULL,
	estv_Id			    INT NOT NULL,
	emp_Id				INT NOT NULL,
	pedi_Fecha			DATE NOT NULL,
	pedi_UsuarioCreador	INT NOT NULL,
	pedi_FechaCreacion	DATETIME NOT NULL,
	pedi_UsuarioMod		INT,
	pedi_FechaMod		DATETIME ,
	pedi_Estado			BIT NOT NULL,
	CONSTRAINT PK_dbo_tbPed_pedi_ID PRIMARY KEY(pedi_ID),
	CONSTRAINT FK_dbo_tbPedidos_dbo_tbDirecciones_direc_ID FOREIGN KEY(pedi_DireccionID) REFERENCES tbDirecciones(direc_ID),
	CONSTRAINT FK_tbPedidos_UsuarioCrea	 FOREIGN KEY (pedi_UsuarioCreador) REFERENCES tbUsuarios(usu_ID),
	CONSTRAINT FK_tbPedidos_UsuarioModif	 FOREIGN KEY (pedi_UsuarioMod) REFERENCES tbUsuarios(usu_ID),
	CONSTRAINT FK_tbPedidos_tbEstadoEnvio     	 FOREIGN KEY (estv_Id) REFERENCES tbEstadoEnvios (estv_Id)

);



	CREATE TABLE tbPedidoDetalles
	(
	det_Id					  INT IDENTITY(1,1) PRIMARY KEY,
	pedi_ID				      INT NOT NULL,
	art_ID				      INT NOT NULL,
	det_Cantidad			 INT NOT NULL,
	det_UsuarioCrea			 INT NOT NULL,
	det_FechaCrea			 DATETIME NOT NULL,
	det_UsuModif			 INT,
	det_FechaModif			 DATETIME,
	det_Estado				 BIT,
	 CONSTRAINT FK_tbPedidos_Detalles_Pedidos        FOREIGN KEY(pedi_ID) REFERENCES tbPedidos(pedi_ID),
	 CONSTRAINT FK_tbPedidosDetalles_UsuarioCrea	 FOREIGN KEY (det_UsuarioCrea) REFERENCES tbUsuarios(usu_ID),
	 CONSTRAINT FK_tbPedidosDetalles_UsuarioModif	 FOREIGN KEY (det_UsuModif) REFERENCES tbUsuarios(usu_ID)

	);


---------------------------------------------------
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

--------------------- ... ---------------

-------- LUEGO SE HACE EL UDP DE USUARIOS Y SE INSERTA SOLO UN USUARIO
CREATE OR ALTER PROCEDURE UDP_USUARIOS_INSERT
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


EXEC UDP_USUARIOS_INSERT 'Admin', 1,1,'123',1,1

--SELECT*FROM tbUsuarios
------ LUEGO SE HACE EL UDP PARA EMPLEADOS Y SE INSERTAN EMPELADOS

--------------- ...

------CUANDO YA SE HAN INSERTADO EMPELADOS, HACER ESTOS CONSTRAINT

ALTER TABLE [dbo].[tbUsuarios]
ADD CONSTRAINT FK_tbUsuarios_tbEmpleados FOREIGN KEY(emp_Id) REFERENCES [dbo].[tbEmpleados] (emp_Id)

---- LUEGO DE A;ADIR EL CONSTRAINT, IR A EMPLEADOS Y A;ADIR LOS CONSTRAINT DE ALL[A


----------------- CUANDO YA SE A;ADIERON LOS CONSTRAINT, HACER MAS INSERTS

EXEC UDP_USUARIOS_INSERT 'Meow', 2,1,'123',1,1
EXEC UDP_USUARIOS_INSERT 'Gatita Mala', 3,1,'1106',1,1
EXEC UDP_USUARIOS_INSERT 'Run', 4,1,'1401',1,1
EXEC UDP_USUARIOS_INSERT 'mcqueen', 5,1,'Qkjn',1,1
EXEC UDP_USUARIOS_INSERT 'Ovner', 6,2,'Qwe14',0,1
EXEC UDP_USUARIOS_INSERT 'Emil', 7,2,'JsJs',0,1
EXEC UDP_USUARIOS_INSERT 'XXX', 8,2,'XxXxX',0,1



GO




-------------------ESTADOS CIVILES----------------------------------------


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
EXEC UDP_DEPARTAMENTOS_INSERT 'Atlántida', 1
EXEC UDP_DEPARTAMENTOS_INSERT 'Choluteca', 1
EXEC UDP_DEPARTAMENTOS_INSERT 'Colón', 1
EXEC UDP_DEPARTAMENTOS_INSERT 'Comayagua', 1
EXEC UDP_DEPARTAMENTOS_INSERT 'Copán', 1
EXEC UDP_DEPARTAMENTOS_INSERT 'Cortés', 1
EXEC UDP_DEPARTAMENTOS_INSERT 'El Paraíso', 1
EXEC UDP_DEPARTAMENTOS_INSERT 'Francisco Morazán', 1
EXEC UDP_DEPARTAMENTOS_INSERT 'Gracias a Dios', 1
EXEC UDP_DEPARTAMENTOS_INSERT 'Intibucá', 1
EXEC UDP_DEPARTAMENTOS_INSERT 'Islas de la Bahía', 1
EXEC UDP_DEPARTAMENTOS_INSERT 'La Paz', 1
EXEC UDP_DEPARTAMENTOS_INSERT 'Lempira', 1
EXEC UDP_DEPARTAMENTOS_INSERT 'Ocotepeque', 1
EXEC UDP_DEPARTAMENTOS_INSERT 'Olancho', 1
EXEC UDP_DEPARTAMENTOS_INSERT 'Santa Bárbara', 1
EXEC UDP_DEPARTAMENTOS_INSERT 'Valle', 1
EXEC UDP_DEPARTAMENTOS_INSERT 'Yoro', 1


GO

-------------------------------------------------------------------------



------------------------------------- CIUDADES--------------------------



CREATE OR ALTER PROCEDURE UDP_CIUDADES_INSERT
(
@ciu_Decription		NVARCHAR(100),
@ciu_IdDepto        INT,
@UsuCrea			INT)

AS BEGIN

DECLARE		@FechaCrea  DATETIME = GETDATE();
DECLARE		@UsuModi    INT = NULL;
DECLARE		@FechaModi	DATETIME = NULL;

INSERT INTO [dbo].[tbCiudades] ([ciu_Descripcion], [ciu_DeptoID], [ciu_UsuarioCreador], [ciu_FechaCreacion], [ciu_UsuarioMod], [ciu_FechaMod])
VALUES (
		@ciu_Decription, 
		@ciu_IdDepto, 
		@UsuCrea, 
		@FechaCrea, 
		@UsuModi,
		@FechaModi)
END 





	   EXEC UDP_CIUDADES_INSERT 'LA CEIBA', 1,1
	   EXEC UDP_CIUDADES_INSERT 'EL PORVENIR', 1,1
	   EXEC UDP_CIUDADES_INSERT 'ESPARTA', 1,1
	   EXEC UDP_CIUDADES_INSERT 'JUTIAPA', 1,1
	   EXEC UDP_CIUDADES_INSERT 'LA MASICA', 1,1
	   EXEC UDP_CIUDADES_INSERT 'SAN FRANCISCO', 1,1
	   EXEC UDP_CIUDADES_INSERT 'TELA', 1,1
	   EXEC UDP_CIUDADES_INSERT 'ARIZONA', 1,1

INSERT INTO [dbo].[tbCiudades]
VALUES 
	   ('TRUJILLO', 2,1,GETDATE(),NULL,NULL),
	   ('BALFATE', 2,1,GETDATE(),NULL,NULL),
	   ('IRIONA', 2,1,GETDATE(),NULL,NULL),
	   ('LIMÓN', 2,1,GETDATE(),NULL,NULL),
	   ('SABÁ', 2,1,GETDATE(),NULL,NULL),
	   ('SANTA FE', 2,1,GETDATE(),NULL,NULL),
	   ('STA. ROSA DE AGUÁN', 2,1,GETDATE(),NULL,NULL),
	   ('SONAGUERA', 2,1,GETDATE(),NULL,NULL),
	   ('TOCOA', 2,1,GETDATE(),NULL,NULL),
	   ('BONITO ORIENTAL', 2,1,GETDATE(),NULL,NULL),
	   ('COMAYAGUA', 3,1,GETDATE(),NULL,NULL),
	   ('AJUTERIQUE', 3,1,GETDATE(),NULL,NULL),
	   ('EL ROSARIO', 3,1,GETDATE(),NULL,NULL),
	   ('ESQUÍAS', 3,1,GETDATE(),NULL,NULL),
	   ('SABÁ', 3,1,GETDATE(),NULL,NULL),
	   ('SANTA FE', 3,1,GETDATE(),NULL,NULL),
	   ('STA. ROSA DE AGUÁN', 3,1,GETDATE(),NULL,NULL),
	   ('SONAGUERA', 3,1,GETDATE(),NULL,NULL),
	   ('TOCOA', 3,1,GETDATE(),NULL,NULL),
	   ('BONITO ORIENTAL', 3,1,GETDATE(),NULL,NULL),
	   ('MINAS DE ORO', 3,1,GETDATE(),NULL,NULL),
	   ('OJOS DE AGUA', 3,1,GETDATE(),NULL,NULL),
	   ('SAN JERÓNIMO', 3,1,GETDATE(),NULL,NULL),
	   ('S. JOSE DE COMAYAGUA', 3,1,GETDATE(),NULL,NULL),
	   ('S. JOSE DEL POTRERO', 3,1,GETDATE(),NULL,NULL),
	   ('SAN LUIS', 3,1,GETDATE(),NULL,NULL),
	   ('SAN SEBASTIÁN', 3,1,GETDATE(),NULL,NULL),
	   ('SIGUATEPEQUE', 3,1,GETDATE(),NULL,NULL),
	   ('VILLA DE S. ANTONIO', 3,1,GETDATE(),NULL,NULL),
	   ('LAJAS', 3,1,GETDATE(),NULL,NULL),
	   ('TAULABÉ', 3,1,GETDATE(),NULL,NULL),
	   ('STA. ROSA DE COPÁN', 4,1,GETDATE(),NULL,NULL),
	   ('CABAÑAS', 4,1,GETDATE(),NULL,NULL),
	   ('CONCEPCIÓN', 4,1,GETDATE(),NULL,NULL),
	   ('COPÁN RUINAS', 4,1,GETDATE(),NULL,NULL),
	   ('CORQUÓN', 4,1,GETDATE(),NULL,NULL),
	   ('CUCUYAGUA', 4,1,GETDATE(),NULL,NULL),
	   ('DOLORES', 4,1,GETDATE(),NULL,NULL),
	   ('DULCE NOMBRE', 4,1,GETDATE(),NULL,NULL),
	   ('EL PARAÍSO', 4,1,GETDATE(),NULL,NULL),
	   ('FLORIDA', 4,1,GETDATE(),NULL,NULL),
	   ('LA JIGUA', 4,1,GETDATE(),NULL,NULL),
	   ('LA UNIÓN', 4,1,GETDATE(),NULL,NULL),
	   ('NUEVA ARCADIA', 4,1,GETDATE(),NULL,NULL),
	   ('SAN AGUSTÍN', 4,1,GETDATE(),NULL,NULL),
	   ('SAN ANTONIO', 4,1,GETDATE(),NULL,NULL),
	   ('SAN JERÓNIMO', 4,1,GETDATE(),NULL,NULL),
	   ('SAN JOSÉ', 4,1,GETDATE(),NULL,NULL),
	   ('SAN JUAN DE OPOA', 4,1,GETDATE(),NULL,NULL),
	   ('SAN NICOLÁS', 4,1,GETDATE(),NULL,NULL),
	   ('SAN PEDRO', 4,1,GETDATE(),NULL,NULL),
	   ('SANTA RITA', 4,1,GETDATE(),NULL,NULL),
	   ('TRINIDAD', 4,1,GETDATE(),NULL,NULL),
	   ('VERACRUZ', 4,1,GETDATE(),NULL,NULL),
	   ('SAN PEDRO SULA', 5,1,GETDATE(),NULL,NULL),
	   ('CHOLOMA', 5,1,GETDATE(),NULL,NULL),
	   ('OMOA', 5,1,GETDATE(),NULL,NULL),
	   ('PIMIENTA', 5,1,GETDATE(),NULL,NULL),
	   ('POTRERILLOS', 5,1,GETDATE(),NULL,NULL),
	   ('PUERTO CORTÉS', 5,1,GETDATE(),NULL,NULL),
	   ('S. ANTONIO DE CORTÉS', 5,1,GETDATE(),NULL,NULL),
	   ('SAN FCO. DE YOJOA', 5,1,GETDATE(),NULL,NULL),
	   ('SAN MANUEL', 5,1,GETDATE(),NULL,NULL),
	   ('STA. CRUZ DE YOJOA', 5,1,GETDATE(),NULL,NULL),
	   ('VILLANUEVA', 5,1,GETDATE(),NULL,NULL),
	   ('LA LIMA', 5,1,GETDATE(),NULL,NULL),
	   ('CHOLUTECA', 6,1,GETDATE(),NULL,NULL),
	   ('APACILAGUA', 6,1,GETDATE(),NULL,NULL),
	   ('CONCEPCIÓN DE MARÁA', 6,1,GETDATE(),NULL,NULL),
	   ('DUYURE', 6,1,GETDATE(),NULL,NULL),
	   ('EL CORPUS', 6,1,GETDATE(),NULL,NULL),
	   ('EL TRIUNFO', 6,1,GETDATE(),NULL,NULL),
	   ('MARCOVIA', 6,1,GETDATE(),NULL,NULL),
	   ('MOROLICA', 6,1,GETDATE(),NULL,NULL),
	   ('NAMASIGUE', 6,1,GETDATE(),NULL,NULL),
	   ('OROCUINA', 6,1,GETDATE(),NULL,NULL),
	   ('PESPIRE', 6,1,GETDATE(),NULL,NULL),
	   ('SAN ANTONIO DE FLORES', 6,1,GETDATE(),NULL,NULL),
	   ('SAN ISIDRO', 6,1,GETDATE(),NULL,NULL),
	   ('SAN JOSE', 6,1,GETDATE(),NULL,NULL),
	   ('SAN MARCOS DE COLÓN', 6,1,GETDATE(),NULL,NULL),
	   ('SANTA ANA DE YUSGUARE,', 6,1,GETDATE(),NULL,NULL),
	   ('YUSCARÁN', 7,1,GETDATE(),NULL,NULL),
	   ('ALAUCA', 7,1,GETDATE(),NULL,NULL),
	   ('DANLÍ', 7,1,GETDATE(),NULL,NULL),
	   ('EL PARAÍSO', 7,1,GETDATE(),NULL,NULL),
	   ('"GUINOPE', 7,1,GETDATE(),NULL,NULL),
	   ('JACALEAPA', 7,1,GETDATE(),NULL,NULL),
	   ('LIURE', 7,1,GETDATE(),NULL,NULL),
	   ('MOROCELÁ', 7,1,GETDATE(),NULL,NULL),
	   ('OROPOLÁ', 7,1,GETDATE(),NULL,NULL),
	   ('POTRERILLOS', 7,1,GETDATE(),NULL,NULL),
	   ('S. ANTONIO DE FLORES', 7,1,GETDATE(),NULL,NULL),
	   ('SAN LUCAS', 7,1,GETDATE(),NULL,NULL),
	   ('SAN MATÍAS', 7,1,GETDATE(),NULL,NULL),
	   ('SOLEDAD', 7,1,GETDATE(),NULL,NULL),
	   ('TEUPASENTI', 7,1,GETDATE(),NULL,NULL),
	   ('TEXIGUAT', 7,1,GETDATE(),NULL,NULL),
	   ('VADO ANCHO', 7,1,GETDATE(),NULL,NULL),
	   ('YAUYUPE', 7,1,GETDATE(),NULL,NULL),
	   ('TROJES', 7,1,GETDATE(),NULL,NULL),
	   ('DISTRITO CENTRAL', 8,1,GETDATE(),NULL,NULL),
	   ('ALUBAR?N', 8,1,GETDATE(),NULL,NULL),
	   ('CEDROS', 8,1,GETDATE(),NULL,NULL),
	   ('CURARÓN', 8,1,GETDATE(),NULL,NULL),
	   ('EL PROVENIR', 8,1,GETDATE(),NULL,NULL),
	   ('GUAIMACA', 8,1,GETDATE(),NULL,NULL),
	   ('LA LIBERTAD', 8,1,GETDATE(),NULL,NULL),
	   ('LA VENTA', 8,1,GETDATE(),NULL,NULL),
	   ('LEPATERIQUE', 8,1,GETDATE(),NULL,NULL),
	   ('MARAITA', 8,1,GETDATE(),NULL,NULL),
	   ('MARALE', 8,1,GETDATE(),NULL,NULL),
	   ('NUEVA AREMNIA', 8,1,GETDATE(),NULL,NULL),
	   ('OJOJONA', 8,1,GETDATE(),NULL,NULL),
	   ('ORICA', 8,1,GETDATE(),NULL,NULL),
	   ('REITOCA', 8,1,GETDATE(),NULL,NULL),
	   ('SABANA GRANDE', 8,1,GETDATE(),NULL,NULL),
	   ('S. ANTONIO DE ORIENTE', 8,1,GETDATE(),NULL,NULL),
	   ('SAN BUENAVENTURA', 8,1,GETDATE(),NULL,NULL),
	   ('SAN IGNACIO', 8,1,GETDATE(),NULL,NULL),
	   ('SAN JUAN DE FLORES', 8,1,GETDATE(),NULL,NULL),
	   ('SAN MIGUELITO', 8,1,GETDATE(),NULL,NULL),
	   ('SANTA ANA', 8,1,GETDATE(),NULL,NULL),
	   ('SANTA LUCÍA', 8,1,GETDATE(),NULL,NULL),
	   ('TALANGA', 8,1,GETDATE(),NULL,NULL),
	   ('TATUMBLA', 8,1,GETDATE(),NULL,NULL),
	   ('VALLE DE ÁNGELES', 8,1,GETDATE(),NULL,NULL),
	   ('VILLA DE SAN FRANCISCO', 8,1,GETDATE(),NULL,NULL),
	   ('VALLECILLO', 8,1,GETDATE(),NULL,NULL),
	   ('PUERTO LEMPIRA', 9,1,GETDATE(),NULL,NULL),
	   ('BRUS LAGUNA', 9,1,GETDATE(),NULL,NULL),
	   ('AHUAS', 9,1,GETDATE(),NULL,NULL),
	   ('JUAN FRANCISCO BULNES', 9,1,GETDATE(),NULL,NULL),
	   ('VILLEDA MORALES', 9,1,GETDATE(),NULL,NULL),
	   ('WAMPUSIRPE', 9,1,GETDATE(),NULL,NULL),
	   ('LA ESPERANZA', 10,1,GETDATE(),NULL,NULL),
	   ('CAMASCA', 10,1,GETDATE(),NULL,NULL),
	   ('COLOMONCAGUA', 10,1,GETDATE(),NULL,NULL),
	   ('CONCEPCIÓN', 10,1,GETDATE(),NULL,NULL),
	   ('DOLORES', 10,1,GETDATE(),NULL,NULL),
	   ('INTIBUCÁ', 10,1,GETDATE(),NULL,NULL),
	   ('JESÚS DE OTORO', 10,1,GETDATE(),NULL,NULL),
	   ('MAGDALENA', 10,1,GETDATE(),NULL,NULL),
	   ('MASAGUARA', 10,1,GETDATE(),NULL,NULL),
	   ('SAN ANTONIO', 10,1,GETDATE(),NULL,NULL),
	   ('SAN ISIDRO', 10,1,GETDATE(),NULL,NULL),
	   ('SAN JUAN DE FLORES', 10,1,GETDATE(),NULL,NULL),
	   ('SAN MARCOS DE LA SIERRA', 10,1,GETDATE(),NULL,NULL),
	   ('SAN MIGUEL GUANCAPLA', 10,1,GETDATE(),NULL,NULL),
	   ('SANTA LUCÍA', 10,1,GETDATE(),NULL,NULL),
	   ('YAMARANGUILA', 10,1,GETDATE(),NULL,NULL),
	   ('S. FRANCISCO OPALACA', 10,1,GETDATE(),NULL,NULL),
	   ('ROATÁN', 11,1,GETDATE(),NULL,NULL),
	   ('GUANAJA', 11,1,GETDATE(),NULL,NULL),
	   ('JOSÉ SANTO GUARDIOLA', 11,1,GETDATE(),NULL,NULL),
	   ('UTILA', 11,1,GETDATE(),NULL,NULL),
	   ('LA PAZ', 12,1,GETDATE(),NULL,NULL),
	   ('AGUANQUETERIQUE', 12,1,GETDATE(),NULL,NULL),
	   ('CABAÑAS', 12,1,GETDATE(),NULL,NULL),
	   ('CANE', 12,1,GETDATE(),NULL,NULL),
	   ('CHINACLA', 12,1,GETDATE(),NULL,NULL),
	   ('GUAJIQUIRO', 12,1,GETDATE(),NULL,NULL),
	   ('LAUTERIQUE', 12,1,GETDATE(),NULL,NULL),
	   ('MARCALA', 12,1,GETDATE(),NULL,NULL),
	   ('MERCEDES DE ORIENTE', 12,1,GETDATE(),NULL,NULL),
	   ('OPATORO', 12,1,GETDATE(),NULL,NULL),
	   ('S. ANTONIO DEL NORTE', 12,1,GETDATE(),NULL,NULL),
	   ('SAN JOSÉ', 12,1,GETDATE(),NULL,NULL),
	   ('SAN JUAN', 12,1,GETDATE(),NULL,NULL),
	   ('SAN PEDRO DE TUTULE', 12,1,GETDATE(),NULL,NULL),
	   ('SANTA ANA', 12,1,GETDATE(),NULL,NULL),
	   ('SANTA ELENA', 12,1,GETDATE(),NULL,NULL),
	   ('SANTA MARÍA', 12,1,GETDATE(),NULL,NULL),
	   ('SANTIA PURINGLA', 12,1,GETDATE(),NULL,NULL),
	   ('YARULA', 12,1,GETDATE(),NULL,NULL),
	   ('GRACIAS', 13,1,GETDATE(),NULL,NULL),
	   ('BELÉN', 13,1,GETDATE(),NULL,NULL),
	   ('CANDELARIA', 13,1,GETDATE(),NULL,NULL),
	   ('COLOLACA', 13,1,GETDATE(),NULL,NULL),
	   ('ERANDIQUE', 13,1,GETDATE(),NULL,NULL),
	   ('GUALCINSE', 13,1,GETDATE(),NULL,NULL),
	   ('GUARITA', 13,1,GETDATE(),NULL,NULL),
	   ('LA CAMPA', 13,1,GETDATE(),NULL,NULL),
	   ('LA IGUALA', 13,1,GETDATE(),NULL,NULL),
	   ('LAS FLORES', 13,1,GETDATE(),NULL,NULL),
	   ('LA UNIÓN', 13,1,GETDATE(),NULL,NULL),
	   ('LA VIRTUD', 13,1,GETDATE(),NULL,NULL),
	   ('LEPAERA', 13,1,GETDATE(),NULL,NULL),
	   ('MAPULACA', 13,1,GETDATE(),NULL,NULL),
	   ('PIRAERA', 13,1,GETDATE(),NULL,NULL),
	   ('SAN ANDRÉS', 13,1,GETDATE(),NULL,NULL),
	   ('SAN FRANCISCO', 13,1,GETDATE(),NULL,NULL),
	   ('SAN JUAN GUARITA', 13,1,GETDATE(),NULL,NULL),
	   ('SAN MANUEL COLOHETE', 13,1,GETDATE(),NULL,NULL),
	   ('SAN RAFAEL', 13,1,GETDATE(),NULL,NULL),
	   ('SAN SEBASTIÁN', 13,1,GETDATE(),NULL,NULL),
	   ('SANTA CRUZ', 13,1,GETDATE(),NULL,NULL),
	   ('TALGUA', 13,1,GETDATE(),NULL,NULL),
	   ('TAMBLA', 13,1,GETDATE(),NULL,NULL),
	   ('TOMALA', 13,1,GETDATE(),NULL,NULL),
	   ('VALLADOLID', 13,1,GETDATE(),NULL,NULL),
	   ('VIRGINIA', 13,1,GETDATE(),NULL,NULL),
	   ('S. MARCOS DE CAIQUÁN', 13,1,GETDATE(),NULL,NULL),
	   ('NUEVA OCOTEPEQUE', 14,1,GETDATE(),NULL,NULL),
	   ('BELÉN GUALCHO', 14,1,GETDATE(),NULL,NULL),
	   ('CONCEPCIÓN', 14,1,GETDATE(),NULL,NULL),
	   ('DOLORES MERENDÓN', 14,1,GETDATE(),NULL,NULL),
	   ('FRATERNIDAD', 14,1,GETDATE(),NULL,NULL),
	   ('LA ENCARNACIÓN', 14,1,GETDATE(),NULL,NULL),
	   ('LA LABOR', 14,1,GETDATE(),NULL,NULL),
	   ('LUCERNA', 14,1,GETDATE(),NULL,NULL),
	   ('MERCEDES', 14,1,GETDATE(),NULL,NULL),
	   ('MERCEDES', 14,1,GETDATE(),NULL,NULL),
	   ('S. FRANCISCO DEL VALLE', 14,1,GETDATE(),NULL,NULL),
	   ('SAN JORGE', 14,1,GETDATE(),NULL,NULL),
	   ('SAN MARCOS', 14,1,GETDATE(),NULL,NULL),
	   ('SANTA FE', 14,1,GETDATE(),NULL,NULL),
	   ('SENSENTI', 14,1,GETDATE(),NULL,NULL),
	   ('SINUAPA', 14,1,GETDATE(),NULL,NULL),
	   ('JUTICALPA', 15,1,GETDATE(),NULL,NULL),
	   ('CAMPAMENTO', 15,1,GETDATE(),NULL,NULL),
	   ('CATACAMAS', 15,1,GETDATE(),NULL,NULL),
	   ('CONCORDIA', 15,1,GETDATE(),NULL,NULL),
	   ('DULCE NOMBRE DE CULMÁ', 15,1,GETDATE(),NULL,NULL),
	   ('EL ROSARIO', 15,1,GETDATE(),NULL,NULL),
	   ('ESQUIPULAS DEL NORTE', 15,1,GETDATE(),NULL,NULL),
	   ('GUALACO', 15,1,GETDATE(),NULL,NULL),
	   ('GUARIZAMA', 15,1,GETDATE(),NULL,NULL),
	   ('GUATA', 15,1,GETDATE(),NULL,NULL),
	   ('GUAYAPE', 15,1,GETDATE(),NULL,NULL),
	   ('JANO', 15,1,GETDATE(),NULL,NULL),
	   ('LA UNIÓN', 15,1,GETDATE(),NULL,NULL),
	   ('MANGULILE', 15,1,GETDATE(),NULL,NULL),
	   ('MANTO', 15,1,GETDATE(),NULL,NULL),
	   ('SALAMÉ', 15,1,GETDATE(),NULL,NULL),
	   ('SAN ESTEBAN', 15,1,GETDATE(),NULL,NULL),
	   ('S. FRANCISCO DE BECERRA', 15,1,GETDATE(),NULL,NULL),
	   ('S. FRANCISCO DE LA PAZ', 15,1,GETDATE(),NULL,NULL),
	   ('SANTA MARÍA DEL REAL', 15,1,GETDATE(),NULL,NULL),
	   ('SILCA', 15,1,GETDATE(),NULL,NULL),
	   ('YOCÓN', 15,1,GETDATE(),NULL,NULL),
	   ('FROYLAN TURCIOS', 15,1,GETDATE(),NULL,NULL),
	   ('SANTA BÁRBARA', 16,1,GETDATE(),NULL,NULL),
	   ('ARADA', 16,1,GETDATE(),NULL,NULL),
	   ('ATIMA', 16,1,GETDATE(),NULL,NULL),
	   ('AZACUALPA', 16,1,GETDATE(),NULL,NULL),
	   ('CEGUACA', 16,1,GETDATE(),NULL,NULL),
	   ('COLINAS', 16,1,GETDATE(),NULL,NULL),
	   ('CONCEPCIÓN DEL NORTE', 16,1,GETDATE(),NULL,NULL),
	   ('CONCEPCIÓN DEL SUR', 16,1,GETDATE(),NULL,NULL),
	   ('CHINDA', 16,1,GETDATE(),NULL,NULL),
	   ('EL NÓSPERO', 16,1,GETDATE(),NULL,NULL),
	   ('GUALALA', 16,1,GETDATE(),NULL,NULL),
	   ('ILAMA', 16,1,GETDATE(),NULL,NULL),
	   ('MACUELIZO', 16,1,GETDATE(),NULL,NULL),
	   ('NARANJITO', 16,1,GETDATE(),NULL,NULL),
	   ('NUEVA CELILAC', 16,1,GETDATE(),NULL,NULL),
	   ('PETOA', 16,1,GETDATE(),NULL,NULL),
	   ('PROTECCIÓN', 16,1,GETDATE(),NULL,NULL),
	   ('QUIMISTÁN', 16,1,GETDATE(),NULL,NULL),
	   ('S. FRANCISCO DE OJUERA', 16,1,GETDATE(),NULL,NULL),
	   ('SAN LUIS', 16,1,GETDATE(),NULL,NULL),
	   ('SAN MARCOS', 16,1,GETDATE(),NULL,NULL),
	   ('SAN NICOLÁS', 16,1,GETDATE(),NULL,NULL),
	   ('SAN PEDRO ZACAPA', 16,1,GETDATE(),NULL,NULL),
	   ('SANTA RITA', 16,1,GETDATE(),NULL,NULL),
	   ('SAN VICENTE SENTENARIO', 16,1,GETDATE(),NULL,NULL),
	   ('TRINIDAD', 16,1,GETDATE(),NULL,NULL),
	   ('LAS VEGAS', 16,1,GETDATE(),NULL,NULL),
	   ('NUEVA FRONTERA', 16,1,GETDATE(),NULL,NULL),
	   ('NACAOME', 17,1,GETDATE(),NULL,NULL),
	   ('ALIANZA', 17,1,GETDATE(),NULL,NULL),
	   ('AMAPALA', 17,1,GETDATE(),NULL,NULL),
	   ('ARAMECINA', 17,1,GETDATE(),NULL,NULL),
	   ('CARIDAD', 17,1,GETDATE(),NULL,NULL),
	   ('ASCORÁN', 17,1,GETDATE(),NULL,NULL),
	   ('LANGUE', 17,1,GETDATE(),NULL,NULL),
	   ('SAN FCO. DE CORAY', 17,1,GETDATE(),NULL,NULL),
	   ('SAN LORENZO', 17,1,GETDATE(),NULL,NULL),
	   ('YORO', 18,1,GETDATE(),NULL,NULL),
	   ('ARENAL', 18,1,GETDATE(),NULL,NULL),
	   ('EL NEGRITA', 18,1,GETDATE(),NULL,NULL),
	   ('EL PROGRESO', 18,1,GETDATE(),NULL,NULL),
	   ('JOCÓN', 18,1,GETDATE(),NULL,NULL),
	   ('MORAZÁN', 18,1,GETDATE(),NULL,NULL),
	   ('OLANCHITO', 18,1,GETDATE(),NULL,NULL),
	   ('SANTA RITA', 18,1,GETDATE(),NULL,NULL),
	   ('SULACO', 18,1,GETDATE(),NULL,NULL),
	   ('VICTORIA', 18,1,GETDATE(),NULL,NULL),
	   ('YORITO', 18,1,GETDATE(),NULL,NULL);
	  


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
EXEC UDP_CARGOS_INSERT 'Supervisor de Operaciones Logísticas',1
EXEC UDP_CARGOS_INSERT 'Analista de Servicio al Cliente',1
EXEC UDP_CARGOS_INSERT 'Supervisor de Recursos Humanos',1
EXEC UDP_CARGOS_INSERT 'Becario (Admón. o Psicología Organizacional)',1
EXEC UDP_CARGOS_INSERT 'Analista de Transporte',1
EXEC UDP_CARGOS_INSERT 'Coordinador de Logística (e-commerce)',1
EXEC UDP_CARGOS_INSERT 'Almacenista',1
EXEC UDP_CARGOS_INSERT 'Coordinador de Inventarios',1
EXEC UDP_CARGOS_INSERT 'Ayudante General',1
EXEC UDP_CARGOS_INSERT 'Auxiliar de Rampa',1
EXEC UDP_CARGOS_INSERT 'Chofer Repartidor',1
EXEC UDP_CARGOS_INSERT 'Especialista en Marketing',1
EXEC UDP_CARGOS_INSERT 'Coordinador de Logística y Distribución',1
EXEC UDP_CARGOS_INSERT 'Ejecutivo de Ventas',1
EXEC UDP_CARGOS_INSERT 'Gerente de Operaciones Logísticas',1
EXEC UDP_CARGOS_INSERT 'Programador Java',1
EXEC UDP_CARGOS_INSERT 'Auxiliar de Almacén',1
EXEC UDP_CARGOS_INSERT 'Ejecutivo de Cuentas por Cobrar',1
EXEC UDP_CARGOS_INSERT 'Analista Financiero',1
EXEC UDP_CARGOS_INSERT 'Delivery Station Manager',1
EXEC UDP_CARGOS_INSERT 'IT Support Associate',1
EXEC UDP_CARGOS_INSERT 'Global Trade HTS Classification Program Manager',1
EXEC UDP_CARGOS_INSERT 'Supervisor de Aduanas',1
EXEC UDP_CARGOS_INSERT 'Ejecutivo de Ventas',1
EXEC UDP_CARGOS_INSERT 'Ejecutivo de Tráfico Internacional',1

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
EXEC UDP_EMPLEADOS_INSERT 'Dania','Baca','0502200001459','01-14-2003',1,'S','F',2,1
EXEC UDP_EMPLEADOS_INSERT 'Andrea','Paz','0502200189657','01-19-2002',2,'S','F',3,1
EXEC UDP_EMPLEADOS_INSERT 'Katerin','Rivas','0501200385476','02-24-2001',3,'S','F',4,1
EXEC UDP_EMPLEADOS_INSERT 'Amelia','Gomez','0501199512346','03-17-2000',4,'S','F',5,1
EXEC UDP_EMPLEADOS_INSERT 'Genifer','Lopez','0502200069874','05-22-2002',5,'S','F',10,1
EXEC UDP_EMPLEADOS_INSERT 'Carlos','Umanzor','0502200136547','10-14-2001',6,'D','M',9,1
EXEC UDP_EMPLEADOS_INSERT 'Allam','Sosa','050274128','01-30-1998',7,'D','M',11,1
EXEC UDP_EMPLEADOS_INSERT 'Daniel','Perdomo','05011999369125','12-15-1999',8,'D','M',17,1
EXEC UDP_EMPLEADOS_INSERT 'Oscar','Gutierrez','05012001789102','07-21-2001',20,'D','M',13,1
EXEC UDP_EMPLEADOS_INSERT 'Marvin','Amaya','05031998562471','11-18-2000',35,'D','M',17,1


---luego de haber agregado estos insert's ... ir a usuarios y crear los contarint de fkempelados



----- HACER LOS CONSTRAINT LUEGO DE HABER HECHO EL CONSTRAINT DE USUARIOS

ALTER TABLE [dbo].[tbEmpleados]
ADD CONSTRAINT FK_tbEmpleados_UsuCrea FOREIGN KEY (emp_UsuarioCrea) REFERENCES tbUsuarios (usu_ID)

ALTER TABLE [dbo].[tbEmpleados]
ADD CONSTRAINT FK_tbEmpleados_UsuModif FOREIGN KEY (emp_UsuModif) REFERENCES tbUsuarios (usu_ID)


----- terminar de hacer los insert's en usuarios 


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
VALUES				('Guantes',						'1',	150, 1, '02-02-2023', NULL, NULL, 1),
					('Lentes',						'1',	150, 1, '02-02-2023', NULL, NULL, 1),
					('Cascos',						'1',	150, 1, '02-02-2023', NULL, NULL, 1),
					('Pantaloncillos',				'1',	150, 1, '02-02-2023', NULL, NULL, 1),
					('Lavaplatos',					'2',	150, 1, '02-02-2023', NULL, NULL, 1),
					('Refrigerador',				'2',	150, 1, '02-02-2023', NULL, NULL, 1),
					('Lavadora',					'2',	150, 1, '02-02-2023', NULL, NULL, 1),
					('Secadora',					'2',	150, 1, '02-02-2023', NULL, NULL, 1),
					('Bicicletas de Montaña',		'3',	150, 1, '02-02-2023', NULL, NULL, 1),
					('Bicicletas de Carretera',		'3',	150, 1, '02-02-2023', NULL, NULL, 1),
					('Bicicletas de Turismo',		'3',	150, 1, '02-02-2023', NULL, NULL, 1),
					('Chalecos',					'4',	150, 1, '02-02-2023', NULL, NULL, 1),
					('Headsets',					'4',	150, 1, '02-02-2023', NULL, NULL, 1),
					('Cadenas',						'4',	150, 1, '02-02-2023', NULL, NULL, 1),
					('Ruedas',						'4',	150, 1, '02-02-2023', NULL, NULL, 1),
					('Camisetas',					'5',	150, 1, '02-02-2023', NULL, NULL, 1),
					('Shorts',						'5',	150, 1, '02-02-2023', NULL, NULL, 1),
					('Gorras',						'5',	150, 1, '02-02-2023', NULL, NULL, 1),
					('Calcetines',					'5',	150, 1, '02-02-2023', NULL, NULL, 1),
					('Manillas',					'6',	150, 1, '02-02-2023', NULL, NULL, 1),
					('Frenos',						'6',	150, 1, '02-02-2023', NULL, NULL, 1),
					('Sillones',					'6',	150, 1, '02-02-2023', NULL, NULL, 1),
					('Pedales',						'6',	150, 1, '02-02-2023', NULL, NULL, 1),
					('Sillas',						'7',	150, 1, '02-02-2023', NULL, NULL, 1),
					('Escritorios',					'7',	150, 1, '02-02-2023', NULL, NULL, 1),
					('Archiveros',					'7',	150, 1, '02-02-2023', NULL, NULL, 1),
					('Tijeras',						'7',	150, 1, '02-02-2023', NULL, NULL, 1),
					('Estantes',					'7',	150, 1, '02-02-2023', NULL, NULL, 1),
					('Platos',						'8',	150, 1, '02-02-2023', NULL, NULL, 1),
					('Cucharas',					'8',	150, 1, '02-02-2023', NULL, NULL, 1),
					('Tenedores',					'8',	150, 1, '02-02-2023', NULL, NULL, 1),
					('Cuchillos',					'8',	150, 1, '02-02-2023', NULL, NULL, 1),
					('Laptop',						'9',	150, 1, '02-02-2023', NULL, NULL, 1),
					('Computadora Escritorio',		'9',	150, 1, '02-02-2023', NULL, NULL, 1),
					('Computadora Personal',		'9',	150, 1, '02-02-2023', NULL, NULL, 1),
					('Tabletas',					'9',	150, 1, '02-02-2023', NULL, NULL, 1),
					('Jarrones',					'10',	150, 1, '02-02-2023', NULL, NULL, 1),
					('Canastas',					'10',	150, 1, '02-02-2023', NULL, NULL, 1),
					('Botellas',					'11',	150, 1, '02-02-2023', NULL, NULL, 1),
					('Bolsones',					'11',	150, 1, '02-02-2023', NULL, NULL, 1),
					('Sneakers',					'12',	150, 1, '02-02-2023', NULL, NULL, 1),
					('Abrigos',						'12',	150, 1, '02-02-2023', NULL, NULL, 1)

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

---------------------------------------- CLIENTES ----------------------------------------------
go
CREATE OR ALTER PROCEDURE UDP_InsertClientes
	@client_Nombre			NVARCHAR (250), 
	@client_Identidad		NVARCHAR(30), 
	@client_EstadoCivil		CHAR(1), 
	@client_Sexo			CHAR(1), 
	@client_Telefono		NVARCHAR(50), 
	@client_Saldo			NVARCHAR(100), 
	@client_LimiteCredito	DECIMAL (20,2), 
	@client_Descuento		NVARCHAR(100), 
	@client_UsuarioCreador	INT
AS
BEGIN
	INSERT INTO tbClientes (client_Nombre, 
							client_Identidad, 
							client_EstadoCivil, 
							client_Sexo, 
							client_Telefono, 
							client_Saldo, 
							client_LimiteCredito, 
							client_Descuento, 
							client_UsuarioCreador, 
							client_FechaCreacion, 
							client_UsuarioMod, 
							client_FechaMod, 
							client_Estado)
	VALUES					(@client_Nombre, 
							 @client_Identidad, 
							 @client_EstadoCivil, 
							 @client_Sexo, 
							 @client_Telefono, 
							 @client_Saldo, 
							 @client_LimiteCredito, 
							 @client_Descuento, 
							 @client_UsuarioCreador, 
							 GETDATE(), 
							 NULL, 
							 NULL, 
							 1)
END

--- inserts de clientes
EXEC UDP_InsertClientes 'Josefina Bustillo', '0902-2002-002892','S','F','33456790','120000.90', '10000', '0.5', 1
EXEC UDP_InsertClientes 'Lola Hernandez',	 '0902-2003-002892','S','F','33456790','120000.90', '10000', '0.5', 1
EXEC UDP_InsertClientes 'Melissa Melgar',	 '0902-2006-002892','C','F','33456790','120000.90', '10000', '0.5', 1
EXEC UDP_InsertClientes 'Joel Dominguez',	 '0902-1998-002892','S','M','33456790','120000.90', '10000', '0.5', 1
EXEC UDP_InsertClientes 'Luis Hernandez',	 '0902-2001-001892','C','M','33456790','120000.90', '10000', '0.5', 1
EXEC UDP_InsertClientes 'Kevin Valladares',	 '0902-1989-002892','C','M','33456790','120000.90', '10000', '0.5', 1





----------------------------------------------------------------------------------------------------------------------

--------------------------------- ESTADOS ENVIOS (PEDIDOS)---------------------------
INSERT INTO [dbo].[tbEstadoEnvios]
VALUES ('En paqueteria');
INSERT INTO [dbo].[tbEstadoEnvios]
VALUES ('Entregado');
INSERT INTO [dbo].[tbEstadoEnvios]
VALUES ('Enviado');

------------------------------------------------------------------------------------





--------------------------------- ESTADOS ENVIOS (PEDIDOS)---------------------------

GO
CREATE OR ALTER PROCEDURE UDP_DIRECCIONES_INSERT
@direc_ClienteID INT, 
@direc_DireccionExacta NVARCHAR(MAX),
@direc_CiudadID INT,
@direc_UsuarioCreador INT


AS
BEGIN

DECLARE @direc_FechaCreacion DATETIME = GETDATE();
DECLARE @direc_UsuarioMod INT; 
DECLARE @direc_FechaMod   DATETIME = NULL;
DECLARE @direc_Estado BIT = 1;


INSERT INTO [dbo].[tbDirecciones] ( [direc_ClienteID], [direc_DireccionExacta], 
[direc_CiudadID], [direc_UsuarioCreador], [direc_FechaCreacion], [direc_UsuarioMod], [direc_FechaMod], [direc_Estado])
VALUES (@direc_ClienteID, @direc_DireccionExacta, @direc_CiudadID, @direc_UsuarioCreador, @direc_FechaCreacion, @direc_UsuarioMod, @direc_FechaMod, @direc_Estado)

END


EXEC UDP_DIRECCIONES_INSERT 1,'Aldea Monterrey, Bajos de Choloma', 1,1
EXEC UDP_DIRECCIONES_INSERT 2,'col. La lopez, pasaje 4, casa 2',2,2
EXEC UDP_DIRECCIONES_INSERT 3,'Res. San carlos, 3 pasaje, casa 11', 3,1
EXEC UDP_DIRECCIONES_INSERT 4,'Res. La candelaria, segunda calle, casa 14 ', 6,1
EXEC UDP_DIRECCIONES_INSERT 5,'Res. El racncho, fecitram ', 10,1
EXEC UDP_DIRECCIONES_INSERT 6,'Res. Las fuentes, bloque 2 casa 9',90,1


GO


------------------------------------------------------------------------------------







--------------------------------- PEDIDOS-------------------------------------------
--CSA012

GO

CREATE OR ALTER PROCEDURE UDP_PEDIDOS_INSERT
@pedi_Code VARCHAR(6),
@pedi_DireccionID INT, 
@pedi_CostoEnvio DECIMAL(18,2), 
@estv_Id INT,
@emp_Id INT,
@pedi_Fecha DATE,
@pedi_UsuarioCreador INT

AS
BEGIN

DECLARE @pedi_FechaCreacion DATETIME = GETDATE();
DECLARE @pedi_UsuarioMod INT = NULL;
DECLARE @pedi_FechaMod DATETIME = GETDATE();
DECLARE @pedi_Estado BIT = 1;

INSERT INTO [dbo].[tbPedidos] ([pedi_Code], [pedi_DireccionID], [pedi_CostoEnvio], 
[estv_Id], [emp_Id], [pedi_Fecha], [pedi_UsuarioCreador], [pedi_FechaCreacion], [pedi_UsuarioMod], [pedi_FechaMod], [pedi_Estado])
VALUES (@pedi_Code, @pedi_DireccionID, @pedi_CostoEnvio, @estv_Id, @emp_Id, @pedi_Fecha,@pedi_UsuarioCreador, @pedi_FechaCreacion, @pedi_UsuarioMod, @pedi_FechaMod, @pedi_Estado)

END


EXEC UDP_PEDIDOS_INSERT 'CSA012',1,350.00, 2, 11,'02-14-2023',1
EXEC UDP_PEDIDOS_INSERT 'CSA013',2,350.00, 1, 11,'02-14-2023',1
EXEC UDP_PEDIDOS_INSERT 'CSA014',3,500.00, 1,11,'02-14-2023',1
EXEC UDP_PEDIDOS_INSERT 'CSA015',4,400.00, 2, 11,'02-14-2023',1
EXEC UDP_PEDIDOS_INSERT 'CSA016',6,1000.00,2,11,'02-14-2023',1
EXEC UDP_PEDIDOS_INSERT 'CSA017',1,500.00, 3, 11,'02-14-2023',1
EXEC UDP_PEDIDOS_INSERT 'CSA018',2,400.00, 3, 11,'02-14-2023',1
EXEC UDP_PEDIDOS_INSERT 'CSA019',3,1000.00,1,11,'02-14-2023',1
EXEC UDP_PEDIDOS_INSERT 'CSA021',4,500.00, 1, 11,'02-14-2023',1
EXEC UDP_PEDIDOS_INSERT 'CSA022',5,400.00, 2, 11,'02-14-2023',1
EXEC UDP_PEDIDOS_INSERT 'CSA023',6,1000.0, 2, 11,'02-14-2023',1
EXEC UDP_PEDIDOS_INSERT 'CSA024',5,500.00, 2, 11,'02-14-2023',1
EXEC UDP_PEDIDOS_INSERT 'CSA025',2,400.00, 2, 11,'02-14-2023',1
EXEC UDP_PEDIDOS_INSERT 'CSA026',3,1000.00,2, 11,'02-14-2023',1
EXEC UDP_PEDIDOS_INSERT 'CSA027',4,350.00, 2, 11,'02-14-2023',1


 GO


------------------------------------------------------------------------------------








 --------------------------------- PEDIDOS DETALLES     ---------------------------

 CREATE OR ALTER PROCEDURE UDP_PEDIDO_DETALLE
@pedi_ID  INT, 
@art_ID INT,
@det_Cantidad INT,
@det_UsuarioCrea INT


 AS
 BEGIN

DECLARE @det_FechaCrea DATETIME = GETDATE();
DECLARE @det_UsuModif INT = NULL;
DECLARE @det_FechaModi DATETIME = NULL;
DECLARE @det_Estado BIT = 1;

INSERT INTO [dbo].[tbPedidoDetalles] ([pedi_ID], [art_ID], [det_Cantidad], [det_UsuarioCrea], [det_FechaCrea], [det_UsuModif], [det_FechaModif], [det_Estado])
VALUES								 (@pedi_ID, @art_ID, @det_Cantidad, @det_UsuarioCrea, @det_FechaCrea, @det_UsuModif, @det_FechaModi, @det_Estado)

END


EXEC UDP_PEDIDO_DETALLE 2,3,5,1
EXEC UDP_PEDIDO_DETALLE 2,4,10,1
EXEC UDP_PEDIDO_DETALLE 3,10,10,1
EXEC UDP_PEDIDO_DETALLE 4,21,5,1
EXEC UDP_PEDIDO_DETALLE 5,31,9,1
EXEC UDP_PEDIDO_DETALLE 5,28,7,1
EXEC UDP_PEDIDO_DETALLE 4,9,1,1
EXEC UDP_PEDIDO_DETALLE 5,24,20,1
EXEC UDP_PEDIDO_DETALLE 7,14,5,1
EXEC UDP_PEDIDO_DETALLE 8,11,10,1
EXEC UDP_PEDIDO_DETALLE 9,13,4,1
EXEC UDP_PEDIDO_DETALLE 10,23,14,2
EXEC UDP_PEDIDO_DETALLE 11,29,15,2
EXEC UDP_PEDIDO_DETALLE 15,15,17,2
EXEC UDP_PEDIDO_DETALLE 13,7,7,1


GO


------------------------------------------------------------------------------------
CREATE OR ALTER VIEW V_INDEX_ARTICULOS
AS
SELECT [art_ID] [ID ARTICULO], [art_Descripcion] DESCRIPCION FROM [dbo].[tbArticulos]



GO
CREATE OR ALTER VIEW V_INDEX_CARGOS
AS
SELECT [carg_Id] ID, [carg_Description] DESCRIPCION FROM [dbo].[tbCargos]




GO


CREATE OR ALTER VIEW V_INDEX_CIUDADES
AS
SELECT [ciu_ID] ID,[ciu_Descripcion] [NOMBRE CIUDAD] FROM [dbo].[tbCiudades]

GO





CREATE OR ALTER VIEW V_INDEX_CLIENTES
AS
SELECT[client_ID] ID,[client_Nombre] NOMBRE,[client_Identidad] IDENTIDAD, [client_Saldo] SALDO,[client_LimiteCredito] [LIMITE CREDITO],[client_Descuento] DESCUENTO
FROM [dbo].[tbClientes] c
INNER JOIN [dbo].[tbEstadosCiviles] e ON c.client_EstadoCivil = e.est_ID
GO




CREATE OR ALTER VIEW V_INDEX_DEPARTAMENTOS
AS
SELECT [depto_ID]  ID,[depto_Descripcion] NOMBRE FROM [dbo].[tbDepartamentos]
GO


CREATE OR ALTER VIEW V_INDEX_DIRECCIONES
AS
SELECT [direc_ID] [ID], [client_Nombre] CLIENTE, [direc_DireccionExacta] REFERENCIA, [ciu_Descripcion] CIUDAD,[depto_Descripcion] DEPARTAMENTO  
FROM [dbo].[tbDirecciones] d
INNER JOIN [dbo].[tbClientes] c ON d.direc_ClienteID = c.client_ID
INNER JOIN [dbo].[tbCiudades] ciu ON ciu.ciu_ID = d.direc_CiudadID
INNER JOIN [dbo].[tbDepartamentos] depa ON depa.depto_ID = ciu.ciu_DeptoID
GO




CREATE OR ALTER VIEW V_INDEX_EMPLEADOS
AS
SELECT [emp_Id] ID,[emp_Name] NOMBRE, [emp_Apellido] APELLIDO, [emp_DNI] IDENTIDAD,
CASE	[emp_Sexo]
		WHEN 'F' THEN 'FEMENINO'
		when 'M' THEN 'MASCULINO'
		ELSE 'OTROS' END AS SEXO ,[carg_Description] CARGO 
FROM [dbo].[tbEmpleados] e
INNER JOIN [dbo].[tbCargos] c ON c.carg_Id = e.carg_Id 
GO

CREATE OR ALTER VIEW V_INDEX_ESTADOS_CIVILES
AS
SELECT [est_ID] ID,[est_Descripcion] DESCRIPCION FROM [dbo].[tbEstadosCiviles]
GO



CREATE OR ALTER VIEW V_INDEX_FABRICAS
AS
SELECT [fab_ID] ID,[fab_Descripcion] NOMBRE FROM [dbo].[tbFabricas]
GO

CREATE OR ALTER VIEW [dbo].[V_INDEX_PEDIDOS_DETALLES]
AS
SELECT [det_Id] ID_DETALLE,p.[pedi_Code] [CODIGO PEDIDO], [art_Descripcion] [ARTICULO], [det_Cantidad] CANTIDAD FROM [dbo].[tbPedidoDetalles] pd
INNER JOIN [dbo].[tbArticulos] a ON a.art_ID = pd.art_ID
INNER JOIN [dbo].[tbPedidos] p ON pd.pedi_ID = p.pedi_ID
GO



CREATE OR ALTER VIEW V_INDEX_PEDIDOS
AS
SELECT [pedi_ID] ID, estv.estv_Description [ESTADO], [pedi_Code] CODIGO, 
d.direc_DireccionExacta DIRECCION, c.client_Nombre CLIENTE, [emp_Name] ENCARGADO
FROM [dbo].[tbPedidos] p
INNER JOIN [dbo].[tbDirecciones] d ON d.direc_ID = p.pedi_DireccionID
INNER JOIN [dbo].[tbClientes] c ON c.client_ID = d.direc_ClienteID
INNER JOIN [dbo].[tbEstadoEnvios] estv ON estv.estv_Id = p.estv_Id
INNER JOIN [dbo].[tbEmpleados] emp ON emp.emp_Id = p.emp_Id
GO



CREATE OR ALTER VIEW V_INDEX_USUARIOS
AS
SELECT [usu_ID] ID,[usu_Usuario] USUARIO, [emp_Name] NOMBRE, r.rol_Descripcion ROL FROM [dbo].[tbUsuarios] u
INNER JOIN [dbo].[tbEmpleados] emp ON emp.emp_Id = u.emp_Id
INNER JOIN [dbo].[tblRoles] r ON r.rol_ID = u.rol_ID
GO


--SELECT*FROM [dbo].[V_INDEX_ARTICULOS]
--SELECT*FROM [dbo].[V_INDEX_CARGOS]
--SELECT*FROM [dbo].[V_INDEX_CLIENTES]
--SELECT*FROM [dbo].[V_INDEX_DEPARTAMENTOS]
--SELECT*FROM [dbo].[V_INDEX_DIRECCIONES]
--SELECT*FROM [dbo].[V_INDEX_EMPLEADOS]
--SELECT*FROM [dbo].[V_INDEX_ESTADOS_CIVILES]
--SELECT*FROM [dbo].[V_INDEX_FABRICAS]
--SELECT*FROM [dbo].[V_INDEX_PEDIDOS]
--SELECT*FROM [dbo].[V_INDEX_PEDIDOS_DETALLES]
--SELECT*FROM [dbo].[V_INDEX_USUARIOS]


--------------------------------------------------------------------------------------------------------------
-------------------------------------------- TABLA ARTICULOS ----------------------------------------------

CREATE OR ALTER   PROCEDURE [dbo].[UDP_Editar_Articulos]
		@art_ID				INT, 
		@art_Descripcion	NVARCHAR(200), 
		@fab_ID				INT, 
		@art_Stock			INT,
		@art_UsuarioMod		VARCHAR(50)
AS
BEGIN
		UPDATE	tbArticulos
		SET		[art_Descripcion] = @art_Descripcion , [fab_ID] = @fab_ID, [art_Stock] = @art_Stock,
				[art_UsuarioMod] = @art_UsuarioMod, art_FechaMod = GETDATE()
		WHERE	[art_ID] = @art_ID
END
GO
CREATE OR ALTER PROCEDURE UDP_Eliminar_Articulos
		@ID INT,
		@UsuarioMod	VARCHAR(50)
AS
BEGIN
			UPDATE	tbArticulos
			SET		[art_Estado] = 0, [art_UsuarioMod] = @UsuarioMod , 
					[art_FechaMod] = GETDATE()
END

GO
-------------------------------------------- TABLA CARGOS ----------------------------------------------
CREATE OR ALTER PROCEDURE UDP_Editar_Cargos
		@carg_Id				INT, 
		@carg_Description	NVARCHAR(200),
		@rep_UsuarioMod		VARCHAR(50)
AS
BEGIN
		UPDATE	tbCargos
		SET		[carg_Description] = @carg_Description, [rep_UsuarioMod] = @rep_UsuarioMod,
				[rep_FechaMod] = GETDATE()		
		WHERE	[carg_Id] = @carg_Id
END
GO
CREATE OR ALTER PROCEDURE UDP_Eliminar_Cargos
		@ID INT,
		@UsuarioMod	VARCHAR(50)
AS
BEGIN
			UPDATE	tbCargos
			SET		rep_Estado = 0, [rep_UsuarioMod] = @UsuarioMod , 
					rep_FechaMod = GETDATE()
END
go
-------------------------------------------- TABLA CIUDADES ----------------------------------------------
CREATE OR ALTER PROCEDURE UDP_Editar_Ciudades
		@ciu_ID				INT, 
		@ciu_Descripcion	NVARCHAR(200),
		@ciu_UsuarioMod		VARCHAR(50)
AS
BEGIN
		UPDATE	tbCiudades
		SET		ciu_Descripcion = @ciu_Descripcion, [ciu_UsuarioMod] = @ciu_UsuarioMod,
				[ciu_FechaMod] = GETDATE()		
		WHERE	[ciu_ID] = @ciu_ID
END
GO
-------------------------------------------- TABLA CLIENTES ----------------------------------------------
CREATE OR ALTER   PROCEDURE [dbo].[UDP_Editar_Clientes]
		@client_ID				INT, 
		@client_Nombre			NVARCHAR(250), 
		@client_Identidad		NVARCHAR(30), 
		@client_EstadoCivil		CHAR(1), 
		@client_Sexo			CHAR(1), 
		@client_Telefono		NVARCHAR(50), 
		@client_Saldo			NVARCHAR(100), 
		@client_LimiteCredito	DECIMAL(20,2), 
		@client_Descuento		NVARCHAR(100),  
		@client_UsuarioMod		NVARCHAR(50)
AS
BEGIN
		UPDATE	tbClientes
		SET		[client_Nombre] = @client_Nombre,				[client_Identidad] = @client_Identidad,
				[client_EstadoCivil] = @client_EstadoCivil,		[client_Sexo] = @client_Sexo,
				[client_Telefono] = @client_Telefono,			[client_Saldo] = @client_Saldo,
				[client_LimiteCredito] = @client_LimiteCredito, [client_Descuento] = @client_Descuento,
				[client_UsuarioMod] = @client_UsuarioMod,		client_FechaMod = GETDATE()
END
GO
CREATE OR ALTER PROCEDURE UDP_Eliminar_Cliente
		@ID			INT,
		@UsuarioMod	NVARCHAR(50)
AS
BEGIN
		UPDATE	tbClientes
		SET		[client_Estado] = 0, [client_UsuarioMod] = @UsuarioMod, [client_FechaMod] = GETDATE()
END

GO
-------------------------------------------- TABLA DEPARTAMENTOS  -------------------------------------------
CREATE OR ALTER PROCEDURE UDP_Editar_Departamentos
		@depto_ID				INT, 
		@depto_Descripcion		NVARCHAR(255),
		@usu_UsuarioMod			NVARCHAR(50)
AS
BEGIN
		UPDATE	tbDepartamentos
		SET		[depto_Descripcion] = @depto_Descripcion, [usu_UsuarioMod] = @usu_UsuarioMod,
				[depto_FechaMod] = GETDATE()
		WHERE	[depto_ID] = @depto_ID
END

-------------------------------------------- TABLA DIRECCIONES  -------------------------------------------
GO
CREATE OR ALTER PROCEDURE UDP_Editar_Direcciones
		@direc_ID				INT, 
		@direc_ClienteID		INT, 
		@direc_DireccionExacta	NVARCHAR(MAX), 
		@direc_CiudadID			INT, 
		@direc_UsuarioMod		NVARCHAR(50)
AS
BEGIN
		UPDATE	tbDirecciones
		SET		[direc_ClienteID] = @direc_ClienteID, [direc_DireccionExacta] = @direc_DireccionExacta,
				[direc_CiudadID] = @direc_CiudadID, [direc_UsuarioMod] = @direc_UsuarioMod, 
				[direc_FechaMod] = GETDATE()
		WHERE	[direc_ID] = @direc_ID
END

GO
CREATE OR ALTER PROCEDURE UDP_Eliminar_Direcciones
			@ID				INT,
			@UsuarioModi	NVARCHAR(50)
AS
BEGIN
		UPDATE	tbDirecciones
		SET		[direc_Estado] = 0, [direc_UsuarioMod] = @UsuarioModi, [direc_FechaMod] = GETDATE()
END
go
-------------------------------------------- TABLA EMPLEADOS  -------------------------------------------
CREATE OR ALTER   PROCEDURE [dbo].[UDP_Editar_Empleados]
		@emp_Id			INT, 
		@emp_Name		NVARCHAR(150), 
		@emp_Apellido	NVARCHAR(150), 
		@emp_DNI		VARCHAR(13), 
		@emp_FechaNac	DATE, 
		@ciu_ID			INT, 
		@est_ID			CHAR(1), 
		@emp_Sexo		CHAR(1), 
		@carg_Id		INT, 
		@emp_UsuModif	NVARCHAR(50)
AS
BEGIN
		UPDATE	tbEmpleados
		SET		[emp_Name] = @emp_Name, [emp_Apellido] = @emp_Apellido, [emp_DNI] = @emp_DNI,
				[emp_FechaNac]= @emp_FechaNac, [ciu_ID] = @ciu_ID, [est_ID] = @est_ID,
				[emp_Sexo] = @emp_Sexo, [carg_Id] = @carg_Id, [emp_UsuModif] = @emp_UsuModif,
				[emp_FechaModif] = GETDATE()
		WHERE	[emp_Id] = @emp_Id
END

GO
CREATE OR ALTER PROCEDURE UDP_Eliminar_Empleados
		@ID			INT,
		@UsuModi	NVARCHAR(50)
AS
BEGIN
		UPDATE  tbEmpleados
		SET		[emp_Estado] = 0, [emp_UsuModif] = @UsuModi, [emp_FechaModif] = GETDATE()
		WHERE	[emp_Id] = @ID
END
go
---------------------------------------- TABLA ESTADOS CIVILES  ------------------------------------------
CREATE OR ALTER PROCEDURE	UDP_Editar_EstadosCiviles
		@est_ID				CHAR(1), 
		@est_Descripcion	NVARCHAR(100), 
		@est_UsuMod			NVARCHAR(50)
AS
BEGIN
		UPDATE	tbEstadosCiviles
		SET		[est_Descripcion] = @est_Descripcion, [est_UsuMod] = @est_UsuMod,
				[est_FechaMod] = GETDATE()
		WHERE	[est_ID] = @est_ID
END

go
CREATE OR ALTER PROCEDURE	UDP_Eliminar_EstadosCiviles
		@ID			CHAR(1),
		@UsuMod		NVARCHAR(50)
AS
BEGIN
		UPDATE tbEstadosCiviles
		SET		[est_Estado] = 0, [est_UsuMod] = @UsuMod, [est_FechaMod] = GETDATE()
		WHERE	[est_ID] = @ID
END

GO
---------------------------------------- TABLA FABRICAS  ------------------------------------------
CREATE OR  ALTER PROCEDURE UDP_Editar_Fabricas
		@fab_ID				INT, 
		@fab_Descripcion	NVARCHAR(200), 
		@fab_Telefono		NVARCHAR(250), 
		@fab_UsuarioMod		NVARCHAR(50)
		
AS
BEGIN
		UPDATE	tbFabricas
		SET		[fab_Descripcion] = @fab_Descripcion,	[fab_Telefono] = @fab_Telefono,
				[fab_UsuarioMod] = @fab_UsuarioMod,		[fab_FechaMod] = GETDATE()
		WHERE	[fab_ID] = @fab_ID
END

go
CREATE OR ALTER PROCEDURE UDP_Eliminar_Fabricas
		@ID INT,
		@UsuMod NVARCHAR(50)
AS
BEGIN
		UPDATE	tbFabricas
		SET		[fab_Estado] = 0, [fab_UsuarioMod] = @UsuMod, fab_FechaMod = GETDATE()
		WHERE	[fab_ID] = @ID
END

go
---------------------------------------- TABLA PEDIDOS  ------------------------------------------

CREATE OR ALTER PROCEDURE UDP_Editar_Pedidos
		@pedi_ID				INT, 
		@pedi_Code				VARCHAR(6), 
		@pedi_DireccionID		INT, 
		@pedi_CostoEnvio		DECIMAL (18,2), 
		@estv_Id				INT, 
		@emp_Id					INT, 
		@pedi_Fecha				DATE, 
		@pedi_UsuarioMod		NVARCHAR(50)
AS
BEGIN
		UPDATE	tbPedidos
		SET		[pedi_Code] = @pedi_Code , [pedi_DireccionID] = @pedi_DireccionID , [pedi_CostoEnvio] = @pedi_CostoEnvio,
				[estv_Id] = @estv_Id, [emp_Id] = @emp_Id, [pedi_Fecha] = @pedi_Fecha, [pedi_UsuarioMod] = @pedi_UsuarioMod,
				pedi_FechaMod = GETDATE()
		WHERE	[pedi_ID] = @pedi_ID
END

go
CREATE OR ALTER PROCEDURE UDP_Eliminar_Pedidos
		@ID			INT,
		@UsuMod		NVARCHAR(50)
AS
BEGIN
		UPDATE	tbPedidos
		SET		[pedi_Estado] = 0, [pedi_UsuarioMod] = @UsuMod, [pedi_FechaMod] = GETDATE()
		WHERE	[pedi_ID] = @ID
END

go
---------------------------------------- TABLA USUARIOS  ------------------------------------------
CREATE OR ALTER PROCEDURE UDP_Editar_Usuarios
		@usu_ID			INT, 
		@usu_Usuario	NVARCHAR(200), 
		@rol_ID			INT, 
		@usu_EsAdmin	BIT,
		@usu_UsuarioMod	NVARCHAR(50)
AS
BEGIN
		UPDATE  tbUsuarios
		SET		[usu_Usuario] = @usu_Usuario, [rol_ID] = @rol_ID,
				[usu_UsuarioMod] = @usu_UsuarioMod, [usu_FechaMod] = GETDATE(), [usu_EsAdmin] = @usu_EsAdmin
		WHERE	[usu_ID] = @usu_ID
END
go
CREATE OR ALTER PROCEDURE UDP_Eliminar_Usuarios
		@usu_ID				INT,
		@usu_UsuarioMod		NVARCHAR(50)
AS
BEGIN
		UPDATE tbUsuarios
		SET		[usu_Estado] = 0, [usu_UsuarioMod] = @usu_UsuarioMod, [usu_FechaMod] = GETDATE()
		WHERE	[usu_ID] = @usu_ID
END

---------------------------------------- TABLA PEDIDOS DETALLES  ------------------------------------------
GO
CREATE OR ALTER PROCEDURE UDP_Editar_PedidosDetalles
		@det_Id			INT, 
		@pedi_ID		INT, 
		@art_ID			INT, 
		@det_Cantidad	INT, 
		@det_UsuModif	NVARCHAR(50)
AS
BEGIN
		UPDATE tbPedidoDetalles
		SET		[pedi_ID] = @pedi_ID, [art_ID] = @art_ID , [det_Cantidad] = @det_Cantidad,
				[det_UsuModif] = @det_UsuModif, [det_FechaModif] = GETDATE()
		WHERE	[det_Id] = @det_Id
END
GO
CREATE OR ALTER PROCEDURE UDP_Eliminar_PedidosDetalles
		@ID			INT,
		@UsuModi	NVARCHAR(30)
AS
BEGIN
		UPDATE tbPedidoDetalles
		SET		[det_Estado] = 0, [det_UsuModif] = @UsuModi, [det_FechaModif] = GETDATE()
		WHERE	[det_Id] = @ID
END


------------------------------------ UDPS DEL LOGIN ---------------------------------------
GO
CREATE OR ALTER PROCEDURE UDP_VALIDAR_LOGIN
@usu_Usuario NVARCHAR(200),
@usu_Clave   NVARCHAR(MAX)

AS
BEGIN
DECLARE @Pass   NVARCHAR(MAX) = CONVERT(NVARCHAR(MAX), HASHBYTES('SHA2_512',@usu_Clave),2);

SELECT [usu_ID],[usu_Usuario],[usu_Clave],[emp_Name] FROM [dbo].[tbUsuarios] usu
INNER JOIN [dbo].[tbEmpleados] emp ON emp.emp_Id = usu.emp_Id
WHERE [usu_Usuario] = @usu_Usuario
AND
[usu_Clave] = @Pass

END
 GO


 EXEC UDP_VALIDAR_LOGIN 'Gatita Mala', '1106'



 ------------------- UDPS PARA RECUPERACION DE CONTRA
 GO
 CREATE OR ALTER PROCEDURE UDP_USUARIO_VALIDAR
 @usu_Usuario NVARCHAR(150)

 AS
 BEGIN

 SELECT [usu_ID], [usu_Usuario] FROM [dbo].[tbUsuarios]
 WHERE [usu_Usuario] =	@usu_Usuario
 END
 

  EXEC UDP_USUARIO_VALIDAR 'meow'

   GO


  CREATE OR ALTER PROCEDURE UDP_CambiarContraOlvidada
  @usu_Usuario   NVARCHAR(250),
  @usu_NewClave   NVARCHAR(200)
  AS
  BEGIN

  DECLARE @Pass NVARCHAR(200) = CONVERT(NVARCHAR(MAX), HASHBYTES('SHA2_512', @usu_NewClave),2);

  UPDATE [dbo].[tbUsuarios] SET [usu_Clave] = @Pass WHERE [usu_Usuario] = @usu_Usuario

  END

  GO



  CREATE OR ALTER PROCEDURE UDP_PASSWORD_CAMBIAR
  @usu_Usuario NVARCHAR(250),
  @usu_Clave   NVARCHAR(200),
  @usu_NewClave  NVARCHAR(200)

  AS
  BEGIN

  DECLARE @Pass NVARCHAR(200) = CONVERT(NVARCHAR(MAX), HASHBYTES('SHA2_512', @usu_Clave),2);
  DECLARE @Contra NVARCHAR(200) = CONVERT(NVARCHAR(MAX), HASHBYTES('SHA2_512', @usu_NewClave),2);

  UPDATE [dbo].[tbUsuarios]  SET [usu_Clave] = @Contra WHERE [usu_Usuario] = @usu_Usuario AND [usu_Clave] = @Pass

  END
   
   GO