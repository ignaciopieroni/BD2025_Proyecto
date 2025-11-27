CREATE OR REPLACE VIEW sc_cafeteria.vista_ventas_por_producto AS
SELECT p.nombre AS producto,
       SUM(v.cantidad) AS total_vendido
FROM sc_cafeteria.ventas v
JOIN sc_cafeteria.productos p ON v.id_producto = p.id_producto
GROUP BY p.nombre;