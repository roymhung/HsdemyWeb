package Hsdemy.vn.HsdemyWeb.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import Hsdemy.vn.HsdemyWeb.domain.Chapter;
import Hsdemy.vn.HsdemyWeb.repository.ChapterRepository;

@Service
public class ChapterService {

    private final ChapterRepository chapterRepository;

    public ChapterService(ChapterRepository chapterRepository) {
        this.chapterRepository = chapterRepository;
    }

    public List<Chapter> fetchByCourseId(Long courseId) {
        return chapterRepository.findByCourseIdOrderByPositionAsc(courseId);
    }

    public boolean existsPositionInCourse(Long courseId, int position) {
        return chapterRepository.existsByCourseIdAndPosition(courseId, position);
    }

    public boolean existsPositionInCourseExcludeChapter(Long courseId, int position, Long chapterId) {
        return chapterRepository.existsByCourseIdAndPositionAndIdNot(courseId, position, chapterId);
    }

    public Chapter getById(Long id) {
        Optional<Chapter> chapter = chapterRepository.findById(id);
        return chapter.orElse(null);
    }

    public void deleteById(Long id) {
        chapterRepository.deleteById(id);
    }

    public Chapter save(Chapter chapter) {
        return chapterRepository.save(chapter);
    }
}
