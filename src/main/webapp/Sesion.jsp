<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Registro e Inicio de Sesión</title>
  <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    <style>
      .alerta-error, .alerta-exito {
        padding: 10px 15px;
        margin: 10px auto;
        width: 90%;
        max-width: 500px;
        border-radius: 8px;
        text-align: center;
        font-weight: bold;
        font-size: 16px;
      }
      .alerta-error {
        background-color: #ffe0e0;
        color: #d8000c;
        border: 1px solid #d8000c;
      }
      .alerta-exito {
        background-color: #e0ffe5;
        color: #006400;
        border: 1px solid #006400;
      }
      @keyframes fadeIn {
        from {
          opacity: 0;
          transform: translateY(-5px);
        }
        to {
          opacity: 1;
          transform: translateY(0);
        }
      }
      .fade-in {
        animation: fadeIn 0.5s ease-in-out;
      }
    </style>
</head>
<body>
  <!-- Mensajes del servidor -->
    <c:if test="${not empty success}">
      <div class="alerta-exito fade-in">
        <i class='bx bx-check-circle'></i><br>${success}
      </div>
    </c:if>
    <c:if test="${not empty error}">
      <div class="alerta-error fade-in">
        <i class='bx bx-error-circle'></i><br>${error}
      </div>
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
          <div class="register-alert-area"></div>
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
          <div class="login-alert-area"></div>
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

      function mostrarAlerta(mensajeHTML, contenedorSelector) {
        const contenedor = document.querySelector(contenedorSelector);
        contenedor.innerHTML = `
          <div class="alerta-error" style="animation: fadeIn 0.5s ease-in-out;">
            <i class='bx bx-error-circle'></i> <br>${mensajeHTML}
          </div>
        `;
      }

      // Validación de Registro
      const registerForm = document.querySelector(".form-register");
      registerForm.addEventListener("submit", function (e) {
        const nombre = registerForm.nombre.value.trim();
        const apellido = registerForm.apellido.value.trim();
        const email = registerForm.userEmail.value.trim();
        const password = registerForm.userPassword.value;

        const nameRegex = /^[A-Za-zÁÉÍÓÚáéíóúÑñ\s]{2,}$/;
        const emailRegex = /^[^@\s]+@[^@\s]+\.[^@\s]+$/;
        const passwordRegex = /^(?=.[a-z])(?=.[A-Z])(?=.\d)(?=.[@$!%?&.#])[A-Za-z\d@$!%?&.#]{8,}$/;

        let errores = [];

        if (!nameRegex.test(nombre)) {
          errores.push("• El nombre debe tener al menos 2 letras y solo caracteres alfabéticos.");
        }
        if (!nameRegex.test(apellido)) {
          errores.push("• El apellido debe tener al menos 2 letras y solo caracteres alfabéticos.");
        }
        if (!emailRegex.test(email)) {
          errores.push("• El correo electrónico no tiene un formato válido.");
        }
        if (!passwordRegex.test(password)) {
          errores.push("• La contraseña debe tener al menos 8 caracteres, una mayúscula, una minúscula, un número y un símbolo.");
        }

        if (errores.length > 0) {
          e.preventDefault();
          console.log("Errores detectados en registro:", errores);
          mostrarAlerta(errores.join("<br>"), ".register-alert-area");
        }
      });

      // Validación de Inicio de Sesión
      const loginForm = document.querySelector(".form-login");
      loginForm.addEventListener("submit", function (e) {
        const email = loginForm.userEmail.value.trim();
        const password = loginForm.userPassword.value;

        const emailRegex = /^[^@\s]+@[^@\s]+\.[^@\s]+$/;
        const passwordRegex = /^.{4,}$/;

        let errores = [];

        if (!emailRegex.test(email)) {
          errores.push("• El correo electrónico no es válido.");
        }
        if (!passwordRegex.test(password)) {
          errores.push("• La contraseña debe tener al menos 4 caracteres.");
        }

        if (errores.length > 0) {
          e.preventDefault();
          console.log("Errores detectados en login:", errores);
          mostrarAlerta(errores.join("<br>"), ".login-alert-area");
        }
      });
    </script>
</body>
</html>