CREATE OR REPLACE PROCEDURE llenarProbabilidades(ID_PARTIDA in NUMBER)
AS
  ID_INCOGNITA NUMBER(10);

  CURSOR buscar_incognitas(ID_P NUMBER) IS
  SELECT I.ID FROM INCOGNITAS I
  WHERE ID_P = I.IDPARTIDA;

BEGIN

  OPEN buscar_incognitas(ID_PARTIDA);
  LOOP
    FETCH buscar_incognitas INTO ID_INCOGNITA;
    EXIT WHEN buscar_incognitas%NOTFOUND;

      IF ID_INCOGNITA IS NOT NULL THEN
        FOR I IN 1..9 LOOP
        
          INSERT INTO PROBABILIDADES(IDINCOGNITA, NUMERO, IDJUEGO)
          VALUES(ID_INCOGNITA, I, ID_PARTIDA);
        END LOOP;

      END IF;
  END LOOP;
  CLOSE buscar_incognitas;

END;
/
