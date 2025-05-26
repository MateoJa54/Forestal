package com.espe.app.forestal.security.util;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordEncoder {
    public String encode(String rawPassword) {
        return BCrypt.hashpw(rawPassword, BCrypt.gensalt());
    }
    public boolean matches(String rawPassword, String hashed) {
        return BCrypt.checkpw(rawPassword, hashed);
    }
}
