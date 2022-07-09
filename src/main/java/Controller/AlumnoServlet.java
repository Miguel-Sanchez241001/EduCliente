/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import ValidSesion.ValidSession;
import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.ws.WebServiceRef;
import org.apache.log4j.BasicConfigurator;
import org.apache.log4j.Logger;
import ws.Alumno;
import ws.Docente;
import ws.Nota;
import ws.ServiciosEdutin_Service;
import ws.Usuario;

@WebServlet(name = "Alumno", urlPatterns = {"/Alumno"})
public class AlumnoServlet extends HttpServlet {

    @WebServiceRef(wsdlLocation = "WEB-INF/wsdl/localhost_8080/EdutinServicio/ServiciosEdutin.wsdl")
    private ServiciosEdutin_Service service;
    private static final Logger LOG = Logger.getLogger(AlumnoServlet.class.getName());

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BasicConfigurator.configure();
        ValidSession.validAlumno(request, response);
        String alumno, nombre = null;
        alumno = request.getParameter("usuario");

        Integer opcion = Integer.parseInt(request.getParameter("opcion"));

        LOG.info(alumno + " " + opcion + " ");

        int idUserAlu = loguear(alumno).getId();
        LOG.info(alumno + " " + idUserAlu);
        List<Alumno> alumnos = listarAlumnos();
        for (Alumno alu : alumnos) {
            if (alu.getIdUser().getId() == idUserAlu) {
                nombre = alu.getNombre();
            }
        }
        request.setAttribute("Alumno", nombre);
        request.setAttribute("username", alumno);

        List<Nota> notas = listarNotas();
        List<Docente> docentes = listarDocentes();
        if (opcion != null) {
            switch (opcion) {
                case 1:
                    request.setAttribute("lista", notas);
                    request.setAttribute("message", "1");
                    break;
                case 2:
                    request.setAttribute("lista", docentes);
                    request.setAttribute("message", "2");
                    break;
               case 3:
                    
                    request.setAttribute("message", "3");
                    break;
            }
        }
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("mainAl.jsp");
        requestDispatcher.forward(request, response);
    }

    private java.util.List<ws.Nota> listarNotas() {
        // Note that the injected javax.xml.ws.Service reference as well as port objects are not thread safe.
        // If the calling of port operations may lead to race condition some synchronization is required.
        ws.ServiciosEdutin port = service.getServiciosEdutinPort();
        return port.listarNotas();
    }

    private java.util.List<ws.Docente> listarDocentes() {
        // Note that the injected javax.xml.ws.Service reference as well as port objects are not thread safe.
        // If the calling of port operations may lead to race condition some synchronization is required.
        ws.ServiciosEdutin port = service.getServiciosEdutinPort();
        return port.listarDocentes();
    }

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
        processRequest(request, response);
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private Usuario loguear(java.lang.String userName) {
        // Note that the injected javax.xml.ws.Service reference as well as port objects are not thread safe.
        // If the calling of port operations may lead to race condition some synchronization is required.
        ws.ServiciosEdutin port = service.getServiciosEdutinPort();
        return port.loguear(userName);
    }

    private java.util.List<ws.Alumno> listarAlumnos() {
        // Note that the injected javax.xml.ws.Service reference as well as port objects are not thread safe.
        // If the calling of port operations may lead to race condition some synchronization is required.
        ws.ServiciosEdutin port = service.getServiciosEdutinPort();
        return port.listarAlumnos();
    }
}
