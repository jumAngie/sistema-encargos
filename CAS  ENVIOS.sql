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
	usu_FechaCreacion	DATE NOT NULL,
	usu_UsuarioMod		INT,
	depto_FechaMod		DATE
	CONSTRAINT PK_dbo_tbDepartamentos_depto_DepartamentoId PRIMARY KEY(depto_ID),
	CONSTRAINT FK_tbDepartamentos_UsuarioCrea		FOREIGN KEY (usu_UsuarioCreador) REFERENCES tbUsuarios(usu_ID),
	CONSTRAINT FK_tbDepartamentos_UsuarioModif		FOREIGN KEY (usu_UsuarioMod) REFERENCES tbUsuarios(usu_ID)

);

CREATE TABLE tbCiudades(
	ciu_ID				INT,
	ciu_Descripcion		NVARCHAR(255) NOT NULL,
	ciu_DeptoID			INT NOT NULL,
	ciu_UsuarioCreador	INT NOT NULL,
	ciu_FechaCreacion	DATE NOT NULL,
	ciu_UsuarioMod		INT,
	ciu_FechaMod		DATE ,
	CONSTRAINT PK_db_tbCiudades_ciu_ID PRIMARY KEY(ciu_ID),
	CONSTRAINT FK_dbo_tbCiudades_dbo_tbDepartamentos_depto_ID FOREIGN KEY(ciu_DeptoID) REFERENCES tbDepartamentos(depto_ID),
    CONSTRAINT FK_tbCiudades_UsuarioCrea		FOREIGN KEY (ciu_UsuarioCreador) REFERENCES tbUsuarios(usu_ID),
	CONSTRAINT FK_tbCiudades_UsuarioModif		FOREIGN KEY (ciu_UsuarioMod) REFERENCES tbUsuarios(usu_ID)

);

CREATE TABLE tbEstadosCiviles(
    est_ID				CHAR(1) NOT NULL,
    est_Descripcion		NVARCHAR(100),
    est_UsuCrea			INT NOT NULL,
    est_FechaCrea		DATE NOT NULL,
    est_UsuMod			INT,
    est_FechaMod        DATE
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
	client_LimiteCredito	NVARCHAR(100),
	client_Descuento		NVARCHAR(100),
	client_UsuarioCreador	INT NOT NULL,
	client_FechaCreacion	DATE NOT NULL,
	client_UsuarioMod		INT,
	client_FechaMod			DATE ,
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
	direc_FechaCreacion		DATE NOT NULL,
	direc_UsuarioMod		INT,
	direc_FechaMod			DATE ,
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
rep_FechaCreacion		DATE NOT NULL,
rep_UsuarioMod			INT,
rep_FechaMod			DATE ,
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
	fab_Descripcion		NVARCHAR(200) NOT NULL,
	fab_Telefono		NVARCHAR(250) NOT NULL,
	fab_UsuarioCreador	INT NOT NULL,
	fab_FechaCreacion	DATE NOT NULL,
	fab_UsuarioMod		INT,
	fab_FechaMod		DATE ,
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
	art_FechaCreacion	DATE NOT NULL,
	art_UsuarioMod		INT,
	art_FechaMod		DATE ,
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
	pedi_FechaCreacion	DATE NOT NULL,
	pedi_UsuarioMod		INT,
	pedi_FechaMod		DATE ,
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




