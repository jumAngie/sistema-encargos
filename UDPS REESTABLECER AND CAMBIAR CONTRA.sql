USE DBArticulosEncargos

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






 