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
            <h1>SISTEMA DE REGISTRO FORESTAL - ZONAS</h1>
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

                <!-- Modal de edición -->
                <div id="editZonaModal" class="modal">
                    <div class="modal-content p-4 bg-light rounded shadow">
                        <span class="btn-close float-end" onclick="document.getElementById('editZonaModal').style.display = 'none'"></span>
                        <h2>Editar zona forestal</h2>
                        <form action="${pageContext.request.contextPath}/Zona" method="post">
                            <input type="hidden" name="option" value="update" />
                            <input type="hidden" name="zonaId" id="editZonaId" />
                            <div class="mb-3">
                                <label class="form-label">Nombre:</label>
                                <input type="text" name="nombre" id="editNombre" class="form-control" required />
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Ubicación:</label>
                                <input type="text" name="ubicacion" id="editUbicacion" class="form-control" required />
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Área (hectáreas):</label>
                                <input type="number" step="0.01" name="areaHectareas" id="editArea" class="form-control" required />
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Tipo de vegetación:</label>
                                <input type="text" name="tipoVegetacion" id="editVegetacion" class="form-control" />
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Coordenadas:</label>
                                <input type="text" name="coordenadas" id="editCoordenadas" class="form-control" />
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Fecha Registro:</label>
                                <input type="date" name="fechaRegistro" id="editFecha" class="form-control" required />
                            </div>
                            <button type="submit" class="btn btn-success">Actualizar Zona</button>
                        </form>
                    </div>
                </div>

                <!-- Modal de Especies de Árboles asociadas -->
                <div id="especieZonaModal" class="modal">
                    <div class="modal-content p-4 bg-light rounded shadow w-75 mx-auto">
                        <span class="btn-close float-end" onclick="document.getElementById('especieZonaModal').style.display = 'none'"></span>
                        <h2>Gestión de Especies en la Zona</h2>

                        <div class="mt-3">
                            <h5 class="mb-3">Agregar especie a esta zona:</h5>
                            <form id="formAgregarEspecie" method="post" action="${pageContext.request.contextPath}/ZonaEspecie">
                                <input type="hidden" name="zonaId" id="zonaIdEspecie" />

                                <div class="mb-3">
                                    <label for="especieSelect" class="form-label">Seleccione una especie:</label>
                                    <select id="especieSelect" name="especieId" class="form-select" required>
                                        <!-- Opciones se llenarán dinámicamente desde el backend -->
                                    </select>
                                </div>

                                <button type="submit" class="btn btn-success">Agregar Especie</button>
                            </form>
                        </div>

                        <div class="mt-5">
                            <h5>Especies registradas en esta zona:</h5>
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover mt-2">
                                    <thead class="table-success text-center">
                                        <tr>
                                            <th>Nombre común</th>
                                            <th>Nombre Cientifico</th>
                                            <th>Densidad</th>
                                        </tr>
                                    </thead>
                                    <tbody id="tablaEspeciesZona">
                                        <!-- Filas se llenarán dinámicamente desde backend o por JavaScript -->
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>


                <!-- Modal de Programas/Zonas Protegidas -->
                <div id="programaModal" class="modal">
                    <div class="modal-content p-4 bg-light rounded shadow">
                        <span class="btn-close float-end" onclick="document.getElementById('programaModal').style.display = 'none'"></span>
                        <h2>Programas de Conservación / Zonas Protegidas</h2>
                    </div>
                </div>



                <h2>Zonas Registradas</h2>
                <!-- Depuración: mostrar total encontradas -->
                <c:if test="${empty zonas}">
                    <p class="countZone">No hay zonas registradas.</p>
                </c:if>
                <c:if test="${not empty zonas}">
                    <p class="countZone">Total de zonas: ${fn:length(zonas)}</p>
                </c:if>

                <!-- Barra de búsqueda -->
                <div class="input-group mb-3 w-50">
                    <span class="input-group-text" id="basic-addon1"><i class="bi bi-search"></i></span>
                    <input type="text" class="form-control" id="busquedaZona" placeholder="Buscar por Nombre...">
                </div>


                <div class="table-responsive rounded shadow-sm mt-4">
                    <table class="table table-hover align-middle">
                        <thead class="table-success text-center">
                            <tr>
                                <th> Nombre</th>
                                <th> Ubicación</th>
                                <th> Área (ha)</th>
                                <th> Fecha Registro</th>
                                <th>️ Tipo de Vegetacion</th>
                                <th>️ Acción</th>

                            </tr>
                        </thead>
                        <tbody class="table-light">
                            <c:forEach var="zona" items="${zonas}">
                                <tr>
                                    <td>${zona.nombre}</td>
                                    <td>${zona.ubicacion}</td>
                                    <td>${zona.areaHectareas}</td>
                                    <td>${zona.fechaRegistro}</td>
                                    <td>${zona.tipoVegetacion}</td>
                                    <td class="text-center">
                                        <!-- Botón para abrir el modal de edición -->
                                        <button class="btn btn-sm btn-warning" onclick="openEditModal(${zona.zonaId}, '${zona.nombre}', '${zona.ubicacion}', ${zona.areaHectareas}, '${zona.tipoVegetacion}', '${zona.coordenadas}', '${zona.fechaRegistro}')">
                                            <i class="bi bi-pencil-square"></i>
                                        </button>

                                        <!-- Botón para abrir modal de árboles -->
                                        <button class="btn btn-sm btn-secondary" onclick="openEspecieModal(${zona.zonaId})">
                                            <i class="bi bi-tree"></i>
                                        </button>

                                        <!-- Botón para abrir modal de zonas protegidas -->
                                        <button class="btn btn-sm btn-dark" onclick="openProgramaModal(${zona.zonaId})">
                                            <i class="bi bi-shield-lock-fill"></i>
                                        </button>


                                        <!-- Botón de eliminar -->
                                        <form action="${pageContext.request.contextPath}/Zona" method="get" style="display:inline;">
                                            <input type="hidden" name="option" value="delete"/>
                                            <input type="hidden" name="id" value="${zona.zonaId}" />
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

        <!-- Cierra el modal si se hace clic fuera del contenido -->
        <script>
            window.onclick = function (event) {
                const modal = document.getElementById('zonaModal');
                if (event.target == modal) {
                    modal.style.display = "none";
                }
            }
        </script>

        <script>
            function openEditModal(id, nombre, ubicacion, area, vegetacion, coordenadas, fecha) {
                document.getElementById('editZonaId').value = id;
                document.getElementById('editNombre').value = nombre;
                document.getElementById('editUbicacion').value = ubicacion;
                document.getElementById('editArea').value = area;
                document.getElementById('editVegetacion').value = vegetacion;
                document.getElementById('editCoordenadas').value = coordenadas;
                document.getElementById('editFecha').value = fecha;

                document.getElementById('editZonaModal').style.display = 'block';
            }

            function openEspecieModal(zonaId) {
                document.getElementById('especieZonaModal').style.display = 'block';
            }

            function openProgramaModal(zonaId) {
                document.getElementById('programaModal').style.display = 'block';
            }


            // Cierra los modales al hacer clic fuera de ellos
            window.onclick = function (event) {
                ['zonaModal', 'editZonaModal', 'especieModal', 'especieZonaModal', 'programaModal'].forEach(function (id) {
                    const modal = document.getElementById(id);
                    if (modal && event.target === modal) {
                        modal.style.display = "none";
                    }
                });
            }
            
                document.getElementById("busquedaZona").addEventListener("keyup", function () {
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

        </script>

    </body>
</html>