IF OBJECT_ID('ControlStock','P') IS NOT NULL DROP PROC ControlStock

  GO

  --CREATE TRIGGER  ControlStock

  --ON tbPedidoDetalles INSTEAD  OF INSERT -- Tenemos que comprobar el stock antes de que se realice  la inserción

  --AS

  --BEGIN

  --      INSERT INTO tbPedidoDetalles (pedi_ID,art_ID,det_Cantidad)

  --            SELECT T1.art_ID, art_Stock  

  --            FROM tbArticulos T1  INNER JOIN Inserted  ON t1.art_ID= (SELECT art_ID FROM tbPedidoDetalles)

  --            WHERE det_Cantidad-art_Stock  >= 0

  --            -- Si existencias-cant < 0 es que no hay suficiente  stock, por lo que no se insertará el pedido.

  --END;

  --GO

  SELECT 'Antes',* FROM productos WHERE idfab='bic' AND idproducto=41003; -- Para comprobar las existencias del producto

  INSERT INTO  Pedidos (numpedido,fechapedido,rep,fab,producto,clie,cant,importe) 

                    VALUES (010101123,GETDATE(),108,'bic',41003,2103,10,1000);

        -- Intentamos insertar un pedido de 10 unidades del  producto en cuestion (no hay suficiente stock).

        SELECT 'Después  INSERT',* FROM  productos WHERE idfab='bic' AND idproducto=41003;

        -- Comprobamos que el campo  existencia no se ha reducido   

        SELECT 'Después INSERT',* FROM pedidos WHERE numpedido=010101123;

        -- Comprobamos que el pedido no se ha introducido    

  INSERT INTO  Pedidos (numpedido,fechapedido,rep,fab,producto,clie,cant,importe) 

                    VALUES (010101123,GETDATE(),108,'bic',41003,2103,2,1000);

        -- Intentamos insertar un pedido de 2 unidades del producto  en cuestion (hay suficiente stock).

        SELECT 'Después  INSERT',* FROM  productos WHERE idfab='bic' AND idproducto=41003;

        -- Comprobamos que el campo  existencia se ha reducidoen 2 unidades (por el otro trigger)

        SELECT 'Después INSERT',* FROM pedidos WHERE numpedido=010101123;

        -- Comprobamos que el pedido ahora sí se ha introducido