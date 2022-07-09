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
       	<meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!--===============================================================================================-->	
        <link rel="icon" type="image/png" href="https://w7.pngwing.com/pngs/695/140/png-transparent-information-education-com-computer-icons-others-thumbnail.png"/>
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="assets2/vendor/bootstrap/css/bootstrap.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="assets2/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="assets2/fonts/iconic/css/material-design-iconic-font.min.css">
        <!--===============================================================================================-->
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="assets2/css/util.css">
        <link rel="stylesheet" type="text/css" href="assets2/css/main.css">

        <title>Edutin</title>
    </head>
    <body>



        <div class="limiter">
            <div class="container-login100">
                <div class="wrap-login100">
                    <form class="login100-form validate-form" action="Login" method="POST">
                        <span class="login100-form-title p-b-26">
                            Bienvenido a
                        </span>
                        <span class="login100-form-title p-b-48">
                            <img src="https://github.com/Miguel-Sanchez241001/ewe/blob/main/logo.PNG?raw=true" alt="">
                        </span>

                        <div class="wrap-input100 validate-input" data-validate = "Valid email is: a@b.c">
                            <input class="input100" type="text" name="UserName">
                            <span class="focus-input100" data-placeholder="Usuario"></span>
                        </div>

                        <div class="wrap-input100 validate-input" data-validate="Enter password">
                            <span class="btn-show-pass">
                                <i class="zmdi zmdi-eye"></i>
                            </span>
                            <input class="input100" type="password" name="Clave">
                            <span class="focus-input100" data-placeholder="Password"></span>
                        </div>

                        <div class="container-login100-form-btn">
                            <div class="wrap-login100-form-btn">
                                <div class="login100-form-bgbtn"></div>
                                <button class="login100-form-btn">
                                    Login
                                </button>
                            </div>
                        </div>
                        <%
                            if (message != null) {
                        %>
                        <div class="text-center p-t-115">
                            <span class="txt1">
                                <%= message%>
                            </span>


                        </div>

                        <%
                            }
                        %>

                    </form>
                </div>
            </div>
        </div>


        <div id="dropDownSelect1"></div>

        <!--===============================================================================================-->
        <script src="assets2/vendor/jquery/jquery-3.2.1.min.js"></script>
        <!--===============================================================================================-->
        <script src="assets2/vendor/animsition/js/animsition.min.js"></script>
        <!--===============================================================================================-->
        <script src="assets2/vendor/bootstrap/js/popper.js"></script>
        <script src="assets2/vendor/bootstrap/js/bootstrap.min.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/select2/select2.min.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/daterangepicker/moment.min.js"></script>
        <script src="vendor/daterangepicker/daterangepicker.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/countdowntime/countdowntime.js"></script>
        <!--===============================================================================================-->
        <script src="assets2/js/main.js"></script>
        <!-- Remind Passowrd -->

    </body>
</html>
