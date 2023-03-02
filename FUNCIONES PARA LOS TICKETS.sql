CREATE OR ALTER PROCEDURE V_TICKET_PEDIDOSPORCLIENTE
		@ID INT
AS
BEGIN
SELECT	pedi_Code AS PEDIDO, pedi_CostoEnvio AS COSTO_ENVÍO, pedi_Fecha AS FECHA, empleados.emp_Name + ' ' + empleados.emp_Apellido AS EMPLEADO, estadoenvio.estv_Description AS ESTADO_ENVIO FROM tbPedidos pedidos	INNER JOIN [dbo].[tbDirecciones] direc
ON		pedidos.pedi_DireccionID = direc.direc_ID			INNER JOIN [dbo].[tbClientes]	clientes
ON		direc.direc_ClienteID = clientes.client_ID			INNER JOIN [dbo].[tbEstadoEnvios] estadoenvio
ON		pedidos.estv_Id = estadoenvio.estv_Id				INNER JOIN	[dbo].[tbEmpleados] empleados
ON		pedidos.emp_Id = empleados.emp_Id
WHERE	clientes.client_ID = @ID
END

EXEC V_TICKET_PEDIDOSPORCLIENTE 1

go
CREATE FUNCTION UDF_PedidosPorCliente(@Cliente_ID INT)
RETURNS TABLE
AS
RETURN
(
	SELECT	pedi_Code AS PEDIDO, pedi_CostoEnvio AS COSTO_ENVÍO, pedi_Fecha AS FECHA, empleados.emp_Name + ' ' + empleados.emp_Apellido AS EMPLEADO, estadoenvio.estv_Description AS ESTADO_ENVIO FROM tbPedidos pedidos	INNER JOIN [dbo].[tbDirecciones] direc
ON		pedidos.pedi_DireccionID = direc.direc_ID			INNER JOIN [dbo].[tbClientes]	clientes
ON		direc.direc_ClienteID = clientes.client_ID			INNER JOIN [dbo].[tbEstadoEnvios] estadoenvio
ON		pedidos.estv_Id = estadoenvio.estv_Id				INNER JOIN	[dbo].[tbEmpleados] empleados
ON		pedidos.emp_Id = empleados.emp_Id
WHERE	clientes.client_ID = @Cliente_ID
)
GO
SELECT * FROM UDF_PedidosPorCliente(2)
GO
CREATE FUNCTION UDF_ArticulosPorPedido(@PedidoCode VARCHAR(6))
RETURNS TABLE
AS
RETURN
(
	SELECT T3.pedi_Code AS PEDIDO, t2.art_Descripcion  AS ARTICULO, t1.det_Cantidad AS CANTIDAD FROM tbPedidoDetalles T1 INNER JOIN [dbo].[tbArticulos]  T2
		ON t1.art_ID = t2.art_ID INNER JOIN [dbo].[tbPedidos] t3
		ON T1.pedi_ID = T3.pedi_ID
		WHERE T3.pedi_Code = @PedidoCode
)
GO

SELECT * FROM UDF_ArticulosPorPedido('CSA01')

SELECT * FROM tbPedidoDetalles
SELECT * FROM tbPedidos