/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.matakuliah.matakuliah.repository;

import com.matakuliah.matakuliah.entity.Matakuliah;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author LABP2COMDOSEN
 */
@Repository
public interface MatakuliahRepository extends JpaRepository<Matakuliah , Long> {

    public Optional<Matakuliah> findMatakuliahByKode(String kode);
    
}
