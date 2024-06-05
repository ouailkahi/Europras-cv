package ntt.cv.europass.repository;

import ntt.cv.europass.entity.Language;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LanguageRepository extends JpaRepository<Language, Long> {

    Language findByLanguageCode(String code);
}

