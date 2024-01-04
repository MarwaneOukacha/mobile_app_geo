package Projet.Flutter.Authentification.Authentification.Controller;

import Projet.Flutter.Authentification.Authentification.ServicesInterfaces.PointVenteInterface;
import Projet.Flutter.Authentification.Authentification.entitys.AppUSER;
import Projet.Flutter.Authentification.Authentification.entitys.PointVente;
import Projet.Flutter.Authentification.Authentification.reposetory.UserReposetory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/PointVente")
//@CrossOrigin("*")
public class PointVenteController {
    @Autowired
    private PointVenteInterface service;
    @Autowired
    private UserReposetory FournisseurRepo;
    @GetMapping("/{id}")
    public  List<PointVente> GetAllPointByLivreurId(@PathVariable("id") Long id){

        return service.getALLPointByLivreurID(id);
    }
    @GetMapping("/fournisseur/{id}")
    public  List<PointVente> GetALLPointByFournisseurID(@PathVariable("id") Long id){
        return service.getALLPointByFournisseurID(id);
    }

    @PostMapping("/{email}")
    public void AddPointVente(@RequestBody PointVente point,@PathVariable String email){
        LocalDate date = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String formattedDate = date.format(formatter);
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date convertedDate = sdf.parse(formattedDate);
            point.setDateDaffectation(convertedDate);
            var idfournissuer=FournisseurRepo.findByEmail(email).getID();
            point.setIdFournisseur(idfournissuer);
        } catch (ParseException e) {
            throw new RuntimeException(e);
        }
        service.addPointVente(point);
    }
}
