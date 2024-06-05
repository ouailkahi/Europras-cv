package ntt.cv.europass.repository;

import ntt.cv.europass.entity.Sector;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SectorRepository extends JpaRepository<Sector, Long> {

    Sector findByName(String name);
}
