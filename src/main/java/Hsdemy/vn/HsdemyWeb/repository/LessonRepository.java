package Hsdemy.vn.HsdemyWeb.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import Hsdemy.vn.HsdemyWeb.domain.Lesson;

@Repository
public interface LessonRepository extends JpaRepository<Lesson, Long> {
    List<Lesson> findByChapterIdOrderByPositionAsc(Long chapterId);

    boolean existsByChapterIdAndPosition(Long chapterId, int position);
}
