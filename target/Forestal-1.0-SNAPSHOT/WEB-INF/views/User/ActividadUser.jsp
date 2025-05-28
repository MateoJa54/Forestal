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
            <!-- Menú simplificado para usuarios normales -->
            <button onclick="location.href = '${pageContext.request.contextPath}/ZonaUser'">Zonas Forestales</button>
            <button onclick="location.href = '${pageContext.request.contextPath}/EspecieUser'">Especies de Árboles</button>
            <button onclick="location.href = '${pageContext.request.contextPath}/ActividadUser'">Actividades de Conservación</button>
        </div>

        <div class="main">
            <!-- Modal de visualización (solo lectura) -->
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
                        <p id="viewZonaNombre"></p>
                    </div>
                </div>
            </div>

            <h2>Actividades Proteccion Registradas</h2>
            <c:if test="${empty actividades}">
                <p class="countZone">No hay actividades registradas.</p>
            </c:if>
            <c:if test="${not empty actividades}">
                <p class="countZone">Total de actividades: ${fn:length(actividades)}</p>
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
                            <th>Nombre</th>
                            <th>Presupuesto</th>
                            <th>Estado</th>
                            <th>Acción</th>
                        </tr>
                    </thead>
                    <tbody class="table-light">
                        <c:forEach var="actividad" items="${actividades}">
                            <tr>
                                <td>${actividad.nombre}</td>
                                <td>${actividad.presupuesto}</td>
                                <td>${actividad.estado}</td>
                                <td class="text-center">
                                                                    <!-- Solo botón de visualización -->
                                <button
                                    class="btn btn-sm" style="background-color:#006837; color: white"
                                    data-nombre="${actividad.nombre}"
                                    data-descripcion="${actividad.descripcion}"
                                    data-fechainicio="${actividad.fechaInicio}"
                                    data-fechafin="${actividad.fechaFin}"
                                    data-presupuesto="${actividad.presupuesto}"
                                    data-estado="${actividad.estado}"
                                    data-zonanombre="${actividad.zona.nombre}"
                                    data-zonaubicacion="${actividad.zona.ubicacion}"
                                    onclick="openViewModal(this)">
                                    <i class="bi bi-eye"></i> Ver
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
        // Cierra modales al hacer clic fuera de ellos
        window.onclick = function(event) {
            if (event.target === document.getElementById('viewActividadModal')) {
                document.getElementById('viewActividadModal').style.display = "none";
            }
        }

        // Función de búsqueda
        document.getElementById("busquedaActividad").addEventListener("keyup", function() {
            const filtro = this.value.toLowerCase();
            const filas = document.querySelectorAll("tbody.table-light tr");

            filas.forEach(fila => {
                const nombre = fila.cells[0].textContent.toLowerCase();
                nombre.includes(filtro) 
                    ? fila.style.display = "" 
                    : fila.style.display = "none";
            });
        });

function openViewModal(btn) {
    document.getElementById('viewNombre').textContent         = btn.dataset.nombre || '';
    document.getElementById('viewDescripcion').textContent    = btn.dataset.descripcion || '';
    document.getElementById('viewFechaInicio').textContent    = btn.dataset.fechainicio || '';
    document.getElementById('viewFechaFin').textContent       = btn.dataset.fechafin || '';
    document.getElementById('viewPresupuesto').textContent    = btn.dataset.presupuesto || '';
    document.getElementById('viewEstado').textContent         = btn.dataset.estado || '';
    // Nuevo: mostrar zona asociada
    const zonaInfo = [];
    if (btn.dataset.zonanombre)   zonaInfo.push(btn.dataset.zonanombre);
    if (btn.dataset.zonaubicacion) zonaInfo.push(btn.dataset.zonaubicacion);
    document.getElementById('viewZonaNombre').textContent     = zonaInfo.join(' - ');
    document.getElementById('viewActividadModal').style.display = 'block';
}

    </script>
</body>
</html>






