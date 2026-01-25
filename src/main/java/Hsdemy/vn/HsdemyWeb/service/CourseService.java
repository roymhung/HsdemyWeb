package Hsdemy.vn.HsdemyWeb.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import Hsdemy.vn.HsdemyWeb.domain.Course;
import Hsdemy.vn.HsdemyWeb.repository.CourseRepository;

@Service
public class CourseService {

    private final CourseRepository courseRepository;

    public CourseService(CourseRepository courseRepository) {
        this.courseRepository = courseRepository;
    }

    // CREATE + UPDATE
    public Course createProduct(Course course) {
        return this.courseRepository.save(course);
    }

    public Course saveCourse(Course course) {
        return courseRepository.save(course);
    }

    // LIST ALL (simple)
    public List<Course> fetchCourses() {
        return courseRepository.findAll();
    }

    // LIST WITH PAGINATION (admin chuẩn)
    public Page<Course> fetchCourses(Pageable pageable) {
        return courseRepository.findAll(pageable);
    }

    // DETAIL
    public Course getCourseById(long id) {
        return courseRepository.findById(id).orElse(null);
    }

    // DELETE
    public void deleteCourse(long id) {
        courseRepository.deleteById(id);
    }

    // CHECK EXIST
    public boolean existsById(long id) {
        return courseRepository.existsById(id);
    }
}
