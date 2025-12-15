-- 4.4. Programación en Base de Datos


-- Stored Procedure: Procedimiento para actualizar el estado de un caso
DELIMITER //
CREATE PROCEDURE SP_ActualizarEstadoCaso (
    IN p_id_caso INT,
    IN p_nuevo_estado VARCHAR(50)
)
BEGIN
    -- Validar que el caso exista
    IF EXISTS (SELECT 1 FROM CASOS WHERE id_caso = p_id_caso) THEN
        -- Actualizar el estado del caso
        UPDATE CASOS
        SET estado = p_nuevo_estado
        WHERE id_caso = p_id_caso;
        
        -- Insertar un registro de auditoría de cambio de estado                                              -- esto es opcional
        -- INSERT INTO AUDITORIA_CASOS (id_caso, fecha_cambio, estado_anterior, estado_nuevo) VALUES (...)
        
        SELECT 'Estado del caso actualizado exitosamente.' AS Mensaje;
    ELSE
        SELECT 'Error: El caso especificado no existe.' AS Mensaje;
    END IF;
END //
DELIMITER ;

