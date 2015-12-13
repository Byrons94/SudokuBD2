CREATE OR REPLACE PROCEDURE pProbAdyacentesHorizontales
	(ppartida IN INTEGER, pincognita IN INTEGER, pfila IN INTEGER, pcolumna IN INTEGER, pcuadrante IN INTEGER) IS
	
	verdadero NUMBER(1) := 1;
	falso NUMBER(1) := 0;
	valor1 INTEGER := 0;
	valor2 INTEGER := 0;
	
BEGIN
			
	--por cada resultado intersecado horizontalmente
	FOR insersecada IN (
		SELECT tpis.valor
		FROM partidas tpar 
		INNER JOIN plantillas tpla ON tpla.id = tpar.idPlantilla 
		INNER JOIN pistas tpis ON tpis.idPlantilla = tpla.id 
		INNER JOIN posiciones tpos ON tpos.id = tpis.idPosicion
		WHERE 
			tpar.id = ppartida AND 
			(tpos.fila = ObtenerAdyacente(pfila,verdadero)) AND
			tpos.cuadrante <> pcuadrante
		INTERSECT 
		SELECT tpis.valor 
		FROM partidas tpar 
		INNER JOIN plantillas tpla ON tpla.id = tpar.idPlantilla 
		INNER JOIN pistas tpis ON tpis.idPlantilla = tpla.id 
		INNER JOIN posiciones tpos ON tpos.id = tpis.idPosicion
		WHERE 
			tpar.id = ppartida AND 
			(tpos.fila = ObtenerAdyacente(pfila,falso)) AND
			tpos.cuadrante <> pcuadrante
	)
	LOOP
		
		valor1 := 0;
		valor2 := 1;
		
		--seleccionar primer valor adyacente
		SELECT GetValorPosicion(ppartida, pfila, ObtenerAdyacente(pcolumna,verdadero))
		INTO valor1
		FROM dual;
		
		--si el primer valor no se encontro
		IF valor1 = 0 THEN
			SELECT GetValorEnColumnaActual(ppartida, ObtenerAdyacente(pcolumna,verdadero), pcuadrante, insersecada.valor)
			INTO valor1
			FROM dual;
		END IF;
		
		--seleccionar segundo valor adyacente
		SELECT GetValorPosicion(ppartida, pfila, ObtenerAdyacente(pcolumna,falso))
		INTO valor2
		FROM dual;
		
		--si el segundo valor no se encontro
		IF valor2 = 0 THEN
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


