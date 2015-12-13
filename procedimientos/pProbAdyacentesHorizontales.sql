CREATE OR REPLACE PROCEDURE pProbAdyacentesHorizontales
	(ppartida IN INTEGER, pincognita IN INTEGER, pfila IN INTEGER, pcolumna IN INTEGER, pcuadrante IN INTEGER) IS
	
	verdadero NUMBER(1) := 1;
	falso NUMBER(1) := 0;
	valor1 INTEGER := 0;
	valor2 INTEGER := 0;
	
BEGIN
			
	--por cada resultado intersecado horizontalmente
	FOR insersecada IN (
		SELECT valor
		FROM
		(
			SELECT tpis.valor, tpos.fila
			FROM partidas tpar 
			INNER JOIN plantillas tpla ON tpla.id = tpar.idPlantilla 
			INNER JOIN pistas tpis ON tpis.idPlantilla = tpla.id 
			INNER JOIN posiciones tpos ON tpos.id = tpis.idPosicion
			WHERE tpar.id = ppartida
			UNION
			SELECT tinc.valor, tposi.fila
			FROM incognitas tinc 
			INNER JOIN posiciones tposi ON tposi.id = tinc.idPosicion
			WHERE tinc.idPartida = ppartida
		) ady1
		WHERE 
			ady1.fila = ObtenerAdyacente(pfila,verdadero) AND
			ady1.valor NOT IN 
			(
				SELECT tinc.valor
				FROM incognitas tinc 
				INNER JOIN posiciones tposi ON tposi.id = tinc.idPosicion
				WHERE tposi.cuadrante = pcuadrante AND tinc.valor IS NOT NULL
				UNION
				SELECT tpist.valor
				FROM partidas tparti
				INNER JOIN plantillas tplanti ON tplanti.id = tparti.idPlantilla
				INNER JOIN pistas tpist ON tpist.idPlantilla = tplanti.id
				INNER JOIN posiciones tposi ON tposi.id = tpist.idPosicion
				WHERE tposi.cuadrante = pcuadrante AND tpist.valor IS NOT NULL
			)		
		INTERSECT
		SELECT valor
		FROM
		(
			SELECT tpis.valor, tpos.fila
			FROM partidas tpar 
			INNER JOIN plantillas tpla ON tpla.id = tpar.idPlantilla 
			INNER JOIN pistas tpis ON tpis.idPlantilla = tpla.id 
			INNER JOIN posiciones tpos ON tpos.id = tpis.idPosicion
			WHERE tpar.id = ppartida
			UNION
			SELECT tinc.valor, tposi.fila
			FROM incognitas tinc 
			INNER JOIN posiciones tposi ON tposi.id = tinc.idPosicion
			WHERE tinc.idPartida = ppartida
		) ady2
		WHERE 
			ady2.fila = ObtenerAdyacente(pfila,falso) AND
			ady2.valor NOT IN 
			(
				SELECT tinc.valor
				FROM incognitas tinc 
				INNER JOIN posiciones tposi ON tposi.id = tinc.idPosicion
				WHERE tposi.cuadrante = pcuadrante AND tinc.valor IS NOT NULL
				UNION
				SELECT tpist.valor
				FROM partidas tparti
				INNER JOIN plantillas tplanti ON tplanti.id = tparti.idPlantilla
				INNER JOIN pistas tpist ON tpist.idPlantilla = tplanti.id
				INNER JOIN posiciones tposi ON tposi.id = tpist.idPosicion
				WHERE tposi.cuadrante = pcuadrante AND tpist.valor IS NOT NULL
			)
	)
	LOOP
		
		valor1 := 0;
		valor2 := 0;
		
		--seleccionar primer valor adyacente
		SELECT GetValorPosicion(ppartida, pfila, ObtenerAdyacente(pcolumna,verdadero))
		INTO valor1
		FROM dual;
		
		--si el primer valor no se encontro
		IF valor1 = 0 OR valor1 IS NULL THEN
			SELECT GetValorEnColumnaActual(ppartida, ObtenerAdyacente(pcolumna,verdadero), pcuadrante, insersecada.valor)
			INTO valor1
			FROM dual;
		END IF;
		
		--seleccionar segundo valor adyacente
		SELECT GetValorPosicion(ppartida, pfila, ObtenerAdyacente(pcolumna,falso))
		INTO valor2
		FROM dual;
		
		--si el segundo valor no se encontro
		IF valor2 = 0 OR valor2 IS NULL THEN
			SELECT GetValorEnColumnaActual(ppartida, ObtenerAdyacente(pcolumna,falso), pcuadrante, insersecada.valor)
			INTO valor2
			FROM dual;
		END IF;
		
		--si los dos valores fueron encontrados
		IF valor1 <> 0 AND valor2 <> 0 THEN
			dbms_output.put_line('H-> FILA:' || pfila || ' / COLUMNA:' || pcolumna || ' / VALOR:' || insersecada.valor);
			DELETE FROM probabilidades tpro
			WHERE tpro.idIncognita = pincognita AND tpro.numero <> insersecada.valor;
		END IF;
		
	END LOOP;
	
END;
/


