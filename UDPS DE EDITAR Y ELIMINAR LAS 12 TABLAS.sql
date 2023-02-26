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
CREATE OR ALTER PROCEDURE UDP_Editar_Clientes
		@client_ID				INT, 
		@client_Nombre			NVARCHAR(250), 
		@client_Identidad		NVARCHAR(30), 
		@client_EstadoCivil		CHAR(1), 
		@client_Sexo			CHAR(1), 
		@client_Telefono		NVARCHAR(50), 
		@client_Saldo			NVARCHAR(100), 
		@client_LimiteCredito	NVARCHAR(100), 
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
CREATE OR ALTER PROCEDURE UDP_Editar_Empleados
		@emp_Id			INT, 
		@emp_Name		NVARCHAR(150), 
		@emp_Apellido	NVARCHAR(150), 
		@emp_DNI		INT, 
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