DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

DROP TABLE IF EXISTS constelacion;
DROP TABLE IF EXISTS estrella;
DROP TABLE IF EXISTS planeta;
DROP TABLE IF EXISTS satelite;
DROP TABLE IF EXISTS agujero_negro;
DROP TABLE IF EXISTS galaxia;
DROP TABLE IF EXISTS nebulosa;
DROP TABLE IF EXISTS sistema_planetario;
DROP TABLE IF EXISTS asteroide;
DROP TABLE IF EXISTS cometa;
DROP TABLE IF EXISTS meteorito;
DROP TABLE IF EXISTS cinturon;

CREATE TABLE constelacion(
    nombre_constelacion VARCHAR(30),
    cantidad_estrellas BIGINT,
    PRIMARY KEY(nombre_constelacion)
);

CREATE TABLE estrella(
    nombre_estrella VARCHAR(30),
    nombre_constelacion VARCHAR(30),
    tamaño BIGINT,
    edad BIGINT,
    PRIMARY KEY(nombre_estrella),
    CONSTRAINT no_constelacion
        FOREIGN KEY(nombre_constelacion)
            REFERENCES constelacion(nombre_constelacion)
                ON DELETE CASCADE
);

CREATE TABLE planeta(
    nombre_planeta VARCHAR(30),
    nombre_estrella VARCHAR(30),
    tamaño BIGINT,
    orbita VARCHAR(30),
    PRIMARY KEY(nombre_planeta),
    CONSTRAINT no_estrella
        FOREIGN KEY(nombre_estrella)
            REFERENCES estrella(nombre_estrella)
                ON DELETE CASCADE
);

CREATE TABLE satelite(
    nombre_satelite VARCHAR(30),
    nombre_planeta VARCHAR(30),
    tamaño BIGINT,
    PRIMARY KEY(nombre_satelite),
    CONSTRAINT no_planeta
        FOREIGN KEY(nombre_planeta)
            REFERENCES planeta(nombre_planeta)
                ON DELETE CASCADE
);

CREATE TABLE agujero_negro(
    nombre_agujero VARCHAR(30),
    distancia VARCHAR(30),
    tamaño_horizonte BIGINT,
    PRIMARY KEY(nombre_agujero)
);

CREATE TABLE galaxia(
    nombre_galaxia VARCHAR(30),
    nombre_agujero VARCHAR(30),
    PRIMARY KEY(nombre_galaxia),
    CONSTRAINT no_agujero_negro
        FOREIGN KEY(nombre_agujero)
            REFERENCES agujero_negro(nombre_agujero)
                ON DELETE CASCADE
);

CREATE TABLE nebulosa(
    nombre_galaxia VARCHAR(30),
	tamaño BIGINT,
    CONSTRAINT no_galaxia
        FOREIGN KEY(nombre_galaxia)
            REFERENCES galaxia(nombre_galaxia)
                ON DELETE CASCADE
);

CREATE TABLE sistema_planetario(
    nombre_sistema VARCHAR(30),
    nombre_estrella VARCHAR(30),
    nombre_galaxia VARCHAR(30),
    cantidad_planetas BIGINT,
    PRIMARY KEY(nombre_sistema),
    CONSTRAINT no_galaxia
        FOREIGN KEY(nombre_galaxia)
            REFERENCES galaxia(nombre_galaxia)
                ON DELETE CASCADE,
    CONSTRAINT no_estrella
        FOREIGN KEY(nombre_estrella)
            REFERENCES estrella(nombre_estrella)
                ON DELETE CASCADE
);

CREATE TABLE asteroide(
    nombre_asteroide VARCHAR(30),
    tamaño INT,
    PRIMARY KEY(nombre_asteroide)
);

CREATE TABLE cometa(
    nombre_asteroide VARCHAR(30),
    nombre_sistema VARCHAR(30),
    tamaño_estela INT,
    CONSTRAINT no_sistema_planetario
        FOREIGN KEY(nombre_sistema)
            REFERENCES sistema_planetario(nombre_sistema)
                ON DELETE CASCADE,
    CONSTRAINT no_asteroide
        FOREIGN KEY(nombre_asteroide)
            REFERENCES asteroide(nombre_asteroide)
                ON DELETE CASCADE
);

