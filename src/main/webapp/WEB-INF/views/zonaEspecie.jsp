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
</head>
<body>

  <!-- Header -->
  <div class="header">
    <h1>SISTEMA DE REGISTRO FORESTAL - Asociación Zona/Especie</h1>
    <form action="${pageContext.request.contextPath}/LogoutServlet" method="post">
      <button class="logout-btn">Cerrar sesión</button>
    </form>
  </div>

  <!-- Sidebar -->
  <div class="main-content d-flex">
    <div class="sidebar">
      <button onclick="location.href='${pageContext.request.contextPath}/Home'">Home</button>
      <button onclick="location.href='${pageContext.request.contextPath}/Zona'">Zonas</button>
      <button onclick="location.href='${pageContext.request.contextPath}/Especie'">Especies</button>
      <button class="active">Zona–Especie</button>
      <button onclick="location.href='${pageContext.request.contextPath}/Actividad'">
        Actividades
      </button>
    </div>

    <!-- Main -->
    <div class="main p-4">

      <!-- Formulario de Asociación -->
      <div class="card mb-4 shadow-sm">
        <div class="card-body">
          <h5>Asociar especie a zona</h5>
          <form method="post" action="${pageContext.request.contextPath}/ZonaEspecie" class="row g-3">
            <div class="col-md-4">
              <label class="form-label">Zona:</label>
              <select name="zonaId" class="form-select" required>
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
                        <a href="${pageContext.request.contextPath}/ZonaEspecie?zonaId=${ze.zona.zonaId}&action=delete&especieId=${ze.especie.especieId}"
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
