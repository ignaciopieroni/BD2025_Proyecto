-- Esquema de base de datos: cafeteria

DROP TABLE IF EXISTS sc_cafeteria.clientes;
CREATE TABLE sc_cafeteria.clientes (
    id_cliente SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE,
    fecha_alta DATE DEFAULT CURRENT_DATE
);

DROP TABLE IF EXISTS  sc_cafeteria.productos;
CREATE TABLE sc_cafeteria.productos (
    id_producto SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio NUMERIC(10,2) NOT NULL,
    stock INTEGER NOT NULL CHECK (stock >= 0)
);

DROP TABLE IF EXISTS sc_cafeteria.empleados;
CREATE TABLE sc_cafeteria.empleados (
    id_empleado SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    puesto VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS sc_cafeteria.ventas;
CREATE TABLE sc_cafeteria.ventas (
    id_venta SERIAL PRIMARY KEY,
    id_cliente INTEGER NOT NULL,
    id_producto INTEGER NOT NULL,
    cantidad INTEGER NOT NULL CHECK (cantidad > 0),
    fecha TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (id_cliente) REFERENCES sc_cafeteria.clientes(id_cliente),
    FOREIGN KEY (id_producto) REFERENCES sc_cafeteria.productos(id_producto)
);
