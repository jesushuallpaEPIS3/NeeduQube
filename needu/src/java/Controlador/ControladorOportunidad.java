package Controlador;

import ModeloDAO.OportunidadDAO;
import Modelo.Oportunidad;
import ModeloDAO.OrganizacionDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "ControladorOportunidad", urlPatterns = {"/ControladorOportunidad"})
public class ControladorOportunidad extends HttpServlet {
    OrganizacionDAO orgdao = new OrganizacionDAO();
    @Override
   protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    HttpSession session = request.getSession(false);
    if (session != null) {
        int idusuario = (int) session.getAttribute("idusuario");

        int idorganizacion = orgdao.obtenerIdorganizacion(idusuario);
        if (idorganizacion == -1) {
            System.out.println("La sesión existe pero no contiene idOrganizacion");
            response.sendRedirect("login.jsp"); // Redirige a la página de inicio de sesión
            return;
        }

        // Procesar la creación o eliminación de la oportunidad si la sesión contiene la información necesaria
        String accion = request.getParameter("accion");

        if ("crear".equals(accion)) {
            // Crear una nueva oportunidad
            String titulo = request.getParameter("titulo");
            String descripcion = request.getParameter("descripcion");
            String fecha = request.getParameter("fecha"); // Tratada como String
            int idUbicacion = Integer.parseInt(request.getParameter("idubicacion"));
            int idCausa = Integer.parseInt(request.getParameter("idcausa"));

            // Crear instancia de Oportunidad y establecer sus valores
            Oportunidad opo = new Oportunidad();
            opo.setTitulo(titulo);
            opo.setDescripcion(descripcion);
            opo.setFecha(fecha); // Asignación directa como String
            opo.setIdubicacion(idUbicacion);
            opo.setIdorganizacion(idorganizacion);
            opo.setIdcausa(idCausa);

            // Crear instancia de OportunidadDAO y guardar la oportunidad
            OportunidadDAO dao = new OportunidadDAO();
            boolean exito = dao.crearOportunidad(opo);

            if (exito) {
                response.sendRedirect("inicio.jsp"); // Redirige a la página de administrador
            } else {
                // Manejar el caso de fallo en la inserción
                response.sendRedirect("paginaErrorCreacion.jsp"); // Redirige a la página de error
            }
        } else if ("eliminar".equals(accion)) {
            // Eliminar una oportunidad existente
            int idOportunidad = Integer.parseInt(request.getParameter("idOportunidad"));

            // Crear instancia de OportunidadDAO y eliminar la oportunidad
            OportunidadDAO dao = new OportunidadDAO();
            boolean exito = dao.eliminarOportunidad(idOportunidad);

            if (exito) {
                response.sendRedirect("inicio.jsp"); // Redirige a la página de administrador
            } else {
                // Manejar el caso de fallo en la eliminación
                response.sendRedirect("paginaErrorEliminacion.jsp"); // Redirige a la página de error
            }
        } else {
            System.out.println("Acción no válida.");
            response.sendRedirect("paginaError.jsp"); // Redirige a la página de error
        }

    } else {
        System.out.println("No hay sesión activa.");
        response.sendRedirect("login.jsp"); // Redirige a la página de inicio de sesión
    }
}


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("Entrando a doGet de ControladorOportunidad");
            String accion = request.getParameter("accion");
            if ("ver".equals(accion)) {
                int idOportunidad = Integer.parseInt(request.getParameter("id"));
                System.out.println("ID de Oportunidad a ver: " + idOportunidad);
                OportunidadDAO dao = new OportunidadDAO();
                Oportunidad opo = dao.getOportunidadById(idOportunidad);
                if (opo != null) {
                    System.out.println("Oportunidad encontrada: " + opo.getTitulo());
                    request.setAttribute("oportunidad", opo);
                    request.getRequestDispatcher("/InfoOportunidad.jsp").forward(request, response);
                } else {
                    System.out.println("Oportunidad no encontrada.");
                   
                }
            }
    }
}