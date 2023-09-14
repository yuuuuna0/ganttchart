package com.weaverloft.ganttchart.util;

import org.springframework.security.crypto.password.PasswordEncoder;

import java.security.NoSuchAlgorithmException;

public class EncryptPassword implements PasswordEncoder {
    @Override
    public String encode(CharSequence rawPassword) {

        return rawPassword.toString();
    }

    @Override
    public boolean matches(CharSequence charSequence, String s) {
        return false;
    }

    //sha로 실제로도 encoding 시키기


}