CREATE TABLE meteorito(
    nombre_asteroide VARCHAR(30),
    nombre_planeta VARCHAR(30),
    CONSTRAINT no_planeta
        FOREIGN KEY(nombre_planeta)
            REFERENCES planeta(nombre_planeta)
                ON DELETE CASCADE,
    CONSTRAINT no_asteroide
        FOREIGN KEY(nombre_asteroide)
            REFERENCES asteroide(nombre_asteroide)
                ON DELETE CASCADE
);

CREATE TABLE cinturon(
    nombre_cinturon VARCHAR(30),
    nombre_estrella VARCHAR(30),
    orbita VARCHAR(30),
    PRIMARY KEY(nombre_cinturon),
    CONSTRAINT no_estrella
        FOREIGN KEY(nombre_estrella)
            REFERENCES estrella(nombre_estrella)
                ON DELETE CASCADE
);

INSERT INTO constelacion(nombre_constelacion, cantidad_estrellas)
VALUES
    ('Ofiuco', 6),
    ('Centaurus', 9);

INSERT INTO estrella(nombre_estrella, nombre_constelacion, tamaño, edad)
VALUES
    ('Sol', 'Ofiuco', 696340, 4000000603),
    ('Proxima Centauri', 'Centaurus', 107280, 4000000653),
    ('Barnard', 'Ofiuco', 136360, 10000000001);

INSERT INTO planeta(nombre_planeta, nombre_estrella, tamaño, orbita)
VALUES
    ('La Tierra', 'Sol', 69340, 'Circular'),
    ('Jupiter', 'Sol', 21440, 'Circular'),
    ('Proxima D', 'Proxima Centauri', 69280, 'Elíptica');

INSERT INTO satelite(nombre_satelite, nombre_planeta, tamaño)
VALUES
    ('La Luna', 'La Tierra', 9340),
    ('Europa', 'Jupiter', 1440),
    ('Titán', 'Jupiter', 1130);

INSERT INTO agujero_negro(nombre_agujero, distancia, tamaño_horizonte)
VALUES
    ('Sagitario A*', '26 mil años luz', 40000),
    ('S5 0014+81', '22 mil millones de años luz', 1000000);

INSERT INTO galaxia(nombre_galaxia, nombre_agujero)
VALUES
    ('Via Láctea' , 'Sagitario A*'),
    ('Andrómeda' , 'S5 0014+81'),
    ('Triangulum' , 'S5 0014+81');
    
INSERT INTO nebulosa(nombre_galaxia, tamaño)
VALUES
    ('Via Láctea' , 23230000),
    ('Andrómeda' , 8767000000),
    ('Triangulum' , 15560000000);

INSERT INTO sistema_planetario(nombre_sistema, nombre_estrella, nombre_galaxia, cantidad_planetas)
VALUES
    ('Sistema Solar', 'Sol', 'Via Láctea', 8),
    ('Proxima', 'Proxima Centauri', 'Via Láctea', 3),
    ('Titawin', 'Barnard', 'Triangulum' , 5);

INSERT INTO cinturon(nombre_cinturon, nombre_estrella, orbita)
VALUES
    ('Cinturón principal', 'Sol', 'Circular'),
    ('Cinturón de Kuiper', 'Sol', 'Elíptica');

INSERT INTO asteroide(nombre_asteroide, tamaño)
VALUES
    ('Halley', 45),
    ('Hale-Bop', 59),
    ('El Chaco', 37),
    ('Willamette', 155);

INSERT INTO cometa(nombre_asteroide, nombre_sistema, tamaño_estela)
VALUES
    ('Halley', 'Sistema Solar', 12),
    ('Hale-Bop', 'Sistema Solar', 30);

INSERT INTO meteorito(nombre_asteroide, nombre_planeta)
VALUES
    ('El Chaco', 'La Tierra'),
    ('Willamette', 'La Tierra');
