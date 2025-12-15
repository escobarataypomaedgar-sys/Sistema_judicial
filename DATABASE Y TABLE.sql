-- Crear base de datos llamado sistema_judicial

CREATE DATABASE sistema_judicial;
USE sistema_judicial;

-- 1. Tabla JUZGADOS
CREATE TABLE JUZGADOS (
    id_juzgado INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(255),
    telefono VARCHAR(20)
);

-- 2. Tabla TIPOS_CASO
CREATE TABLE TIPOS_CASO (
    id_tipo_caso INT PRIMARY KEY AUTO_INCREMENT,
    nombre_tipo VARCHAR(50) NOT NULL UNIQUE,
    descripcion TEXT
);

-- 3. Tabla PERSONAS
CREATE TABLE PERSONAS (
    id_persona INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    dni VARCHAR(20) NOT NULL UNIQUE,
    direccion VARCHAR(255),
    telefono VARCHAR(20)
);

-- 4. Tabla JUECES (Relación 1:1 con PERSONAS)
CREATE TABLE JUECES (
    id_juez INT PRIMARY KEY AUTO_INCREMENT,
    id_persona INT NOT NULL UNIQUE,
    matricula VARCHAR(50) NOT NULL UNIQUE,
    especialidad VARCHAR(100),
    FOREIGN KEY (id_persona) REFERENCES PERSONAS(id_persona)
);

-- 5. Tabla CASOS
CREATE TABLE CASOS (
    id_caso INT PRIMARY KEY AUTO_INCREMENT,
    id_juzgado INT NOT NULL,
    id_tipo_caso INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    estado VARCHAR(50) NOT NULL DEFAULT 'INICIADO', -- Ej: INICIADO, EN PROCESO, RESUELTO, ARCHIVADO
    descripcion TEXT,
    FOREIGN KEY (id_juzgado) REFERENCES JUZGADOS(id_juzgado),
    FOREIGN KEY (id_tipo_caso) REFERENCES TIPOS_CASO(id_tipo_caso)
);

-- 6. Tabla PARTES_CASO (Tabla de relación N:M entre CASOS y PERSONAS)
CREATE TABLE PARTES_CASO (
    id_parte_caso INT PRIMARY KEY AUTO_INCREMENT,
    id_caso INT NOT NULL,
    id_persona INT NOT NULL,
    rol_parte VARCHAR(50) NOT NULL, -- Ej: Demandante, Demandado, Abogado, Testigo
    UNIQUE KEY uk_caso_persona_rol (id_caso, id_persona, rol_parte),
    FOREIGN KEY (id_caso) REFERENCES CASOS(id_caso),
    FOREIGN KEY (id_persona) REFERENCES PERSONAS(id_persona)
);

-- 7. Tabla AUDIENCIAS
CREATE TABLE AUDIENCIAS (
    id_audiencia INT PRIMARY KEY AUTO_INCREMENT,
    id_caso INT NOT NULL,
    id_juez INT NOT NULL,
    fecha_hora DATETIME NOT NULL,
    sala VARCHAR(50),
    resultado TEXT,
    FOREIGN KEY (id_caso) REFERENCES CASOS(id_caso),
    FOREIGN KEY (id_juez) REFERENCES JUECES(id_juez)
);

-- 8. Tabla RESOLUCIONES
CREATE TABLE RESOLUCIONES (
    id_resolucion INT PRIMARY KEY AUTO_INCREMENT,
    id_caso INT NOT NULL,
    id_juez INT NOT NULL,
    fecha_emision DATE NOT NULL,
    tipo_resolucion VARCHAR(100), -- Ej: Sentencia, Auto, Decreto
    texto_completo TEXT,
    FOREIGN KEY (id_caso) REFERENCES CASOS(id_caso),
    FOREIGN KEY (id_juez) REFERENCES JUECES(id_juez)
);

-- Tabla de Auditoría para el Trigger
CREATE TABLE AUDITORIA_RESOLUCIONES (
    id_auditoria INT PRIMARY KEY AUTO_INCREMENT,
    id_resolucion_eliminada INT,
    fecha_eliminacion DATETIME,
    usuario_eliminacion VARCHAR(100)
);
