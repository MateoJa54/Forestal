package com.espe.app.forestal.service;

import com.espe.app.forestal.dao.UsuarioDao;
import com.espe.app.forestal.model.Usuario;
import com.espe.app.forestal.model.RolUsuario;
import com.espe.app.forestal.security.util.PasswordEncoder;

import java.util.Optional;

public class UsuarioService {
    private final UsuarioDao usuarioDao;
    private final PasswordEncoder passwordEncoder;

    public UsuarioService() {
        this.usuarioDao = new UsuarioDao();
        this.passwordEncoder = new PasswordEncoder();
    }

    /** Autentica un usuario por correo y contraseña. */
    public Optional<Usuario> login(String correo, String rawPassword) {
        if (correo == null || rawPassword == null) {
            return Optional.empty();
        }
        String email = correo.trim().toLowerCase();
        Optional<Usuario> opt = usuarioDao.findByCorreo(email);
        if (opt.isPresent() && passwordEncoder.matches(rawPassword, opt.get().getContrasena())) {
            return opt;
        }
        return Optional.empty();
    }

    /**
     * Registra un usuario nuevo de tipo \"usuario\".
     * Devuelve false si ya existía un usuario con ese correo.
     */
    public boolean register(String nombre, String apellido, String correo, String rawPassword) {
        if (nombre == null || apellido == null || correo == null || rawPassword == null) {
            return false;
        }
        String email = correo.trim().toLowerCase();
        // 1) No permitir duplicados
        if (usuarioDao.findByCorreo(email).isPresent()) {
            return false;  // ya existe
        }
        // 2) Construir el objeto
        Usuario u = new Usuario();
        u.setNombre(nombre.trim());
        u.setApellido(apellido.trim());
        u.setCorreo(email);
        u.setContrasena(passwordEncoder.encode(rawPassword));
        u.setRol(RolUsuario.usuario);
        // 3) Guardar
        return usuarioDao.save(u);
    }
}
