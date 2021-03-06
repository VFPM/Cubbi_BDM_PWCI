USE db_bdmm_pwci;

CREATE TABLE Roles(
    ID_Rol				INT AUTO_INCREMENT      NOT NULL COMMENT 'Clave primaria del usuario',
    txt_Nombre			VARCHAR(20)             NOT NULL COMMENT 'Nombre del rol, puede ser estudiante o maestro',
    
    CONSTRAINT pk_rol PRIMARY KEY (ID_Rol)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Categorias (
	ID_Categoria		INT AUTO_INCREMENT      NOT NULL COMMENT 'Clave primaria de la categoria',
    txt_Nombre			VARCHAR(30)             NOT NULL COMMENT 'Nombre de la categoria',
    
    CONSTRAINT pk_cat PRIMARY KEY (ID_Categoria)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Usuarios (
	ID_Usuario			INT AUTO_INCREMENT                      NOT NULL      COMMENT 'Clave primaria del usuario',
    ID_Rol				INT                                     NOT NULL      COMMENT 'Clave foranea del rol del usuario',
    txt_NomUser			VARCHAR(20)                             NOT NULL      COMMENT 'Nombre del usuario',
	txt_Contra			VARCHAR(20)                             NOT NULL      COMMENT 'Contraseña del usuario',
	txt_Nom				VARCHAR(30)                             NOT NULL      COMMENT 'Nombre real del usuario',
	txt_ApePat			VARCHAR(30)                             NOT NULL      COMMENT 'Apellido o apellidos del usuario',
	txt_Email			VARCHAR(40)                             NOT NULL      COMMENT 'Correo electronico del usuario',
    txt_Genero          ENUM("Masculino", "Femenino", "Otro")   NOT NULL      COMMENT 'Genero del usuario',
    date_FchaNac        DATE                                    NOT NULL      COMMENT 'Fecha de nacimiento del usuario',
	date_FchaRegistro	DATE                                    NULL          COMMENT 'Fecha de registro del usuario',
	date_FchaUltiCambio	DATE                                    NULL          COMMENT 'Fecha del ultimo cambio realizado en la informacion del usuario',
	blob_img			MEDIUMBLOB                              DEFAULT NULL  COMMENT 'Foto de perfil del usuario',

	CONSTRAINT pk_us PRIMARY KEY (ID_Usuario),
    CONSTRAINT fk_us_rol FOREIGN KEY (ID_Rol) REFERENCES Roles (ID_Rol)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Cursos (
	ID_Curso			INT AUTO_INCREMENT      NOT NULL COMMENT 'Clave primaria del curso',
	ID_Usuario			INT                     NOT NULL COMMENT 'Clave foranea del creador del curso',
    ID_Categoria		INT                     NOT NULL COMMENT 'Clave foranea de la categoria del curso',
    int_Niveles			INT                     NOT NULL COMMENT 'Cantidad de temas que tendra el curso',
    txt_Titulo  		VARCHAR(30)             NOT NULL COMMENT 'Titulo del curso',
    txt_Descripcion		VARCHAR(200)            NOT NULL COMMENT 'Clave foranea de la categoria del curso',
    txt_Duracion        VARCHAR(10)             NULL     COMMENT 'Duracion aproximada del curso establecida por el creador',
    isPrecioGeneral		INT	                    NOT NULL COMMENT 'En caso de que el precio del curso sea general se marca en esta columna',
    f_Precio			FLOAT                   NULL     COMMENT 'El precio en caso de que el precio del curso sea general',
	blob_img			MEDIUMBLOB              NOT NULL COMMENT 'Imagen representativa del curso',
    ruta_vid            VARCHAR(200)            NULL     COMMENT 'Video de presentacion sobre el curso',
    isAcitvo			BOOL    DEFAULT true    NOT NULL COMMENT 'Variable para ver si el curso sigue estando activo a inscripciones',
    isEdited            BOOL    DEFAULT false   NOT NULL COMMENT 'Variable para saber si la informacion del curso fue modificada',
    date_FchaRegistro	DATE    				NOT NULL COMMENT 'Fecha de creacion del curso',
	date_FchaUltiCambio DATE					NOT NULL COMMENT 'Fecha de la ultima modificacion del curso',
    
	CONSTRAINT pk_cur PRIMARY KEY (ID_Curso),
    CONSTRAINT fk_cur_usu FOREIGN KEY (ID_Usuario) REFERENCES Usuarios (ID_Usuario),
    CONSTRAINT fk_cur_cat FOREIGN KEY (ID_Categoria) REFERENCES Categorias (ID_Categoria)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Secciones (
	ID_Seccion			INT     NOT NULL COMMENT 'Clave primaria de la seccion del curso',
	ID_Curso			INT     NOT NULL COMMENT 'Clave foranea para identificar el curso',
    
	CONSTRAINT pk_sec PRIMARY KEY (ID_Curso, ID_Seccion),
    CONSTRAINT fk_sec_cur FOREIGN KEY (ID_Curso) REFERENCES Cursos (ID_Curso)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Capitulos (
    ID_Capitulo         INT             NOT NULL COMMENT 'Clave primaria del capitulo',
	ID_Seccion			INT             NOT NULL COMMENT 'Clave foranea de la seccion del capitulo',
	ID_Curso			INT             NOT NULL COMMENT 'Clave foranea del curso del capitulo',
    txt_Titulo  		VARCHAR(200)    NOT NULL COMMENT 'Titulo del capitulo',
    f_Precio			FLOAT           NULL     COMMENT 'Precio del capitulo',
	ruta_vid			VARCHAR(200)    NOT NULL COMMENT 'Video del capitulo',
	ruta_docs			VARCHAR(200)    NOT NULL COMMENT 'Documento relacionado al capitulo',
    
	CONSTRAINT pk_cap PRIMARY KEY (ID_Curso, ID_Seccion, ID_Capitulo),
    CONSTRAINT fk_cap_sec FOREIGN KEY (ID_Curso, ID_Seccion) REFERENCES Secciones (ID_Curso, ID_Seccion)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Categorias_cursos (
	ID_Categoria		INT      NOT NULL COMMENT 'Clave foranea de la categoria',
    ID_Curso			INT      NOT NULL COMMENT 'Clave foranea del curso',
    
    CONSTRAINT pk_cat_cur PRIMARY KEY (ID_Categoria, ID_Curso),
    CONSTRAINT fk_cat_cur_cat FOREIGN KEY (ID_Categoria) REFERENCES Categorias (ID_Categoria),
    CONSTRAINT fk_cat_cur_cur FOREIGN KEY (ID_Curso) REFERENCES Cursos (ID_Curso)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Promedios (
    ID_Curso			INT                     NOT NULL COMMENT 'Clave foranea del curso',
    ID_Usuario			INT                     NOT NULL COMMENT 'Clave foranea del usuario que hizo la calificacion',
    bool_like		    BOOL	default false	NOT NULL COMMENT 'Calificacion que le dio el usuario al curso',
    bool_dislike	    BOOL	default false	NOT NULL COMMENT 'Calificacion que le dio el usuario al curso',
    
    CONSTRAINT pk_pro PRIMARY KEY (ID_Curso, ID_Usuario),
    CONSTRAINT fk_pro_cur FOREIGN KEY (ID_Curso) REFERENCES Cursos (ID_Curso),
    CONSTRAINT fk_pro_usu FOREIGN KEY (ID_Usuario) REFERENCES Usuarios (ID_Usuario)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Cursos_Registrados (
	ID_Usuario			INT     NOT NULL 	COMMENT 'Clave primaria del usuario registardo en el curso',
    ID_Curso			INT     NOT NULL 	COMMENT 'Clave primaria refiriendose al curso registrado',
    int_SeccionActual	INT     NULL		COMMENT 'La seccion en la que se encuentra actualmente el usuario',
    int_CapituloActual	INT     DEFAULT 1	COMMENT 'Capitulo en el que se encuentra el usuario actualmente',
    isTerminado			BOOL    NOT NULL 	COMMENT 'Para afirmar que si usuario ha terminado o no el curso',
    isBaja				BOOL    NOT NULL 	COMMENT 'Para afirmar que si el usuario se ha dado de baja enel curso',
    f_MontoPagado		FLOAT   NOT NULL 	COMMENT 'Monto que se ha pagado del curso hasta el momento',
    int_TipoPago		INT	    NOT NULL 	COMMENT 'Tipo de pago utilizado',
    date_FchaRegistro	DATE    NULL     	COMMENT 'Fecha de registro del usuario en el curso',
    date_FchaTerm		DATE    NULL     	COMMENT 'para mostrar la fecha del dia en que el alumno terminó el curso',
    date_FchaUltimaEntrada DATE NULL        COMMENT 'Fecha de la ultima vez que entro al curso',
    
	CONSTRAINT pk_curreg PRIMARY KEY (ID_Usuario, ID_Curso),
    CONSTRAINT fk_curreg_usu FOREIGN KEY (ID_Usuario) REFERENCES Usuarios (ID_Usuario),
    CONSTRAINT fk_curreg_cur FOREIGN KEY (ID_Curso) REFERENCES Cursos (ID_Curso),
    CONSTRAINT fk_curreg_niv FOREIGN KEY (ID_Curso, int_SeccionActual) REFERENCES Secciones (ID_Curso, ID_Seccion)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Accesos (
	ID_Usuario			INT      NOT NULL COMMENT 'Clave foranea del usuario',
    ID_Curso			INT      NOT NULL COMMENT 'Clave foranea del curso',
    ID_Seccion			INT      NOT NULL COMMENT 'Clave foranea de la seccion que el usuario puede acceder',
    
    CONSTRAINT pk_acc PRIMARY KEY (ID_Usuario, ID_Curso, ID_Seccion),
    CONSTRAINT fk_acc_usu_cur FOREIGN KEY (ID_Usuario, ID_Curso) REFERENCES Cursos_Registrados (ID_Usuario, ID_Curso),
    CONSTRAINT fk_acc_cur_sec FOREIGN KEY (ID_Curso, ID_Seccion) REFERENCES Secciones (ID_Curso, ID_Seccion)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Mensajes_Cursos (
	ID_Mensaje			INT AUTO_INCREMENT  NOT NULL COMMENT 'Clave primaria del mensaje',		
    ID_Curso            INT             	NOT NULL COMMENT 'Clave foranea del curso',
    ID_Usuario          INT             	NOT NULL COMMENT 'Clave foranea del usuario',
    txt_Mensaje         VARCHAR(500)    	NOT NULL COMMENT 'Texto del mensaje escrito por el usuario',
    isFromEscuela       BOOL            	NOT NULL COMMENT 'Para revisar si el mensaje fue enviado por el profesor',
    date_FchaEnvio      DATE            	NOT NULL COMMENT 'Fecha de cuando se envió el mensaje',

    CONSTRAINT pk_mencur PRIMARY KEY (ID_Mensaje),
    CONSTRAINT fk_mencur_cur FOREIGN KEY (ID_Curso) REFERENCES Cursos (ID_Curso),
    CONSTRAINT fk_mencur_usu FOREIGN KEY (ID_Usuario) REFERENCES Usuarios (ID_Usuario)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Comentarios_Cursos (
    ID_Curso            INT             NOT NULL COMMENT 'Clave primaria del curso',
    ID_Usuario          INT             NOT NULL COMMENT 'Clave primaria del usuario',
    txt_Comentario      VARCHAR(500)    NOT NULL COMMENT 'texto del comentario hecho por el usuario',
    date_FchaEnvio      DATE            NOT NULL COMMENT 'Fecha de cuando se envió el comentario',

    CONSTRAINT pk_comcur PRIMARY KEY (ID_Usuario, ID_Curso),
    CONSTRAINT fk_comcur_cur FOREIGN KEY (ID_Curso) REFERENCES Cursos (ID_Curso),
    CONSTRAINT fk_comcur_usu FOREIGN KEY (ID_Usuario) REFERENCES Usuarios (ID_Usuario)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Carrito (
	ID_Usuario			INT     NOT NULL COMMENT 'Clave primaria del usuario que va a comprar',
    ID_Curso			INT     NOT NULL COMMENT 'Clave primaria del curso que se piensa comprar',
    int_SeccionActual	INT     NOT NULL COMMENT 'Copia del parametro de la tabla de cursos registrado',
    isTerminado			BOOL    NOT NULL COMMENT 'Copia del parametro de la tabla de cursos registrado',
    isBaja				BOOL    NOT NULL COMMENT 'Copia del parametro de la tabla de cursos registrado',
    date_FchaTerm		DATE    NOT NULL COMMENT 'Copia del parametro de la tabla de cursos registrado',
    
	CONSTRAINT pk_curreg PRIMARY KEY (ID_Usuario, ID_Curso),
    CONSTRAINT fk_car_usu FOREIGN KEY (ID_Usuario) REFERENCES Usuarios (ID_Usuario),
    CONSTRAINT fk_car_cur FOREIGN KEY (ID_Curso) REFERENCES Cursos (ID_Curso),
    CONSTRAINT fk_car_niv FOREIGN KEY (ID_Curso, int_SeccionActual) REFERENCES Secciones (ID_Curso, ID_Seccion)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;