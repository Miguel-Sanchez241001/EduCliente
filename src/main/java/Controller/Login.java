
package Controller;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.ws.WebServiceRef;
import ws.ServiciosEdutin_Service;
import ws.Usuario;



@WebServlet(name = "Login", urlPatterns = {"/Login"})
public class Login extends HttpServlet {

   @WebServiceRef(wsdlLocation = "WEB-INF/wsdl/localhost_8080/EdutinServicio/ServiciosEdutin.wsdl")
    private ServiciosEdutin_Service service;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession sesion = request.getSession(true);
        String username = request.getParameter("UserName");
        String password = request.getParameter("Clave");
        Usuario usuario = loguear(username);
        RequestDispatcher requestDispatcher = null;
        String mensaje = "hhol";
        if (!usuario.getUsername().equals("na")) {
            sesion.setAttribute("username", username);
            if (usuario.getClave().equals(password)) {
                switch (usuario.getTipo()) {
                    case 1:
                        sesion.setAttribute("key", "dsjhf.FDS!543|5G*DFgfdrhd%#454GDfgDb" + username);
                        mensaje = "admin";
                        requestDispatcher = request.getRequestDispatcher("mainA.jsp");
                        break;
                    case 2:
                        sesion.setAttribute("key", "121241qfqweqtqasdafefqwefqwefq" + username);
                        mensaje = "Docente";
                        requestDispatcher = request.getRequestDispatcher("mainD.jsp");
                        break;
                    case 3:

                        sesion.setAttribute("key", "asdfasfawfn26519qwubqwiugbqw" + username);
                        mensaje = "alumno";
                        requestDispatcher = request.getRequestDispatcher("mainAl.jsp");
                        break;

                }
                request.setAttribute("username", username);
                request.setAttribute("message", mensaje);
                requestDispatcher.forward(request, response);

            } else {

                request.setAttribute("username", username);
                request.setAttribute("message", "La contraseña es incorrecta");
                requestDispatcher = request.getRequestDispatcher("index.jsp");
                requestDispatcher.forward(request, response);

            }
        } else {
            request.setAttribute("username", username);
            request.setAttribute("message", "El usuario y/o contraseña son incorrectos");
            requestDispatcher = request.getRequestDispatcher("index.jsp");
            requestDispatcher.forward(request, response);
        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Login de la web";
    }// </editor-fold>

    private Usuario loguear(java.lang.String userName) {
        // Note that the injected javax.xml.ws.Service reference as well as port objects are not thread safe.
        // If the calling of port operations may lead to race condition some synchronization is required.
        ws.ServiciosEdutin port = service.getServiciosEdutinPort();
        return port.loguear(userName);
    }

   

}
