package ModeloDAO;

import Config.Conexion;
import Modelo.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SolicitudDAO {
    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    public boolean existeSolicitud(int idVoluntario, int idOportunidad) {
        String sql = "SELECT * FROM tbsolicitud WHERE idvoluntario = ? AND idoportunidad = ?";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, idVoluntario);
            ps.setInt(2, idOportunidad);
            rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean crearSolicitud(Solicitud solicitud) {
        String sql = "INSERT INTO tbsolicitud (idoportunidad, idvoluntario, mensaje, entregado) VALUES (?, ?, ?, ?)";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, solicitud.getIdoportunidad());
            ps.setInt(2, solicitud.getIdvoluntario());
            ps.setString(3, solicitud.getMensaje());
            ps.setInt(4, solicitud.getEntregado());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return false;
        }
    }

}
