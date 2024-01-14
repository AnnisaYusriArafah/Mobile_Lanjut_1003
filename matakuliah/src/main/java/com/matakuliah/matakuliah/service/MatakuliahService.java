package com.matakuliah.matakuliah.service;

import com.matakuliah.matakuliah.entity.Matakuliah;
import com.matakuliah.matakuliah.repository.MatakuliahRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Service
public class MatakuliahService {

    @Autowired
    private MatakuliahRepository matakuliahRepository;

    public List<Matakuliah> getAll() {
        return matakuliahRepository.findAll();
    }

    public Matakuliah getMatakuliah(Long idmatakuliah) {
        return matakuliahRepository.findById(idmatakuliah).orElse(null);
    }

    public void insert(Matakuliah matakuliah) {
        Optional<Matakuliah> matakuliahOptional =
                matakuliahRepository.findMatakuliahByKode(matakuliah.getKode());
        if (matakuliahOptional.isPresent()) {
            throw new IllegalStateException("Kode matakuliah sudah ada");
        }
        matakuliahRepository.save(matakuliah);
    }

    public void delete(Long idmatakuliah) {
        boolean exists = matakuliahRepository.existsById(idmatakuliah);
        if (!exists) {
            throw new IllegalStateException("Matakuliah dengan ID ini tidak ada");
        }
        matakuliahRepository.deleteById(idmatakuliah);
    }

    public void update(Long idmatakuliah, String nama, String kode, String sks) {
        Matakuliah matakuliah = matakuliahRepository.findById(idmatakuliah)
                .orElseThrow(() -> new IllegalStateException("Matakuliah tidak ada"));

        if (nama != null && nama.length() > 0 && !Objects.equals(matakuliah.getNama(), nama)) {
            matakuliah.setNama(nama);
        }

        if (kode != null && kode.length() > 0 && !Objects.equals(matakuliah.getKode(), kode)) {
            Optional<Matakuliah> matakuliahOptional = matakuliahRepository.findMatakuliahByKode(kode);
            if (matakuliahOptional.isPresent()) {
                throw new IllegalStateException("Kode matakuliah sudah ada");
            }
            matakuliah.setKode(kode);
        }

        if (sks != null && sks.length() > 0 && !Objects.equals(matakuliah.getSks(), sks)) {
            matakuliah.setSks(sks);
        }

        // Simpan perubahan ke dalam basis data
        matakuliahRepository.save(matakuliah);
    }

    public void update(Long matakuliahId, String nama, String sks) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
