<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sistema de Gestión Forestal</title>
    <!-- Bootstrap Icons CDN -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background-color: #FFF8E1;
            color: #333;
        }
        header {
            background-color: #005C25;
            color: white;
            padding: 20px 40px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .header-title {
            display: flex;
            align-items: center;
            font-size: 24px;
            font-weight: bold;
        }
        .header-title img {
            height: 50px;
            margin-right: 15px;
        }
        .user-panel {
            display: flex;
            align-items: center;
            gap: 1rem;
            font-size: 16px;
        }
        .user-panel i {
            font-size: 1.5rem;
            cursor: pointer;
        }
        .user-panel a {
            color: white;
            text-decoration: none;
        }
        .user-panel a:hover {
            text-decoration: underline;
        }
        nav {
            background-color: #1E5631;
            padding: 10px 0;
            display: flex;
            justify-content: center;
        }
        nav a {
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            font-weight: bold;
        }
        nav a:hover {
            background-color: #3D9140;
        }
        .banner {
            width: 100%;
            height: 300px;
            background-image: url('https://images.theconversation.com/files/584404/original/file-20240326-22-a29mv8.jpg?ixlib=rb-4.1.0&rect=0%2C361%2C5615%2C2808&q=45&auto=format&w=1356&h=668&fit=crop');
            background-size: cover;
            background-position: center;
        }
        .contenido {
            padding: 40px;
            text-align: center;
        }
        .contenido h2 {
            color: #005C25;
        }
        .contenido p {
            max-width: 800px;
            margin: 20px auto;
            font-size: 18px;
        }
        footer {
            background-color: #005C25;
            color: white;
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .redes a {
            margin-left: 15px;
            color: white;
            text-decoration: none;
            font-size: 20px;
        }
        .redes a:hover {
            color: #FFC107;
        }
    </style>
</head>
<body>

    <!-- HEADER -->
    <header>
        <div class="header-title">
            <img src="https://cdn-icons-png.flaticon.com/512/4275/4275503.png" alt="Logo Forestal">
            SISTEMA DE GESTIÓN FORESTAL
        </div>
        <c:if test="${not empty sessionScope.usuario}">
            <div class="user-panel">
                <i class="bi bi-person-circle"></i>
                <span>${sessionScope.usuario.nombre} ${sessionScope.usuario.apellido}</span>
              <a href="${pageContext.request.contextPath}/Logout">Cerrar sesión</a>

            </div>
        </c:if>
    </header>

    <!-- NAV -->
    <nav>
        <a href="${pageContext.request.contextPath}/Home">Inicio</a>
        <a href="${pageContext.request.contextPath}/ZonaUser">Zonas Forestales</a>
        <a href="${pageContext.request.contextPath}/EspecieUser">Especies</a>
        <a href="${pageContext.request.contextPath}/ActividadUser">Actividades</a>
        <c:if test="${sessionScope.rol == 'administrador'}">
            <a href="${pageContext.request.contextPath}/ZonaEspecieAdmin">Administración Especies</a>
        </c:if>
    </nav>

    <!-- BANNER -->
    <div class="banner"></div>

    <!-- CONTENIDO -->
    <div class="contenido">
        <h2>Bienvenido al Sistema de Gestión Forestal</h2>
        <p>
            Esta plataforma está diseñada para ayudarte a gestionar de forma eficiente las zonas forestales,
            las especies de árboles y las actividades de conservación. Aquí podrás registrar nuevas zonas,
            consultar información detallada y contribuir a la protección del medio ambiente.
        </p>
        <p>
            ¡Únete a la conservación y gestión sostenible de nuestros bosques!
        </p>
    </div>

    <!-- FOOTER -->
    <footer>
        <div>&copy; 2025 Sistema de Gestión Forestal</div>
        <div class="redes">
            Síguenos:
            <a href="https://facebook.com" target="_blank">🌐 Facebook</a>
            <a href="https://twitter.com" target="_blank">🐦 Twitter</a>
            <a href="https://instagram.com" target="_blank">📸 Instagram</a>
        </div>
    </footer>

</body>
</html>
