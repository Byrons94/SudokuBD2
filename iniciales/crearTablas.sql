--**********INICIO DE CREACION DE TABLAS**********
Prompt ******  CREACION DE TABLAS



Prompt ******  INCOGNITAS  ....

CREATE TABLE Incognitas (
    id integer  NOT NULL,
    idPosicion INTEGER NOT NULL,
    idPartida INTEGER NOT NULL,
    numIntento INTEGER NULL,
    valor INTEGER NULL,
    CONSTRAINT Incognitas_pk PRIMARY KEY (id)
);


CREATE SEQUENCE Incognitas_seq;


Prompt ******  PROBABILIDADES  ....

CREATE TABLE Probabilidades (
    idjuego integer      NOT NULL,
    idIncognita integer  NOT NULL,
    numero integer       NOT NULL
);

CREATE SEQUENCE Probabilidades_seq;


Prompt ******  PARTIDAS  ....

CREATE TABLE Partidas (
    id INTEGER NOT NULL,
    idUsuario INTEGER NOT NULL,
    idPlantilla INTEGER NOT NULL,
    tiempoInicio DATE NOT NULL,
    tiempoFin DATE NULL,
    segundos NUMBER(5,2) NULL,
    puntos INTEGER DEFAULT 0 NOT NULL,
    CONSTRAINT Partidas_pk PRIMARY KEY (id)
);

CREATE SEQUENCE Partidas_seq;



Prompt ******  PISTAS  ....

CREATE TABLE Pistas (
    idPosicion INTEGER NOT NULL,
    idPlantilla INTEGER NOT NULL,
    valor INTEGER NOT NULL,
    CONSTRAINT Pistas_pk PRIMARY KEY (idPosicion,idPlantilla)
);



Prompt ******  PLANTILLAS  ....

CREATE TABLE Plantillas (
    id INTEGER NOT NULL,
    nombre VARCHAR2(20) NOT NULL,
    nivel INTEGER NOT NULL,
    CONSTRAINT Plantillas_pk PRIMARY KEY (id)
);

CREATE SEQUENCE Plantillas_seq;



Prompt ******  POSICIONES  ....

CREATE TABLE Posiciones (
    id INTEGER NOT NULL,
    fila INTEGER NOT NULL,
    columna INTEGER NOT NULL,
    cuadrante INTEGER NOT NULL,
    CONSTRAINT Posiciones_pk PRIMARY KEY (id)
);

CREATE SEQUENCE Posiciones_seq;



Prompt ******  USUARIOS  ....

CREATE TABLE Usuarios (
    id INTEGER NOT NULL,
    nombre VARCHAR2(50) NOT NULL,
    correo VARCHAR2(50) NOT NULL,
    apellido VARCHAR2(50) NOT NULL,
    CONSTRAINT Usuarios_pk PRIMARY KEY (id)
);

CREATE SEQUENCE Usuarios_seq
	START WITH 1
	INCREMENT BY 1
	NOCACHE
	NOCYCLE;



--**********FIN DE CREACION DE TABLAS**********




--**********INICIO DE CREACION DE LLAVES FORANEAS**********
Prompt ******  CREACION DE LLAVES FORANEAS



Prompt ******  PARTIDA DE INCOGNITA  ....

ALTER TABLE Incognitas ADD CONSTRAINT Casillas_Partidas
    FOREIGN KEY (idPartida)
    REFERENCES Partidas (id)
    ;



Prompt ******  POSICION DE INCOGNITA  ....

ALTER TABLE Incognitas ADD CONSTRAINT Casillas_Posiciones
    FOREIGN KEY (idPosicion)
    REFERENCES Posiciones (id)
    ;



Prompt ******  PLATILLA DE PARTIDA  ....

ALTER TABLE Partidas ADD CONSTRAINT Partidas_Plantillas
    FOREIGN KEY (idPlantilla)
    REFERENCES Plantillas (id)
    ;



Prompt ******  USUARIO DE INCOGNITA  ....

ALTER TABLE Partidas ADD CONSTRAINT Partidas_Usuarios
    FOREIGN KEY (idUsuario)
    REFERENCES Usuarios (id)
    ;



Prompt ******  PISTAS DE PLANTILLA  ....

ALTER TABLE Pistas ADD CONSTRAINT Pistas_Plantillas
    FOREIGN KEY (idPlantilla)
    REFERENCES Plantillas (id)
    ;



Prompt ******  POSICION DE PISTA  ....

ALTER TABLE Pistas ADD CONSTRAINT Pistas_Posiciones
    FOREIGN KEY (idPosicion)
    REFERENCES Posiciones (id)
    ;




-- End of file.
