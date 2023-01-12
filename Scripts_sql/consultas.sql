SELECT * FROM planeta;
SELECT * FROM planeta WHERE nombre_sistema = 'Sistema Solar';

--prueba del disparador que guarda los metoritos con la fecha y peligrosidad cuando se inserta en la tabla meteorito
INSERT INTO asteroide (nombre_asteroide, tamaño) VALUES ('Rita', 18);
INSERT INTO meteorito (nombre_asteroide, nombre_planeta, tamaño) VALUES ('Rita', 'La Tierra', 18);
SELECT * FROM meteoritos_tierra;
--prueba del disparador que actualiza la cantidad de estrellas de una constelación
INSERT INTO estrella(nombre_estrella, nombre_constelacion, tamaño, edad) VALUES ('Hadar', 'Centaurus', 907280, 700203653);
SELECT * FROM constelacion;
--prueba del disparador que actualiza la cantidad de planetas de un sistema planetario
INSERT INTO planeta(nombre_planeta, nombre_estrella, nombre_sistema, tamaño, orbita) 
VALUES ('Mercurio', 'Sol', 'Sistema Solar', 12932, 'Circular');
SELECT * FROM sistema_planetario;
--prueba para el disparador que guarda la fecha cuando un cometa se detecta
INSERT INTO asteroide (nombre_asteroide, tamaño) VALUES ('Timo', 18);
INSERT INTO cometa (nombre_asteroide, nombre_sistema, tamaño_estela, tamaño) VALUES ('Timo', 'Sistema Solar', 14,101);
SELECT * FROM cometas_detectados;

--prueba para comprobar los check de numeros negativos
UPDATE sistema_planetario SET cantidad_planetas = -10 WHERE nombre_sistema = 'Proxima';
INSERT INTO agujero_negro(nombre_agujero, distancia, tamaño_horizonte) VALUES ('Tigris A*', '46 mil años luz', -39129)

--prueba de eliminacion en cascada
DELETE FROM constelacion WHERE nombre_constelacion = 'Centaurus';
SELECT * FROM planeta;
