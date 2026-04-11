package Hsdemy.vn.HsdemyWeb.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import Hsdemy.vn.HsdemyWeb.domain.Chapter;

@Repository
public interface ChapterRepository extends JpaRepository<Chapter, Long> {
    List<Chapter> findByCourseIdOrderByPositionAsc(Long courseId);

    boolean existsByCourseIdAndPosition(Long courseId, int position);

    boolean existsByCourseIdAndPositionAndIdNot(Long courseId, int position, Long id);
}
