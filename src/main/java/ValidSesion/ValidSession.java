/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ValidSesion;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 *
 * @author pc
 */
public class ValidSession {
   static String  mensaje = "Logueate primero";
    public static void validAdmin(HttpServletRequest request, HttpServletResponse response) {
        boolean error = false;
        HttpSession session = request.getSession();
        
        if (session != null) {
            String key = (String) session.getAttribute("key");
            String username = (String) session.getAttribute("username");

            if (key != null && username != null) {
                if (!key.equals("dsjhf.FDS!543|5G*DFgfdrhd%#454GDfgDb" + username)) {
                    error = true;
                }
            } else {
                error = true;
            }
        }
        if (error) {
            request.setAttribute("message", ValidSession.mensaje);
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("index.jsp");

            try {
                requestDispatcher.forward(request, response);
            } catch (ServletException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public static void validAlumno(HttpServletRequest request, HttpServletResponse response) {
        boolean error = false;
        HttpSession session = request.getSession();
        if (session != null) {
            String key = (String) session.getAttribute("key");
            String username = (String) session.getAttribute("username");

            if (key != null && username != null) {
                if (!key.equals("asdfasfawfn26519qwubqwiugbqw" + username)) {
                    error = true;
                }
            } else {
                error = true;
            }
        }
        if (error) {
            request.setAttribute("message", ValidSession.mensaje);
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("index.jsp");

            try {
                requestDispatcher.forward(request, response);
            } catch (ServletException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
   
 public static void validDocente(HttpServletRequest request, HttpServletResponse response) {
        boolean error = false;
        HttpSession session = request.getSession();
        if (session != null) {
            String key = (String) session.getAttribute("key");
            String username = (String) session.getAttribute("username");

            if (key != null && username != null) {
                if (!key.equals("121241qfqweqtqasdafefqwefqwefq" + username)) {
                    error = true;
                }
            } else {
                error = true;
            }
        }
        if (error) {
            request.setAttribute("message", ValidSession.mensaje);
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("index.jsp");

            try {
                requestDispatcher.forward(request, response);
            } catch (ServletException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

}

