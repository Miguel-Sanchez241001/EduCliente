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
import ws.Materia;
import ws.Nota;
import ws.Usuario;
import ws.ServiciosEdutin_Service;

/**
 *
 * @author pc
 */
@WebServlet(name = "Admin", urlPatterns = {"/Admin"})
public class AdminServlet extends HttpServlet {

    @WebServiceRef(wsdlLocation = "WEB-INF/wsdl/localhost_8080/EdutinServicio/ServiciosEdutin.wsdl")
    private ServiciosEdutin_Service service;
    private static final Logger LOG = Logger.getLogger(AdminServlet.class.getName());

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
        ValidSession.validAdmin(request, response);
        String userName, clave, respuesta, nombre, apellido, opcionRegistrarTipo, DocenteN;
      

        int idMateria;
        Integer edad;
        List<Usuario> usuarios = listar();
        List<Alumno> alumnos = listarAlumnos();
        List<Docente> docentes = listarDocentes();
        List<Nota> notas = listarNotas();
        List<Materia> materias = listarMaterias();
        String opcionLista = request.getParameter("opLis");
        String opcionRegistrar = request.getParameter("opReg");
        opcionRegistrarTipo = request.getParameter("tipo");

        for (Docente docente : docentes) {
            LOG.info(" " + docente.getId() + " " + docente.getNombre() + " " + docente.getApellido());
        }

        if (opcionLista != null) {
            switch (opcionLista) {
                case "Admin":
                    request.setAttribute("lista", usuarios);
                    request.setAttribute("message", "1");
                    break;
                case "Alumnos":
                    request.setAttribute("lista", alumnos);
                    request.setAttribute("message", "2");
                    break;
                case "Docentes":
                    request.setAttribute("lista", docentes);
                    request.setAttribute("message", "3");
                    break;
                case "Notas":
                    request.setAttribute("lista", notas);
                    request.setAttribute("message", "4");
                    break;
            }
        }
        if (opcionRegistrar != null) {
            switch (opcionRegistrar) {
                case "Admin":
                    request.setAttribute("message", "6");
                    break;
                case "Alumnos":
                    request.setAttribute("lista", docentes);
                    request.setAttribute("message", "7");
                    break;
                case "Docentes":
                    request.setAttribute("lista", materias);
                    request.setAttribute("message", "5");
                    break;

            }
        }
        if (opcionRegistrarTipo != null) {
            switch (opcionRegistrarTipo) {
                case "admin":
                    userName = request.getParameter("Username");
                    clave = request.getParameter("password");
                    respuesta = registrar(userName, clave, 1);
                    LOG.info(respuesta);
                    usuarios = listar();
                    request.setAttribute("lista", usuarios);
                    request.setAttribute("message", "1");
                    break;
                case "docente":
                    userName = request.getParameter("Username");
                    clave = request.getParameter("password");
                    respuesta = registrar(userName, clave, 2);
                    LOG.info(respuesta);
                    nombre = request.getParameter("Nombre");
                    apellido = request.getParameter("Apellido");
                    idMateria = Integer.parseInt(request.getParameter("Materia"));
                    LOG.info(" " + nombre + " " + apellido + " " + idMateria + " ");
                    respuesta = registrarDocente(loguear(userName).getId(), idMateria, nombre, apellido);
                    docentes = listarDocentes();    
                    LOG.info(respuesta);
                    request.setAttribute("lista", docentes);
                    request.setAttribute("message", "3");
                    break;
                case "alumno":
                    userName = request.getParameter("Username");
                    clave = request.getParameter("password");
                    respuesta = registrar(userName, clave, 3);
                    LOG.info(respuesta);

                    nombre = request.getParameter("Nombre");
                    apellido = request.getParameter("Apellido");
                    edad = Integer.parseInt(request.getParameter("pena"));
                    DocenteN = request.getParameter("Edad");
                    LOG.info(" " + nombre + " " + apellido + " " + edad + " " + DocenteN);
                    registrarAlumno(Integer.parseInt(DocenteN), nombre, apellido, edad, loguear(userName).getId());
                    alumnos = listarAlumnos();
                    request.setAttribute("lista", alumnos);
                    request.setAttribute("message", "2");
                    break;

            }

        }
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("mainA.jsp");
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

 
   
  
   
 
   

   
    private  String registrarDocente(int usuario, int materia, java.lang.String nombre, java.lang.String apellido) {
       
        ws.ServiciosEdutin port = service.getServiciosEdutinPort();
        return port.registrarDocente(usuario, materia, nombre, apellido);
    }

    private  String registrarAlumno(int docente, java.lang.String nombre, java.lang.String apellido, java.lang.Integer edad, int usuario) {
      
        ws.ServiciosEdutin port = service.getServiciosEdutinPort();
        return port.registrarAlumno(docente, nombre, apellido, edad, usuario);
    }

    private  Usuario loguear(java.lang.String userName) {
        
        ws.ServiciosEdutin port = service.getServiciosEdutinPort();
        return port.loguear(userName);
    }

    private  String registrar(java.lang.String userName, java.lang.String clave, int tipo) {
        ws.ServiciosEdutin port = service.getServiciosEdutinPort();
        return port.registrar(userName, clave, tipo);
    }

    private  String registrarMateria(java.lang.String materia) {
       
        ws.ServiciosEdutin port = service.getServiciosEdutinPort();
        return port.registrarMateria(materia);
    }

    private  java.util.List<ws.Nota> listarNotas() {
        
        ws.ServiciosEdutin port = service.getServiciosEdutinPort();
        return port.listarNotas();
    }

    private  java.util.List<ws.Materia> listarMaterias() {
      
        ws.ServiciosEdutin port = service.getServiciosEdutinPort();
        return port.listarMaterias();
    }

    private  java.util.List<ws.Docente> listarDocentes() {
       
        ws.ServiciosEdutin port = service.getServiciosEdutinPort();
        return port.listarDocentes();
    }

    private  java.util.List<ws.Alumno> listarAlumnos() {
        ws.ServiciosEdutin port = service.getServiciosEdutinPort();
        return port.listarAlumnos();
    }

    private  java.util.List<ws.Usuario> listar() {
        ws.ServiciosEdutin port = service.getServiciosEdutinPort();
        return port.listar();
    }

   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
