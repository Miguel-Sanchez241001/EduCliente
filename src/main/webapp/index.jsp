<%-- 
    Document   : login
    Created on : 13 dic. 2021, 00:05:48
    Author     : pc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%!
    String username, message;

%>
<%
    username = (String) request.getAttribute("username");
    message = (String) request.getAttribute("message");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <link rel="stylesheet" href="css/estilosLogin.css">
       <link rel="icon" href="https://w7.pngwing.com/pngs/695/140/png-transparent-information-education-com-computer-icons-others-thumbnail.png">
        <title>Edutin</title>
    </head>
    <body>
        
        
     
<div class="wrapper fadeInDown">
  <div id="formContent">
    <!-- Tabs Titles -->

    <!-- Icon -->
    <div class="fadeIn first">
      <img src="https://cdn-icons-png.flaticon.com/512/3135/3135768.png" id="icon" alt="User Icon" />
    </div>

    <!-- Login Form -->
    <form action="Login" method="POST">
      <input type="text" id="login" class="fadeIn second" name="UserName" placeholder="Ingresa tu usuario">
      <input type="text" id="password" class="fadeIn third" name="Clave" placeholder="password">
      <input type="submit" class="fadeIn fourth" name="btnIngresar" value="Ingresar">
    </form>

    <!-- Remind Passowrd -->
    <div id="formFooter">
      <%
            if (message != null) {
        %>

        <p > <%= message%> </p>

        <%
            }
        %>
    </div>

  </div>
</div>

    </body>
</html>
