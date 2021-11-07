DELIMITER //
CREATE FUNCTION Max_Cursos() 
RETURNS INT
BEGIN
	DECLARE maximo INT;
	SET maximo = (select MAX(Cursos.ID_Curso) from cursos);
	RETURN maximo;
END;
//


DELIMITER //
CREATE FUNCTION Crear_Porcentaje(capActual INT, secActual INT, curso INT, capCantidad INT) 
RETURNS FLOAT
BEGIN
	DECLARE porcentaje FLOAT;
	DECLARE division FLOAT;
    DECLARE capAnteriores INT;
    DECLARE caps INT;
    
    SET secActual = secActual - 1;
    SET capAnteriores = 0;
    
	while secActual > 0 do
	SET caps = (select COUNT(ID_Capitulo) from Capitulos where ID_seccion = secActual and ID_Curso = curso);
    SET capAnteriores = capAnteriores + caps;
    SET secActual = secActual - 1;
	end while;
    
    SET capActual = capActual + capAnteriores;
    
	SET division = (capActual - 1) / capCantidad;
	SET porcentaje = division * 100;
	RETURN porcentaje;
END;
//


DELIMITER //
CREATE FUNCTION Obtener_Usuario_Mensajes(idCurso INT, idUsuario INT, isMaestro BOOLEAN) 
RETURNS VARCHAR(50)
BEGIN
	DECLARE txt_Nombre VARCHAR(50);
    
	IF isMaestro = 0 THEN
		SET txt_Nombre = (SELECT usuarios.txt_NomUser from usuarios where usuarios.ID_Usuario = idUsuario);
    ELSE
		SET txt_Nombre = (SELECT usuarios.txt_NomUser from cursos inner join usuarios on usuarios.ID_Usuario = cursos.ID_Usuario where cursos.ID_Curso = idCurso);
    END IF;
	RETURN txt_Nombre;
END;
//


select Max_Cursos();

drop function Max_Cursos;
drop function Crear_Porcentaje;
drop function Obtener_Usuario_Mensajes;

SET GLOBAL log_bin_trust_function_creators = 1;


