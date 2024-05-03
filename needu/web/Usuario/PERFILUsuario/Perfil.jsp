<%@ page import="ModeloDAO.*" %>
<%@ page import="java.util.*" %>
<%@ page import="Modelo.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Perfil de Usuario</title>
    <link rel="stylesheet" type="text/css" href="Usuario/PERFILUsuario/EstilosPerfil.css">



</form>
     <style>


        <% if (session.getAttribute("rol") != null && session.getAttribute("rol").equals("voluntario")) { %>
            body {
                background-color: #add8e6; 
            }
        <% } else if (session.getAttribute("rol") != null && session.getAttribute("rol").equals("organizacion")) { %>
            body {
                background-color: #d3d3d3;
            }
        <% } else if (session.getAttribute("rol") != null && session.getAttribute("rol").equals("administrador")) { %>
            body {
                background-color: #fffacd;
            }
        <% } %>

        
    </style>
    <link rel="icon" type="image/jpeg" href="imagenes\logo.jpeg"> 
</head>
<body>
    <div class="menu">
    <div class="menu-title">Perfil de usuario</div>
    <a href="ControladorLogin?accion=redirigirInicio">Inicio</a>
    <a href="ControladorChat?accion=allchats">Chat</a>
    <a href="ControladorNotificacion?accion=notificacion">Notificaciones</a>
    <a href="ControladorPerfil?accion=perfil">Perfil</a>
    <a href="ControladorUsuario?accion=control">Control de usuarios</a>
    <a href="ControladorLogin?accion=logout">Cerrar Sesi�n</a>
  </div>
    
    <div class="main-content">
        <div class="bienvenida">
            <% String nombreUsuario = (session.getAttribute("nombre") != null) ? (String) session.getAttribute("nombre") : "Usuario"; %>
            <label>Bienvenido, <strong><%= nombreUsuario %></strong></label><br><br>
        </div>

        <% if (session.getAttribute("rol") != null) { %>
            <% if (session.getAttribute("rol").equals("voluntario")) { %>
                <label>Rol: Voluntario</label><br><br>
            <% } else if (session.getAttribute("rol").equals("organizacion")) { %>
                <label>Rol: Organizaci�n</label><br><br>
            <% } else if (session.getAttribute("rol").equals("administrador")) { %>
                <label>Rol: Administrador</label><br><br>
            <% } %>
        <% } %>
            <% 
            int estado = (session.getAttribute("estado") != null) ? (int)session.getAttribute("estado") : 0;
        %>
        <p class='<%= (estado == 0) ? "red" : "lightgreen" %>'>Estado: <%= (estado == 0) ? "Inactivo" : "Activo" %></p>


        <div class="content">
        <% if (session.getAttribute("rol") != null && session.getAttribute("rol").equals("voluntario")) { %>
            <div class="voluntario-profile">
                <label>ID Voluntario:</label>
                <input type="text" value="<%= (session.getAttribute("idvoluntario") != null) ? session.getAttribute("idvoluntario") : "" %>" disabled><br>
                    <form method="post" action="ControladorPerfil?accion=editarVoluntario">
                    
                    <div class="input-row">
                        <div class="input-group">
                            <label>Nombre:</label>
                            <input type="text" value="<%= (session.getAttribute("nombre") != null) ? session.getAttribute("nombre") : "" %>" name="nombre" required>
                        </div>
                        
                        <div class="input-group">
                            <label>Edad:</label>
                            <input type="number" value="<%= (session.getAttribute("edad") != null) ? session.getAttribute("edad") : "" %>" name="edad" required>
                        </div>
                    </div>
                    
                    <div class="input-row">
                        <div class="input-group">
                            <label>Apellido:</label>
                            <input type="text" value="<%= (session.getAttribute("apellido") != null) ? session.getAttribute("apellido") : "" %>" name="apellido" required>
                        </div>
                        
                        <div class="input-group">
                            <label>Correo:</label>
                            <input type="email" value="<%= (session.getAttribute("correo") != null) ? session.getAttribute("correo") : "" %>" name="correo" required>
                        </div>
                    </div>
                        
                        <label>G�nero:</label>
                        <select name="genero" required>
                            <option value="Hombre" <%= (session.getAttribute("genero") != null && session.getAttribute("genero").equals("Hombre")) ? "selected" : "" %>>Hombre</option>
                            <option value="Mujer" <%= (session.getAttribute("genero") != null && session.getAttribute("genero").equals("Mujer")) ? "selected" : "" %>>Mujer</option>
                            <option value="Prefiero no decirlo" <%= (session.getAttribute("genero") != null && session.getAttribute("genero").equals("Prefiero no decirlo")) ? "selected" : "" %>>Prefiero no decirlo</option>
                        </select>
                        

                        <input type="submit" value="Actualizar Perfil" class="btn-actualizar"><br>
                    </form>
            </div>
        </div>
        
       

    
        
            
    <% } else if (session.getAttribute("rol") != null && session.getAttribute("rol").equals("organizacion")) { %>
    <div class="perfil-organizacion">
            <div class="datos-organizacion">
    <label>ID Organizaci�n:</label>
    <input type="text" value="<%= (session.getAttribute("idorganizacion") != null) ? session.getAttribute("idorganizacion") : "" %>" disabled><br><br>
    <form method="post" action="ControladorPerfil?accion=editarOrganizacion">
        <label>Nombre de la Organizaci�n:</label>
        <input type="text" value="<%= (session.getAttribute("nombre") != null) ? session.getAttribute("nombre") : "" %>" name="nombre" required><br><br>

        <label>Tipo:</label>
        <input type="text" value="<%= (session.getAttribute("tipo") != null) ? session.getAttribute("tipo") : "" %>" name="tipo" required><br><br>

        <label>Correo:</label>
        <input type="email" value="<%= (session.getAttribute("correo") != null) ? session.getAttribute("correo") : "" %>" name="correo" required><br><br>

        <input type="submit" value="Actualizar Perfil" class="btn-actualizar"><br>
        <br>
    </form>
        <form action="ControladorCalificar" method="GET">
            <input type="hidden" name="accion" value="listarPerfiles">
            <button type="submit" class="btn-listar">Listar Perfiles</button>
        </form>
     </div>
    <div class="agregar-oportunidad">
    <h1>Agregar Oportunidad:</h1>  
    <!-- Agregar Oportunidad-->
<div class="agregar-oportunidad">
    <!-- Formulario Agregar Oportunidad -->
    <form action="ControladorOportunidad" method="post">

        <!-- T�tulo -->
        <label for="titulo">T�tulo:</label>
        <input type="text" name="titulo" id="titulo" required><br>

        <!-- Descripci�n -->
        <label for="descripcion">Descripci�n:</label>
        <textarea name="descripcion" id="descripcion" required></textarea><br>

        <!-- Fecha -->
        <label for="fecha">Fecha:</label>
        <input type="date" name="fecha" id="fecha" required><br>

        <!-- Ubicaci�n -->
        <label for="idubicacion">Ubicaci�n:</label>
        <select name="idubicacion" id="idubicacion" required>
            <% 
            UbicacionDAO ubicacionDao = new UbicacionDAO();
            List<Ubicacion> ubicaciones = ubicacionDao.listarUbicaciones();
            for (Ubicacion ubi : ubicaciones) {
                out.println("<option value='" + ubi.getIdubicacion() + "'>" + ubi.getPais() + ", " + ubi.getCiudad() + " - " + ubi.getDireccion() + "</option>");
            }
            %>
        </select><br>

        <!-- Causa -->
        <label for="idcausa">Causa:</label>
        <select name="idcausa" id="idcausa" required>
            <% 
            CausaDAO causaDao = new CausaDAO();
            List<Causa> causas = causaDao.listarCausas();
            for (Causa caus : causas) {
                out.println("<option value='" + caus.getIdcausa() + "'>" + caus.getNombre() + "</option>");
            }
            %>
        </select><br>

        <!-- Campo oculto para la acci�n "crear" -->
        <input type="hidden" name="accion" value="crear">

        <!-- Bot�n de enviar -->
        <input type="submit" value="Crear Oportunidad">
    </form>
</div>

    <br>
    <div class="oportunidades-organizacion">
    <h1>Todas las Oportunidades creadas por su Organizacion:</h1>
    <div>
        <%
            Integer idOrganizacion = null;
            if (session.getAttribute("idorganizacion") != null) {
                idOrganizacion = (Integer) session.getAttribute("idorganizacion");

                OportunidadDAO oportunidadDao = new OportunidadDAO();
                List<Oportunidad> oportunidadesOrganizacion = oportunidadDao.listarOportunidadesPorOrganizacion(idOrganizacion);

                if (oportunidadesOrganizacion != null && !oportunidadesOrganizacion.isEmpty()) {
                    for (Oportunidad opo : oportunidadesOrganizacion) {
        %>
                        <div class='oportunidad'>
                            <h2><%= opo.getTitulo() %></h2>
                            <p>Descripci�n: <%= opo.getDescripcion() %></p>
                            <p>Fecha: <%= opo.getFecha() %></p>

                            <!-- Bot�n de eliminar oportunidad con confirmaci�n -->
                            <form method='post' action='ControladorOportunidad' onsubmit="return confirm('�Est�s seguro de eliminar esta oportunidad?');">
                                <input type='hidden' name='accion' value='eliminar'>
                                <input type='hidden' name='idOportunidad' value='<%= opo.getIdoportunidad() %>'>
                                <input type='submit' value='Eliminar'>
                            </form>
                        </div>
        <%
                    }
                } else {
                    out.print("<p>No hay oportunidades disponibles para tu organizaci�n.</p>");
                }
            } else {
                // Redirigir al inicio de sesi�n si no hay una sesi�n v�lida
                response.sendRedirect("login.jsp");
                return;
            }
        %>
    </div>


        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    <% } else if (session.getAttribute("rol") != null && session.getAttribute("rol").equals("administrador")) { %>
    <label>ID Administrador:</label>
    <input type="text" value="<%= (session.getAttribute("idadmin") != null) ? session.getAttribute("idadmin") : "" %>" disabled><br><br>
    <form method="post" action="ControladorPerfil?accion=editarAdministrador">
        <label>Nombre del Administrador:</label>
        <input type="text" value="<%= (session.getAttribute("nombre") != null) ? session.getAttribute("nombre") : "" %>" name="nombre" required><br><br>

  

        <input type="submit" value="Actualizar Perfil" class="btn-actualizar"><br>
    </form>
    <% } %>


    <form method="post" action="ControladorPerfil?accion=actualizarEstado" onsubmit="return confirm('�Est� seguro de realizar esta acci�n?');">
        <button type="submit" name="estado" value="1">Activar Cuenta</button>
        <button type="submit" name="estado" value="0">Desactivar Cuenta</button>
    </form>

    <p class='<%= (estado == 0) ? "red" : "lightgreen" %>'>Estado: <%= (estado == 0) ? "Inactivo" : "Activo" %></p>
    
    <script>
        function checkState() {
            let currentState = <%= (int)session.getAttribute("estado") %>;

            if (currentState === 0) {
                let countdown = 4; 
                let timer = setInterval(function() {
                    countdown--;
                    if (countdown === 0) {
                        clearInterval(timer);
                        document.getElementById("message").innerText = "Cuenta desactivada. Cerrando sesi�n...";
                        setTimeout(() => {
                            window.location.href = 'index.jsp'; 
                        }, 1000);
                    }
                }, 1000); 
            }
        }

        checkState(); 
    </script>

    <p id="message"></p>
    
    
    
    <script>
        window.onload = function() {
            var gender = '<%= session.getAttribute("genero") %>';
            var profileImg = document.getElementById('profile-img');

            if (gender === 'Mujer') {
                profileImg.src = 'ruta/a/mujerperfil.png';
            } else {
                profileImg.src = 'ruta/a/hombreperfil.png';
            }
        };
    </script>

</body>
</html>