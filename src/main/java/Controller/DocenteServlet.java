/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import ValidSesion.ValidSession;
import java.io.IOException;
import java.util.ArrayList;
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

@WebServlet(name = "Docente", urlPatterns = {"/Docente"})
public class DocenteServlet extends HttpServlet {

    @WebServiceRef(wsdlLocation = "WEB-INF/wsdl/localhost_8080/EdutinServicio/ServiciosEdutin.wsdl")
    private ServiciosEdutin_Service service;
    private static final Logger LOG = Logger.getLogger(DocenteServlet.class.getName());

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

        ValidSession.validDocente(request, response);
        String docente, nombre = null;
        docente = request.getParameter("usuario");
        String opcion = request.getParameter("opcion");
        LOG.info(docente + " " + opcion + " ");
        int idDocente = loguear(docente).getId();
        LOG.info(" id doc " + idDocente);
        List<Docente> docentes = listarDocentes();
        int idMateria = 0;
        for (Docente alu : docentes) {
            if (alu.getUsuario().getId() == idDocente) {
                nombre = alu.getNombre();
                idMateria = alu.getMateria().getId();
                LOG.info(" materia id: " + idMateria + " profe :" + nombre);
            }
        }
        List<Nota> notas = listarNotas();
        request.setAttribute("Docente", nombre);
        request.setAttribute("username", docente);
        request.setAttribute("notas", notas);
        List<Alumno> alumnos = listarAlumnos();
        List<Alumno> misAlumnos = new ArrayList<>();
        List<Nota> misNotas = new ArrayList<>();
        for (Alumno alum : alumnos) {
            if (alum.getIdDocente().getNombre().equals(nombre)) {
                misAlumnos.add(alum);
                LOG.info(misAlumnos);
                for (Nota nota : notas) {

                    if (nota.getAlumno().getNombre().equals(alum.getNombre())) {
                        misNotas.add(nota);
                        misAlumnos.remove(alum);
                    }
                }
            }
        }
        LOG.info("lista " + misAlumnos);
        if (opcion != null) {
            switch (opcion) {
                case "registro":

                    request.setAttribute("lista", misAlumnos);
                    request.setAttribute("message", "1");
                    break;
                case "alumnos":
                    alumnos = listarAlumnos();
                    request.setAttribute("lista", alumnos);
                    request.setAttribute("message", "2");
                    break;
                case "ver":

                    request.setAttribute("lista", misNotas);
                    request.setAttribute("message", "3");
                    break;
            }
        }

        String confirmacion = request.getParameter("tipo");
        if (confirmacion != null) {
            String alumno = (String) request.getParameter("Alumno");
            int Nota = Integer.parseInt((String) request.getParameter("Nota"));
            String res = registrarNota(idMateria, buscarAlumno(alumno).getIdAlumnos(), Nota);
            LOG.info(res);

            request.setAttribute("lista", misNotas);
            request.setAttribute("message", "3");
        }

        RequestDispatcher requestDispatcher = request.getRequestDispatcher("mainD.jsp");
        requestDispatcher.forward(request, response);
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

    private java.util.List<ws.Docente> listarDocentes() {
        // Note that the injected javax.xml.ws.Service reference as well as port objects are not thread safe.
        // If the calling of port operations may lead to race condition some synchronization is required.
        ws.ServiciosEdutin port = service.getServiciosEdutinPort();
        return port.listarDocentes();
    }

    private java.util.List<ws.Alumno> listarAlumnos() {
        // Note that the injected javax.xml.ws.Service reference as well as port objects are not thread safe.
        // If the calling of port operations may lead to race condition some synchronization is required.
        ws.ServiciosEdutin port = service.getServiciosEdutinPort();
        return port.listarAlumnos();
    }

    private Alumno buscarAlumno(java.lang.String idAlumno) {
        // Note that the injected javax.xml.ws.Service reference as well as port objects are not thread safe.
        // If the calling of port operations may lead to race condition some synchronization is required.
        ws.ServiciosEdutin port = service.getServiciosEdutinPort();
        return port.buscarAlumno(idAlumno);
    }

    private java.util.List<ws.Nota> listarNotas() {
        // Note that the injected javax.xml.ws.Service reference as well as port objects are not thread safe.
        // If the calling of port operations may lead to race condition some synchronization is required.
        ws.ServiciosEdutin port = service.getServiciosEdutinPort();
        return port.listarNotas();
    }

    private String registrarNota(int materia, int alumno, double nota) {
        // Note that the injected javax.xml.ws.Service reference as well as port objects are not thread safe.
        // If the calling of port operations may lead to race condition some synchronization is required.
        ws.ServiciosEdutin port = service.getServiciosEdutinPort();
        return port.registrarNota(materia, alumno, nota);
    }

}
