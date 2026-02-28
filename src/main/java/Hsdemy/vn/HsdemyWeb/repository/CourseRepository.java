package Hsdemy.vn.HsdemyWeb.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import Hsdemy.vn.HsdemyWeb.domain.Course;

@Repository
public interface CourseRepository extends JpaRepository<Course, Long> {
    List<Course> findByTitleIgnoreCase(String title);

    @Query("""
            SELECT c FROM Course c
            WHERE LOWER(c.name) LIKE LOWER(CONCAT('%', :keyword, '%'))
               OR LOWER(c.author) LIKE LOWER(CONCAT('%', :keyword, '%'))
               OR LOWER(c.title) LIKE LOWER(CONCAT('%', :keyword, '%'))
               OR LOWER(c.shortDesc) LIKE LOWER(CONCAT('%', :keyword, '%'))
            """)
    List<Course> searchCourses(@Param("keyword") String keyword);
}
