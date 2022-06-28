<%-- 
    Document   : main
    Created on : 14/12/2021, 04:07:33 PM
    Author     : pc
--%>

<%@page import="ws.Materia"%>
<%@page import="ws.Alumno"%>
<%@page import="ws.Docente"%>
<%@page import="ws.Nota"%>
<%@page import="ValidSesion.ValidSession"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ws.Usuario"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%!
    String username, message, tipo;
    Integer acum;
    List<Usuario> usuario;
    List<Alumno> alumnos;
    List<Docente> docentes;
    List<Nota> notas;
    List<Materia> materias;
%>
<%
    ValidSession.validAdmin(request, response);
    username = (String) request.getAttribute("username");
    message = (String) request.getAttribute("message");
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
            <a class="navbar-brand" href="#">Edutin</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">

                    <li class="nav-item active">
                        <button type="button" class="nav-link btn btn-link" data-toggle="modal" data-target="#ModalRegistrar">Registrar</button>
                    </li>
                    <li class="nav-item active">
                        <button type="button" class="nav-link btn btn-link" data-toggle="modal" data-target="#ModalListar">Listar</button>
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
            <h1  style="display: inline-block" class="display-1 col-auto"> TU MEJOR OPCIÓN </h1>
        </div>



        <!--TABLA USUARIOS-->
        <%
            if (message.equals("1")) {
                usuario = (List<Usuario>) request.getAttribute("lista");
        %>
        <div class="container p- mb-2 bg-white ">
            <table class="table table-dark table-striped">
                <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Usuario</th>
                        <th scope="col">Clave</th>
                        <th scope="col">Rol</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (Usuario usuario : usuario) {
                    %>
                    <tr>
                        <th scope="row"><%=acum++%></th>
                        <td><%= usuario.getUsername()%></td>
                        <td><%= usuario.getClave()%></td>

                        <%  if (usuario.getTipo() == 1) {
                                tipo = "Admin";
                            } else {
                                if (usuario.getTipo() == 2) {
                                    tipo = "Docente";
                                } else {
                                    tipo = "Alumno";
                                }
                            }
                        %>
                        <td><%= tipo%></td>
                    </tr>
                    <%  }%>
                </tbody>
            </table>
        </div>
        <% }%>

        <!--TABLA ALUMNOS-->
        <%
            if (message.equals("2")) {
                alumnos = (List<Alumno>) request.getAttribute("lista");
        %>
        <div class="container p- mb-2 bg-white ">
            <table class="table table-dark table-striped">
                <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Nombre</th>
                        <th scope="col">Apellido</th>
                        <th scope="col">Edad</th>
                        <th scope="col">Tutor</th>
                        <th scope="col">Username</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (Alumno alumno : alumnos) {
                    %>
                    <tr>
                        <th scope="row"><%= acum++%></th>

                        <td><%= alumno.getNombre()%></td>
                        <td><%= alumno.getApellido()%></td>
                        <td><%= alumno.getEdad()%></td>
                        <td><%= alumno.getIdDocente().getNombre()%></td>
                        <td><%= alumno.getIdUser().getUsername()%></td>
                    </tr>
                    <%  }%>
                </tbody>
            </table>
        </div>
        <% }%>               

        <!--TABLA DOCENTES-->
        <%
            if (message.equals("3")) {
                docentes = (List<Docente>) request.getAttribute("lista");
        %>
        <div class="container p- mb-2 bg-white ">
            <table class="table table-dark table-striped">
                <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Nombre</th>
                        <th scope="col">Apellido</th>
                        <th scope="col">Materia</th>
                        <th scope="col">Username</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (Docente docente : docentes) {
                    %>
                    <tr>
                        <th scope="row"><%= acum++%></th>                      
                        <td><%= docente.getNombre()%></td>
                        <td><%= docente.getApellido()%></td>
                        <td><%= docente.getMateria().getMateria()%></td>
                        <td><%= docente.getUsuario().getUsername()%></td>
                    </tr>
                    <%  }%>
                </tbody>
            </table>
        </div>
        <% }%>  

        <!--TABLA NOTAS-->
        <%
            if (message.equals("4")) {
                notas = (List<Nota>) request.getAttribute("lista");
        %>
        <div class="container p- mb-2 bg-white ">
            <table class="table table-dark table-striped">
                <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Materia</th>
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
                        <td><%= nota.getIdCurso().getMateria()%></td>
                        <td><%= nota.getAlumno().getNombre() + nota.getAlumno().getApellido()%></td>
                        <td><%= nota.getNota()%></td>
                    </tr>
                    <%  }%>
                </tbody>
            </table>
        </div>
        <% }%>


        <!--FORMULARIO REGISTRO DOCENTE-->
        <%
            if (message.equals("5")) {
                materias = (List<Materia>) request.getAttribute("lista");
        %>
        <div class="container my-0" id="advanced-search-form">
            <h2>Registrar Docente</h2>
            <form action="Admin" method="post">

                <div class="form-group">
                    <label for="Nombre">Nombre</label>
                    <input type="text" name="Nombre" class="form-control" placeholder="Nombre" id="Nombre">
                </div>
                <div class="form-group">
                    <label for="Apellido">Apellido</label>
                    <input type="Apellido" name="Apellido" class="form-control" placeholder="Apellido" id="Apellido">
                </div>
                <div class="form-group">
                    <label for="Materia">Materia</label>
                    <select class="form-select" name="Materia"aria-label="Default select example">
                        <option selected>Seleccione la Materia del Docente</option>
                        <%
                            for (Materia materia : materias) {
                        %>
                        <option value="<%=materia.getId()%>"><%=materia.getMateria()%></option>
                        <% }%>
                    </select>
                </div>
                <div class="form-group">
                    <label for="Username">Username</label>
                    <input type="text" name="Username" class="form-control" placeholder="Username" id="Username">
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" name="password" class="form-control" placeholder="Password" id="password">
                </div>
                <input type="text" name="tipo" class="form-control" value="docente" hidden id="password">

                <button type="submit" class="btn btn-info btn-lg btn-responsive" >Registrar</button>
            </form>
        </div>
        <% }%>       

        <!--FORMULARIO REGISTRO ADMIN-->
        <%
            if (message.equals("6")) {
        %>
        <div class="container my-0" id="advanced-search-form">
            <h2>Registrar Admin</h2>
            <form action="Admin" method="post">

                <div class="form-group">
                    <label for="Username">Username</label>
                    <input type="text" name="Username" class="form-control" placeholder="Username" id="Username">
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" name="password" class="form-control" placeholder="Password" id="password">
                </div>
                <input type="text" name="tipo" class="form-control" value="admin" hidden id="password">

                <button type="submit" class="btn btn-info btn-lg btn-responsive" >Registrar</button>
            </form>
        </div>
        <% }%>       

        <!--FORMULARIO REGISTRO ALUMNO-->
        <%
            if (message.equals("7")) {
                docentes = (List<Docente>) request.getAttribute("lista");
        %>
        <div class="container my-0" id="advanced-search-form">
            <h2>Registrar Alumno</h2>
            <form action="Admin" method="post">

                <div class="form-group">
                    <label for="Nombre">Nombre</label>
                    <input type="text" name="Nombre" class="form-control" placeholder="Nombre" id="Nombre">
                </div>
                <div class="form-group">
                    <label for="Apellido">Apellido</label>
                    <input type="text" name="Apellido" class="form-control" placeholder="Apellido" id="Apellido">
                </div>
                <div class="form-group">
                    <label for="Edad">Edad</label>
                    <input type="number" name="pena" class="form-control" placeholder="Edad" id="Edad">
                </div>                
                <div class="form-group">
                    <label for="Tutor">Tutor</label>
                    <select class="form-control"name="Edad">
                        <%
                            for (Docente docente : docentes) {
                        %>              

                        <option value="<%=docente.getId()%>"><%=docente.getNombre() + " " + docente.getId()%></option>
                        <% }%>

                    </select>
                </div>
                <div class="form-group">
                    <label for="Username">Username</label>
                    <input type="text" name="Username" class="form-control" placeholder="Username" id="Username">
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" name="password" class="form-control" placeholder="Password" id="password">
                </div>
                <input type="text" name="tipo" class="form-control" value="alumno" hidden id="password">

                <button type="submit" class="btn btn-info btn-lg btn-responsive" >Registrar</button>
            </form>
        </div>   
        <% }%>       

        <!-- Modal para listar -->
        <div class="modal fade" id="ModalListar" tabindex="-1" role="dialog" aria-labelledby="EjemploModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Que deseas ver :</h5>
                    </div>
                    <div class="modal-body">
                        <form action="Admin" method="POST">
                            <div class="container">
                                <div class="row">
                                    <div class="col"> 
                                        <select class="form-select" name="opLis" aria-label="Default select example">
                                            <option selected>Elige</option>
                                            <option value="Admin">Usuarios</option>
                                            <option value="Alumnos">Alumnos</option>
                                            <option value="Docentes">Docentes</option>
                                            <option value="Notas">Notas</option>
                                        </select> 
                                    </div>
                                    <div class="col">
                                        <input type="submit" class="btn btn-primary " name="btnIngresar" value="Listar">
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal para Registrar -->
        <div class="modal fade" id="ModalRegistrar" tabindex="-1" role="dialog" aria-labelledby="EjemploModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Que usuario deseas registrar:</h5>
                    </div>
                    <div class="modal-body">
                        <form action="Admin" method="POST">
                            <div class="container">
                                <div class="row">
                                    <div class="col"> 
                                        <select class="form-select" name="opReg" aria-label="Default select example">
                                            <option selected>Elige</option>
                                            <option value="Admin">Admin</option>
                                            <option value="Alumnos">Alumnos</option>
                                            <option value="Docentes">Docentes</option>
                                        </select> 
                                    </div>
                                    <div class="col">
                                        <input type="submit" class="btn btn-primary " name="btnIngresar" value="Registrar">
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>















    </body>
</html>
