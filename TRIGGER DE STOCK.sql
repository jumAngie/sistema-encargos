CREATE TRIGGER tg_ActualizarStock ON tbPedidoDetalles
AFTER INSERT 
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE		tbArticulos SET art_Stock = art_Stock - (SELECT det_Cantidad from inserted)
	WHERE		art_ID = (Select art_ID from inserted)
END;

EXEC UDP_PEDIDO_DETALLE 2, 3, 2, 1

SELECT * FROM tbPedidoDetalles WHERE art_ID = 3
SELECT * FROM tbArticulos

--ALTER TABLE tbPedidoDetalles ADD CONSTRAINT fk_Cantidad CHECK (det_Cantidad <= tbArticulos.art_Stock)
--REFERENCES tbArticulos(art_ID) 
--ON UPDATE CASCADE ON DELETE CASCADE;