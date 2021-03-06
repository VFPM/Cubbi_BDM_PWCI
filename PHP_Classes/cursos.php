<?php
    class Cursos extends DB {
        private $ID_Curso;
        private $ID_Usuario;
        private $ID_Categoria;
        private $ID_Seccion;
        private $int_Niveles;
        private $txt_Titulo;
        private $txt_Descripcion;
        private $txt_Duracion;
        private $isPrecioGeneral;
        private $f_Precio;
        private $blob_img;
        private $blob_vid;
        private $isAcitvo;
        private $isEdited;
        private $date_registro;
        private $date_cambio;
        private $int_likes;
        private $int_inscritos;
        private $int_tema_actual;
        private $int_capitulo_actual;
        private $txt_titulo_capitulo;

        public function __construct() {
        }

        function set_idCurso($ID_Curso) { $this->ID_Curso = $ID_Curso; }
        function get_idCurso() { return $this->ID_Curso; }

        function set_idUsuario($ID_Usuario) { $this->ID_Usuario = $ID_Usuario; }
        function get_idUsuario() { return $this->ID_Usuario; }

        function set_idCategoria($ID_Categoria) { $this->ID_Categoria = $ID_Categoria; }
        function get_idCategoria() { return $this->ID_Categoria; }

        function set_idSeccion($ID_Seccion) { $this->ID_Seccion = $ID_Seccion; }
        function get_idSeccion() { return $this->ID_Seccion; }

        function set_titulo($txt_Titulo) { $this->txt_Titulo = $txt_Titulo; }
        function get_titulo() { return $this->txt_Titulo; }

        function set_niveles($int_Niveles) { $this->int_Niveles = $int_Niveles; }
        function get_niveles() { return $this->int_Niveles; }

        function set_descripcion($txt_Descripcion) { $this->txt_Descripcion = $txt_Descripcion; }
        function get_descripcion() { return $this->txt_Descripcion; }

        function set_duracion($txt_Duracion) { $this->txt_Duracion = $txt_Duracion; }
        function get_duracion() { return $this->txt_Duracion; }

        function set_isPrecioGeneral($isPrecioGeneral) { $this->isPrecioGeneral = $isPrecioGeneral; }
        function get_isPrecioGeneral() { return $this->isPrecioGeneral; }

        function set_precio($f_Precio) { $this->f_Precio = $f_Precio; }
        function get_precio() { return $this->f_Precio; }

        function set_img($blob_img) { $this->blob_img = $blob_img; }
        function get_img() { return $this->blob_img; }

        function set_video($blob_vid) { $this->blob_vid = $blob_vid; }
        function get_video() { return $this->blob_vid; }

        function set_isAcitvo($isAcitvo) { $this->isAcitvo = $isAcitvo; }
        function get_isAcitvo() { return $this->isAcitvo; }

        function set_isEdited($isEdited) { $this->isEdited = $isEdited; }
        function get_isEdited() { return $this->isEdited; }

        function set_profesor($txt_profesor) { $this->txt_profesor = $txt_profesor; }
        function get_profesor() { return $this->txt_profesor; }

        function set_registro($date_registro) { $this->date_registro = $date_registro; }
        function get_registro() { return $this->date_registro; }

        function set_cambio($date_cambio) { $this->date_cambio = $date_cambio; }
        function get_cambio() { return $this->date_cambio; }

        function set_likes($int_likes) { $this->int_likes = $int_likes; }
        function get_likes() { return $this->int_likes; }

        function set_Inscritos($int_inscritos) { $this->int_inscritos = $int_inscritos; }
        function get_Inscritos() { return $this->int_inscritos; }

        function set_tema($int_tema_actual) { $this->int_tema_actual = $int_tema_actual; }
        function get_tema() { return $this->int_tema_actual; }

        function set_capitulo($int_capitulo_actual) { $this->int_capitulo_actual = $int_capitulo_actual; }
        function get_capitulo() { return $this->int_capitulo_actual; }

        function set_titulo_capitulo($txt_titulo_capitulo) { $this->txt_titulo_capitulo = $txt_titulo_capitulo; }
        function get_titulo_capitulo() { return $this->txt_titulo_capitulo; }

        public function query_insert_curso() {
            try{
                $database = new DB;
                $conexion = $database->ConectarDB();
                $sql = "call sp_Cursos('A', null, ?, ?, ?, ?, ?, ?, ?, ?, '{$this->blob_img}', ?, true, false)";
                $statement = $conexion->prepare($sql);
                $statement->execute(array($this->ID_Usuario, $this->ID_Categoria, $this->int_Niveles, $this->txt_Titulo, $this->txt_Descripcion, $this->txt_Duracion, $this->isPrecioGeneral, $this->f_Precio, $this->blob_vid));
                $statement->closeCursor();

            }catch(Exception $e) {
                return $e;
            }
        }

        public function query_insert_acceso() {
            try{
                $database = new DB;
                $conexion = $database->ConectarDB();
                $sql = "call sp_Accesos('A', ?, ?, ?)";
                $statement = $conexion->prepare($sql);
                $statement->execute(array($this->ID_Usuario, $this->ID_Curso, $this->ID_Seccion));
                $statement->closeCursor();

            }catch(Exception $e) {
                return $e;
            }
        }

        public function query_eliminar_curso() {
            try{
                $database = new DB;
                $conexion = $database->ConectarDB();
                $sql = "call sp_Cursos('B', ?, 0, 0, 0, '', '', '', false, 0, null, '', false, false)";
                $statement = $conexion->prepare($sql);
                $statement->execute(array($this->ID_Curso));
                $statement->closeCursor();

            }catch(Exception $e) {
                return $e;
            }
        }

        public function query_reactivar_curso() {
            try{
                $database = new DB;
                $conexion = $database->ConectarDB();
                $sql = "call sp_Cursos('D', ?, 0, 0, 0, '', '', '', false, 0, null, '', false, false)";
                $statement = $conexion->prepare($sql);
                $statement->execute(array($this->ID_Curso));
                $statement->closeCursor();

            }catch(Exception $e) {
                return $e;
            }
        }

        public function query_update_curso() {
            try{
                $database = new DB;
                $conexion = $database->ConectarDB();
                $sql = "call sp_Cursos('C', ?, ?, ?, ?, ?, ?, ?, ?, ?, '{$this->blob_img}', ?, true, true)";
                $statement = $conexion->prepare($sql);
                $statement->execute(array($this->ID_Curso, $this->ID_Usuario, $this->ID_Categoria, $this->int_Niveles, $this->txt_Titulo, $this->txt_Descripcion, $this->txt_Duracion, $this->isPrecioGeneral, $this->f_Precio, $this->blob_vid));
                $statement->closeCursor();

            }catch(Exception $e) {
                return $e;
            }
        }
    }
?>