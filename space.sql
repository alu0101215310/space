DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

DROP TABLE IF EXISTS estrella;
DROP TABLE IF EXISTS planeta;
DROP TABLE IF EXISTS satelite;
DROP TABLE IF EXISTS constelacion;
DROP TABLE IF EXISTS agujero_negro;
DROP TABLE IF EXISTS galaxia;
DROP TABLE IF EXISTS nebulosa;
DROP TABLE IF EXISTS sistema_solar;
DROP TABLE IF EXISTS asteroide;
DROP TABLE IF EXISTS cometa;
DROP TABLE IF EXISTS meteorito;
DROP TABLE IF EXISTS cinturon;

CREATE TABLE estrella(
    nombre_estrella VARCHAR(30),
    tamaño INT,
    edad INT,
    PRIMARY KEY(nombre_estrella)
);

CREATE TABLE planeta(
    nombre_planeta VARCHAR(30),
    nombre_estrella VARCHAR(30),
    tamaño INT,
    orbita INT,
    PRIMARY KEY(nombre_planeta),
    CONSTRAINT no_estrella
        FOREIGN KEY(nombre_estrella)
            REFERENCES estrella(nombre_estrella)
                ON DELETE CASCADE
);

CREATE TABLE satelite(
    nombre_planeta VARCHAR(30),
    nombre_satelite VARCHAR(30),
    tamaño INT,
    PRIMARY KEY(nombre_satelite),
    CONSTRAINT no_planeta
        FOREIGN KEY(nombre_planeta)
            REFERENCES planeta(nombre_planeta)
                ON DELETE CASCADE
);

CREATE TABLE constelacion(
    nombre_constelacion VARCHAR(30),
    coordenadas VARCHAR(30),
    PRIMARY KEY(nombre_constelacion)
);

CREATE TABLE agujero_negro(
    nombre_agujero VARCHAR(30),
    coordenadas VARCHAR(30),
    tamaño INT,
    tamaño_horizonte INT,
    PRIMARY KEY(nombre_agujero, coordenadas)
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
    CONSTRAINT no_galaxia
        FOREIGN KEY(nombre_galaxia)
            REFERENCES galaxia(nombre_galaxia)
                ON DELETE CASCADE
);

CREATE TABLE sistema_solar(
    nombre_sistema VARCHAR(30),
    nombre_estrella VARCHAR(30),
    nombre_galaxia VARCHAR(30),
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
    forma VARCHAR(30),
    tamaño INT,
    PRIMARY KEY(nombre_asteoride)
);

CREATE TABLE cometa(
    nombre_asteroide VARCHAR(30),
    nombre_sistema VARCHAR(30),
    tamaño_estela INT,
    velocidad INT,
    CONSTRAINT no_sistema_solar
        FOREIGN KEY(nombre_sistema)
            REFERENCES sistema_solar(nombre_sistema)
                ON DELETE CASCADE,
    CONSTRAINT no_asteroide
        FOREIGN KEY(nombre_asteroide)
            REFERENCES asteroide(nombre_asteoride)
                ON DELETE CASCADE
);

CREATE TABLE meteorito(
    nombre_asteroide VARCHAR(30),
    nombre_planeta VARCHAR(30),
    velocidad INT,
    CONSTRAINT no_planeta
        FOREIGN KEY(nombre_planeta)
            REFERENCES planeta(nombre_planeta)
                ON DELETE CASCADE,
    CONSTRAINT no_asteroide
        FOREIGN KEY(nombre_asteroide)
            REFERENCES asteroide(nombre_asteoride)
                ON DELETE CASCADE
);

CREATE TABLE cinturon(
    nombre_cinturon VARCHAR(30),
    nombre_estrella VARCHAR(30),
    velocidad VARCHAR(30),
    tamaño INT,
    PRIMARY KEY(nombre_cinturón),
    CONSTRAINT no_estrella
        FOREIGN KEY(nombre_estrella)
            REFERENCES estrella(nombre_estrella)
                ON DELETE CASCADE
);
