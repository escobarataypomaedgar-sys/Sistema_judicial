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
