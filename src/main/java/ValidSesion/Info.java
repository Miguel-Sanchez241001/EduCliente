/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ValidSesion;


import java.util.logging.*;

/**
 *
 * @author pc
 */
public class Info {

    public final Logger logger = Logger.getLogger("MyLog");
    public FileHandler fileHandler;

    public Info() {
        try {
            this.fileHandler = new FileHandler("src/recursos/MyLogFile.txt");
            this.logger.addHandler(fileHandler);
            SimpleFormatter simpleFormatter = new SimpleFormatter();
            fileHandler.setFormatter(simpleFormatter);
        } catch (Exception e) {}

    }

    public void MenLog(String men) {
        logger.info(men);
    }
}
