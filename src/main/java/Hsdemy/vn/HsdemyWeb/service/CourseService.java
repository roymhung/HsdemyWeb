package Hsdemy.vn.HsdemyWeb.service;

import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;

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

    public int renameCategoryTitle(String oldTitle, String newTitle) {
        if (oldTitle == null || newTitle == null) {
            return 0;
        }
        String oldNormalized = oldTitle.trim();
        String newNormalized = newTitle.trim();
        if (oldNormalized.isEmpty() || newNormalized.isEmpty()
                || oldNormalized.equalsIgnoreCase(newNormalized)) {
            return 0;
        }

        List<Course> courses = courseRepository.findByTitleIgnoreCase(oldNormalized);
        if (courses.isEmpty()) {
            return 0;
        }
        String finalNewTitle = newNormalized.toUpperCase(Locale.ROOT);
        List<Course> updated = courses.stream().peek(course -> course.setTitle(finalNewTitle)).collect(Collectors.toList());
        courseRepository.saveAll(updated);
        return updated.size();
    }
}
