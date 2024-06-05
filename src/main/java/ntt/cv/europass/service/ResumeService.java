package ntt.cv.europass.service;

import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import ntt.cv.europass.dto.ResumeDTO;
import ntt.cv.europass.entity.*;
import ntt.cv.europass.mapper.ResumeMapper;
import ntt.cv.europass.repository.ResumeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.List;
import java.util.Optional;
import java.util.concurrent.CompletableFuture;

@Service
@RequiredArgsConstructor
public class ResumeService {

    private final ResumeRepository resumeRepository;
    private final AddressService addressService;
    private final LanguageService languageService;

    @Autowired
    private final ExperienceService experienceService;

    private final SkillService skillService;
    private final LanguageProficiencyService languageProficiencyService;
    private final CertificateService certificateService;
    private final CountryService countryService;
    private final EducationService educationService;

    public ResumeDTO parseResume(String json) throws Exception {
        //Using  ObjectMapper a powerful and flexible tool for converting between Java objects and JSON.
        ObjectMapper objectMapper = new ObjectMapper().registerModule(new JavaTimeModule());;

        //This line uses the readValue method of the ObjectMapper instance to convert the JSON string into a Java object.
        return objectMapper.readValue(json, ResumeDTO.class);
    }




    @Transactional
    public void saveResume(String json) throws Exception {
        ResumeDTO resumeDTO = parseResume(json);
        Resume resume = ResumeMapper.mapToEntity(resumeDTO);

        Optional<Resume> existingResumeOptional = Optional.ofNullable(resumeRepository.findByEmail(resume.getEmail()));
        if (existingResumeOptional.isPresent()) {
            System.out.println("Email already registered.");
        } else {
            saveNewResume(resume);
        }
    }

    private void saveNewResume(Resume resume) {
        // Save the Resume entity along with its associated data
        Address address = addressService.save(resume.getAddress());
        resume.setAddress(address);

        Language language = languageService.save(resume.getPrimaryLanguage());
        resume.setPrimaryLanguage(language);

        List<Certificate> certificates = certificateService.saveMultiple(resume.getCertificates());
        resume.setCertificates(certificates);

        List<Education> educations = educationService.saveMultiple(resume.getEducations());
        resume.setEducations(educations);

        List<Country> nationalities = countryService.saveMultiple(resume.getCountries());
        resume.setCountries(nationalities);

        // Save the Resume entity
        Resume savedResume = resumeRepository.save(resume);

        // Save and associate other entities
        saveAndAssociateEntities(savedResume);
    }

    private void saveAndAssociateEntities(Resume resume) {
        // Save and associate experiences
        List<Experience> experiences = resume.getExperiences();
        experiences.forEach(experience -> {
            experience.setResume(resume);
        });
        experienceService.saveMultiple(experiences);

        // Save and associate skills
        List<Skill> skills = resume.getSkills();
        skills.forEach(skill -> {
            skill.setResume(resume);
        });
        skillService.saveMultiple(skills);

        // Save and associate language proficiencies
        List<LanguageProficiency> languageProficiencies = resume.getLanguageProficiencies();
        languageProficiencies.forEach(languageProficiency -> {
            languageProficiency.setResume(resume);
        });
        languageProficiencyService.saveMultiple(languageProficiencies);

    }




}
