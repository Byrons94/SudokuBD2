CREATE OR REPLACE PROCEDURE CrearPartida (pidPlantilla INTEGER, pidUsuario INTEGER) AS
	partida INTEGER;
	BEGIN
		--crear partida
		INSERT INTO partidas (tiempoInicio, idUsuario, idPlantilla, puntos) VALUES 
			(SYSDATE, pidUsuario, pidPlantilla, 0);
			
		--seleccionar id partida
		
		SELECT MAX(tpar.id) 
		INTO partida 
		FROM partidas tpar;
		
		--crear incognitas
		INSERT INTO incognitas (idPosicion, idPartida) 
			SELECT tpo.id, partida
			FROM posiciones tpo 
			WHERE tpo.id NOT IN
			(
				SELECT tpos.id 
				FROM plantillas tpla
				INNER JOIN pistas tpi ON tpla.id = tpi.idPlantilla
				INNER JOIN posiciones tpos ON tpos.id = tpi.idPosicion
				WHERE tpla.id = pidPlantilla
			);
		
		
	END;
/