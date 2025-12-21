-- Trigger: Disparador de auditoría que guarda en una tabla histórica cuando se elimina un registro de RESOLUCIONES

DELIMITER //
CREATE TRIGGER TR_Auditoria_Resoluciones_DELETE
BEFORE DELETE ON RESOLUCIONES
FOR EACH ROW
BEGIN
    INSERT INTO AUDITORIA_RESOLUCIONES (id_resolucion_eliminada, fecha_eliminacion, usuario_eliminacion)
    VALUES (OLD.id_resolucion, NOW(), USER());
END //
DELIMITER ;

DELETE FROM RESOLUCIONES WHERE id_resolucion = 1;
SELECT * FROM AUDITORIA_RESOLUCIONES;


-- TRIGGER PARA CASOS (UPDATE de estado)

DELIMITER //

CREATE TRIGGER TR_Auditoria_Audiencias_INSERT
AFTER INSERT ON AUDIENCIAS
FOR EACH ROW
BEGIN
    INSERT INTO AUDITORIA_AUDIENCIAS (
        id_audiencia,
        id_caso,
        fecha_programada,
        usuario,
        fecha_registro
    )
    VALUES (
        NEW.id_audiencia,
        NEW.id_caso,
        NEW.fecha_hora,
        USER(),
        NOW()
    );
END //

DELIMITER ;

INSERT INTO AUDIENCIAS (id_caso, id_juez, fecha_hora, sala, resultado)
VALUES (1, 2, '2025-12-20 10:30:00', 'Sala 3', 'Audiencia programada');

SELECT * FROM AUDITORIA_AUDIENCIAS;




