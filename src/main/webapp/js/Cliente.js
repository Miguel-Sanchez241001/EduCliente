/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

                    //function websocket(){
                    var ws;
                    var wsUri = "ws://localhost:8080/Edut/websocketserver";
                    ws = new WebSocket(wsUri);
                    var authHeader;
                    let nombre = document.getElementById('nombreUser').innerHTML;
                    const selector = document.getElementById('destinatario');
                    const txtArea = document.querySelector('#mensajes');
                   // Mensaje enviado al servidor por cada nuevo usuario
                        ws.onopen = function () {
                       // console.log(nombre);
                        ws.send(nombre);
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
                        message = document.getElementById('mensaje').value;
                         towho = selector.value + "@";
                          ws.send(towho + message);
                    }
        
                    // Cuando ocurre un error, maneje el error
                    ws.onerror = function (evt) {
                        alert("Error en la conexion procede a cerrarla");
                        ws.close();
                    };
        
                    // Mostrar información en la pantalla actual
                    function writeToScreen(message) {
                        txtArea.value += message + '\n';
                    }
        
                    // Ejecuta ws.close al cerrar la página
                    window.onbeforeunload = function () {
                        ws.close();
                    };
                    //  }

 


