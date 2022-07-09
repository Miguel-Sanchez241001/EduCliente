<%-- 
    Document   : mainAl
    Created on : 16/12/2021, 12:24:41 PM
    Author     : pc
--%>

<%@page import="ws.Docente"%>
<%@page import="ws.Materia"%>
<%@page import="ws.Nota"%>
<%@page import="java.util.List"%>
<%@page import="ValidSesion.ValidSession"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%  ValidSession.validAlumno(request, response);
    List<Nota> notas;
    Integer acum;
    List<Docente> docentes;
    String username, message, Alumno, profe;
%>
<%
    ValidSession.validAlumno(request, response);
    username = (String) request.getAttribute("username");
    message = (String) request.getAttribute("message");
    Alumno = (String) request.getAttribute("Alumno");
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
                    <li class="nav-item active mr-sm-2 ">
                        <a class="nav-link " href="Alumno?opcion=1&usuario=<%=username%>">Notas</a>
                    </li>
                    <li class="nav-item active mr-sm-2 ">
                        <a class="nav-link " href="Alumno?opcion=2&usuario=<%=username%>">Cursos</a>
                    </li>
                    <li class="nav-item active mr-sm-2 ">
                        <a class="nav-link " href="Alumno?opcion=3&usuario=<%=username%>">Bibloteca</a>
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
            <h1  style="display: inline-block" class="display-1 col-auto text-uppercase"> TU MEJOR OPCIÓN <%= username%> </h1>
        </div>



        <!--TABLA NOTAS-->
        <%
            if (message.equals("1")) {
                notas = (List<Nota>) request.getAttribute("lista");
        %>
        <div class="container p- mb-2 bg-white ">
            <table class="table table-dark table-striped">
                <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Materia</th>
                        <th scope="col">Nota</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (Nota nota : notas) {
                    %>
                    <%
                        if (nota.getAlumno().getNombre().equals(Alumno)) {
                    %>
                    <tr>
                        <th scope="row"><%= acum++%></th>                      
                        <td><%= nota.getIdCurso().getMateria()%></td>
                        <td><%= nota.getNota()%></td>
                    </tr>
                    <%  }%>

                    <%  }%>
                </tbody>
            </table>
        </div>
        <% }%>  


        <!--CURSOS-->
        <%
            if (message.equals("2")) {
                
        %>
     <div class=" container-sm w-75 mx-auto" >
            <div class="row row-cols-5  row-cols-md-5 g-5">
                <div class="col p-2">
                    <div class="card h-100">
                        <img src="https://ichef.bbci.co.uk/news/640/cpsprodpb/164EE/production/_109347319_gettyimages-611195980.jpg" class="card-img-top" alt="...">
                        <div class="card-body">
                            <h5 class="card-title text-uppercase">Matematica</h5>
                            <p class="card-text ">This is a longer card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
                        </div>
                        <div class=" w-100 text-center"><a href="#" class="w-100 btn btn-primary" target="_blank">Consultar Docente</a></div>
                    </div>
                </div>
                <div class="col p-2">
                    <div class="card h-100 ">
                        <img src="https://www.buk.cl/hubfs/comunicacio%CC%81n%20efectiva%202jpg-06.jpg" class="card-img-top" alt="...">
                        <div class="card-body">
                            <h5 class="card-title text-uppercase">comunicacion</h5>
                            <p class="card-text">This is a longer card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
                        </div>
                        <div class=" w-100 text-center"><a href="#" class="w-100 btn btn-primary" target="_blank">Consultar Docente</a></div>
                    </div>
                </div>
                <div class="col p-2">
                    <div class="card  h-100">
                        <img src="https://www.bbva.com/wp-content/uploads/2019/04/cienciabbva_optimized-1024x768.jpg" class="card-img-top" alt="...">
                        <div class="card-body">
                            <h5 class="card-title text-uppercase">ciencia</h5>
                            <p class="card-text">This is a longer card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
                        </div>
                        <div class=" w-100 text-center"><a href="#" class="w-100 btn btn-primary" target="_blank">Consultar Docente</a></div>
                    </div>
                </div>
                <div class="col p-2">
                    <div class="card h-100 ">
                        <img src="https://significa.do/wp-content/uploads/2019/03/religion.jpg" class="card-img-top" alt="...">
                        <div class="card-body">
                            <h5 class="card-title text-uppercase">religion</h5>
                            <p class="card-text">This is a longer card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
                        </div>
                        <div class=" w-100 text-center"><a href="#" class="w-100 btn btn-primary" target="_blank">Consultar Docente</a></div>
                    </div>
                </div>
                <div class="col p-2">
                    <div class="card h-100 ">
                        <img src="https://i0.wp.com/sonria.com/wp-content/uploads/2016/05/fisica.jpg?resize=1080%2C675&ssl=1" class="card-img-top" alt="...">
                        <div class="card-body">
                            <h5 class="card-title text-uppercase">Fisica</h5>
                            <p class="card-text">This is a longer card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
                        </div>
                        <div class=" w-100 text-center"><a href="#" class="w-100 btn btn-primary" target="_blank">Consultar Docente</a></div>
                    </div>
                </div>

            </div>
        </div>  
        <% }%> 


        <!-- Bibloteca -->
        <%
            if (message.equals("3")) {
        %>
        <div class=" w-75 mx-auto row row-cols-1 row-cols-md-2 g-4">
            <div class="col">
                <div class="card h-100">
                    <img src="	https://virtual.autonoma.edu.pe/CampusVirtual/assets/img/Biblioteca/odilo.png" class="card-img-top" alt="...">
                    <div class="card-body">
                        <h5 class="card-title">ebooks</h5>
                        <p class="card-text ">Biblioteca digital de aprendizaje inteligente que brinda contenido multidisciplinario de calidad a texto completo que procede de las editoriales más reconocidas del mundo.
                            Nota: Para iniciar y registrarse debe colocar el código uniaperu2022</p>
                    </div>
                    <div class=" w-100 text-center"><a href="https://university.odilo.es/" class="w-100 btn btn-primary" target="_blank">Consultar</a></div>
                </div>
            </div>
            <div class="col">
                <div class="card h-100">
                    <img src="https://virtual.autonoma.edu.pe/CampusVirtual/assets/img/Biblioteca/20220216_SCIELO.jpg" class="card-img-top" alt="...">
                    <div class="card-body">
                        <h5 class="card-title">Base de datos</h5>
                        <p class="card-text">Base de datos de revistas científicas a texto completo, especialmente desarrollado para responder a las necesidades de los países en América Latina y el Caribe.</p>
                    </div>
                    <div class=" w-100 text-center">
                        <a href="https://scielo.org/es/" class=" w-100 btn btn-primary" target="_blank">Consultar</a>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="card h-100">
                    <img src="https://virtual.autonoma.edu.pe/CampusVirtual/assets/img/Biblioteca/20220216_DIALNET.jpg" class="card-img-top" alt="...">
                    <div class="card-body">
                        <h5 class="card-title">Base de datos</h5>
                        <p class="card-text">Base de datos de acceso abierto, que contiene artículos de revistas, artículos obras colectivas, libros, actas de congresos, reseñas bibliográficas y tesis doctorales.</p>
                    </div><div class=" w-100 text-center">
                        <a href="https://dialnet.unirioja.es/" class=" w-100 btn btn-primary" target="_blank">Consultar</a>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="card h-100">
                    <img src="https://virtual.autonoma.edu.pe/CampusVirtual/assets/img/Biblioteca/20220216_REDALYC.jpg" class="card-img-top" alt="...">
                    <div class="card-body">
                        <h5 class="card-title">Revistas</h5>
                        <p class="card-text">Contiene acceso a revistas de alta calidad científica, comparte el modelo de publicación sin fines de lucro para conservar la naturaleza académica y abierta de la comunicación científica</p>
                    </div>
                    <div class=" w-100 text-center"> <a href="https://www.redalyc.org/" class=" w-100 btn btn-primary" target="_blank">Consultar</a></div>

                </div>
            </div>
        </div>
        <%  }%>
































    </body>
</html>
