<%-- 
    Document   : mainD
    Created on : 16/12/2021, 12:24:51 PM
    Author     : pc
--%>

<%@page import="ws.Alumno"%>
<%@page import="ws.Nota"%>
<%@page import="java.util.List"%>
<%@page import="ValidSesion.ValidSession"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%  ValidSession.validDocente(request, response);
    Integer acum;
    List<Alumno> alumno;
    List<Nota> notas;
    String username, message, Docente;
%>
<%
    username = (String) request.getAttribute("username");
    message = (String) request.getAttribute("message");
    Docente = (String) request.getAttribute("Docente");

    acum = 1;
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="css/estilos.css" rel="stylesheet" type="text/css"/>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Kdam+Thmor+Pro&display=swap" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js" integrity="sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s" crossorigin="anonymous"></script>
        <link rel="icon" href="https://w7.pngwing.com/pngs/695/140/png-transparent-information-education-com-computer-icons-others-thumbnail.png">
        <title>Edutin</title>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <a class="navbar-brand" href="Docente">Edutin</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active mr-sm-2 ">
                        <a class="nav-link " href="Docente?opcion=registro&usuario=<%=username%>">Notas</a>
                    </li>
                    <li class="nav-item active mr-sm-2 ">
                        <a class="nav-link " href="Docente?opcion=alumnos&usuario=<%=username%>">Alumnos</a>
                    </li>
                    <li class="nav-item active mr-sm-2 ">
                        <a class="nav-link " href="Docente?opcion=ver&usuario=<%=username%>">Ver</a>
                    </li>
                    <li class="nav-item active mr-sm-2 ">
                        <a class="nav-link " href="Chat.jsp">Chat</a>
                    </li>
                </ul>
                <ul class="navbar-nav my-2 my-lg-0">
                    <li class="nav-item active mr-sm-2 ">
                        <a class="nav-link " href="SignOut">Salir</a>
                    </li>
                </ul>
            </div>
        </nav>

        <div id="div1"class="fadeIn first">
            <img src="img/logo.PNG" id="icon" alt="User Icon" />
            <h1  style="display: inline-block" class="display-1 col-auto"> TU MEJOR OPCIÓN <%= username%> </h1>
        </div>



        <!--FORMULARIO REGISTRO Nota-->
        <%
            if (message.equals("1")) {
                alumno = (List<Alumno>) request.getAttribute("lista");
        %>
        <div class="container my-0" id="advanced-search-form">
            <h2>Registrar Nota</h2>
            <form action="Docente" method="post">
                <div class="form-group">
                    <label for="Alumno">Alumno</label>
                    <select class="form-control"name="Alumno">

                        <%
                            for (Alumno ali : alumno) {
                        %>
                        <option value="<%=ali.getNombre()%>"><%=ali.getNombre()%></option>
                        <%}%>
                    </select>
                </div>
                <div class="form-group">
                    <label for="Nota">Nota</label>
                    <input type="number" name="Nota" class="form-control" placeholder="Nota" id="Nota">
                </div>
                <input type="text" name="tipo" class="form-control" value="registro" hidden id="password">
                <input type="text" name="usuario" class="form-control" value="<%=username%>" hidden id="password">
                <button type="submit" class="btn btn-info btn-lg btn-responsive" >Registrar</button>
            </form>
        </div>   
        <% }%>       

        <!--TABLA ALUMNOS-->
        <%
            if (message.equals("2")) {
                alumno = (List<Alumno>) request.getAttribute("lista");
        %>
        <div class="container p- mb-2 bg-white ">
            <table class="table table-dark table-striped">
                <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Nombre</th>
                        <th scope="col">Apellido</th>
                        <th scope="col">Edad</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (Alumno alum : alumno) {
                    %>

                    <%
                        if (alum.getIdDocente().getNombre().equals(Docente)) {
                    %>
                    <tr>
                        <th scope="row"><%= acum++%></th>
                        <td><%= alum.getNombre()%></td>
                        <td><%= alum.getApellido()%></td>
                        <td><%= alum.getEdad()%></td>
                    </tr>
                    <%  }%>
                    <%  }%>
                </tbody>
            </table>
        </div>
        <% }%>  


        <!--TABLA NOTAS-->
        <%
            if (message.equals("3")) {
                notas = (List<Nota>) request.getAttribute("lista");
        %>
        <div class="container p- mb-2 bg-white ">
            <table class="table table-dark table-striped">
                <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Alumno</th>
                        <th scope="col">Nota</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (Nota nota : notas) {
                    %>
                    <tr>
                        <th scope="row"><%= acum++%></th>                      
                        <td><%= nota.getAlumno().getNombre() + " " + nota.getAlumno().getApellido()%></td>
                        <td><%= nota.getNota()%></td>
                    </tr>
                    <%  }%>
                </tbody>
            </table>
        </div>
        <% }%>





























    </body>
</html>
