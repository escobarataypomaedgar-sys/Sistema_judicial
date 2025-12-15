-- 5 Consultas mas complejos 
-- Consulta 1: Listar el total de casos por Juez, mostrando su nombre completo.

SELECT P.nombre, P.apellido, J.matricula, COUNT(C.id_caso) AS total_casos_presididos
FROM JUECES J
JOIN PERSONAS P ON J.id_persona = P.id_persona
JOIN AUDIENCIAS A ON J.id_juez = A.id_juez
JOIN CASOS C ON A.id_caso = C.id_caso
GROUP BY P.nombre, P.apellido, J.matricula
ORDER BY total_casos_presididos DESC;

-- Consulta 2: Listar los casos (id y descripción) que tienen más de 2 partes involucradas.

SELECT C.id_caso, C.descripcion
FROM CASOS C
WHERE C.id_caso IN (SELECT id_caso
FROM PARTES_CASO
GROUP BY id_caso
HAVING COUNT(id_parte_caso) > 2
);

-- Consulta 3: Listar todos los casos, su tipo, el juzgado y el número de audiencias programadas.

SELECT C.id_caso, T.nombre_tipo AS tipo_caso, JZ.nombre AS juzgado, COUNT(A.id_audiencia) AS numero_audiencias
FROM CASOS C
JOIN TIPOS_CASO T ON C.id_tipo_caso = T.id_tipo_caso
JOIN JUZGADOS JZ ON C.id_juzgado = JZ.id_juzgado
LEFT JOIN AUDIENCIAS A ON C.id_caso = A.id_caso
GROUP BY C.id_caso, T.nombre_tipo, JZ.nombre
ORDER BY C.id_caso;

-- Consulta 4: Listar los Jueces (nombre y especialidad) que han emitido al menos una Sentencia.

SELECT DISTINCT P.nombre, P.apellido, J.especialidad
FROM JUECES J
JOIN PERSONAS P ON J.id_persona = P.id_persona
JOIN RESOLUCIONES R ON J.id_juez = R.id_juez
WHERE R.tipo_resolucion = 'Sentencia';

-- Consulta 5: Listar los Juzgados y el total de resoluciones emitidas en cada uno.

SELECT JZ.nombre AS juzgado, COUNT(R.id_resolucion) AS total_resoluciones
FROM JUZGADOS JZ
LEFT JOIN CASOS C ON JZ.id_juzgado = C.id_juzgado
LEFT JOIN RESOLUCIONES R ON C.id_caso = R.id_caso
GROUP BY JZ.nombre
ORDER BY total_resoluciones DESC;
