
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
        .user-panel {
            position: absolute;
            top: 20px;
            right: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            background-color: rgba(255, 255, 255, 0.2);
            padding: 8px 15px;
            border-radius: 20px;
            color: white;
        }
        .user-panel i {
            font-size: 1.2rem;
        }
        .user-panel a {
            color: white;
            text-decoration: none;
            font-weight: bold;
        }
        .user-panel a:hover {
            text-decoration: underline;
        }
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
        min-width: 0; /* Permite que el texto se trunque */
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
        <h1>SISTEMA DE REGISTRO FORESTAL - ACTIVIDADES DE PROTECCIÓN</h1>
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
                <button onclick="location.href = '${pageContext.request.contextPath}/ZonaAdmin'">Zonas Forestales</button>
                <button onclick="location.href = '${pageContext.request.contextPath}/EspecieAdmin'">Especies de Árboles</button>
                <button onclick="location.href = '${pageContext.request.contextPath}/ActividadAdmin'">Actividades de Conservación</button>
                <button onclick="location.href = '${pageContext.request.contextPath}/ZonaEspecieAdmin'">Adminsitracion Especie</button>
                <button onclick="location.href='${pageContext.request.contextPath}/UsuarioAdmin'">Administración Usuarios</button>
            </div>

            <div class="main">
                <!-- Botón Agregar Zona -->
                <button class="btn-agregar" onclick="document.getElementById('zonaModal').style.display = 'block'">
                    Agregar Zona
                </button>
                <c:if test="${not empty errores}">
                    <ul style="color:red;">
                        <c:forEach var="error" items="${errores}">
                            <li>${error}</li>
                        </c:forEach>
                    </ul>
                </c:if>
                <!-- Modal Registrar Zona -->
                <div id="zonaModal" class="modal">
                    <div class="modal-content p-4 bg-light rounded shadow">
                        <span class="btn-close float-end" onclick="document.getElementById('zonaModal').style.display = 'none'"></span>
                        <h2>Registrar nueva zona forestal</h2>
                        <form action="${pageContext.request.contextPath}/ZonaAdmin" method="post">
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

                <!-- Modal Editar Zona -->
                <div id="editZonaModal" class="modal">
                    <div class="modal-content p-4 bg-light rounded shadow">
                        <span class="btn-close float-end" onclick="document.getElementById('editZonaModal').style.display = 'none'"></span>
                        <h2>Editar zona forestal</h2>
                        <form action="${pageContext.request.contextPath}/ZonaAdmin" method="post">
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

                <!-- Modal Especies de Árboles -->
                <div id="especieZonaModal" class="modal">
                    <div class="modal-content p-4 bg-light rounded shadow w-75 mx-auto">
                        <span class="btn-close float-end" onclick="document.getElementById('especieZonaModal').style.display = 'none'"></span>
                        <h2>Gestión de Especies en la Zona</h2>
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

                <!-- Modal Programas/Zonas Protegidas -->
                <div id="programaModal" class="modal">
                    <div class="modal-content p-4 bg-light rounded shadow">
                        <span class="btn-close float-end" onclick="document.getElementById('programaModal').style.display = 'none'"></span>
                        <h2>Programas de Conservación / Zonas Protegidas</h2>
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
                                        <!-- Editar -->
                                        <button class="btn btn-sm " style="background-color: #2196F3; color: white" 
                                                onclick="openEditModal(
                                                ${zona.zonaId},
                                                            '${zona.nombre}',
                                                            '${zona.ubicacion}',
                                                ${zona.areaHectareas},
                                                            '${zona.tipoVegetacion}',
                                                            '${zona.coordenadas}',
                                                            '${zona.fechaRegistro}'
                                                            )">
                                            <i class="bi bi-pencil-square"></i>
                                        </button>
                                        <!-- Ver Especies -->
                                        <button class="btn btn-sm " style="background-color:#006837; color: white"
                                                onclick="location.href = '${pageContext.request.contextPath}/ZonaAdmin?option=listarEspeciesZona&zonaId=${zona.zonaId}'">
                                            <i class="bi bi-tree"></i>
                                        </button>
                                        <!-- Eliminar -->
                                        <form action="${pageContext.request.contextPath}/ZonaAdmin" method="get" style="display:inline;">
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


        <script>
            <c:if test="${not empty especiesZona}">
        document.getElementById('especieZonaModal').style.display = 'block';
            </c:if>
        </script>

        <!-- 2) Función editar -->
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
        </script>

        <script>
            function openProgramaModal() {
                document.getElementById('programaModal').style.display = 'block';
            }
        </script>

        <script>
            window.onclick = function (event) {
                ['zonaModal', 'editZonaModal', 'especieZonaModal', 'programaModal']
                        .forEach(id => {
                            const m = document.getElementById(id);
                            if (m && event.target === m)
                                m.style.display = 'none';
                        });
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
            document.addEventListener('DOMContentLoaded', function () {
                const formNew = document.querySelector('#zonaModal form');
                const formEdit = document.querySelector('#editZonaModal form');
                [formNew, formEdit].forEach(form => {
                    form.addEventListener('submit', function (e) {
                        const nombre = form.querySelector('[name="nombre"]').value.trim();
                        const ubicacion = form.querySelector('[name="ubicacion"]').value.trim();
                        const area = parseFloat(form.querySelector('[name="areaHectareas"]').value);
                        const fecha = new Date(form.querySelector('[name="fechaRegistro"]').value);
                        const hoy = new Date();

                        const regexTexto = /^[A-Za-zÁÉÍÓÚáéíóúÑñ ]{3,}$/;

                        let errores = [];

                        if (!regexTexto.test(nombre)) {
                            errores.push("El nombre debe tener al menos 3 letras y solo contener letras y espacios.");
                        }

                        if (!regexTexto.test(ubicacion)) {
                            errores.push("La ubicación debe tener al menos 3 letras y solo contener letras y espacios.");
                        }

                        if (isNaN(area) || area <= 0) {
                            errores.push("El área debe ser un número mayor a 0.");
                        }

                        if (fecha > hoy) {
                            errores.push("La fecha de registro no puede ser futura.");
                        }

                        if (errores.length > 0) {
                            e.preventDefault();
                            alert(errores.join('\n'));
                        }
                    });
                });
            });
        </script>
    </body>
</html>
