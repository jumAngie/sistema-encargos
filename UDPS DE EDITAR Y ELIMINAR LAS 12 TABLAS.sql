-------------------------------------------- TABLA ARTICULOS ----------------------------------------------

CREATE OR ALTER PROCEDURE UDP_Editar_Articulos
		@art_ID				INT, 
		@art_Descripcion	NVARCHAR(200), 
		@fab_ID				INT, 
		@art_Stock			INT,
		@art_UsuarioMod		VARCHAR(50)
AS
BEGIN
		UPDATE	tbArticulos
		SET		[art_Descripcion] = @art_Descripcion , [fab_ID] = @fab_ID, [art_Stock] = @art_Stock,
				[art_UsuarioCreador] = @art_UsuarioMod
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

-------------------------------------------- TABLA CIUDADES ----------------------------------------------