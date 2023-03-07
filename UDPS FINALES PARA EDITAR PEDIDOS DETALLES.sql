CREATE OR ALTER PROCEDURE UDP_CARGARCODIGOSDet
AS
BEGIN
SELECT pedi_ID, pedi_Code FROM tbPedidos WHERE pedi_Estado = 1
END

EXEC UDP_CARGARCODIGOSDet

go
CREATE OR ALTER PROCEDURE UDP_CARGARDETALLE
		@ID INT
AS
BEGIN
	SELECT det.pedi_ID, pedi.pedi_Code, det.art_ID, arti.art_Descripcion, det.det_Cantidad  FROM tbPedidoDetalles det INNER JOIN tbPedidos pedi
	ON	det.pedi_ID = pedi.pedi_ID INNER JOIN tbArticulos arti
	ON  det.art_ID = arti.art_ID
	WHERE det.det_Id = @ID AND det_Estado = 1
END

GO

CREATE OR ALTER PROCEDURE UDP_CARGARARTICULOSDet
AS
BEGIN
	SELECT art_ID, art_Descripcion FROM tbArticulos WHERE art_Estado = 1
END