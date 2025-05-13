<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sistema de Gestión Forestal</title>
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

        header img {
            height: 50px;
            margin-right: 15px;
        }

        .header-title {
            display: flex;
            align-items: center;
            font-size: 24px;
            font-weight: bold;
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

    <header>
        <div class="header-title">
            <img src="https://cdn-icons-png.flaticon.com/512/4275/4275503.png" alt="Logo Forestal">
            SISTEMA DE GESTIÓN FORESTAL
        </div>
    </header>

    <nav>
        <a href="#">Inicio</a>
        <a href="#">Zonas Forestales</a>
        <a href="#">Especies</a>
        <a href="#">Actividades</a>
        <a href="#">Contacto</a>
    </nav>

    <div class="banner"></div>

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
