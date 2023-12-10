package Projet.Flutter.Authentification.Authentification.ServicesImp;

import Projet.Flutter.Authentification.Authentification.ServicesInterfaces.AuthentificationService;
import Projet.Flutter.Authentification.Authentification.ServicesInterfaces.JwtService;
import Projet.Flutter.Authentification.Authentification.entitys.AppUSER;
import Projet.Flutter.Authentification.Authentification.reposetory.UserReposetory;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import org.apache.catalina.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.security.Key;
import java.util.Date;
import java.util.HashMap;

@Service
class AuthtificationServiceV1 implements AuthentificationService{
    @Autowired
    JwtService jwtService;
    @Autowired
    UserReposetory repo;
    @Autowired
    PasswordEncoder encoder;
    @Override
    public String generateToken(String email) {
        return jwtService.generateToken(email);
    }

    @Override
    public void registre(AppUSER newUser) {
        newUser.setPassword(encoder.encode(newUser.getPassword()));
        repo.save(newUser);
    }
}
