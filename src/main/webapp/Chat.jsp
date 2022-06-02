<%-- 
    Document   : Chat
    Created on : 09/05/2022, 01:24:50 AM
    Author     : pc
--%>



<%@page import="ValidSesion.Info"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String result, men, username;
    String Nombre = (String) request.getSession().getAttribute("username");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Sala de chat simple</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta charset="UTF-8"> 
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
        <link rel="stylesheet" href="css/ChatStyle.css">
    </head>

    <body>
        <header class="titulo">
            <h1>Sala de chat simple</h1>
            <p id="xsxs"><%=Nombre%></p>
        </header>



        <div class="col-sm-6">
            <textarea id="mensajes" rows="10" cols="10" class="form-control" placeholder="Mensajes" readonly></textarea>
        </div>
        <div class="col-sm-5">
            <form action="ChatSev" target="el-iframe">
                <input type="text" id="in" name="message" class="form-control" value="" placeholder="Escriba aqui">
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <button id="button-addon2" onclick="button()" type="submit"  class="btn btn-primary mt-2">Enviar</button>

                        </div> 
                        <div class="col"> 
                            <select class="form-select" aria-label="Default select example" id="destinatario" name="destinatario" >
                                <option value="all">Todos</option>
                            </select> 
                        </div> 
                    </div> 
                </div>

            </form>
        </div>



        <iframe class="ocultar" name="el-iframe"></iframe>
        <style>
            .ocultar{
                display: None;
            }
        </style>


















 
<script  type="text/javascript">
                    //function websocket(){
                    var ws;
                    var wsUri = "ws://localhost:8080/Edut/echo";
                    ws = new WebSocket(wsUri);
                    var authHeader;
                    let nombre = document.getElementById('xsxs').innerHTML;
                    const selector = document.getElementById('destinatario');
                    const txtArea = document.querySelector('#mensajes');
                    ws.onopen = function () {
                       
                        console.log(nombre);
                        ws.send(nombre);// Este mensaje debe ser recibido por OnMessage en el servidor
                    };
        
                    // Procesamiento de procesamiento de información después de la conexión
                    ws.onmessage = function (message) {
                        console.log({message});
                       // writeToScreen(message.data);
                       
                        authHeader = message.data;
                       
                        if (message.data.startsWith("[") ) {
                            let arr = authHeader.slice(1,-1);
                            let arr3 = arr.split(', ');
                            let arr4 = arr3.filter((item) => item !== nombre);
                            console.log({arr4});
                            let repeticion = false;
                            remover();
                            arr4.forEach(function(ar) {      
                            console.log(ar);
                                for (let i = 0; i < selector.length; i++) {
                                    
                                   if( selector[i].value === ar){
                                       repeticion = true;
                                        break;
                                    }                       
                                    
                                }
                                if (!repeticion) {
                                    agregar(ar);
                                }
                                
                            });
                            
                        }else{ 
                            writeToScreen(message.data);
                        }
                    };
                    //Remover opciones para las nuevas
                    function remover(){
                        const sel3 = document.getElementById('destinatario');
                        for (var t=1; t<sel3.length; t++) {
                                sel3.remove(t);
                        }
                    }
                    //Funcion agregar option a select
                    function agregar(valor){
                         const option = document.createElement('option');
                             option.value = valor;
                             option.text = valor;
                            selector.appendChild(option);
                    }
                    // Supervise el botón enviar para obtener la información enviada y enviar el objeto
                    function button() {
                        message = document.getElementById('in').value;
                
                towho = selector.value + "@";
                       
                ws.send(towho + message);
                    }
        
                    // Cuando ocurre un error, maneje el error
                    ws.onerror = function (evt) {
                        writeToScreen('<span style="color:red;">ERROR:</span>' + evt.data);
                        ws.close();
                    };
        
                    // Mostrar información en la pantalla actual
                    function writeToScreen(message) {
                      /**  var pre = document.createElement("p");
                        pre.style.wordWrap = "break-word";
                        pre.innerHTML = message;
                        output.appendChild(pre);
         **/
                        
                        txtArea.value += message + '\n';
                    }
        
                    // Ejecuta ws.close al cerrar la página
                    window.onbeforeunload = function () {
                        ws.close();
                    };
                    //  }
        
                </script>
    </body>
</html>