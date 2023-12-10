package Projet.Flutter.Authentification.Authentification.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AuthentificationDto {
    private String email;
    private String password;
}
