/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
(function (window, document, JSON) {
    'use strict';

var ws;
var nombre = document.getElementById('nombre').value;
        var wsUri = "ws://localhost:8080/testSoccket/echo";
        ws = new WebSocket(wsUri);
        
        ws.onopen = function(){
        //  n=prompt('Por favor, dése un apodo:');
         // n=n.substr(0,16);
        
        console.log(nombre);
          ws.send(nombre);// Este mensaje debe ser recibido por OnMessage en el servidor
        };
 
        // Procesamiento de procesamiento de información después de la conexión
        ws.onmessage = function(message){
             writeToScreen(message.data); 
        };
 
        // Supervise el botón enviar para obtener la información enviada y enviar el objeto
        function button(){
          message = document.getElementById('in').value;
          towho = document.getElementById('destinatario').value + "@";
          ws.send(towho+message);
        }   
 
        // Cuando ocurre un error, maneje el error
        ws.onerror = function (evt){ 
                writeToScreen('<span style="color:red;">ERROR:</span>'+evt.data);
                ws.close();
            };
 
        // Mostrar información en la pantalla actual
        function writeToScreen(message){
            var pre = document.createElement("p");
            pre.style.wordWrap = "break-word";
            pre.innerHTML = message;
            output.appendChild(pre);
        }   
 
        // Ejecuta ws.close al cerrar la página
        window.onbeforeunload=function (){ 
             ws.close();
        }; 
})(window, document, JSON);
 


