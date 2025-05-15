<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Zonas Forestales</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilo.css">
    </head>

    <body>

        <div class="header">
            <img src="https://cdn-icons-png.flaticon.com/512/4275/4275503.png" alt="Logo Forestal">
            <h1>SISTEMA DE REGISTRO FORESTAL - ACTIVIDADES DE PROTECCIÓN </h1>
            <form action="LogoutServlet" method="post">
                <button class="logout-btn">Cerrar sesión</button>
            </form>
        </div>
        <div class="main-content">
            <div class="sidebar">
                <button onclick="location.href = '${pageContext.request.contextPath}/Home'">Home</button>
                <button onclick="location.href = '${pageContext.request.contextPath}/Zona'">Zonas Forestales</button>
                <button onclick="location.href = '${pageContext.request.contextPath}/Especie'">Especies de Árboles</button>
                <button onclick="location.href = '${pageContext.request.contextPath}/Actividad'">Actividades de Conservación</button>
            </div>

            <div class="main">
                <button class="btn-agregar" onclick="document.getElementById('actividadModal').style.display = 'block'">Agregar Especie</button>

                <!-- Modal de registro -->
                <div id="actividadModal" class="modal">
                    <div class="modal-content p-4 bg-light rounded shadow">
                        <span class="btn-close float-end" onclick="document.getElementById('actividadModal').style.display = 'none'"></span>
                        <h2>Registrar Actividad de Conservación</h2>


                        <form action="${pageContext.request.contextPath}/Actividad" method="post">
                            <input type="hidden" name="option" value="new" />

                            <div class="mb-3">
                                <label class="form-label">Nombre de la Actividad:</label>
                                <input type="text" name="nombre" class="form-control" required />
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Descripción:</label>
                                <textarea name="descripcion" class="form-control" rows="3"></textarea>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Fecha de Inicio:</label>
                                <input type="date" name="fechaInicio" class="form-control" required />
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Fecha de Fin:</label>
                                <input type="date" name="fechaFin" class="form-control" />
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Presupuesto (USD):</label>
                                <input type="number" step="0.01" name="presupuesto" class="form-control" />
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Estado:</label>
                                <select name="estado" class="form-select" required>
                                    <option value="">Seleccione...</option>
                                    <option value="PLANEADA">Planificada</option>
                                    <option value="EN_PROGRESO">En Progreso</option>
                                    <option value="COMPLETADA">Finalizada</option>
                                    <option value="CANCELADA">Cancelada</option>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Zona Forestal:</label>
                                <select name="zonaId" class="form-select" required>
                                    <option value="">Seleccione una zona...</option>
                                    <c:forEach var="zona" items="${zonas}">
                                        <option value="${zona.zonaId}">
                                            ${zona.nombre} - ${zona.ubicacion}
                                        </option>
                                    </c:forEach>
                                </select>

                            </div>
                            <button type="submit" class="btn btn-success">Guardar Actividad</button>
                        </form>
                    </div>
                </div>



                <!-- Modal de edición -->
                <div id="editActividadModal" class="modal" style="display:none;">
                    <div class="modal-content p-4 bg-light rounded shadow">
                        <span class="btn-close float-end" onclick="document.getElementById('editActividadModal').style.display = 'none'"></span>
                        <h2>Editar actividad de conservación</h2>
                        <form action="${pageContext.request.contextPath}/Actividad" method="post">
                            <input type="hidden" name="actividadId" id="editActividadId" />

                            <div class="mb-3">
                                <label class="form-label">Nombre:</label>
                                <input type="text" name="nombre" id="editNombre" class="form-control" required />
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Descripción:</label>
                                <textarea name="descripcion" id="editDescripcion" class="form-control" rows="3"></textarea>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Fecha Inicio:</label>
                                <input type="date" name="fechaInicio" id="editFechaInicio" class="form-control" required />
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Fecha Fin:</label>
                                <input type="date" name="fechaFin" id="editFechaFin" class="form-control" />
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Presupuesto:</label>
                                <input type="number" step="0.01" name="presupuesto" id="editPresupuesto" class="form-control" />
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Estado:</label>
                                <select name="estado" id="editEstado" class="form-select" required>
                                    <option value="">Seleccione...</option>
                                    <option value="PLANEADA">Planificada</option>
                                    <option value="EN_PROGRESO">En Progreso</option>
                                    <option value="COMPLETADA">Completada</option>
                                    <option value="CANCELADA">Cancelada</option>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Zona Forestal:</label>
                                <select name="zonaId" id="editZonaId" class="form-select" required>
                                    <option value="">Seleccione una zona...</option>
                                    <c:forEach var="zona" items="${zonas}">
                                        <option value="${zona.zonaId}">${zona.nombre} - ${zona.ubicacion}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <button type="submit" class="btn btn-success">Actualizar actividad</button>
                        </form>
                    </div>
                </div>



                <div id="viewActividadModal" class="modal" style="display:none;">
                    <div class="modal-content p-4 bg-light rounded shadow">
                        <span class="btn-close float-end" onclick="document.getElementById('viewActividadModal').style.display = 'none'"></span>
                        <h2>Detalle de Actividad de Conservación</h2>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Nombre:</label>
                            <p id="viewNombre"></p>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Descripción:</label>
                            <p id="viewDescripcion"></p>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Fecha Inicio:</label>
                            <p id="viewFechaInicio"></p>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Fecha Fin:</label>
                            <p id="viewFechaFin"></p>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Presupuesto:</label>
                            <p id="viewPresupuesto"></p>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Estado:</label>
                            <p id="viewEstado"></p>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Zona Forestal:</label>
                            <select id="viewZonaId" class="form-select" disabled>
                                <option value="">Seleccione una zona...</option>
                                <c:forEach var="zona" items="${zonas}">
                                    <option value="${zona.zonaId}">${zona.nombre} - ${zona.ubicacion}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>



                <h2>Actividades Proteccion Registradas</h2>
                <!-- Depuración: mostrar total encontradas -->
                <c:if test="${empty actividades}">
                    <p class="countZone">No hay zonas registradas.</p>
                </c:if>
                <c:if test="${not empty actividades}">
                    <p class="countZone">Total de zonas: ${fn:length(actividades)}</p>
                </c:if>

                <!-- Barra de búsqueda -->
                <div class="input-group mb-3 w-50">
                    <span class="input-group-text" id="basic-addon1"><i class="bi bi-search"></i></span>
                    <input type="text" class="form-control" id="busquedaActividad" placeholder="Buscar por Nombre de Actividad">
                </div>


                <div class="table-responsive rounded shadow-sm mt-4">
                    <table class="table table-hover align-middle">
                        <thead class="table-success text-center">
                            <tr>
                                <th> Nombre</th>
                                <th> Prespuesto</th>
                                <th> Estado</th>
                                <th>️ Acción</th>

                            </tr>
                        </thead>
                        <tbody class="table-light">
                            <c:forEach var="actividad" items="${actividades}">
                                <tr>
                                    <td>${actividad.nombre}</td>
                                    <td>${actividad.presupuesto}</td>
                                    <td>${actividad.estado}</td>
                                    <td class="text-center">

                                        <!-- Botón para abrir el modal de edición -->
                                        <button 
                                            class="btn btn-sm btn-warning" 
                                            data-id="${actividad.actividadId}"
                                            data-nombre="${actividad.nombre}"
                                            data-descripcion="${actividad.descripcion}"
                                            data-fechainicio="${actividad.fechaInicio}"
                                            data-fechafin="${actividad.fechaFin}"
                                            data-presupuesto="${actividad.presupuesto}"
                                            data-estado="${actividad.estado}"
                                            data-zonaid="${actividad.zona.zonaId}"
                                            onclick="openEditModal(this)">
                                            <i class="bi bi-pencil-square"></i>
                                        </button>

                                        <button
                                            class="btn btn-sm btn-info"
                                            data-nombre="${actividad.nombre}"
                                            data-descripcion="${actividad.descripcion}"
                                            data-fechainicio="${actividad.fechaInicio}"
                                            data-fechafin="${actividad.fechaFin}"
                                            data-presupuesto="${actividad.presupuesto}"
                                            data-estado="${actividad.estado}"
                                            data-zonaid="${actividad.zona.zonaId}"
                                            onclick="openViewModal(this)">
                                            <i class="bi bi-eye"></i>
                                        </button>


                                        <!-- Botón de eliminar -->
                                        <form action="${pageContext.request.contextPath}/Actividad" method="get" style="display:inline;">
                                            <input type="hidden" name="option" value="delete"/>
                                            <input type="hidden" name="id" value="${actividad.actividadId}" />
                                            <button class="btn btn-sm btn-danger" onclick="return confirm('¿Eliminar esta zona?');">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </form>


                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>


        <script>
            function openEditModal(btn) {
                document.getElementById('editActividadId').value = btn.dataset.id;
                document.getElementById('editNombre').value = btn.dataset.nombre;
                document.getElementById('editDescripcion').value = btn.dataset.descripcion || '';
                document.getElementById('editFechaInicio').value = btn.dataset.fechainicio;
                document.getElementById('editFechaFin').value = btn.dataset.fechafin || '';
                document.getElementById('editPresupuesto').value = btn.dataset.presupuesto || '';
                document.getElementById('editEstado').value = btn.dataset.estado;
                document.getElementById('editZonaId').value = btn.dataset.zonaid;

                document.getElementById('editActividadModal').style.display = 'block';
            }




            // Cierra los modales al hacer clic fuera de ellos
            window.onclick = function (event) {
                ['actividadModal', 'editActividadModal', 'viewActividadModal'].forEach(function (id) {
                    const modal = document.getElementById(id);
                    if (modal && event.target === modal) {
                        modal.style.display = "none";
                    }
                });
            }

            document.getElementById("busquedaActividad").addEventListener("keyup", function () {
                const filtro = this.value.toLowerCase();
                const filas = document.querySelectorAll("tbody.table-light tr");

                filas.forEach(fila => {
                    const nombre = fila.cells[0].textContent.toLowerCase(); // Nombre

                    if (nombre.includes(filtro)) {
                        fila.style.display = "";
                    } else {
                        fila.style.display = "none";
                    }
                });
            });

            function openViewModal(btn) {
                document.getElementById('viewNombre').textContent = btn.dataset.nombre || '';
                document.getElementById('viewDescripcion').textContent = btn.dataset.descripcion || '';
                document.getElementById('viewFechaInicio').textContent = btn.dataset.fechainicio || '';
                document.getElementById('viewFechaFin').textContent = btn.dataset.fechafin || '';
                document.getElementById('viewPresupuesto').textContent = btn.dataset.presupuesto || '';
                document.getElementById('viewEstado').textContent = btn.dataset.estado || '';
                document.getElementById('viewZonaId').value = btn.dataset.zonaid;

                document.getElementById('viewActividadModal').style.display = 'block';
            }




        </script>

    </body>
</html>