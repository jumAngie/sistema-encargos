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


SELECT*FROM [dbo].[V_INDEX_ARTICULOS]
SELECT*FROM [dbo].[V_INDEX_CARGOS]
SELECT*FROM [dbo].[V_INDEX_CLIENTES]
SELECT*FROM [dbo].[V_INDEX_DEPARTAMENTOS]
SELECT*FROM [dbo].[V_INDEX_DIRECCIONES]
SELECT*FROM [dbo].[V_INDEX_EMPLEADOS]
SELECT*FROM [dbo].[V_INDEX_ESTADOS_CIVILES]
SELECT*FROM [dbo].[V_INDEX_FABRICAS]
SELECT*FROM [dbo].[V_INDEX_PEDIDOS]
SELECT*FROM [dbo].[V_INDEX_PEDIDOS_DETALLES]
SELECT*FROM [dbo].[V_INDEX_USUARIOS]


