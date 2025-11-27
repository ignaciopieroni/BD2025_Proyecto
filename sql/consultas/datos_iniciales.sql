-- ==============================
-- DATOS INICIALES - CAFETERIA
-- ==============================

-- CLIENTES
INSERT INTO sc_cafeteria.clientes (nombre, email, fecha_alta) VALUES
('María López',      'maria.lopez@example.com',      '2025-01-10'),
('Juan Pérez',       'juan.perez@example.com',       '2025-02-03'),
('Ana González',     'ana.gonzalez@example.com',     '2025-02-15'),
('Carlos Ramírez',   'carlos.ramirez@example.com',   '2025-03-01'),
('Lucía Fernández',  'lucia.fernandez@example.com',  '2025-03-20');

-- PRODUCTOS
INSERT INTO sc_cafeteria.productos (nombre, precio, stock) VALUES
('Café espresso',          3000.00,  200),
('Café latte',             3500.00,  150),
('Medialuna',              500.00,  300),
('Tostado jamón y queso', 1300.00,  100),
('Jugo de naranja',        1000.00,   80),
('Budín de limón',         700.00,   60);

-- EMPLEADOS
INSERT INTO sc_cafeteria.empleados (nombre, puesto) VALUES
('Sofía Martínez',  'Cajera'),
('Diego Torres',    'Barista'),
('Paula Herrera',   'Moza'),
('Lucas Díaz',      'Encargado');

-- VENTAS
-- Ojo: estos INSERT asumen que:
--  - Los clientes se insertaron en el orden anterior → id_cliente de 1 a 5
--  - Los productos se insertaron en el orden anterior → id_producto de 1 a 6

INSERT INTO sc_cafeteria.ventas (id_cliente, id_producto, cantidad, fecha) VALUES
(1, 1, 1, '2025-04-01 08:30:00'),   -- María compra 1 café espresso
(1, 3, 2, '2025-04-01 08:31:00'),   -- María compra 2 medialunas
(2, 2, 1, '2025-04-01 09:10:00'),   -- Juan compra 1 café latte
(2, 4, 1, '2025-04-01 09:11:00'),   -- Juan compra 1 tostado
(3, 5, 2, '2025-04-01 10:05:00'),   -- Ana compra 2 jugos de naranja
(3, 3, 1, '2025-04-01 10:06:00'),   -- Ana compra 1 medialuna
(4, 1, 1, '2025-04-02 08:45:00'),   -- Carlos compra 1 espresso
(4, 6, 1, '2025-04-02 08:46:00'),   -- Carlos compra 1 budín
(5, 2, 1, '2025-04-02 11:20:00'),   -- Lucía compra 1 latte
(5, 3, 3, '2025-04-02 11:21:00'),   -- Lucía compra 3 medialunas
(1, 5, 1, '2025-04-03 08:40:00'),   -- María compra 1 jugo
(2, 6, 2, '2025-04-03 09:15:00');   -- Juan compra 2 budines
