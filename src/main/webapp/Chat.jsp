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
            <p id="nombreUser"><%=Nombre%></p>
        </header>



        <div class="col-sm-6">
            <textarea id="mensajes" rows="10" cols="10" class="form-control" placeholder="Mensajes" readonly></textarea>
        </div>
        <div class="col-sm-5">
            <form action="ChatSev" target="el-iframe">
                <input type="text" id="mensaje" name="message" class="form-control" value="" placeholder="Escriba aqui">
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
<script src="js/Cliente.js"></script> 
        

    </body>
</html>