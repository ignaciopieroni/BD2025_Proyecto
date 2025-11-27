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
