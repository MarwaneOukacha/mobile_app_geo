package Projet.Flutter.Authentification.Authentification.entitys;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
public class AppUSER {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long ID;
    @Column(nullable = false)
    private String userName;
    @Column(nullable = false,unique = true)
    private String email;
    @Column(nullable = false)
    private String numTelephone;
    @Column(nullable = false)
    private String password;
    private String role;
}
