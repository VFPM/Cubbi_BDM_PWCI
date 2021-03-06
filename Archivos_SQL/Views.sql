CREATE VIEW View_Usuarios AS
SELECT Usuarios.ID_Usuario as ID,
            Roles.txt_Nombre as Rol,
            Usuarios.txt_NomUser as Usuario,
            Usuarios.txt_Contra as Contrasenia,
            CONCAT(Usuarios.txt_Nom, ' ', Usuarios.txt_ApePat) as Nombre_Completo,
            Usuarios.txt_Email as Email,
            Usuarios.txt_Genero as Genero,
            Usuarios.date_FchaNac as Fecha_Nacimiento,
            TIMESTAMPDIFF(YEAR, Usuarios.date_FchaNac, NOW()) AS Edad,
            Usuarios.date_FchaRegistro as Fecha_Registro,
            Usuarios.date_FchaUltiCambio as Fecha_Cambio,
            Usuarios.blob_img as Foto_Perfil
            from Usuarios
        inner join Roles on Roles.ID_Rol = Usuarios.ID_Rol;

CREATE VIEW View_VideosCursos AS
SELECT Capitulos.ID_Curso as Curso,
            Capitulos.ID_Seccion as Tema,
            Capitulos.ID_Capitulo as Capitulo,
            Capitulos.txt_Titulo as Titulo,
            Capitulos.f_Precio as Precio,
            Capitulos.ruta_vid as Video,
            Capitulos.ruta_docs as Documento
            from Capitulos;

CREATE VIEW View_Curso AS
SELECT Cursos.ID_Curso as ID,
            Cursos.txt_Titulo as Titulo,
            Cursos.txt_Descripcion as Descripcion,
            Cursos.txt_Duracion as Duracion,
            Cursos.blob_img as Imagen,
            Cursos.ID_Usuario as ID_Profesor,
            Usuarios.txt_NomUser as Profesor,
            Cursos.isAcitvo as Activo,
            Cursos.isPrecioGeneral as Tipo,
            Cursos.f_Precio as Precio,
            Cursos.date_FchaRegistro as Registro,
            Cursos.date_FchaUltiCambio as Cambio,
            COUNT(distinct Cursos_Registrados.ID_Usuario) as Registros_Cantidad,
            ObtenerCantidadLikes(Cursos.ID_Curso) as Likes
            from Cursos
            inner join Usuarios on Usuarios.ID_Usuario = Cursos.ID_Usuario
            left join Cursos_Registrados on Cursos_Registrados.ID_Curso = Cursos.ID_Curso
            group by Cursos.ID_Curso;

CREATE VIEW View_Curso_Categoria AS
SELECT Cursos.ID_Curso as ID,
            Cursos.txt_Titulo as Titulo,
            Cursos.txt_Descripcion as Descripcion,
            Cursos.txt_Duracion as Duracion,
            Cursos.blob_img as Imagen,
            Usuarios.txt_NomUser as Profesor,
            Cursos.isAcitvo as Activo,
            Cursos.isPrecioGeneral as Tipo,
            Cursos.f_Precio as Precio,
            Categorias_cursos.ID_Categoria as ID_Categoria,
            Categorias.txt_Nombre as Categoria,
            Cursos.date_FchaRegistro as Registro,
            Cursos.date_FchaUltiCambio as Cambio,
            COUNT(Cursos_Registrados.ID_Usuario) as Registros_Cantidad,
            ObtenerCantidadLikes(Cursos.ID_Curso) as Likes
            from Categorias_cursos
            inner join Cursos on Cursos.ID_Curso = Categorias_cursos.ID_Curso
            inner join Usuarios on Usuarios.ID_Usuario = Cursos.ID_Usuario
            inner join Categorias on Categorias.ID_Categoria = Categorias_cursos.ID_Categoria
            left join Cursos_Registrados on Cursos_Registrados.ID_Curso = Categorias_cursos.ID_Curso
            group by Cursos.ID_Curso, Categoria;

CREATE VIEW View_Comentarios AS
SELECT Comentarios_Cursos.txt_Comentario as Comentario,
            Comentarios_Cursos.date_FchaEnvio as Fecha,
            Usuarios.txt_NomUser as Usuario,
            Usuarios.blob_img as img,
            Cursos.ID_Curso as ID_Curso,
            Usuarios.ID_Usuario as ID_Usuario
            from Comentarios_Cursos
        inner join Usuarios on Usuarios.ID_Usuario = Comentarios_Cursos.ID_Usuario
        inner join Cursos on Cursos.ID_Curso = Comentarios_Cursos.ID_Curso
        ORDER BY Fecha DESC;

