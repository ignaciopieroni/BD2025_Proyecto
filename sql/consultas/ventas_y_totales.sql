-- Listar ventas con el nombre del cliente y producto
SELECT c.nombre AS cliente,
       p.nombre AS producto,
       v.cantidad,
       v.fecha
FROM sc_cafeteria.ventas v
JOIN sc_cafeteria.clientes c ON v.id_cliente = c.id_cliente
JOIN sc_cafeteria.productos p ON v.id_producto = p.id_producto;

-- Total vendido por producto
SELECT p.nombre AS producto,
       SUM(v.cantidad) AS total_vendido
FROM sc_cafeteria.ventas v
JOIN sc_cafeteria.productos p ON v.id_producto = p.id_producto
GROUP BY p.nombre;