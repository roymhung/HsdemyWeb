package Hsdemy.vn.HsdemyWeb.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import Hsdemy.vn.HsdemyWeb.domain.Course;

@Repository
public interface CourseRepository extends JpaRepository<Course, Long> {
    List<Course> findByTitleIgnoreCase(String title);
}
