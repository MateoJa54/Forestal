<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Administración de Usuarios</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"/>
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
        .user-panel i { font-size: 1.2rem; }
        .user-panel a {
            color: white;
            text-decoration: none;
            font-weight: bold;
        }
        .user-panel a:hover { text-decoration: underline; }

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
        @media (max-width: 992px) {
            .header {
                flex-direction: column;
                align-items: stretch;
                padding: 10px;
            }
            .header-left { margin-bottom: 10px; }
            .user-panel {
                align-self: flex-end;
                margin-left: 0;
            }
        }
        .btn-agregar {
            margin-bottom: 15px;
            background-color: #006837;
            color: white;
        }
        .btn-agregar:hover { background-color: #005C25; }
    </style>
</head>
<body>

    <div class="header">
        <div class="header-left">
            <img src="https://cdn-icons-png.flaticon.com/512/4275/4275503.png" alt="Logo Forestal">
            <h1>SISTEMA DE REGISTRO FORESTAL - USUARIOS</h1>
        </div>
        <c:if test="${not empty sessionScope.usuario}">
            <div class="user-panel">
                <i class="bi bi-person-circle"></i>
                <span>${sessionScope.usuario.nombre}</span>
                <a href="${pageContext.request.contextPath}/Logout">Cerrar sesión</a>
            </div>
        </c:if>
    </div>

    <div class="main-content d-flex">
        <div class="sidebar">
            <button onclick="location.href='${pageContext.request.contextPath}/ZonaAdmin'">Zonas Forestales</button>
            <button onclick="location.href='${pageContext.request.contextPath}/EspecieAdmin'">Especies de Árboles</button>
            <button onclick="location.href='${pageContext.request.contextPath}/ActividadAdmin'">Actividades de Conservación</button>
            <button onclick="location.href='${pageContext.request.contextPath}/ZonaEspecieAdmin'">Administración Especie</button>
            <button onclick="location.href='${pageContext.request.contextPath}/UsuarioAdmin'">Administración Usuarios</button>
        </div>

        <div class="main flex-fill p-3">
            <!-- Botón para abrir modal de registro -->
            <button class="btn btn-agregar" onclick="document.getElementById('usuarioModal').style.display='block'">
                <i class="bi bi-plus-lg"></i> Agregar Usuario
            </button>

            <!-- Modal de registro -->
            <div id="usuarioModal" class="modal" style="display:none;">
                <div class="modal-content p-4 bg-light rounded shadow" style="max-width:500px; margin:auto;">
                    <span class="btn-close float-end" onclick="document.getElementById('usuarioModal').style.display='none'">&times;</span>
                    <h2>Registrar Nuevo Usuario</h2>
                    <form action="${pageContext.request.contextPath}/UsuarioAdmin" method="post">
                        <input type="hidden" name="option" value="new"/>
                        <div class="mb-3">
                            <label class="form-label">Nombre:</label>
                            <input type="text" name="nombre" class="form-control" required/>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Apellido:</label>
                            <input type="text" name="apellido" class="form-control" required/>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Correo Electrónico:</label>
                            <input type="email" name="correo" class="form-control" required/>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Contraseña:</label>
                            <input type="password" name="contrasena" class="form-control" required/>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Rol:</label>
                            <select name="rol" class="form-select" required>
                                <option value="">Seleccione...</option>
                                <option value="usuario">Usuario</option>
                                <option value="administrador">Administrador</option>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-success">Guardar Usuario</button>
                    </form>
                </div>
            </div>

            <!-- Modal de edición -->
            <div id="editUsuarioModal" class="modal" style="display:none;">
                <div class="modal-content p-4 bg-light rounded shadow" style="max-width:500px; margin:auto;">
                    <span class="btn-close float-end" onclick="document.getElementById('editUsuarioModal').style.display='none'">&times;</span>
                    <h2>Editar Usuario</h2>
                    <form action="${pageContext.request.contextPath}/UsuarioAdmin" method="post">
                        <input type="hidden" name="option" value="update"/>
                        <input type="hidden" id="editUsuarioId" name="usuarioId"/>

                        <div class="mb-3">
                            <label class="form-label">Nombre:</label>
                            <input type="text" id="editNombre" name="nombre" class="form-control" required/>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Apellido:</label>
                            <input type="text" id="editApellido" name="apellido" class="form-control" required/>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Correo Electrónico:</label>
                            <input type="email" id="editCorreo" name="correo" class="form-control" required/>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Contraseña (dejar en blanco para no cambiar):</label>
                            <input type="password" id="editContrasena" name="contrasena" class="form-control"/>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Rol:</label>
                            <select id="editRol" name="rol" class="form-select" required>
                                <option value="">Seleccione...</option>
                                <option value="usuario">Usuario</option>
                                <option value="administrador">Administrador</option>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-success">Actualizar Usuario</button>
                    </form>
                </div>
            </div>

            <h2>Usuarios Registrados</h2>
            <c:if test="${empty usuarios}">
                <p class="countZone">No hay usuarios registrados.</p>
            </c:if>
            <c:if test="${not empty usuarios}">
                <p class="countZone">Total de usuarios: ${fn:length(usuarios)}</p>
            </c:if>

            <!-- Barra de búsqueda -->
            <div class="input-group mb-3 w-50">
                <span class="input-group-text"><i class="bi bi-search"></i></span>
                <input type="text" id="busquedaUsuario" class="form-control" placeholder="Buscar por nombre o correo..."/>
            </div>

            <div class="table-responsive rounded shadow-sm mt-4">
                <table class="table table-hover align-middle">
                    <thead class="table-success text-center">
                        <tr>
                            <th>Nombre</th>
                            <th>Apellido</th>
                            <th>Correo</th>
                            <th>Rol</th>
                            <th>Fecha Registro</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody class="table-light">
                        <c:forEach var="u" items="${usuarios}">
                            <tr>
                                <td>${u.nombre}</td>
                                <td>${u.apellido}</td>
                                <td>${u.correo}</td>
                                <td>${u.rol}</td>
                                <td>${u.fechaRegistro}</td> <!-- Mostrar LocalDateTime sin fmt -->
                                <td class="text-center">
                                    <!-- Botón Editar -->
                                    <button
                                        class="btn btn-sm btn-primary"
                                        data-id="${u.usuarioId}"
                                        data-nombre="${fn:escapeXml(u.nombre)}"
                                        data-apellido="${fn:escapeXml(u.apellido)}"
                                        data-correo="${fn:escapeXml(u.correo)}"
                                        data-rol="${u.rol}"
                                        onclick="openEditUsuarioModal(this)">
                                        <i class="bi bi-pencil-square"></i>
                                    </button>
                                    <!-- Botón Eliminar -->
                                    <form action="${pageContext.request.contextPath}/UsuarioAdmin" method="get" style="display:inline;">
                                        <input type="hidden" name="option" value="delete"/>
                                        <input type="hidden" name="id" value="${u.usuarioId}"/>
                                        <button class="btn btn-sm btn-danger" onclick="return confirm('¿Eliminar este usuario?');">
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
        function openEditUsuarioModal(btn) {
            document.getElementById('editUsuarioId').value = btn.dataset.id || '';
            document.getElementById('editNombre').value    = btn.dataset.nombre || '';
            document.getElementById('editApellido').value  = btn.dataset.apellido || '';
            document.getElementById('editCorreo').value    = btn.dataset.correo || '';
            document.getElementById('editContrasena').value = '';
            document.getElementById('editRol').value       = btn.dataset.rol || '';
            document.getElementById('editUsuarioModal').style.display = 'block';
        }

        document.getElementById("busquedaUsuario").addEventListener("keyup", function () {
            const filtro = this.value.toLowerCase();
            document.querySelectorAll("tbody.table-light tr")
                .forEach(fila => {
                    const nombre = fila.cells[0].textContent.toLowerCase();
                    const correo = fila.cells[2].textContent.toLowerCase();
                    fila.style.display = (nombre.includes(filtro) || correo.includes(filtro)) ? "" : "none";
                });
        });

        window.onclick = function(event) {
            ['usuarioModal', 'editUsuarioModal'].forEach(id => {
                const modal = document.getElementById(id);
                if (modal && event.target === modal) {
                    modal.style.display = "none";
                }
            });
        };
    </script>
</body>
</html>
