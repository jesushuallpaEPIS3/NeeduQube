<%@page import="Modelo.Oportunidad"%>
<%@page import="java.util.List"%>
<%@page import="ModeloDAO.OportunidadDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Needu</title>
    <link rel="stylesheet" type="text/css" href="estilos_inicio_Organizacion.css">
    <link rel="icon" type="image/jpeg" href="imagenes\logo.jpeg">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Meroitic&family=Poppins:wght@500&display=swap" rel="stylesheet">
</head>
<body>

    <div id="navbar">
        <div class="logo">NGO Volunteer</div>
        <div class="menu-icon" onclick="toggleMenu()">
            <img src="imagenes/menuU.png" alt="Menú">
        </div>
        <div class="links">
            <a href="inicio.jsp">Inicio</a>
            <a href="inicio.jsp">Panel Administrativo</a>
            <a href="ControladorUsuario?accion=control">Control de usuarios</a>
            <a href="ControladorLogin?accion=logout">Cerrar Sesión</a>
        </div>
    </div>

    <div id="menu-options" class="menu-options">
        <ul>
            <li><a href="#">Inicio</a></li>
            <li><a href="ControladorChat?accion=allchats">Chat</a></li>
            <li><a href="ControladorNotificacion?accion=notificacion">Notificaciones</a></li>
            <li><a href="ControladorPerfil?accion=perfil">Perfil</a></li>
            <li><a href="ControladorLogin?accion=logout">Cerrar Sesión</a></li>
            
        </ul>
    </div>

    <div class="seccion">
        <div class="fila">
            <div class="columna-mitad">
                <div class="modulo texto fondo-claro">
                    <div class="texto-interior"><h4>Voluntariado</h4></div>
                </div>
                <div class="modulo texto fondo-claro">
                    <div class="texto-interior"><h1>Conviértete en voluntario o ayuda con un evento</h1></div>
                </div>
                <div class="modulo texto fondo-claro">
                    <div class="texto-interior">
                        <p>Vivamus eu sem et enim sagittis placerat quis et sem. Suspendisse imperdiet condimentum eleifend. Mauris tempus dignissim molestie. Quisque tempus aliquam.</p>
                    </div>
                </div>
                <div class="modulo boton">
                    <a class="boton fondo-claro" href="">Ponte en contacto</a>
                </div>
            </div>
            <div class="columna-mitad ultimo">
                <div class="modulo imagen">
                    <span class="imagen-contenedor">
                        <img decoding="async" fetchpriority="high" width="801" height="801" src="imagenes/doodle_index.png" alt="doodle_index" title="doodle_index">
                    </span>
                </div>
            </div>
        </div>
    </div>
 
       <div id="fb-root"></div>
    <script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v18.0" nonce="ZLLX3Vcw"></script>
<div class="fb-comments" data-href="http://localhost:8080/NeedU_UPT/inicio.jsp" data-width="" data-numposts="5"></div>    
    
    
    
<h1>Todas las Oportunidades:</h1>
<div>
    <% 
        OportunidadDAO oportunidadDao = new OportunidadDAO();
        List<Oportunidad> oportunidades = oportunidadDao.listarOportunidades();

        if (!oportunidades.isEmpty()) {
            for (Oportunidad opo : oportunidades) {
    %>
                <div class='oportunidad'>
                    <h2><%= StringEscapeUtils.escapeHtml(opo.getTitulo()) %></h2>

                    <p>Descripción: <%= opo.getDescripcion() %></p>
                    <p>Fecha: <%= opo.getFecha() %></p>

                    <!-- Botón de compartir en Facebook -->
                    <div class="fb-share-button" 
                    data-href="${fn:escapeXml(request.getRequestURL())}"

                         data-layout="button_count" 
                         data-size="small"
                         data-description="<%= opo.getDescripcion() %>">
                         <a target="_blank" href="https://www.facebook.com/sharer/sharer.php?u=${fn:escapeXml(request.getRequestURL())}&amp;src=sdkpreparse" class="fb-xfbml-parse-ignore">Compartir</a>
                        </div>

                <!-- Botón de compartir en Twitter -->
                <a href="https://twitter.com/share?text=<%= "¡Únete a esta oportunidad en NeedU_UPT!%0A%0ATítulo: " + opo.getTitulo() + "%0ADescripción: " + opo.getDescripcion().replaceAll("\\n", "%0A") %>" class="twitter-share-button" data-show-count="false">Tweet</a>
                <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
                    <!-- Formulario para ser voluntario -->
                    <form method='post' action='#' onsubmit="return showAlert();">
                        <input type='hidden' name='accion' value='serVoluntario'>
                        <input type='hidden' name='idOportunidad' value='<%= opo.getIdoportunidad() %>'>
                        <input type='submit' value='Ser Voluntario'>
                    </form>
                </div>
    <%
            }
        } else {
    %>
            <p>No hay oportunidades disponibles</p>
    <%
        }
    %>
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
                    menuOptions.style.display = "none"; 
                }, 500); 
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
        function showAlert() {
        alert('Has solicitado unirte a esta oportunidad!');
        return true; // Devuelve true para enviar el formulario
    }

        // Agregar un controlador de eventos al evento 'resize' para detectar cambios de tamaño de ventana
        window.addEventListener('resize', closeMenuOnResize);
    </script>

</body>
</html>