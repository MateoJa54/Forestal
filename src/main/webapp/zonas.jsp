<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Zonas Forestales</title>
    <link rel="stylesheet" href="css/estilo.css">
</head>
<body>

<div class="header">
    <h1>SISTEMA DE REGISTRO FORESTAL - ZONAS</h1>
    <form action="LogoutServlet" method="post">
        <button class="logout-btn">Cerrar sesión</button>
    </form>
</div>

<div class="sidebar">
    <button onclick="location.href='zonas.jsp'">Zonas Forestales</button>
    <button onclick="location.href='especies.jsp'">Especies de Árboles</button>
    <button onclick="location.href='actividades.jsp'">Actividades de Conservación</button>
</div>

<div class="main">
    <button class="btn-agregar" onclick="document.getElementById('zonaModal').style.display='block'">Agregar Zona</button>

    <!-- Modal de registro -->
    <div id="zonaModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="document.getElementById('zonaModal').style.display='none'">&times;</span>
            <h2>Registrar nueva zona forestal</h2>
            <form action="ZonaController" method="post">
                <input type="hidden" name="action" value="crear" />
                <label>Nombre:</label><input type="text" name="nombre" required /><br/>
                <label>Ubicación:</label><input type="text" name="ubicacion" required /><br/>
                <label>Área (hectáreas):</label><input type="number" step="0.01" name="area_hectareas" required /><br/>
                <label>Tipo de vegetación:</label><input type="text" name="tipo_vegetacion" /><br/>
                <label>Coordenadas:</label><input type="text" name="coordenadas" /><br/>
                <input type="submit" value="Guardar Zona" />
            </form>
        </div>
    </div>

    <h2>Zonas Registradas</h2>
    <table>
        <thead>
            <tr>
                <th>Nombre</th>
                <th>Ubicación</th>
                <th>Área (ha)</th>
                <th>Fecha Registro</th>
                <th>Acción</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="zona" items="${zonas}">
                <tr>
                    <td>${zona.nombre}</td>
                    <td>${zona.ubicacion}</td>
                    <td>${zona.areaHectareas}</td>
                    <td>${zona.fechaRegistro}</td>
                    <td>
                        <form action="ZonaController" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="eliminar"/>
                            <input type="hidden" name="zonaId" value="${zona.zonaId}" />
                            <button class="delete-btn" onclick="return confirm('¿Eliminar esta zona?');">X</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<!-- Cierra el modal si se hace clic fuera del contenido -->
<script>
    window.onclick = function(event) {
        const modal = document.getElementById('zonaModal');
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
</script>

</body>
</html>
