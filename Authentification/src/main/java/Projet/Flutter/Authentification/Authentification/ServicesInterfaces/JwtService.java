package Projet.Flutter.Authentification.Authentification.ServicesInterfaces;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import org.springframework.stereotype.Service;

import java.util.HashMap;

@Service
public interface JwtService {
    public String generateToken(String email);
    public String createToken(HashMap<String, Object> claims, String email);
    public void validateToken(final String token);
}
