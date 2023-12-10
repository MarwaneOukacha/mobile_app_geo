package Projet.Flutter.Authentification.Authentification.reposetory;

import Projet.Flutter.Authentification.Authentification.entitys.AppUSER;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserReposetory extends JpaRepository<AppUSER,Long> {
    AppUSER findByEmail(String email);
}
