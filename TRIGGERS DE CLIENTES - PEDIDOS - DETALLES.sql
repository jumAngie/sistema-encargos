
go
CREATE OR ALTER TRIGGER tg_EliminarCliente 
ON tbClientes
AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON;
	IF UPDATE(client_Estado)
	BEGIN
		
		UPDATE	tbPedidos
		SET		pedi_Estado = 0, [pedi_UsuarioMod] = (SELECT [client_UsuarioMod] FROM inserted),  [pedi_FechaMod]= GETDATE()
		WHERE	pedi_DireccionID = (SELECT direc_ID FROM tbDirecciones WHERE direc_ClienteID = 
				(SELECT client_ID FROM inserted))
		AND		(SELECT client_Estado from inserted) = 0
	END
END

go
CREATE OR ALTER TRIGGER tg_EliminarDetalles 
ON tbPedidos
FOR UPDATE
AS
BEGIN
	SET NOCOUNT ON;
	IF UPDATE([pedi_Estado])
	BEGIN
		UPDATE	tbPedidoDetalles
		SET		[det_Estado] = 0, 
				[det_UsuModif] = (select distinct [pedi_UsuarioMod] FROM inserted), 
				[det_FechaModif] = GETDATE()
		FROM	tbPedidoDetalles
		INNER JOIN inserted ON tbPedidoDetalles.pedi_ID = inserted.pedi_ID
		WHERE	tbPedidoDetalles.pedi_ID IN (SELECT pedi_ID FROM inserted)
		AND		(SELECT pedi_Estado FROM inserted) = 0
	END
END



GO
CREATE OR ALTER TRIGGER tg_EliminarUsuario 
ON [dbo].[tbEmpleados]
AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON;
	IF UPDATE([emp_Estado])
	BEGIN
		UPDATE	tbUsuarios
		SET		usu_Estado = 0, 
				usu_UsuarioMod = inserted.emp_UsuModif, 
				usu_FechaMod = GETDATE()
		FROM	tbUsuarios
		INNER JOIN inserted ON tbUsuarios.emp_Id = inserted.emp_Id
		WHERE	tbUsuarios.emp_Id IN (SELECT emp_Id FROM inserted)
		AND		inserted.emp_Estado = 0
	END
END

Select * from tbEmpleados
SELECT * FROM tbUsuarios

EXEC UDP_Eliminar_Empleados 3,2

EXEC UDP_Editar_Clientes 2,'Maria Sol', '0512-1995-00934', 'C','F','95-887090','45000','6000','0.02',2

SELECT * FROM	tbPedidos pedi
INNER JOIN		[dbo].[tbDirecciones] dire
on pedi.pedi_DireccionID = dire.direc_ID
INNER JOIN		[dbo].[tbClientes] client
on	dire.direc_ClienteID = client_ID
WHERE client.client_ID = 2