CREATE VIEW View_Registros AS
SELECT Cursos_Registrados.ID_Usuario as ID_Usuario,
            Cursos_Registrados.ID_Curso as ID_Curso,
            Cursos.ID_Usuario as ID_Profesor,
            CONCAT(usuarios.txt_Nom , " ", usuarios.txt_ApePat) as Nombre_Completo,
            Cursos_Registrados.int_SeccionActual as Seccion_Actual,
            Cursos_Registrados.int_CapituloActual as Capitulo_Actual,
            Cursos.blob_img as img,
            Cursos.txt_Titulo as Titulo,
            COUNT(Capitulos.ID_Capitulo) as Capitulos,
            Crear_Porcentaje(Cursos_Registrados.int_CapituloActual, Cursos_Registrados.int_SeccionActual, Cursos_Registrados.ID_Curso, COUNT(Capitulos.ID_Capitulo), Cursos_Registrados.isTerminado) as Porcentaje,
            Capitulos.txt_Titulo as Titulo_Capitulo,
            Cursos.date_FchaUltiCambio as Fecha_Cambio,
            Cursos_Registrados.date_FchaTerm as Fecha_Terminacion,
            Cursos_Registrados.date_FchaRegistro as Fecha_Inscripcion,
            Cursos_Registrados.date_FchaUltimaEntrada as Fecha_Ultima_Entrada,
            Cursos.isAcitvo as Activo,
            Cursos_Registrados.isTerminado as Terminado,
            PagoTotal(Cursos_Registrados.ID_Curso, Cursos_Registrados.ID_Usuario, isPrecioGeneral, Cursos_Registrados.f_MontoPagado) as Pago,
			CASE 
				WHEN Cursos_Registrados.int_TipoPago = 2 THEN 'PayPal' 
				WHEN Cursos_Registrados.int_TipoPago = 1 THEN 'Tarjeta de Credito' 
			END as Tipo_de_Pago
            from Cursos_Registrados
        inner join Cursos on Cursos.ID_Curso = Cursos_Registrados.ID_Curso
        inner join Capitulos on Capitulos.ID_Curso = Cursos_Registrados.ID_Curso 
        inner join usuarios on usuarios.ID_Usuario = Cursos_Registrados.ID_Usuario 
        Group by Cursos_Registrados.ID_Curso, Cursos_Registrados.ID_Usuario
        ORDER BY Cursos_Registrados.date_FchaRegistro DESC;

CREATE VIEW View_Mensajes AS
SELECT Mensajes_Cursos.ID_Mensaje as ID,
            Mensajes_Cursos.ID_Curso as ID_Curso,
            Mensajes_Cursos.ID_Usuario as ID_Usuario,
            usuarios.txt_NomUser as Nombre_Usuario,
            Mensajes_Cursos.txt_Mensaje as Mensaje,
            Mensajes_Cursos.isFromEscuela as isFromEscuela,
            Mensajes_Cursos.date_FchaEnvio as Fecha,
            Cursos.txt_Titulo as Curso,
            Cursos.ID_Usuario as ID_Maestro,
            Obtener_Usuario_Mensajes(Mensajes_Cursos.ID_Curso, Mensajes_Cursos.ID_Usuario, Mensajes_Cursos.isFromEscuela) as Usuario
            from Mensajes_Cursos
        inner join Cursos on Cursos.ID_Curso = Mensajes_Cursos.ID_Curso
        inner join usuarios on usuarios.ID_Usuario = Mensajes_Cursos.ID_Usuario;

CREATE VIEW View_Ventas_Cursos AS
SELECT View_Curso.ID as ID_Curso, 
            View_Curso.Titulo as Titulo, 
            View_Curso.ID_Profesor as ID_Profesor, 
            COUNT(View_Registros.ID_Usuario) as Cantidad_Alumnos, 
            ifnull((SUM(View_Registros.Porcentaje) / COUNT(View_Registros.ID_Usuario)), 0) as Porcentaje, 
            ifnull((SUM(View_Registros.Pago)), 0) as Pago 
            FROM View_Curso
        left join View_Registros on View_Registros.ID_Curso = View_Curso.ID
        Group by View_Curso.ID;

drop view View_Usuarios;
drop VIEW View_VideosCursos;
drop VIEW View_Curso;
drop VIEW View_Curso_Categoria;
drop VIEW View_Comentarios;
drop VIEW View_Registros;
drop View View_Mensajes;
drop View View_Ventas_Cursos;