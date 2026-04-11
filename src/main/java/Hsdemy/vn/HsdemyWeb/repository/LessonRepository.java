package Hsdemy.vn.HsdemyWeb.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import Hsdemy.vn.HsdemyWeb.domain.Lesson;

@Repository
public interface LessonRepository extends JpaRepository<Lesson, Long> {
    List<Lesson> findByChapterIdOrderByPositionAsc(Long chapterId);

    boolean existsByChapterIdAndPosition(Long chapterId, int position);

    @Query("""
            SELECT c.course.id AS courseId, COUNT(l.id) AS videoCount
            FROM Lesson l
            JOIN l.chapter c
            WHERE c.course.id IN :courseIds
              AND l.videoUrl IS NOT NULL
              AND l.videoUrl <> ''
            GROUP BY c.course.id
            """)
    List<CourseVideoCountView> countVideoByCourseIds(@Param("courseIds") List<Long> courseIds);

    interface CourseVideoCountView {
        Long getCourseId();

        Long getVideoCount();
    }
}
