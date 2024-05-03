/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controlador;

import Modelo.*;
import ModeloDAO.*;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author HP
 */
@WebServlet(name = "ControladorSolicitud", urlPatterns = {"/ControladorSolicitud"})
public class ControladorSolicitud extends HttpServlet {
    


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    }
    
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
                int idOportunidad = Integer.parseInt(request.getParameter("idoportunidad"));

        HttpSession session = request.getSession();
        int idUsuario = (Integer) session.getAttribute("idusuario");

        VoluntarioDAO voluntarioDao = new VoluntarioDAO();
        int idVoluntario = voluntarioDao.obtenerIdVoluntarioPorIdUsuario(idUsuario);

        if (idVoluntario == -1) {
            // No redirecciona, solo muestra un mensaje de error en consola
            System.out.println("Error: No se encontró el id del voluntario.");
            return;
        }

        SolicitudDAO solicitudDao = new SolicitudDAO();
        if (solicitudDao.existeSolicitud(idVoluntario, idOportunidad)) {
            // No redirecciona, solo muestra un mensaje en consola
            System.out.println("La solicitud ya existe.");
            return;
        }

        String mensaje = "Interesado en la oportunidad";
        Solicitud solicitud = new Solicitud();
        solicitud.setIdoportunidad(idOportunidad);
        solicitud.setIdvoluntario(idVoluntario);
        solicitud.setMensaje(mensaje);
        solicitud.setEntregado(0);

        boolean exito = solicitudDao.crearSolicitud(solicitud);

        // No redirecciona, solo imprime un mensaje de éxito o error en la consola
        if (exito) {
            System.out.println("Solicitud creada con éxito.");
        } else {
            System.out.println("Error al crear la solicitud.");
        }

    }


}
