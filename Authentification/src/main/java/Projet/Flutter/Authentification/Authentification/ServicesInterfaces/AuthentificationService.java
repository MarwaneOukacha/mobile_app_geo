package Projet.Flutter.Authentification.Authentification.ServicesInterfaces;

import Projet.Flutter.Authentification.Authentification.entitys.AppUSER;
import io.jsonwebtoken.Jwts;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.Objects;

@Service
public interface AuthentificationService {
    String generateToken(String email);

    void registre(AppUSER newUser);
}
