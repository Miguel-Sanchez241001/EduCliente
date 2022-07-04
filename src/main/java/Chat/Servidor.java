/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Chat;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import org.apache.log4j.Logger;
import javax.websocket.EncodeException;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;
import org.apache.log4j.BasicConfigurator;

/**
 *
 * @author pc
 */
@ServerEndpoint("/websocketserver")
public class Servidor {

    private boolean PrimeraVez = true;
    private static String Nombre;// Apodo del usuario
    // la clave de conexión es el ID de la sesión, el valor es este objeto
    private static final HashMap<String, Object> ListaConexiones = new HashMap<String, Object>();
    // La clave userMap es el ID de la sesión, el valor es el nombre de usuario
    private static final HashMap<String, String> userMap = new HashMap<String, String>();
    private Session session;
    public static Logger logger = Logger.getLogger(Servidor.class);

    @OnOpen
    public void start(Session session) {
        this.session = session; // Obtén Seession y guárdalo en SashMap
        ListaConexiones.put(session.getId(), this);
        BasicConfigurator.configure();

    }

    @OnMessage
    public void echo(String incomingMessage, Session session) throws EncodeException {
        Servidor client = null;
        // Primero juzga si el valor se pasa por primera vez, el primer valor es el apodo, pasado por OnOpen en el lado web
        if (PrimeraVez) {
            this.Nombre = incomingMessage;
            String message = "Bienvenido  " + Nombre;
            // El apodo y la ID de sesión se almacenan en HashMap en una correspondencia uno a uno

            userMap.put(session.getId(), Nombre);
            // Transmite el mensaje a todos los usuarios
            for (String key : ListaConexiones.keySet()) {
                try {
                    client = (Servidor) ListaConexiones.get(key);
                    synchronized (client) {
                        // Envía un mensaje de texto a la web correspondiente
                        client.session.getBasicRemote().sendText(message);
                        //   client.session.getBasicRemote().sendObject(Arrays.toString(userMap.values().toArray()));
// enviar la lista de usuarios sin el usuario 
                        client.session.getBasicRemote().sendText(Arrays.toString(userMap.values().toArray()));
                    }
                } catch (IOException e) {
                    ListaConexiones.remove(client);
                    try {
                        client.session.close();
                    } catch (IOException e1) {
                    }
                }
            }
            // Después de ingresar el apodo, no es la primera vez para la posterior transferencia interactiva de valores
            PrimeraVez = false;
        } else {
            /**
             * El valor de InputMessage tiene el formato xxx @ xxxxx, xxx es el
             * apodo del usuario que se enviará, y todo significa que se envía a
             * todos InputMessage.split ("@", 2); Use @ como separador para
             * dividir la cadena en dos partes: xxx y xxxxx
             */
            String[] list = incomingMessage.split("@", 2);
            if (list[0].equalsIgnoreCase("all")) { // todos transmiten a todas las personas
                sendAll(list[1], session);
            } else {
                boolean you = false;// Marcar si se encuentra el usuario remitente
                for (String key : userMap.keySet()) {
                    if (list[0].equalsIgnoreCase(userMap.get(key))) {
                        client = (Servidor) ListaConexiones.get(key);
                        synchronized (client) {
                            try {
                                // Enviar información al usuario especificado
                                client.session.getBasicRemote().sendText(" De " + userMap.get(session.getId()) + " : " + list[1]);
                            } catch (IOException e) {
                                e.printStackTrace();
                            }
                        }
                        you = true;// Encuentra el usuario especificado marcado como verdadero
                        break;
                    }

                }
                // Si es cierto, mostrará que dice xxxxx a xxx en su propia página; de lo contrario, muestre el sistema: no existe tal usuario
                if (you) {
                    try {
                        session.getBasicRemote().sendText("Para " + list[0] + " :" + list[1]);

                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                } else {
                    try {
                        session.getBasicRemote().sendText("Sistema: no existe tal usuario");
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }

            }

        }
    }

    @OnClose
    public void close(Session session) {
        // Cuando un usuario cierra la sesión, transmite a otros usuarios
        String message = "sistema: " + userMap.get(session.getId()) + " Salio del chat grupal";

        userMap.remove(session.getId());
        ListaConexiones.remove(session.getId());
        for (String key : ListaConexiones.keySet()) {
            Servidor client = null;
            try {
                client = (Servidor) ListaConexiones.get(key);
                synchronized (client) {
                    client.session.getBasicRemote().sendText(message);
                    client.session.getBasicRemote().sendText(Arrays.toString(userMap.values().toArray()));
                }
            } catch (IOException e) {
                ListaConexiones.remove(client);
                try {
                    client.session.close();
                } catch (IOException e1) {
                }
            }
        }
    }

    // Difundir toda la información
    public static void sendAll(String mess, Session session) {
        String who = null;
        for (String key : ListaConexiones.keySet()) {
            Servidor client = null;
            try {
                client = (Servidor) ListaConexiones.get(key);
                if (key.equalsIgnoreCase(session.getId())) {
                    who = " Les dije a todos: ";
                } else {
                    who = userMap.get(session.getId()) + " Para todos: ";
                }
                synchronized (client) {

                    client.session.getBasicRemote().sendText(who + mess);
                }
            } catch (IOException e) {
                ListaConexiones.remove(client);
                try {
                    client.session.close();
                } catch (IOException e1) {
                }
            }
        }

    }

    public String getNombre() {
        return this.Nombre;
    }

}
