package Hsdemy.vn.HsdemyWeb.service;

import java.util.List;

import org.springframework.stereotype.Service;

import Hsdemy.vn.HsdemyWeb.domain.Lesson;
import Hsdemy.vn.HsdemyWeb.repository.LessonRepository;

@Service
public class LessonService {

    private final LessonRepository lessonRepository;

    public LessonService(LessonRepository lessonRepository) {
        this.lessonRepository = lessonRepository;
    }

    public List<Lesson> fetchByChapterId(Long chapterId) {
        return lessonRepository.findByChapterIdOrderByPositionAsc(chapterId);
    }

    public boolean existsPositionInChapter(Long chapterId, int position) {
        return lessonRepository.existsByChapterIdAndPosition(chapterId, position);
    }

    public Lesson save(Lesson lesson) {
        return lessonRepository.save(lesson);
    }
}
