package Projet.Flutter.Authentification.Authentification.reposetory;

import Projet.Flutter.Authentification.Authentification.entitys.AppUSER;
import Projet.Flutter.Authentification.Authentification.entitys.PointVente;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public interface PointVenteReposetory extends JpaRepository<PointVente,Long> {
     List<PointVente> findAllByIdLivreur(Long idlivreur);
     List<PointVente> findAllByIdFournisseur(Long idlivreur);
}