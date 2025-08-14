-- LOWER/UPPER

SELECT
    LOWER('ABCDefgh'),
    UPPER('ABCDefgh')

-- TRIM

SELECT 
    TRIM('    JAN     KOWALSKI    ')


SELECT
    TRIM(BOTH '#' FROM '### JAN  KOWALSKI ####')