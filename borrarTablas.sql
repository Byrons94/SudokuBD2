-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2015-11-22 15:57:13.037






-- foreign keys
ALTER TABLE Incognitas DROP CONSTRAINT Casillas_Partidas;

ALTER TABLE Incognitas DROP CONSTRAINT Casillas_Posiciones;

ALTER TABLE Partidas DROP CONSTRAINT Partidas_Plantillas;

ALTER TABLE Partidas DROP CONSTRAINT Partidas_Usuarios;

ALTER TABLE Pistas DROP CONSTRAINT Pistas_Plantillas;

ALTER TABLE Pistas DROP CONSTRAINT Pistas_Posiciones;





-- tables
DROP TABLE Incognitas;
DROP TABLE Probabilidades;
DROP TABLE Partidas;
DROP TABLE Pistas;
DROP TABLE Plantillas;
DROP TABLE Posiciones;
DROP TABLE Usuarios;




-- End of file.

