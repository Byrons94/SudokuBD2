CREATE OR REPLACE PROCEDURE ResolverJuego (pidPartida INTEGER) AS
	primeraVez BOOLEAN := TRUE;
	totalProbabilidades INTEGER := 1;
BEGIN
	WHILE (primeraVez )
	LOOP

		CalcularProbabilidades(pidPartida);

		--desactivar bandera
		primeraVez := FALSE;

		--actualizar total de probabilidades restantes
		SELECT COUNT(1)
		INTO totalProbabilidades
		FROM incognitas tinc
		INNER JOIN probabilidades tpro ON tpro.idIncognita = tinc.id
		WHERE tinc.idPartida = pidPartida;


		FOR probabilidad IN
		(
			--USAR FUNCION HECHA POR MI
		   SELECT tp.idIncognita, tp.numero
		   FROM probabilidades tp
		   WHERE tp.idIncognita IN
		   (
			   SELECT tpro.idIncognita
			   FROM probabilidades tpro
			   GROUP BY tpro.idPartida, tpro.idIncognita
			   HAVING COUNT(1) = 1
		   ) AND idPartida= pidPartida
		)
		LOOP
			dbms_output.put_line('Incognita:'||probabilidad.idIncognita||'/ VALOR REAL:' || probabilidad.numero);
			UPDATE incognitas tinc SET tinc.valor = probabilidad.numero WHERE tinc.id = probabilidad.idIncognita AND tinc.idPartida=pidPartida;
			DELETE FROM probabilidades WHERE idIncognita = probabilidad.idIncognita AND idPartida=pidPartida;
		END LOOP;

	END LOOP;
END;
/
