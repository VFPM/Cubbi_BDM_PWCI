<link rel="stylesheet" href="../Login/login.css">
<link rel="stylesheet" href="../Navegacion/nav.css">
<link rel="stylesheet" href="./registro.css">
<div class="contenedor">
        <div class="bloque">
            <a href="../principal/h.php"> <img src="/Cubbi_BDM_PWCI/Ventanas_de_la_poderosa_Curi/Multimedia/logo.png" alt="logo" class="logo">  </a>    
            <div class="contenido">
                <div class="tittle "><h1> Registro</h1></div>
                    <div class="cont-texto">
                    <div class="email cont"> 
                        <h1>Nombre</h1>
                        <input type="text"  id="inputsearch" placeholder="Nombre" class="diseno-input"> 
                    </div>  
                    <div class="email cont"> 
                        <h1>Apellidos</h1>
                        <input type="text"  id="inputsearch" placeholder="Apellidos" class="diseno-input"> 
                    </div>
                    <div class="email cont"> 
                        <h1>Correo</h1>
                        <input type="text"  id="inputsearch" placeholder="Correo" class="diseno-input"> 
                    </div>
                    <div class="Genero_Fecha email"> 
                        <div class="cabecera">
                            <h1>Genero</h1>
                            <select name="genero" id="Genero">
                                <option value="Femenino">Femenino</option>
                                <option value="Masculino">Masculino</option>
                                <option value="Otrp">Otro</option>
                            </select>                            
                        </div>
                        <div class="cabecera">
                        <h1>Cumpleaños</h1>
                        <input type="date" id="start" name="trip-start"  min="1921-07-07" > 
                        </div>
                        
                        
                    </div>
                    <div class="pass cont">
                        <h1>Contraseña</h1>
                        <input type="password"  id="inputsearch" placeholder="Contraseña" class="diseno-input"> 
                    </div>   
                    <div class="pass cont">
                        <h1>Confirmar contraseña</h1>
                        <input type="password"  id="inputsearch" placeholder="Contraseña" class="diseno-input"> 
                    </div>    
                    <a href="../Cursos/cursos.php"> <button class="btn-inicio"> Registrarse</button>   </a>
                    
                    
                </div>
            </div>
        </div>       
    </div>
