<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Registro e Inicio de Sesión</title>
  <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>
  <!-- Mensajes del servidor -->
  <c:if test="${not empty success}">
    <div class="alerta-exito">${success}</div>
  </c:if>
  <c:if test="${not empty error}">
    <div class="alerta-error">${error}</div>
  </c:if>

  <!-- FORMULARIO DE REGISTRO -->
  <div class="container-form register">
    <div class="information">
      <div class="info-childs">
        <h2>Bienvenido</h2>
        <p>Para unirte a nuestra comunidad por favor inicia sesión o regístrate</p>
        <input type="button" value="Iniciar Sesión" id="sign-in" style="color: white">
      </div>
    </div>
    <div class="form-information">
      <div class="form-information-childs">
        <h2>Crear una Cuenta</h2>
        <form class="form form-register" action="${pageContext.request.contextPath}/Auth" method="post" novalidate>
          <!-- Indica que es un registro -->
          <input type="hidden" name="action" value="register"/>

          <div>
            <label><i class='bx bx-user'></i>
              <input
                type="text"
                placeholder="Nombre"
                name="nombre"
                value="${param.nombre != null ? param.nombre : ''}"
                required/>
            </label>
          </div>
          <div>
            <label><i class='bx bx-user'></i>
              <input
                type="text"
                placeholder="Apellido"
                name="apellido"
                value="${param.apellido != null ? param.apellido : ''}"
                required/>
            </label>
          </div>
          <div>
            <label><i class='bx bx-envelope'></i>
              <input
                type="email"
                placeholder="Correo Electrónico"
                name="userEmail"
                value="${param.userEmail != null ? param.userEmail : ''}"
                required/>
            </label>
          </div>
          <div>
            <label><i class='bx bx-lock-alt'></i>
              <input
                type="password"
                placeholder="Contraseña"
                name="userPassword"
                required/>
            </label>
          </div>
          <input type="submit" value="Registrarse">
        </form>
      </div>
    </div>
  </div>

  <!-- FORMULARIO DE INICIO DE SESIÓN -->
  <div class="container-form login hide">
    <div class="information">
      <div class="info-childs">
        <h2>Bienvenido de nuevo</h2>
        <p>Por favor inicia sesión con tus datos</p>
        <input type="button" value="Registrarse" id="sign-up" style="color: white">
      </div>
    </div>
    <div class="form-information">
      <div class="form-information-childs">
        <h2>Iniciar Sesión</h2>
        <form class="form form-login" action="${pageContext.request.contextPath}/Auth" method="post" novalidate>
          <!-- Indica que es un login -->
          <input type="hidden" name="action" value="login"/>

          <div>
            <label><i class='bx bx-envelope'></i>
              <input
                type="email"
                placeholder="Correo Electrónico"
                name="userEmail"
                value="${param.userEmail != null ? param.userEmail : ''}"
                required/>
            </label>
          </div>
          <div>
            <label><i class='bx bx-lock-alt'></i>
              <input
                type="password"
                placeholder="Contraseña"
                name="userPassword"
                required/>
            </label>
          </div>
          <input type="submit" value="Iniciar Sesión">
        </form>
      </div>
    </div>
  </div>

  <!-- Scripts para alternar formularios -->
  <script>
    const btnSignIn = document.getElementById("sign-in"),
          btnSignUp = document.getElementById("sign-up"),
          containerFormRegister = document.querySelector(".register"),
          containerFormLogin = document.querySelector(".login");

    btnSignIn.addEventListener("click", () => {
      containerFormRegister.classList.add("hide");
      containerFormLogin.classList.remove("hide");
    });
    btnSignUp.addEventListener("click", () => {
      containerFormLogin.classList.add("hide");
      containerFormRegister.classList.remove("hide");
    });
  </script>
</body>
</html>
