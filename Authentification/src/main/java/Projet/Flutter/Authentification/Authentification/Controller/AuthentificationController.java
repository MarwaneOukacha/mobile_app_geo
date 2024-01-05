package Projet.Flutter.Authentification.Authentification.Controller;

import Projet.Flutter.Authentification.Authentification.DTO.AuthentificationDto;
import Projet.Flutter.Authentification.Authentification.DTO.UserDTO;
import Projet.Flutter.Authentification.Authentification.ServicesInterfaces.AuthentificationService;
import Projet.Flutter.Authentification.Authentification.entitys.AppUSER;
import jakarta.persistence.GeneratedValue;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = "*")
@RestController
public class AuthentificationController {
    @Autowired
    public AuthentificationService service;
    private Authentication authenticate;
    @Autowired
    AuthenticationManager authenticationManager;
    @PostMapping("/Auth")
    public String Authentification(@RequestBody AuthentificationDto a){
        authenticate=authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(a.getEmail(),a.getPassword()));
        if(authenticate.isAuthenticated()){
            return service.generateToken(a.getEmail());
        }else {
            throw new RuntimeException("Mot de passe ou email incorrect");
        }
    }
    @PostMapping("/registre")
    public void Registre(@RequestBody UserDTO user){
        AppUSER newUser=new AppUSER();
        newUser.setRole("superviseur");
        BeanUtils.copyProperties(user,newUser);
        service.registre(newUser);
    }
}
