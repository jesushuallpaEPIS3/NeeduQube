package Config;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class Conexion {
    private Connection con;

    public Conexion() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Cargar las propiedades desde el archivo de configuración
            Properties prop = new Properties();
            try (InputStream input = new FileInputStream("config.properties")) {
                prop.load(input);
            }

            // Obtener las credenciales del archivo de configuración
            String url = prop.getProperty("db.url");
            String username = prop.getProperty("db.username");
            String password = prop.getProperty("db.password");

            // Establecer la conexión con la base de datos
            con = DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException | SQLException | IOException e) {
            e.printStackTrace();
        }
    }

    public Connection getConnection() {
        return con;
    }
}
