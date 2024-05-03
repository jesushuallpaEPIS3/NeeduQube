<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Map"%>
<%@page import="Modelo.Oportunidad"%>
<%@page import="java.util.List"%>
<%@page import="ModeloDAO.OportunidadDAO"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="estilos_InfoOportunidad.css">
        <title>JSP Page</title>
    </head>
    <body>
    <div id="navbar">
        <div class="logo">NGO Volunteer</div>
        <div class="menu-icon" onclick="toggleMenu()">
            <img src="imagenes/menuU.png" alt="Menú">
        </div>
        <div class="links">
            <a href="ControladorLogin?accion=redirigirInicio">Inicio</a>
            <a href="ControladorPerfil?accion=perfil">Perfil</a>
            <a href="ControladorLogin?accion=logout">Cerrar Sesión</a>
        </div>
    </div>

    <div id="menu-options" class="menu-options">
        <ul>
            <li><a href="Sobre_Nosotros.jsp">Por qué ser voluntario</a></li>
            <li><a href="ControladorLogin?accion=loginusuario">Inicio de Sesión</a></li>
            <li><a href="ControladorRegistro?accion=registro" class="registro-btn">Regístrate</a></li>
        </ul>
    </div>
        
        
    <div class="imagen-oportunidad">
        <img src="imagenes/imaGenerico.png" alt="Imagen de la Oportunidad">
    </div>

<div class="info-oportunidad">
    <%
        Oportunidad oportunidad = (Oportunidad) request.getAttribute("oportunidad");
        if (oportunidad != null) {
    %>
        <h1><%= oportunidad.getTitulo() %></h1>
        <p><strong>Descripción:</strong> <%= oportunidad.getDescripcion() %></p>
        <p><strong>Fecha:</strong> <%= oportunidad.getFecha() %></p>
        <p><strong>ID Ubicación:</strong> <%= oportunidad.getIdubicacion() %></p>
        <p><strong>ID Organización:</strong> <%= oportunidad.getIdorganizacion() %></p>
        <p><strong>ID Causa:</strong> <%= oportunidad.getIdcausa() %></p>
        <p><strong>Estado:</strong> <%= oportunidad.getEstado() == 1 ? "Activo" : "Inactivo" %></p>

        <form action="ControladorOportunidad" method="post">
            <input type="hidden" name="accion" value="unirse">
            <input type="hidden" name="idoportunidad" value="<%= oportunidad.getIdoportunidad() %>">
            <button type="submit">Unirse a esta Oportunidad</button>
        </form>
    <%
        } else {
            out.println("<p>Oportunidad no encontrada.</p>");
        }
    %>
</div>


    <!-- Botón para Ser Voluntario -->
    <div class="boton-voluntario">
        <form onsubmit="enviarSolicitud(event, idOportunidad);" class="form-oportunidad">
            <button type='submit' class="btn-oportunidad">Ser Voluntario</button>
        </form>
    </div>   
        
        
        
        
        
        
        
        
        
        
        
        <script>
        function toggleMenu() {
            var menuOptions = document.getElementById("menu-options");
            if (menuOptions.style.display === "none" || menuOptions.style.display === "") {
                menuOptions.style.display = "block";
                setTimeout(function() {
                    menuOptions.classList.add("active");
                }, 0);
            } else {
                menuOptions.classList.remove("active"); // Retira la clase "active" para ocultar el menú
                setTimeout(function() {
                    menuOptions.style.display = "none"; // Oculta el menú después de que se retire la animación
                }, 500); // Agrega un retraso para que la animación termine antes de ocultar el menú
            }
        }

        // Función para cerrar el menú cuando cambia el tamaño de la ventana
        function closeMenuOnResize() {
            var menuOptions = document.getElementById("menu-options");
            if (menuOptions.classList.contains('active')) {
                menuOptions.classList.remove('active');
                setTimeout(function() {
                    menuOptions.style.display = "none";
                }, 500);
            }
        }

        // Agregar un controlador de eventos al evento 'resize' para detectar cambios de tamaño de ventana
        window.addEventListener('resize', closeMenuOnResize);
    </script>
    
    
    
        <script>
    function enviarSolicitud(event, idOportunidad) {
        event.preventDefault(); // Detiene el comportamiento de envío del formulario

        fetch('ControladorSolicitud?idoportunidad=' + idOportunidad)
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert(data.message);
            } else {
                alert(data.message);
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Datos enviados correctamente.');
        });
    }
    </script>
    
    
    </body>
</html>
