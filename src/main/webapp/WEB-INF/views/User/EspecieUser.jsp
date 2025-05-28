<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Especies Forestales</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilo.css">
        <style>
            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 15px 20px;
                background-color: #005C25;
                color: white;
                position: relative;
            }
            
            .header-left {
                display: flex;
                align-items: center;
                flex: 1;
                min-width: 0;
            }
            
            .header img {
                height: 50px;
                margin-right: 15px;
                flex-shrink: 0;
            }
            
            .header h1 {
                margin: 0;
                font-size: 1.4rem;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }
            
            .user-panel {
                display: flex;
                align-items: center;
                gap: 10px;
                background-color: rgba(255, 255, 255, 0.2);
                padding: 8px 15px;
                border-radius: 20px;
                margin-left: 15px;
                flex-shrink: 0;
            }
            
            .user-panel i {
                font-size: 1.2rem;
            }
            
            .user-panel span {
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
                max-width: 150px;
            }
            
            .user-panel a {
                color: white;
                text-decoration: none;
                font-weight: bold;
                white-space: nowrap;
            }
            
            .user-panel a:hover {
                text-decoration: underline;
            }
            
            @media (max-width: 992px) {
                .header {
                    flex-direction: column;
                    align-items: stretch;
                    padding: 10px;
                }
                
                .header-left {
                    margin-bottom: 10px;
                }
                
                .user-panel {
                    align-self: flex-end;
                    margin-left: 0;
                }
            }
        </style>
    </head>

    <body>
        <div class="header">
            <div class="header-left">
                <img src="https://cdn-icons-png.flaticon.com/512/4275/4275503.png" alt="Logo Forestal">
                <h1>SISTEMA DE REGISTRO FORESTAL - ESPECIES </h1>
            </div>
            
            <!-- Panel de usuario para cerrar sesión -->
            <c:if test="${not empty sessionScope.usuario}">
                <div class="user-panel">
                    <i class="bi bi-person-circle"></i>
                    <span>${sessionScope.usuario.nombre}</span>
                   <a href="${pageContext.request.contextPath}/Logout">Cerrar sesión</a>

                </div>
            </c:if>
        </div>
        
        <div class="main-content">
            <div class="sidebar">
                <button onclick="location.href = '${pageContext.request.contextPath}/ZonaUser'">Zonas Forestales</button>
                <button onclick="location.href = '${pageContext.request.contextPath}/EspecieUser'">Especies de Árboles</button>
                <button onclick="location.href = '${pageContext.request.contextPath}/ActividadUser'">Actividades de Conservación</button>
            </div>

            <div class="main">
                <!-- Modal de solo visualización -->
                <div id="viewEspecieModal" class="modal" style="display:none;">
                    <div class="modal-content p-4 bg-light rounded shadow" style="max-width:600px; margin:auto;">
                        <span class="btn-close float-end" onclick="document.getElementById('viewEspecieModal').style.display = 'none'">&times;</span>
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
                <c:if test="${empty especies}">
                    <p class="countZone">No hay especies registradas.</p>
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
                                <th>Nombre Comun</th>
                                <th>Nombre Cientifico</th>
                                <th>Familia</th>
                                <th>Estado de Conservacion</th>
                                <th>Acción</th>
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
                                        <button class="btn btn-sm" style="background-color:#006837; color: white"
                                                data-id="${especie.especieId}"
                                                data-nombrecientifico="${fn:escapeXml(especie.nombreCientifico)}"
                                                data-nombrecomun="${fn:escapeXml(especie.nombreComun)}"
                                                data-familia="${fn:escapeXml(especie.familia)}"
                                                data-estadoconservacion="${especie.estadoConservacion}"
                                                data-descripcion="${fn:escapeXml(especie.descripcion)}"
                                                data-imagenurl="${fn:escapeXml(especie.imagenUrl)}"
                                                onclick="openViewEspecieModal(this)">
                                            <i class="bi bi-eye-fill"></i> Ver
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <script>
            function openViewEspecieModal(btn) {
                // Actualizar campos del modal
                document.getElementById('viewNombreCientifico').value = btn.dataset.nombrecientifico || '';
                document.getElementById('viewNombreComun').value = btn.dataset.nombrecomun || '';
                document.getElementById('viewFamilia').value = btn.dataset.familia || '';
                document.getElementById('viewEstadoConservacion').value = btn.dataset.estadoconservacion || '';
                document.getElementById('viewDescripcion').value = btn.dataset.descripcion || '';

                // Manejar imagen
                const imagen = document.getElementById('viewImagen');
                const imagenUrl = btn.dataset.imagenurl;
                if (imagenUrl && imagenUrl.trim() !== '') {
                    imagen.src = imagenUrl;
                    imagen.style.display = 'block';
                } else {
                    imagen.style.display = 'none';
                }

                // Mostrar modal
                document.getElementById('viewEspecieModal').style.display = 'block';
            }

            // Cerrar modal al hacer clic fuera de él
            window.onclick = function(event) {
                if (event.target === document.getElementById('viewEspecieModal')) {
                    document.getElementById('viewEspecieModal').style.display = "none";
                }
            }

            // Función de búsqueda
            document.getElementById("busquedaZona").addEventListener("keyup", function() {
                const filtro = this.value.toLowerCase();
                const filas = document.querySelectorAll("tbody.table-light tr");
                
                filas.forEach(fila => {
                    const nombre = fila.cells[0].textContent.toLowerCase();
                    fila.style.display = nombre.includes(filtro) ? "" : "none";
                });
            });
        </script>
    </body>
</html>