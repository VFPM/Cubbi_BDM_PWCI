<aside id="modal" class="modal"> 
    <div class="contenido-modal"> 
        <header>
            <h1>Editor</h1>
            <a href="#" class="cerrar"> <h3 class="x"> <i class="fas fa-times-circle"></i> </h3> </a>
        </header>
        <article>
            <div class="contenedor-answer">   
                <input type="radio" id="Preguntas" name="categoria" value="preguntas" checked >
                <input type="radio" id="Respuestas" name="categoria" value="Respuestas">  
                <div class="contenedor-categoria">
                    <label for="Preguntas"> <h6 class="design-tittle separacion">Tarjeta de credito</h6></label>
                    <label for="Respuestas"><h6 class="design-tittle">Paypal</h6> </label>                                      
                </div>
                <div class="bloque-menu"  id="Registro">
                <scroll-container>
                    <div class="bloque-contenido">
                        <div class="contenedor-Preg" >
                            <div class="bloque-editar">
                                <h1></h1>
                                <input type="text" placeholder="Numero Terjeta">
                                <h1></h1>
                                <input type="text" placeholder="Fecha expiracion">
                                <h1></h1>
                                <input type="text" placeholder="Codigo seguridad">

                            </div>
                        </div> 
                        <div class="contenedor-resp" id="Registro" >
                            <div class="bloque-editar">
                                <h1> *aqui ira la opcion de paypal* </h1>
                            </div>                                                                                        
                        </div> 
                        <div class="btn-guardado">
                            <a href="../Cursos/cursos.php" class="save-modal">  <button  class="btn-guarda">Pagar</button>   </a>
                        </div>   
                    </div>                                      
                </scroll-container>                                      
            </div>                                     
        </div>
        </article>
    </div>
</aside>