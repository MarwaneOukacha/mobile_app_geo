package Projet.Flutter.Authentification.Authentification.ServicesImp;

import Projet.Flutter.Authentification.Authentification.ServicesInterfaces.PointVenteInterface;
import Projet.Flutter.Authentification.Authentification.entitys.PointVente;
import Projet.Flutter.Authentification.Authentification.reposetory.PointVenteReposetory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class PointVenteserviceV1 implements PointVenteInterface {
    @Autowired
    private PointVenteReposetory repo;
    @Override
    public List<PointVente> getALLPointByLivreurID(Long id){
        return repo.findAllByIdLivreur(id);
    }

    @Override
    public void addPointVente(PointVente point) {
        repo.save(point);
    }

    @Override
    public List<PointVente> getALLPointByFournisseurID(Long id) {
        return repo.findAllByIdFournisseur(id);
    }
}
