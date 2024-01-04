package Projet.Flutter.Authentification.Authentification.entitys;

import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import lombok.Data;

import java.util.Date;

@Entity
@Data
public class PointVente {
    @Id @GeneratedValue
    private Long id;
    @Column(nullable = false)
    private Long idLivreur;
    @Column(nullable = false)
    private Long idFournisseur;
    @Column(nullable = false)
    private double longitude;
    @Column(nullable = false)
    private double latitude;
    @Column(nullable = false)
    private double capacite_stockage;
    @Column(nullable = false)
    private String contact;
    @Column
    private String status;
    @Column()
    private Date dateVisite;
    @Column(nullable = false)
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date dateDaffectation;



}
