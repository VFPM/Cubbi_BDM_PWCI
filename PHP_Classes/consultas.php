<?php
    class Consulta extends DB {
        private $id_Rol;
        private $id_Usuario;
        private $txt_email;
        private $txt_password;

        public function __construct() {
        }

        public function getid_Rol() { return $this->id_Rol; }
        public function setid_Rol($id_Rol) { $this->id_Rol = $id_Rol; return $this; }

        public function getId_Usuario() { return $this->id_Usuario; }
        public function setId_Usuario($id_Usuario) { $this->id_Usuario = $id_Usuario; return $this; }

        public function getTxt_email() { return $this->txt_email; }
        public function setTxt_email($txt_email) { $this->txt_email = $txt_email; return $this; }

        public function getTxt_password() { return $this->txt_password; }
        public function setTxt_password($txt_password) { $this->txt_password = $txt_password; return $this; }



        function query_select_Usuario_by_login() {
            $database = new DB;
            $conexion = $database->ConectarDB();
            $sql = "call sp_Consultas ('Login', 0, 0, ?, ?)";
            $statementSelect = $conexion->prepare($sql);
            $statementSelect->execute(array($this->txt_email, $this->txt_password));
            $rows = $statementSelect->fetchAll();

            //$resultados = mysqli_query($conexion, "call sp_Consultas ('Login', 0, 0, '{$this->txt_email}', '{$this->txt_password}')");
            //mysqli_close($conexion);

            return $rows;
        }

        function query_select_Usuario_by_Perfil() {
            $database = new DB;
            $conexion = $database->ConectarDB();
            $sql = "call sp_Consultas ('Perfil', ?, 0, '', '')";
            $statementSelect = $conexion->prepare($sql);
            $statementSelect->execute(array($this->id_Usuario));
            $rows = $statementSelect->fetchAll();
            
            //$resultados = mysqli_query($conexion, "call sp_Consultas ('Perfil', '{$this->id_Usuario}', 0, '', '')");
            //mysqli_close($conexion);

            return $rows;
        }

        function query_select_comentarios_by_curso($id_curso) {
            $database = new DB;
            $conexion = $database->ConectarDB();
            $sql = "call sp_Consultas ('Comentarios', ?, 0, '', '')";
            $statementSelect = $conexion->prepare($sql);
            $statementSelect->execute(array($id_curso));
            $rows = $statementSelect->fetchAll();
            
            return $rows;
        }

        function query_select_curso_by_id($id_curso) {
            $database = new DB;
            $conexion = $database->ConectarDB();
            $sql = "call sp_Consultas ('Curso', ?, 0, '', '')";
            $statementSelect = $conexion->prepare($sql);
            $statementSelect->execute(array($id_curso));
            $rows = $statementSelect->fetchAll();
            
            return $rows;
        }

        function query_select_capitulos_by_curso($id_curso) {
            $database = new DB;
            $conexion = $database->ConectarDB();
            $sql = "call sp_Consultas ('Videos', ?, 0, '', '')";
            $statementSelect = $conexion->prepare($sql);
            $statementSelect->execute(array($id_curso));
            $rows = $statementSelect->fetchAll();
            
            return $rows;
        }

        function query_select_secciones_by_curso($id_curso) {
            $database = new DB;
            $conexion = $database->ConectarDB();
            $sql = "call sp_Consultas ('Secciones', ?, 0, '', '')";
            $statementSelect = $conexion->prepare($sql);
            $statementSelect->execute(array($id_curso));
            $rows = $statementSelect->fetchAll();
            
            return $rows;
        }

        function query_select_all_cursos() {
            $database = new DB;
            $conexion = $database->ConectarDB();
            $sql = "call sp_Consultas ('All_cursos', 0, 0, '', '')";
            $statementSelect = $conexion->prepare($sql);
            $statementSelect->execute();
            $rows = $statementSelect->fetchAll();
            
            return $rows;
        }

        function query_select_all_categorias() {
            $database = new DB;
            $conexion = $database->ConectarDB();
            $sql = "call sp_Consultas ('All_categorias', 0, 0, '', '')";
            $statementSelect = $conexion->prepare($sql);
            $statementSelect->execute();
            $rows = $statementSelect->fetchAll();
            
            return $rows;
        }

        function query_select_busqueda($opc, $curso, $categoria, $usuario, $opcFiltro, $dateini, $dateFin) {
            if($usuario == 'Todos') { $usuario = ''; }

            $database = new DB;
            $conexion = $database->ConectarDB();
            $sql = "call sp_Busquedas (?, ?, ?, ?, ?, ?, ?)";
            $statementSelect = $conexion->prepare($sql);
            $statementSelect->execute(array($opc, $curso, $categoria, $usuario, $opcFiltro, $dateini, $dateFin));
            $rows = $statementSelect->fetchAll();
            
            return $rows;
        }

        function query_select_accesos($curso, $usuario) {
            $database = new DB;
            $conexion = $database->ConectarDB();
            $sql = "call sp_Consultas ('Accesos_User', ?, ?, '', '')";
            $statementSelect = $conexion->prepare($sql);
            $statementSelect->execute(array($curso, $usuario));
            $rows = $statementSelect->fetchAll();
            
            return $rows;
        }

        function query_select_cursosReg_By_Usuario($usuario) {
            $database = new DB;
            $conexion = $database->ConectarDB();
            $sql = "call sp_Consultas ('All_Registrados', ?, 0, '', '')";
            $statementSelect = $conexion->prepare($sql);
            $statementSelect->execute(array($usuario));
            $rows = $statementSelect->fetchAll();
            
            return $rows;
        }

        function query_select_cursoReg_By_Usuario($usuario, $curso) {
            $database = new DB;
            $conexion = $database->ConectarDB();
            $sql = "call sp_Consultas ('Registrados_User', ?, ?, '', '')";
            $statementSelect = $conexion->prepare($sql);
            $statementSelect->execute(array($usuario, $curso));
            $rows = $statementSelect->fetchAll();
            
            return $rows;
        }

        function query_select_mensajes_By_Usuario($usuario, $curso) {
            $database = new DB;
            $conexion = $database->ConectarDB();
            $sql = "call sp_Consultas ('Mensajes', ?, ?, '', '')";
            $statementSelect = $conexion->prepare($sql);
            $statementSelect->execute(array($curso, $usuario));
            $rows = $statementSelect->fetchAll();
            
            return $rows;
        }

        function query_select_ChatsActivos_By_Maestro($usuario) {
            $database = new DB;
            $conexion = $database->ConectarDB();
            $sql = "call sp_Consultas ('Mensajes_Maestro', ?, 0, '', '')";
            $statementSelect = $conexion->prepare($sql);
            $statementSelect->execute(array($usuario));
            $rows = $statementSelect->fetchAll();
            
            return $rows;
        }

        function query_select_Cursos_By_Maestro($usuario) {
            $database = new DB;
            $conexion = $database->ConectarDB();
            $sql = "call sp_Consultas ('Cursos_Maestro', ?, 0, '', '')";
            $statementSelect = $conexion->prepare($sql);
            $statementSelect->execute(array($usuario));
            $rows = $statementSelect->fetchAll();
            
            return $rows;
        }

        function query_select_reporte1($usuario, $curso) {
            $database = new DB;
            $conexion = $database->ConectarDB();
            $sql = "call sp_Reportes ('Ventas_Cursos', ?, ?)";
            $statementSelect = $conexion->prepare($sql);
            $statementSelect->execute(array($usuario, $curso));
            $rows = $statementSelect->fetchAll();
            
            return $rows;
        }

        function query_select_reporte2($usuario, $curso) {
            $database = new DB;
            $conexion = $database->ConectarDB();
            $sql = "call sp_Reportes ('Ventas_Tipo_De_Pago', ?, ?)";
            $statementSelect = $conexion->prepare($sql);
            $statementSelect->execute(array($usuario, $curso));
            $rows = $statementSelect->fetchAll();
            
            return $rows;
        }

        function query_select_reporte3($usuario, $curso) {
            $database = new DB;
            $conexion = $database->ConectarDB();
            $sql = "call sp_Reportes ('Ventas_Totales', ?, ?)";
            $statementSelect = $conexion->prepare($sql);
            $statementSelect->execute(array($usuario, $curso));
            $rows = $statementSelect->fetchAll();
            
            return $rows;
        }

        function query_select_reporte4($usuario, $curso) {
            $database = new DB;
            $conexion = $database->ConectarDB();
            $sql = "call sp_Reportes ('Ventas_Detalladas', ?, ?)";
            $statementSelect = $conexion->prepare($sql);
            $statementSelect->execute(array($usuario, $curso));
            $rows = $statementSelect->fetchAll();
            
            return $rows;
        }
        
        function query_select_info_diploma($usuario, $curso) {
            $database = new DB;
            $conexion = $database->ConectarDB();
            $sql = "call sp_Consultas ('Diploma', ?, ?, '', '')";
            $statementSelect = $conexion->prepare($sql);
            $statementSelect->execute(array($usuario, $curso));
            $rows = $statementSelect->fetchAll();
            
            return $rows;
        }

        function query_select_cantidad_terminados($usuario) {
            $database = new DB;
            $conexion = $database->ConectarDB();
            $sql = "call sp_Consultas ('Cont_Terminados', ?, 0, '', '')";
            $statementSelect = $conexion->prepare($sql);
            $statementSelect->execute(array($usuario));
            $rows = $statementSelect->fetchAll();
            
            return $rows;
        }

        function query_select_cantidad_interminados($usuario) {
            $database = new DB;
            $conexion = $database->ConectarDB();
            $sql = "call sp_Consultas ('Cont_inTerminados', ?, 0, '', '')";
            $statementSelect = $conexion->prepare($sql);
            $statementSelect->execute(array($usuario));
            $rows = $statementSelect->fetchAll();
            
            return $rows;
        }

        function query_select_ultimo_visitado($usuario) {
            $database = new DB;
            $conexion = $database->ConectarDB();
            $sql = "call sp_Consultas ('Ultimo_Curso', ?, 0, '', '')";
            $statementSelect = $conexion->prepare($sql);
            $statementSelect->execute(array($usuario));
            $rows = $statementSelect->fetchAll();
            
            return $rows;
        }
    }
