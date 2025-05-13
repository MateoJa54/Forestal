<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Zonas Forestales</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilo.css">
    </head>

    <body>

        <div class="header">
            <h1>SISTEMA DE REGISTRO FORESTAL - ZONAS</h1>
            <form action="LogoutServlet" method="post">
                <button class="logout-btn">Cerrar sesión</button>
            </form>
        </div>

        <div class="sidebar">
            <button onclick="location.href = '${pageContext.request.contextPath}/Zona'">Zonas Forestales</button>
            <button onclick="location.href = '${pageContext.request.contextPath}/Especie'">Especies de Árboles</button>
            <button onclick="location.href = '${pageContext.request.contextPath}/Actividad'">Actividades de Conservación</button>
        </div>

        <div class="main">
            <button class="btn-agregar" onclick="document.getElementById('zonaModal').style.display = 'block'">Agregar Zona</button>

            <!-- Modal de registro -->
            <div id="zonaModal" class="modal">
                <div class="modal-content p-4 bg-light rounded shadow">
                    <span class="btn-close float-end" onclick="document.getElementById('zonaModal').style.display = 'none'"></span>
                    <h2>Registrar nueva zona forestal</h2>
                    <form action="${pageContext.request.contextPath}/Zona" method="post">
                        <input type="hidden" name="option" value="new" />
                        <div class="mb-3">
                            <label class="form-label">Nombre:</label>
                            <input type="text" name="nombre" class="form-control" required />
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Ubicación:</label>
                            <input type="text" name="ubicacion" class="form-control" required />
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Área (hectáreas):</label>
                            <input type="number" step="0.01" name="areaHectareas" class="form-control" required />
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Tipo de vegetación:</label>
                            <input type="text" name="tipoVegetacion" class="form-control" />
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Coordenadas:</label>
                            <input type="text" name="coordenadas" class="form-control" />
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Fecha Registro:</label>
                            <input type="date" name="fechaRegistro" class="form-control" value="<%= java.time.LocalDate.now() %>" required />
                        </div>
                        <button type="submit" class="btn btn-primary">Guardar Zona</button>
                    </form>
                </div>
            </div>

            <h2>Zonas Registradas</h2>
            <!-- Depuración: mostrar total encontradas -->
            <c:if test="${empty zonas}">
                <p>No hay zonas registradas.</p>
            </c:if>
            <c:if test="${not empty zonas}">
                <p>Total de zonas: ${fn:length(zonas)}</p>
            </c:if>

            <table class="table table-striped-columns">
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

                                <a href="${pageContext.request.contextPath}/Zona?option=update&id=${zona.zonaId}" class="btn btn-sm btn-warning">Editar</a>
                                <form action="${pageContext.request.contextPath}/Zona" method="get" style="display:inline;">
                                    <input type="hidden" name="option" value="delete"/>
                                    <input type="hidden" name="id" value="${zona.zonaId}" />
                                    <button class="btn btn-sm btn-danger" onclick="return confirm('¿Eliminar esta zona?');">Eliminar</button>
                                </form>

                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Cierra el modal si se hace clic fuera del contenido -->
        <script>
            window.onclick = function (event) {
                const modal = document.getElementById('zonaModal');
                if (event.target == modal) {
                    modal.style.display = "none";
                }
            }
        </script>

    </body>
</html>
