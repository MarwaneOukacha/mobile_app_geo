package Projet.Flutter.Authentification.Authentification.ServicesInterfaces;

import Projet.Flutter.Authentification.Authentification.entitys.PointVente;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public interface PointVenteInterface {
    public List<PointVente> getALLPointByLivreurID(Long id);

    void addPointVente(PointVente point);

    List<PointVente> getALLPointByFournisseurID(Long id);
}
