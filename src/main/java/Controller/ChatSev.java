/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.ws.WebServiceRef;
import org.apache.log4j.BasicConfigurator;
import org.apache.log4j.Logger;
import ws.ServiciosEdutin_Service;

/**
 *
 * @author pc
 */
@WebServlet(name = "ChatSev", urlPatterns = {"/ChatSev"})
public class ChatSev extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @WebServiceRef(wsdlLocation = "WEB-INF/wsdl/localhost_8080/EdutinServicio/ServiciosEdutin.wsdl")
    private ServiciosEdutin_Service service;
    private static final Logger LOG = Logger.getLogger(ChatSev.class.getName());

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BasicConfigurator.configure();
        String opt = request.getParameter("opt");
        if (opt != null) {
            String nombreContac, apellido, correo, mensaje;
            nombreContac = request.getParameter("nombre");
            apellido = request.getParameter("apellido");
            correo = request.getParameter("correo");
            mensaje = request.getParameter("mensaje");
            Integer telefono = Integer.parseInt(request.getParameter("telefono"));
            LOG.info(MensajesContacto(nombreContac, apellido, correo, telefono, mensaje));
        } else {
            String Mensaje = request.getParameter("message");
            String Destinatario = request.getParameter("destinatario");
            String Nombre = (String) request.getSession().getAttribute("username");

            String registrarMensajea = registrarMensaje(Nombre, Mensaje, Destinatario);
            LOG.info(registrarMensajea);

        }

        RequestDispatcher requestDispatcher = request.getRequestDispatcher("");
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

    private String registrarMensaje(java.lang.String Nombre, java.lang.String Mensaje, java.lang.String Destinatario) {
        ws.ServiciosEdutin port = service.getServiciosEdutinPort();
        return port.registrarMensaje(Nombre, Mensaje, Destinatario);
    }

    private String MensajesContacto(String Nombre, String Apellido, String Correo,
            Integer Telefono, String Mensaje) {
        ws.ServiciosEdutin port = service.getServiciosEdutinPort();
        return port.mensajeContacto(Nombre, Apellido, Correo, Telefono, Mensaje);
    }
}
