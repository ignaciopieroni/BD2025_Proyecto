--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

-- Started on 2025-11-27 15:28:54

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 6 (class 2615 OID 90722)
-- Name: sc_cafeteria; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA sc_cafeteria;


ALTER SCHEMA sc_cafeteria OWNER TO postgres;

--
-- TOC entry 228 (class 1255 OID 91169)
-- Name: calcular_total_venta(integer); Type: FUNCTION; Schema: sc_cafeteria; Owner: postgres
--

CREATE FUNCTION sc_cafeteria.calcular_total_venta(id_venta_param integer) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION sc_cafeteria.calcular_total_venta(id_venta_param integer) OWNER TO postgres;

--
-- TOC entry 227 (class 1255 OID 91167)
-- Name: descontar_stock(); Type: FUNCTION; Schema: sc_cafeteria; Owner: postgres
--

CREATE FUNCTION sc_cafeteria.descontar_stock() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE sc_cafeteria.productos
    SET stock = stock - NEW.cantidad
    WHERE id_producto = NEW.id_producto;

    RETURN NEW;
END;
$$;


ALTER FUNCTION sc_cafeteria.descontar_stock() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 219 (class 1259 OID 91116)
-- Name: clientes; Type: TABLE; Schema: sc_cafeteria; Owner: postgres
--

CREATE TABLE sc_cafeteria.clientes (
    id_cliente integer NOT NULL,
    nombre character varying(100) NOT NULL,
    email character varying(150),
    fecha_alta date DEFAULT CURRENT_DATE
);


ALTER TABLE sc_cafeteria.clientes OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 91115)
-- Name: clientes_id_cliente_seq; Type: SEQUENCE; Schema: sc_cafeteria; Owner: postgres
--

CREATE SEQUENCE sc_cafeteria.clientes_id_cliente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sc_cafeteria.clientes_id_cliente_seq OWNER TO postgres;

--
-- TOC entry 4936 (class 0 OID 0)
-- Dependencies: 218
-- Name: clientes_id_cliente_seq; Type: SEQUENCE OWNED BY; Schema: sc_cafeteria; Owner: postgres
--

ALTER SEQUENCE sc_cafeteria.clientes_id_cliente_seq OWNED BY sc_cafeteria.clientes.id_cliente;


--
-- TOC entry 223 (class 1259 OID 91134)
-- Name: empleados; Type: TABLE; Schema: sc_cafeteria; Owner: postgres
--

CREATE TABLE sc_cafeteria.empleados (
    id_empleado integer NOT NULL,
    nombre character varying(100) NOT NULL,
    puesto character varying(50) NOT NULL
);


ALTER TABLE sc_cafeteria.empleados OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 91133)
-- Name: empleados_id_empleado_seq; Type: SEQUENCE; Schema: sc_cafeteria; Owner: postgres
--

CREATE SEQUENCE sc_cafeteria.empleados_id_empleado_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sc_cafeteria.empleados_id_empleado_seq OWNER TO postgres;

--
-- TOC entry 4937 (class 0 OID 0)
-- Dependencies: 222
-- Name: empleados_id_empleado_seq; Type: SEQUENCE OWNED BY; Schema: sc_cafeteria; Owner: postgres
--

ALTER SEQUENCE sc_cafeteria.empleados_id_empleado_seq OWNED BY sc_cafeteria.empleados.id_empleado;


--
-- TOC entry 221 (class 1259 OID 91126)
-- Name: productos; Type: TABLE; Schema: sc_cafeteria; Owner: postgres
--

CREATE TABLE sc_cafeteria.productos (
    id_producto integer NOT NULL,
    nombre character varying(100) NOT NULL,
    precio numeric(10,2) NOT NULL,
    stock integer NOT NULL,
    CONSTRAINT productos_stock_check CHECK ((stock >= 0))
);


ALTER TABLE sc_cafeteria.productos OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 91125)
-- Name: productos_id_producto_seq; Type: SEQUENCE; Schema: sc_cafeteria; Owner: postgres
--

CREATE SEQUENCE sc_cafeteria.productos_id_producto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sc_cafeteria.productos_id_producto_seq OWNER TO postgres;

--
-- TOC entry 4938 (class 0 OID 0)
-- Dependencies: 220
-- Name: productos_id_producto_seq; Type: SEQUENCE OWNED BY; Schema: sc_cafeteria; Owner: postgres
--

ALTER SEQUENCE sc_cafeteria.productos_id_producto_seq OWNED BY sc_cafeteria.productos.id_producto;


--
-- TOC entry 225 (class 1259 OID 91141)
-- Name: ventas; Type: TABLE; Schema: sc_cafeteria; Owner: postgres
--

CREATE TABLE sc_cafeteria.ventas (
    id_venta integer NOT NULL,
    id_cliente integer NOT NULL,
    id_producto integer NOT NULL,
    cantidad integer NOT NULL,
    fecha timestamp without time zone DEFAULT now(),
    CONSTRAINT ventas_cantidad_check CHECK ((cantidad > 0))
);


ALTER TABLE sc_cafeteria.ventas OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 91140)
-- Name: ventas_id_venta_seq; Type: SEQUENCE; Schema: sc_cafeteria; Owner: postgres
--

CREATE SEQUENCE sc_cafeteria.ventas_id_venta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sc_cafeteria.ventas_id_venta_seq OWNER TO postgres;

