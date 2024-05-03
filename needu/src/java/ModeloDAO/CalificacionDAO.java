package ModeloDAO;

import Modelo.Calificacion;
import Config.Conexion;
import Interfaces.CRUDCalificacion;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CalificacionDAO implements CRUDCalificacion {

    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    
    @Override
    public boolean agregarCalificacion(Calificacion calificacion) {
        
        String query = "INSERT INTO tbcalificacion (idusuariocalificador, idusuariocalificado, puntuacion, comentario, fecha) VALUES (?, ?, ?, ?, ?)";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(query);
           ps.setInt(1, calificacion.getIdusuariocalifacador());
            ps.setInt(2, calificacion.getIdusuariocalificado());
            ps.setInt(3, calificacion.getPuntuacion());
            ps.setString(4, calificacion.getComentario());
            ps.setString(5, calificacion.getFecha());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error al agregar calificación: " + e.getMessage());
            return false;
        } finally {
            try {
                con.close();
            } catch (SQLException e) {
                System.out.println("Error al cerrar la conexión: " + e.getMessage());
            }
        }
    }
    
    


    @Override
    public List<String> getComentariosByUsuarioId(int usuarioId) {
        
        String query = "SELECT comentario FROM tbcalificacion WHERE idusuariocalificado = ?";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, usuarioId);
            ResultSet rs = ps.executeQuery();

            List<String> comentarios = new ArrayList<>();

            while (rs.next()) {
                comentarios.add(rs.getString("comentario"));
            }

            return comentarios;
        } catch (SQLException e) {
            System.out.println("Error al obtener comentarios: " + e.getMessage());
            return new ArrayList<>(); 
        } finally {
            try {
                con.close();
            } catch (SQLException e) {
                System.out.println("Error al cerrar la conexión: " + e.getMessage());
            }
        }
    }@Override
        public Map<Integer, List<String>> getComentariosDeTodosLosUsuarios() {
        Map<Integer, List<String>> comentariosUsuarios = new HashMap<>();

        try {
            con = cn.getConnection();
            String query = "SELECT id_usuario, comentario FROM comentarios_table";

            ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int userId = rs.getInt("id_usuario");
                String comentario = rs.getString("comentario");

                if (!comentariosUsuarios.containsKey(userId)) {
                    comentariosUsuarios.put(userId, new ArrayList<>());
                }

                comentariosUsuarios.get(userId).add(comentario);
            }
        } catch (SQLException e) {
            e.printStackTrace(); 
        } finally {
        
        }

        return comentariosUsuarios;
    }
        
        @Override
        public Map<Integer, Map<String, Object>> getComentariosDeTodosLosUsuariosConPuntuacion() {
            Map<Integer, Map<String, Object>> comentariosUsuarios = new HashMap<>();

            try {
                con = cn.getConnection();
                String query = "SELECT idusuariocalificado, puntuacion, comentario FROM tbcalificacion";

                ps = con.prepareStatement(query);
                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
                    int userId = rs.getInt("idusuariocalificado");
                    String comentario = rs.getString("comentario");
                    int puntuacion = rs.getInt("puntuacion");

                    if (!comentariosUsuarios.containsKey(userId)) {
                        comentariosUsuarios.put(userId, new HashMap<>());
                    }

                    // Acumula la puntuación para el usuario
                    Map<String, Object> usuarioData = comentariosUsuarios.get(userId);
                    usuarioData.put("puntuacion", (int) usuarioData.getOrDefault("puntuacion", 0) + puntuacion);

                    // Agrega el comentario para el usuario
                    if (!usuarioData.containsKey("comentarios")) {
                        usuarioData.put("comentarios", new ArrayList<>());
                    }
                    ((List<String>) usuarioData.get("comentarios")).add(comentario);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                // Cierre de recursos
            }

            return comentariosUsuarios;
        }

        public Calificacion getCalificacionByUsuarioId(int usuarioId) {
        String query = "SELECT * FROM tbcalificacion WHERE idusuariocalificado = ?";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, usuarioId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Calificacion calificacion = new Calificacion();
                calificacion.setIdcalificacion(rs.getInt("idcalificacion"));
                calificacion.setIdusuariocalifacador(rs.getInt("idusuariocalificador"));
                calificacion.setIdusuariocalificado(rs.getInt("idusuariocalificado"));
                calificacion.setPuntuacion(rs.getInt("puntuacion"));
                calificacion.setComentario(rs.getString("comentario"));
                calificacion.setFecha(rs.getString("fecha"));

                return calificacion;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Cierre de recursos
        }

        return null; // Retornar null si no se encuentra calificación para el usuario
    }





    
}
