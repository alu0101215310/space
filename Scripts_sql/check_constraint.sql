    ALTER TABLE constelacion
    ADD CONSTRAINT constelacion_not_null
    CHECK (nombre_constelacion IS NOT NULL);

    ALTER TABLE constelacion
    ADD CONSTRAINT constelacion_cantidad_estrellas_negativo
    CHECK (cantidad_estrellas > 0);

    ALTER TABLE estrella
    ADD CONSTRAINT estrella_not_null
    CHECK (nombre_estrella IS NOT NULL);

    ALTER TABLE estrella
    ADD CONSTRAINT estrella_tamaño_negativo
    CHECK (tamaño > 0);

    ALTER TABLE estrella
    ADD CONSTRAINT estrella_edad_negativo
    CHECK (edad > 0);

    ALTER TABLE planeta
    ADD CONSTRAINT planeta_not_null
    CHECK (nombre_planeta IS NOT NULL);

    ALTER TABLE planeta
    ADD CONSTRAINT planeta_tamaño_negativo
    CHECK (tamaño > 0);

    ALTER TABLE satelite
    ADD CONSTRAINT satelite_not_null
    CHECK (nombre_satelite IS NOT NULL);
    
    ALTER TABLE satelite
    ADD CONSTRAINT satelite_tamaño_negativo
    CHECK (tamaño > 0);

    ALTER TABLE agujero_negro
    ADD CONSTRAINT agujero_negro_not_null
    CHECK (nombre_agujero IS NOT NULL);

    ALTER TABLE sistema_planetario
    ADD CONSTRAINT sistema_planetario_not_null
    CHECK (nombre_sistema IS NOT NULL);

    ALTER TABLE sistema_planetario
    ADD CONSTRAINT sistema_planetario_planetas_negativo
    CHECK (cantidad_planetas > 0);

    ALTER TABLE nebulosa
    ADD CONSTRAINT nebulosa_tamaño_negativo
    CHECK (tamaño > 0);

    ALTER TABLE galaxia
    ADD CONSTRAINT galaxia_not_null
    CHECK (nombre_galaxia IS NOT NULL);

    INSERT INTO constelacion(nombre_constelacion, cantidad_estrellas)
VALUES
    ('Ofiuco', 6),
    ('Centaurus', 9);

INSERT INTO estrella(nombre_estrella, nombre_constelacion, tamaño, edad)
VALUES
    ('Sol', 'Ofiuco', 696340, 4000000603),
    ('Proxima Centauri', 'Centaurus', 107280, 4000000653),
    ('Barnard', 'Ofiuco', 136360, 10000000001);

INSERT INTO planeta(nombre_planeta, nombre_estrella, nombre_sistema, tamaño, orbita)
VALUES
    ('La Tierra', 'Sol', 'Sistema Solar',69340, 'Circular'),
    ('Jupiter', 'Sol', 'Sistema Solar', 21440, 'Circular'),
    ('Proxima D', 'Proxima Centauri', 'Proxima', 69280, 'Elíptica');

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

INSERT INTO cometa(nombre_asteroide, nombre_sistema, tamaño_estela, tamaño)
VALUES
    ('Halley', 'Sistema Solar', 12,101),
    ('Hale-Bop', 'Sistema Solar', 30,32);

INSERT INTO meteorito(nombre_asteroide, nombre_planeta, tamaño)
VALUES
    ('El Chaco', 'La Tierra',5),
    ('Willamette', 'La Tierra', 89);