--
-- TOC entry 4939 (class 0 OID 0)
-- Dependencies: 224
-- Name: ventas_id_venta_seq; Type: SEQUENCE OWNED BY; Schema: sc_cafeteria; Owner: postgres
--

ALTER SEQUENCE sc_cafeteria.ventas_id_venta_seq OWNED BY sc_cafeteria.ventas.id_venta;


--
-- TOC entry 226 (class 1259 OID 91159)
-- Name: vista_ventas_por_producto; Type: VIEW; Schema: sc_cafeteria; Owner: postgres
--

CREATE VIEW sc_cafeteria.vista_ventas_por_producto AS
 SELECT p.nombre AS producto,
    sum(v.cantidad) AS total_vendido
   FROM (sc_cafeteria.ventas v
     JOIN sc_cafeteria.productos p ON ((v.id_producto = p.id_producto)))
  GROUP BY p.nombre;


ALTER VIEW sc_cafeteria.vista_ventas_por_producto OWNER TO postgres;

--
-- TOC entry 4764 (class 2604 OID 91119)
-- Name: clientes id_cliente; Type: DEFAULT; Schema: sc_cafeteria; Owner: postgres
--

ALTER TABLE ONLY sc_cafeteria.clientes ALTER COLUMN id_cliente SET DEFAULT nextval('sc_cafeteria.clientes_id_cliente_seq'::regclass);


--
-- TOC entry 4767 (class 2604 OID 91137)
-- Name: empleados id_empleado; Type: DEFAULT; Schema: sc_cafeteria; Owner: postgres
--

ALTER TABLE ONLY sc_cafeteria.empleados ALTER COLUMN id_empleado SET DEFAULT nextval('sc_cafeteria.empleados_id_empleado_seq'::regclass);


--
-- TOC entry 4766 (class 2604 OID 91129)
-- Name: productos id_producto; Type: DEFAULT; Schema: sc_cafeteria; Owner: postgres
--

ALTER TABLE ONLY sc_cafeteria.productos ALTER COLUMN id_producto SET DEFAULT nextval('sc_cafeteria.productos_id_producto_seq'::regclass);


--
-- TOC entry 4768 (class 2604 OID 91144)
-- Name: ventas id_venta; Type: DEFAULT; Schema: sc_cafeteria; Owner: postgres
--

ALTER TABLE ONLY sc_cafeteria.ventas ALTER COLUMN id_venta SET DEFAULT nextval('sc_cafeteria.ventas_id_venta_seq'::regclass);


--
-- TOC entry 4773 (class 2606 OID 91124)
-- Name: clientes clientes_email_key; Type: CONSTRAINT; Schema: sc_cafeteria; Owner: postgres
--

ALTER TABLE ONLY sc_cafeteria.clientes
    ADD CONSTRAINT clientes_email_key UNIQUE (email);


--
-- TOC entry 4775 (class 2606 OID 91122)
-- Name: clientes clientes_pkey; Type: CONSTRAINT; Schema: sc_cafeteria; Owner: postgres
--

ALTER TABLE ONLY sc_cafeteria.clientes
    ADD CONSTRAINT clientes_pkey PRIMARY KEY (id_cliente);


--
-- TOC entry 4779 (class 2606 OID 91139)
-- Name: empleados empleados_pkey; Type: CONSTRAINT; Schema: sc_cafeteria; Owner: postgres
--

ALTER TABLE ONLY sc_cafeteria.empleados
    ADD CONSTRAINT empleados_pkey PRIMARY KEY (id_empleado);


--
-- TOC entry 4777 (class 2606 OID 91132)
-- Name: productos productos_pkey; Type: CONSTRAINT; Schema: sc_cafeteria; Owner: postgres
--

ALTER TABLE ONLY sc_cafeteria.productos
    ADD CONSTRAINT productos_pkey PRIMARY KEY (id_producto);


--
-- TOC entry 4781 (class 2606 OID 91148)
-- Name: ventas ventas_pkey; Type: CONSTRAINT; Schema: sc_cafeteria; Owner: postgres
--

ALTER TABLE ONLY sc_cafeteria.ventas
    ADD CONSTRAINT ventas_pkey PRIMARY KEY (id_venta);


--
-- TOC entry 4784 (class 2620 OID 91168)
-- Name: ventas trg_descontar_stock; Type: TRIGGER; Schema: sc_cafeteria; Owner: postgres
--

CREATE TRIGGER trg_descontar_stock AFTER INSERT ON sc_cafeteria.ventas FOR EACH ROW EXECUTE FUNCTION sc_cafeteria.descontar_stock();


--
-- TOC entry 4782 (class 2606 OID 91149)
-- Name: ventas ventas_id_cliente_fkey; Type: FK CONSTRAINT; Schema: sc_cafeteria; Owner: postgres
--

ALTER TABLE ONLY sc_cafeteria.ventas
    ADD CONSTRAINT ventas_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES sc_cafeteria.clientes(id_cliente);


--
-- TOC entry 4783 (class 2606 OID 91154)
-- Name: ventas ventas_id_producto_fkey; Type: FK CONSTRAINT; Schema: sc_cafeteria; Owner: postgres
--

ALTER TABLE ONLY sc_cafeteria.ventas
    ADD CONSTRAINT ventas_id_producto_fkey FOREIGN KEY (id_producto) REFERENCES sc_cafeteria.productos(id_producto);


-- Completed on 2025-11-27 15:28:55

--
-- PostgreSQL database dump complete
--

