/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.matakuliah.matakuliah.controller;

import com.matakuliah.matakuliah.entity.Matakuliah;
import com.matakuliah.matakuliah.service.MatakuliahService;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;




import java.util.List;
import matakuliahRequest.MatakuliahRequest;

/**
 *
 * @author LABP2COMDOSEN
 */
@RestController
@RequestMapping("/api/v1/matakuliah")
public class MatakuliahController {

    @Autowired
    private MatakuliahService matakuliahService;

    @GetMapping
    public List<Matakuliah> getAll() {
        return matakuliahService.getAll();
    }

    @GetMapping(path = "{id}")
    public Matakuliah getMatakuliah(@PathVariable("id") Long id) {
        return matakuliahService.getMatakuliah(id);
    }

    @PostMapping
    public void insert(@RequestBody Matakuliah matakuliah) {
        matakuliahService.insert(matakuliah);
    }

    @DeleteMapping(path = "{matakuliahId}")
    public void delete(@PathVariable("matakuliahId") Long id) {
        matakuliahService.delete(id);
    }

    @PutMapping(path = "{matakuliahId}")
    public void update(@PathVariable("matakuliahId") Long matakuliahId,
                       @RequestParam(required = false) String nama,
                       @RequestParam(required = false) String sks) {
        matakuliahService.update(matakuliahId, nama, sks);
    }

    @Transactional
    @PostMapping(path = "{matakuliahId}", consumes = "application/json")
    public ResponseEntity<?> update(@PathVariable("matakuliahId") Long matakuliahId,
                                    @RequestBody MatakuliahRequest matakuliahRequest) {
        System.out.println("Received update request: " + matakuliahRequest.toString());

        try {
            // Proses pembaruan data di sini
            matakuliahService.update(matakuliahId, matakuliahRequest.getNama(), matakuliahRequest.getSks());
            return ResponseEntity.ok("Update successful");
        } catch (Exception e) {
            // Tangani kesalahan pembaruan
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Update failed");
        }
    }
}
