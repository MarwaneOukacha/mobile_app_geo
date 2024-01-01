package Projet.Flutter.Authentification.Authentification.Controller;

import Projet.Flutter.Authentification.Authentification.DTO.UserDTO;
import Projet.Flutter.Authentification.Authentification.entitys.AppUSER;
import Projet.Flutter.Authentification.Authentification.reposetory.UserReposetory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/Users")
@CrossOrigin("*")
public class UserController {
    @Autowired
    private UserReposetory repo;
    @GetMapping("/Livreurs")
    public List<UserDTO> GetAllLivreurs() {
        List<UserDTO> livreurDetailsList = repo.findAll().stream()
                .filter(appUSER -> appUSER.getRole().equals("livreur"))
                .map(user -> {
                    UserDTO details = new UserDTO();
                    details.setUserName(user.getUserName());
                    details.setEmail(user.getEmail());
                    details.setNumTelephone(user.getNumTelephone());
                    return details;
                })
                .collect(Collectors.toList());

        return livreurDetailsList;
    }
}
