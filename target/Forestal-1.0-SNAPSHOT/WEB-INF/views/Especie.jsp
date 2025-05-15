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
            <h1>SISTEMA DE REGISTRO FORESTAL - ESPECIES </h1>
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
                <button class="btn-agregar" onclick="document.getElementById('especieModal').style.display = 'block'">Agregar Especie</button>

                <!-- Modal de registro -->
                <div id="especieModal" class="modal">
                    <div class="modal-content p-4 bg-light rounded shadow">
                        <span class="btn-close float-end" onclick="document.getElementById('especieModal').style.display = 'none'"></span>
                        <h2>Registrar nueva especie</h2>
                        <form action="${pageContext.request.contextPath}/Especie" method="post">
                            <input type="hidden" name="option" value="new" />

                            <div class="mb-3">
                                <label class="form-label">Nombre Científico:</label>
                                <input type="text" name="nombreCientifico" class="form-control" required />
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Nombre Común:</label>
                                <input type="text" name="nombreComun" class="form-control" required />
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Familia:</label>
                                <input type="text" name="familia" class="form-control" />
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Estado de Conservación:</label>
                                <select name="estadoConservacion" class="form-select" required>
                                    <option value="">Seleccione...</option>
                                    <option value="VULNERABLE">Vulnerable</option>
                                    <option value="EN_PELIGRO">En peligro</option>
                                    <option value="ESTABLE">Estable</option>
                                    <option value="CASI_AMENAZADA">Casi Amenazada</option>
                                    <option value="EXTINTA">Extinta</option>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Descripción:</label>
                                <textarea name="descripcion" class="form-control" rows="3"></textarea>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">URL de Imagen:</label>
                                <input type="url" name="imagenUrl" class="form-control" />
                            </div>

                            <button type="submit" class="btn btn-primary">Guardar Especie</button>
                        </form>
                    </div>
                </div>


                <!-- Modal de edición -->
                <div id="editEspecieModal" class="modal">
                    <div class="modal-content p-4 bg-light rounded shadow">
                        <span class="btn-close float-end" onclick="document.getElementById('editEspecieModal').style.display = 'none'"></span>
                        <h2>Editar especie de árbol</h2>
                        <form action="${pageContext.request.contextPath}/Especie" method="post">
                            <input type="hidden" name="especieId" id="editEspecieId" />

                            <div class="mb-3">
                                <label class="form-label">Nombre científico:</label>
                                <input type="text" name="nombreCientifico" id="editNombreCientifico" class="form-control" required />
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Nombre común:</label>
                                <input type="text" name="nombreComun" id="editNombreComun" class="form-control" required />
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Familia:</label>
                                <input type="text" name="familia" id="editFamilia" class="form-control" />
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Estado de conservación:</label>
                                <select name="estadoConservacion" id="editEstadoConservacion" class="form-control" required>
                                    <option value="">Seleccione...</option>
                                    <option value="VULNERABLE">Vulnerable</option>
                                    <option value="EN_PELIGRO">En peligro</option>
                                    <option value="ESTABLE">Estable</option>
                                    <option value="CASI_AMENAZADA">Casi Amenazada</option>
                                    <option value="EXTINTA">Extinta</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Descripción:</label>
                                <textarea name="descripcion" id="editDescripcion" class="form-control" rows="4"></textarea>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">URL de imagen:</label>
                                <input type="text" name="imagenUrl" id="editImagenUrl" class="form-control" />
                            </div>

                            <button type="submit" class="btn btn-success">Actualizar especie</button>
                        </form>
                    </div>
                </div>

                <!-- Modal de solo visualización -->
                <div id="viewEspecieModal" class="modal" style="display:none;">
                    <div class="modal-content p-4 bg-light rounded shadow" style="max-width:600px; margin:auto;">
                        <span class="btn-close float-end" onclick="document.getElementById('viewEspecieModal').style.display = 'none'"></span>
                        <h2>Detalles de especie de árbol</h2>

                        <div class="mb-3">
                            <label class="form-label">Imagen:</label>
                            <div style="text-align:center;">
                                <img id="viewImagen" src="" alt="Imagen de la especie" style="max-width:100%; max-height:300px; border-radius:8px;"/>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Nombre científico:</label>
                            <input type="text" id="viewNombreCientifico" class="form-control" readonly />
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Nombre común:</label>
                            <input type="text" id="viewNombreComun" class="form-control" readonly />
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Familia:</label>
                            <input type="text" id="viewFamilia" class="form-control" readonly />
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Estado de conservación:</label>
                            <input type="text" id="viewEstadoConservacion" class="form-control" readonly />
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Descripción:</label>
                            <textarea id="viewDescripcion" class="form-control" rows="4" readonly></textarea>
                        </div>
                        <button class="btn btn-secondary" onclick="document.getElementById('viewEspecieModal').style.display = 'none'">Cerrar</button>
                    </div>
                </div>


                <h2>Especies Registradas</h2>
                <!-- Depuración: mostrar total encontradas -->
                <c:if test="${empty especies}">
                    <p class="countZone">No hay zonas especies.</p>
                </c:if>
                <c:if test="${not empty especies}">
                    <p class="countZone">Total de especies: ${fn:length(especies)}</p>
                </c:if>

                <!-- Barra de búsqueda -->
                <div class="input-group mb-3 w-50">
                    <span class="input-group-text" id="basic-addon1"><i class="bi bi-search"></i></span>
                    <input type="text" class="form-control" id="busquedaZona" placeholder="Buscar por Nombre Comun">
                </div>


                <div class="table-responsive rounded shadow-sm mt-4">
                    <table class="table table-hover align-middle">
                        <thead class="table-success text-center">
                            <tr>
                                <th> Nombre Comun</th>
                                <th> Nombre Cientifico</th>
                                <th> Familia</th>
                                <th> Estado de Conservacion</th>
                                <th>️ Acción</th>

                            </tr>
                        </thead>
                        <tbody class="table-light">
                            <c:forEach var="especie" items="${especies}">
                                <tr>
                                    <td>${especie.nombreComun}</td>
                                    <td>${especie.nombreCientifico}</td>
                                    <td>${especie.familia}</td>
                                    <td>${especie.estadoConservacion}</td>
                                    <td class="text-center">

                                        <!-- Botón para abrir el modal de edición -->
                                        <button class="btn btn-sm btn-warning"
                                                data-id="${especie.especieId}"
                                                data-nombrecientifico="${fn:escapeXml(especie.nombreCientifico)}"
                                                data-nombrecomun="${fn:escapeXml(especie.nombreComun)}"
                                                data-familia="${fn:escapeXml(especie.familia)}"
                                                data-estadoconservacion="${especie.estadoConservacion}"
                                                data-descripcion="${fn:escapeXml(especie.descripcion)}"
                                                data-imagenurl="${fn:escapeXml(especie.imagenUrl)}"
                                                onclick="openEditEspecieModalFromButton(this)">
                                            <i class="bi bi-pencil-square"></i>
                                        </button>

                                        <button class="btn btn-sm btn-info"
                                                data-id="${especie.especieId}"
                                                data-nombrecientifico="${fn:escapeXml(especie.nombreCientifico)}"
                                                data-nombrecomun="${fn:escapeXml(especie.nombreComun)}"
                                                data-familia="${fn:escapeXml(especie.familia)}"
                                                data-estadoconservacion="${especie.estadoConservacion}"
                                                data-descripcion="${fn:escapeXml(especie.descripcion)}"
                                                data-imagenurl="${fn:escapeXml(especie.imagenUrl)}"
                                                onclick="openViewEspecieModal(this)">
                                            <i class="bi bi-eye-fill"></i>
                                        </button>



                                        <!-- Botón de eliminar -->
                                        <form action="${pageContext.request.contextPath}/Especie" method="get" style="display:inline;">
                                            <input type="hidden" name="option" value="delete"/>
                                            <input type="hidden" name="id" value="${especie.especieId}" />
                                            <button class="btn btn-sm btn-danger" onclick="return confirm('¿Eliminar esta especie?');">
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
            function openEditEspecieModalFromButton(btn) {
                document.getElementById('editEspecieId').value = btn.dataset.id;
                document.getElementById('editNombreCientifico').value = btn.dataset.nombrecientifico;
                document.getElementById('editNombreComun').value = btn.dataset.nombrecomun;
                document.getElementById('editFamilia').value = btn.dataset.familia;
                document.getElementById('editEstadoConservacion').value = btn.dataset.estadoconservacion;
                document.getElementById('editDescripcion').value = btn.dataset.descripcion;
                document.getElementById('editImagenUrl').value = btn.dataset.imagenurl;

                document.getElementById('editEspecieModal').style.display = 'block';
            }



            // Cierra los modales al hacer clic fuera de ellos
            window.onclick = function (event) {
                ['especieModal', 'editEspecieModal', 'especieZonaModal', 'viewEspecieModal'].forEach(function (id) {
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

            function openViewEspecieModal(btn) {
                document.getElementById('viewNombreCientifico').value = btn.dataset.nombrecientifico;
                document.getElementById('viewNombreComun').value = btn.dataset.nombrecomun;
                document.getElementById('viewFamilia').value = btn.dataset.familia;
                document.getElementById('viewEstadoConservacion').value = btn.dataset.estadoconservacion;
                document.getElementById('viewDescripcion').value = btn.dataset.descripcion;

                const imagenUrl = btn.dataset.imagenurl; // ✅ ahora sí lo defines

                if (imagenUrl && imagenUrl.trim() !== '') {
                    document.getElementById('viewImagen').src = imagenUrl;
                } else {
                    document.getElementById('viewImagen').src = 'ruta/a/imagen-default.png'; // Opcional
                }

                document.getElementById('viewEspecieModal').style.display = 'block';
            }



        </script>

    </body>
</html>