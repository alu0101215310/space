--Cada vez que se inserte una estrella en la tabla estrella, se debe actualizar la cantidad de estrellas de la constelación correspondiente.
CREATE FUNCTION update_constelacion_estrellas() RETURNS TRIGGER AS $$
BEGIN
    UPDATE constelacion SET cantidad_estrellas = (SELECT COUNT(*) FROM estrella WHERE nombre_constelacion = NEW.nombre_constelacion) 
    WHERE nombre_constelacion = NEW.nombre_constelacion;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_estrellas_constelacion
AFTER INSERT ON estrella
FOR EACH ROW
EXECUTE FUNCTION update_constelacion_estrellas();

--Cada vez que se inserte un planeta en la tabla planeta, se debe actualizar la cantidad de planetas del sistema planetario correspondiente.
CREATE FUNCTION update_sistema_planetario_planetas() RETURNS TRIGGER AS $$
BEGIN
    UPDATE sistema_planetario SET cantidad_planetas = (SELECT COUNT(*) FROM planeta WHERE nombre_sistema = NEW.nombre_sistema) 
    WHERE nombre_sistema = NEW.nombre_sistema;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--Cada vez que se inserte un meteorito o cometa, se debe insetar en la tabla asteroide con su nombre y tamaño.
CREATE TRIGGER update_planetas_sistema_planetario
AFTER INSERT ON planeta
FOR EACH ROW
EXECUTE FUNCTION update_sistema_planetario_planetas();


-- Cada vez que se inserte un meteorito en la tabla meteorito y su planeta de colisión sea la Tierra, se debe insertar en la tabla meteoritos_tierra con su nombre, fecha y peligrosidad.
CREATE FUNCTION insert_meteorito_tierra() RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        IF (NEW.nombre_planeta = 'La Tierra') THEN
            CASE
                WHEN NEW.tamaño <= 3 THEN INSERT INTO meteoritos_tierra (nombre_meteorito, fecha, peligrosidad) VALUES (NEW.nombre_asteroide, NOW(), 1);
                WHEN NEW.tamaño <= 6 THEN INSERT INTO meteoritos_tierra (nombre_meteorito, fecha, peligrosidad) VALUES (NEW.nombre_asteroide, NOW(), 2);
                WHEN NEW.tamaño <= 9 THEN INSERT INTO meteoritos_tierra (nombre_meteorito, fecha, peligrosidad) VALUES (NEW.nombre_asteroide, NOW(), 3);
                WHEN NEW.tamaño <= 12 THEN INSERT INTO meteoritos_tierra (nombre_meteorito, fecha, peligrosidad) VALUES (NEW.nombre_asteroide, NOW(), 4);
                WHEN NEW.tamaño <= 15 THEN INSERT INTO meteoritos_tierra (nombre_meteorito, fecha, peligrosidad) VALUES (NEW.nombre_asteroide, NOW(), 5);
                WHEN NEW.tamaño <= 18 THEN INSERT INTO meteoritos_tierra (nombre_meteorito, fecha, peligrosidad) VALUES (NEW.nombre_asteroide, NOW(), 6);
                WHEN NEW.tamaño <= 25 THEN INSERT INTO meteoritos_tierra (nombre_meteorito, fecha, peligrosidad) VALUES (NEW.nombre_asteroide, NOW(), 7);
                WHEN NEW.tamaño <= 40 THEN INSERT INTO meteoritos_tierra (nombre_meteorito, fecha, peligrosidad) VALUES (NEW.nombre_asteroide, NOW(), 8);
                WHEN NEW.tamaño <= 60 THEN INSERT INTO meteoritos_tierra (nombre_meteorito, fecha, peligrosidad) VALUES (NEW.nombre_asteroide, NOW(), 9);
                WHEN NEW.tamaño > 60 THEN INSERT INTO meteoritos_tierra (nombre_meteorito, fecha, peligrosidad) VALUES (NEW.nombre_asteroide, NOW(), 10);
            END CASE;
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insert_meteorito_tierra
AFTER INSERT ON meteorito
FOR EACH ROW
EXECUTE FUNCTION insert_meteorito_tierra();

--Cada vez que se detecta un cometa se guarda la fecha en la que se detectó
CREATE FUNCTION insert_cometa_detectado() RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        INSERT INTO cometa_detectados (nombre_cometa, fecha) VALUES (NEW.nombre_asteroide, NOW());
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insert_cometa_detectado
AFTER INSERT ON cometa
FOR EACH ROW
EXECUTE FUNCTION insert_cometa_detectado();

