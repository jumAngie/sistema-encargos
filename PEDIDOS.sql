

--------------------------------- ESTADOS ENVIOS (PEDIDOS)---------------------------
INSERT INTO [dbo].[tbEstadoEnvios]
VALUES ('En paqueteria');
INSERT INTO [dbo].[tbEstadoEnvios]
VALUES ('Entregado');
INSERT INTO [dbo].[tbEstadoEnvios]
VALUES ('Enviado');

------------------------------------------------------------------------------------





--------------------------------- ESTADOS ENVIOS (PEDIDOS)---------------------------
ALTER TABLE [dbo].[tbDirecciones]
ALTER COLUMN [direc_FechaCreacion] DATETIME NOT NULL
ALTER TABLE [dbo].[tbDirecciones]
ALTER COLUMN [direc_FechaMod] DATETIME 



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
EXEC UDP_DIRECCIONES_INSERT 5,'Res. El racncho, fecitram sps', 4,1
EXEC UDP_DIRECCIONES_INSERT 6,'Res. Las fuentes, choloma, bloque 2 casa 9', 5,1



GO



------------------------------------------------------------------------------------







--------------------------------- PEDIDOS-------------------------------------------
--CSA012

ALTER TABLE [dbo].[tbPedidos]
ALTER COLUMN [pedi_FechaCreacion] DATETIME NOT NULL
ALTER TABLE [dbo].[tbPedidos]
ALTER COLUMN [pedi_FechaMod] DATETIME NOT NULL


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
EXEC UDP_PEDIDOS_INSERT 'CSA017',7,500.00, 3, 11,'02-14-2023',1
EXEC UDP_PEDIDOS_INSERT 'CSA018',2,400.00, 3, 11,'02-14-2023',1
EXEC UDP_PEDIDOS_INSERT 'CSA019',3,1000.00,1,11,'02-14-2023',1
EXEC UDP_PEDIDOS_INSERT 'CSA021',4,500.00, 1, 11,'02-14-2023',1
EXEC UDP_PEDIDOS_INSERT 'CSA022',5,400.00, 2, 11,'02-14-2023',1
EXEC UDP_PEDIDOS_INSERT 'CSA023',6,1000.0, 2, 11,'02-14-2023',1
EXEC UDP_PEDIDOS_INSERT 'CSA024',7,500.00, 2, 11,'02-14-2023',1
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
EXEC UDP_PEDIDO_DETALLE 6,24,20,1
EXEC UDP_PEDIDO_DETALLE 7,14,5,1
EXEC UDP_PEDIDO_DETALLE 8,11,10,1
EXEC UDP_PEDIDO_DETALLE 9,13,4,1
EXEC UDP_PEDIDO_DETALLE 10,23,14,2
EXEC UDP_PEDIDO_DETALLE 11,29,15,2
EXEC UDP_PEDIDO_DETALLE 12,15,17,2
EXEC UDP_PEDIDO_DETALLE 13,7,7,1


GO








------------------------------------------------------------------------------------


