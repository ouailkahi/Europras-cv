package ntt.cv.europass.service;

import ntt.cv.europass.entity.Certificate;
import ntt.cv.europass.entity.Resume;
import ntt.cv.europass.repository.CertificateRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CertificateService extends MainService<Certificate, Long> {
    @Autowired
    public CertificateService(CertificateRepository repository) {
        super(repository);
    }

}