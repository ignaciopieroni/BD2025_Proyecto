CREATE OR REPLACE FUNCTION sc_cafeteria.descontar_stock()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE sc_cafeteria.productos
    SET stock = stock - NEW.cantidad
    WHERE id_producto = NEW.id_producto;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_descontar_stock
AFTER INSERT ON sc_cafeteria.ventas
FOR EACH ROW
EXECUTE FUNCTION sc_cafeteria.descontar_stock();