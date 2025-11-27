-- Calcula el monto total que ingresó por una venta "id_venta_param".
CREATE OR REPLACE FUNCTION sc_cafeteria.calcular_total_venta(id_venta_param INT)
RETURNS NUMERIC AS $$
DECLARE
    total NUMERIC := 0;
BEGIN
    SELECT SUM(v.cantidad * p.precio)
    INTO total
    FROM sc_cafeteria.ventas v
    JOIN sc_cafeteria.productos p ON v.id_producto = p.id_producto
    WHERE v.id_venta = id_venta_param;

    RETURN total;
END;
$$ LANGUAGE plpgsql;

-- Registrar una venta (versión 1). Retorna el monto$ de la venta
CREATE OR REPLACE FUNCTION sc_cafeteria.registrar_venta(
    p_id_cliente   integer,
    p_id_producto  integer,
    p_cantidad     integer
) 
RETURNS numeric
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_venta          integer;
    v_total             numeric;
    v_stock_disponible  integer;
BEGIN
    -- 1) Verificar que exista el producto y obtener stock actual
    SELECT stock
    INTO v_stock_disponible
    FROM sc_cafeteria.productos
    WHERE id_producto = p_id_producto;

    IF v_stock_disponible IS NULL THEN
        RAISE EXCEPTION 'Producto % no existe', p_id_producto;
    END IF;

    -- 2) Validar stock suficiente
    IF v_stock_disponible < p_cantidad THEN
        RAISE EXCEPTION 'Stock insuficiente. Disponible: %, solicitado: %',
            v_stock_disponible, p_cantidad;
    END IF;

    -- 3) Insertar la venta
    INSERT INTO sc_cafeteria.ventas (id_cliente, id_producto, cantidad)
    VALUES (p_id_cliente, p_id_producto, p_cantidad)
    RETURNING id_venta INTO v_id_venta;

    -- (Aquí se ejecuta el trigger trg_descontar_stock)

    -- 4) Calcular el total usando la función ya existente
    SELECT sc_cafeteria.calcular_total_venta(v_id_venta)
    INTO v_total;

    RETURN v_total;
END;
$$;
