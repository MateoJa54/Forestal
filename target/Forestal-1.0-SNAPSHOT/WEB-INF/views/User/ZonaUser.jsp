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
                <h1>SISTEMA DE REGISTRO FORESTAL - ZONAS</h1>
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
                <!-- Modal Especies de Árboles -->
                <div id="especieZonaModal" class="modal">
                    <div class="modal-content p-4 bg-light rounded shadow w-75 mx-auto">
                        <span class="btn-close float-end" onclick="document.getElementById('especieZonaModal').style.display = 'none'">&times;</span>
                        <h2>Especies en la Zona</h2>
                        <div class="mt-5">
                            <h5>Especies registradas en esta zona:</h5>
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover mt-2">
                                    <thead class="table-success text-center">
                                        <tr>
                                            <th>Nombre común</th>
                                            <th>Nombre Científico</th>
                                            <th>Densidad</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${empty especiesZona}">
                                                <tr>
                                                    <td colspan="3" class="text-center">No hay especies registradas</td>
                                                </tr>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach var="e" items="${especiesZona}">
                                                    <tr>
                                                        <td>${e.nombreComun}</td>
                                                        <td>${e.nombreCientifico}</td>
                                                        <td class="text-end">${e.densidad}</td>
                                                    </tr>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Listado Zonas -->
                <h2>Zonas Registradas</h2>
                <c:if test="${empty zonas}">
                    <p class="countZone">No hay zonas registradas.</p>
                </c:if>
                <c:if test="${not empty zonas}">
                    <p class="countZone">Total de zonas: ${fn:length(zonas)}</p>
                </c:if>

                <!-- Búsqueda -->
                <div class="input-group mb-3 w-50">
                    <span class="input-group-text"><i class="bi bi-search"></i></span>
                    <input type="text" class="form-control" id="busquedaZona" placeholder="Buscar por Nombre...">
                </div>

                <!-- Tabla principal -->
                <div class="table-responsive rounded shadow-sm mt-4">
                    <table class="table table-hover align-middle">
                        <thead class="table-success text-center">
                            <tr>
                                <th>Nombre</th>
                                <th>Ubicación</th>
                                <th>Área (ha)</th>
                                <th>Fecha Registro</th>
                                <th>Tipo de Vegetación</th>
                                <th>Acción</th>
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
                                        <!-- Ver Especies -->
                                        <button class="btn btn-sm" style="background-color:#006837; color: white"
                                                onclick="location.href = '${pageContext.request.contextPath}/ZonaUser?option=listarEspeciesZona&zonaId=${zona.zonaId}'">
                                            <i class="bi bi-tree"></i> Ver especies
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
            <c:if test="${not empty especiesZona}">
                document.getElementById('especieZonaModal').style.display = 'block';
            </c:if>
        </script>

        <script>
            window.onclick = function (event) {
                if (event.target === document.getElementById('especieZonaModal')) {
                    document.getElementById('especieZonaModal').style.display = 'none';
                }
            };
        </script>

        <script>
            document.getElementById("busquedaZona")
                    .addEventListener("keyup", function () {
                        const filtro = this.value.toLowerCase();
                        document.querySelectorAll("tbody.table-light tr")
                                .forEach(fila => {
                                    fila.style.display = fila.cells[0]
                                            .textContent.toLowerCase().includes(filtro)
                                            ? "" : "none";
                                });
                    });
        </script>
    </body>
</html>

