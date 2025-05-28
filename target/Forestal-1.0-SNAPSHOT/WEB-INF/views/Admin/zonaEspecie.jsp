<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Administrar Zona–Especie</title>
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"/>
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
        </script>
        <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilo.css"/>
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
        <!-- Sidebar -->
        <div class="main-content d-flex">
            <div class="sidebar">
                <button onclick="location.href = '${pageContext.request.contextPath}/ZonaAdmin'">Zonas Forestales</button>
                <button onclick="location.href = '${pageContext.request.contextPath}/EspecieAdmin'">Especies de Árboles</button>
                <button onclick="location.href = '${pageContext.request.contextPath}/ActividadAdmin'">Actividades de Conservación</button>
                <button onclick="location.href = '${pageContext.request.contextPath}/ZonaEspecieAdmin'">Adminsitracion Especie</button>

            </div>

            <!-- Main -->
            <div class="main p-4">

                <!-- Formulario de Asociación -->
                <div class="card mb-4 shadow-sm">
                    <div class="card-body">
                        <h5>Asociar especie a zona</h5>
                        <form method="post" action="${pageContext.request.contextPath}/ZonaEspecieAdmin" class="row g-3">
                            <div class="col-md-4">
                                <label class="form-label">Zona:</label>
                               <select name="zonaId"
                                        class="form-select"
                                        required
                                        onchange="if (this.value) window.location='${pageContext.request.contextPath}/ZonaEspecieAdmin?zonaId='+this.value;">
                                    <option value="">-- seleccione --</option>
                                    <c:forEach var="z" items="${allZonas}">
                                        <option value="${z.zonaId}"
                                                ${z.zonaId == selectedZonaId ? 'selected' : ''}>
                                            ${z.nombre}
                                        </option>
                                    </c:forEach>
                                </select>

                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Especie:</label>
                                <select name="especieId" class="form-select" required>
                                    <option value="">-- seleccione --</option>
                                    <c:forEach var="e" items="${allEspecies}">
                                        <option value="${e.especieId}">
                                            ${e.nombreComun} (${e.nombreCientifico})
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <label class="form-label">Densidad:</label>
                                <input type="number" name="densidad" step="0.01"
                                       class="form-control" required/>
                            </div>
                            <div class="col-md-2 d-flex align-items-end">
                                <button type="submit" class="btn btn-success w-100">
                                    <i class="bi bi-plus-circle"></i> Asignar
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Tabla de asociaciones -->
                <div class="card shadow-sm">
                    <div class="card-body">
                        <h5>Especies asociadas a la zona</h5>
                        <c:if test="${empty zonaEspecies}">
                            <p class="text-muted">No hay asociaciones para esta zona.</p>
                        </c:if>
                        <c:if test="${not empty zonaEspecies}">
                            <div class="table-responsive">
                                <table class="table table-hover align-middle">
                                    <thead class="table-success text-center">
                                        <tr>
                                            <th>Zona</th>
                                            <th>Especie</th>
                                            <th>Densidad</th>
                                            <th>Acción</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="ze" items="${zonaEspecies}">
                                            <tr>
                                                <td>${ze.zona.nombre}</td>
                                                <td>${ze.especie.nombreComun}</td>
                                                <td>${ze.densidad}</td>
                                                <td class="text-center">
                                                    <a href="${pageContext.request.contextPath}/ZonaEspecieAdmin?zonaId=${ze.zona.zonaId}&action=delete&especieId=${ze.especie.especieId}"
                                                       class="btn btn-sm btn-danger">
                                                        <i class="bi bi-trash"></i>
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:if>
                    </div>
                </div>

            </div>
        </div>

    </body>
</html>
