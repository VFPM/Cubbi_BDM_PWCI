$(document).ready(function(){
    var precio;
    var idTema;
    var idCurso;
    var isRegistrado = false;
    var isCursoPorCapitulos = false;

    $(".btn_diseño_cap").click(function(){
        var hijo = $(this).children("a");
        var TemaComprar = $(hijo).attr("Tema");
        console.log(TemaComprar);
        $(".temaComprar").text('Tema ' + TemaComprar);
        $(".temaComprar").attr("idtema", TemaComprar);

        precio = $(hijo).attr("Precio");
        idCurso = $(hijo).attr("Curso");
        idTema = TemaComprar;
        isCursoPorCapitulos = true;
    });

    paypal.Buttons({
        
        style: {
            shape: 'pill',
            color: 'blue',
            layout: 'horizontal',
            label: 'paypal',
        },

        createOrder: function(data, actions) {
            return actions.order.create({
                purchase_units: [{"amount":{"currency_code":"MXN","value":precio}}]
            });
        },

        onApprove: function(data, actions) {
            contador ++;
            console.log(contador);
            MostrarMsgBox("Registrado y comprado con exito", "Espero que te guste el curso", "success");
            $(location).attr('href','#');
            var padre = $("[Tema=" + idTema + "]").parent();
            $("[Tema=" + idTema + "]").remove();
            padre.replaceWith('<h2 class="comprado">Tema Comprado</h2>');

            if(isRegistrado == false){
                isRegistrado = true;

                var form_registro = new FormData();
                form_registro.append('curso', idCurso);
                form_registro.append('seccion', idTema);

                $.ajax({
                    data: form_registro,
                    url: '/Cubbi_BDM_PWCI/Controladores/db_agregar_registro_curso.php',
                    method: 'POST',
                    contentType: false,
                    processData: false,
                })
                .done(function(result){
                    console.log(result);
                })
                
                .fail(function(result){
                    console.log(result);
                });
            }

            if(isCursoPorCapitulos) {

            } else {

            }
        },

        onError: function(err) {
            alert(err);
        }

    }).render('#paypal-button-container');



    function MostrarMsgBox(titulo, descripcion, icono){
        Swal.fire({
            title: titulo,
            text: descripcion,
            icon: icono,
            background: '#B8B7C9',
            confirmButtonText: 'OK'
        });
    }

});