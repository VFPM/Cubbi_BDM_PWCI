USE db_bdmm_pwci;
DROP PROCEDURE sp_Cursos_Registros;

DELIMITER $$
CREATE PROCEDURE sp_Cursos_Registros (
    in opc                  VARCHAR(10),
	in ID_Usuario		    INT,
	in ID_Curso			    INT,
    in f_MontoPagado	    FLOAT,
	in int_TipoPago		    INT,
	in ID_Seccion		    INT,
	in ID_Capitulo		    INT
)
BEGIN
	IF opc = 'A' THEN
		INSERT INTO Cursos_Registrados
					(Cursos_Registrados.ID_Usuario, Cursos_Registrados.ID_Curso, Cursos_Registrados.int_SeccionActual, Cursos_Registrados.isTerminado, Cursos_Registrados.isBaja, Cursos_Registrados.f_MontoPagado, Cursos_Registrados.int_TipoPago, Cursos_Registrados.date_FchaRegistro)
				VALUES 
					(ID_Usuario, ID_Curso, 1, 0, 0, f_MontoPagado, int_TipoPago, curdate());
    END IF;

	IF opc = 'C_SecCap' THEN
		UPDATE Cursos_Registrados SET Cursos_Registrados.int_SeccionActual = ID_Seccion,
				Cursos_Registrados.int_CapituloActual = ID_Capitulo,
				Cursos_Registrados.date_FchaUltimaEntrada = curdate()
			WHERE Cursos_Registrados.ID_Usuario = ID_Usuario AND Cursos_Registrados.ID_Curso = ID_Curso;
    END IF;
END
$$
DELIMITER ;