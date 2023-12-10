package Projet.Flutter.Authentification.Authentification.ServicesImp;

import Projet.Flutter.Authentification.Authentification.ServicesInterfaces.JwtService;
import Projet.Flutter.Authentification.Authentification.entitys.AppUSER;
import Projet.Flutter.Authentification.Authentification.reposetory.UserReposetory;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.config.annotation.web.oauth2.client.OAuth2ClientSecurityMarker;
import org.springframework.stereotype.Service;

import java.security.Key;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Service
public class JwtServiceV1 implements JwtService {
    @Autowired
    private UserReposetory repo;
    private static final String SECRET = "5367566B59703373367639792F423F4528482B4D6251655468576D5A71347437";
    @Override
    public String generateToken(String email) {
        HashMap<String, Object> claims = new HashMap<>();
        var username =repo.findByEmail(email).getUserName();
        var role=repo.findByEmail(email).getRole();
        claims.put("Username",username);
        claims.put("Role",role);
        return createToken(claims,email);
    }

    @Override
    public String createToken(HashMap<String, Object> claims, String email) {
        return Jwts.builder().setClaims(claims).setSubject(email).setIssuedAt(new Date(System.currentTimeMillis())).setExpiration(new Date(System.currentTimeMillis() + 1000 * 60 * 30)).signWith(getSignKey(), SignatureAlgorithm.HS256).compact();
    }
    public void validateToken(final String token) {
        Jwts.parserBuilder().setSigningKey(getSignKey()).build().parseClaimsJws(token);
    }
    private Claims extractAllClaims(String token) {
        return Jwts
                .parserBuilder()
                .setSigningKey(getSignKey())
                .build()
                .parseClaimsJws(token)
                .getBody();
    }

    private Key getSignKey() {
        byte[] keyBytes = Decoders.BASE64.decode(SECRET);
        return Keys.hmacShaKeyFor(keyBytes);
    }
}
