DECLARE
  id_juego number(10) := 1;
  casilla number(10);
  valor_casilla number(10);
  FILAF      NUMBER(10);
  COLUMMNAF  NUMBER(10);
  numero number(10);

  CURSOR cursor_juego IS

  SELECT POS.ID, POS.FILA, POS.COLUMNA, PI.valor
  FROM POSICIONES POS
  INNER JOIN PISTAS PI
    ON POS.ID = PI.IDPOSICION
    WHERE PI.IDPLANTILLA =  id_juego;

BEGIN

    OPEN cursor_juego;
      LOOP
        FETCH cursor_juego INTO casilla, FILAF, COLUMMNAF, numero;
        EXIT WHEN cursor_juego%NOTFOUND;
          dbms_output.put_Line(numero);


      END LOOP;
    CLOSE cursor_juego;


END;
/
