package Hsdemy.vn.HsdemyWeb.service;

import java.util.List;
import java.util.Locale;
import java.util.Comparator;
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

    public List<Course> searchCourses(String keyword) {
        if (keyword == null || keyword.isBlank()) {
            return fetchCourses();
        }
        return courseRepository.searchCourses(keyword.trim());
    }

    public List<Course> filterCourses(String keyword, String level, String title, Double maxPrice, String sort) {
        String normalizedKeyword = keyword == null ? "" : keyword.trim().toLowerCase(Locale.ROOT);
        String normalizedLevel = level == null ? "" : level.trim().toLowerCase(Locale.ROOT);
        String normalizedTitle = title == null ? "" : title.trim().toLowerCase(Locale.ROOT);

        Comparator<Course> comparator = Comparator
                .comparing(Course::getCreatedAt, Comparator.nullsLast(Comparator.naturalOrder()))
                .reversed();

        if ("price-asc".equalsIgnoreCase(sort)) {
            comparator = Comparator.comparingDouble(Course::getPrice);
        } else if ("price-desc".equalsIgnoreCase(sort)) {
            comparator = Comparator.comparingDouble(Course::getPrice).reversed();
        }

        return fetchCourses().stream()
                .filter(course -> normalizedKeyword.isBlank()
                        || containsIgnoreCase(course.getName(), normalizedKeyword)
                        || containsIgnoreCase(course.getAuthor(), normalizedKeyword)
                        || containsIgnoreCase(course.getShortDesc(), normalizedKeyword))
                .filter(course -> normalizedLevel.isBlank() || containsIgnoreCase(course.getLevel(), normalizedLevel))
                .filter(course -> normalizedTitle.isBlank() || containsIgnoreCase(course.getTitle(), normalizedTitle))
                .filter(course -> maxPrice == null || course.getPrice() <= maxPrice)
                .sorted(comparator)
                .collect(Collectors.toList());
    }

    public List<String> getDistinctLevels() {
        return fetchCourses().stream()
                .map(Course::getLevel)
                .filter(level -> level != null && !level.isBlank())
                .map(String::trim)
                .distinct()
                .sorted(String.CASE_INSENSITIVE_ORDER)
                .collect(Collectors.toList());
    }

    public List<String> getDistinctTitles() {
        return fetchCourses().stream()
                .map(Course::getTitle)
                .filter(title -> title != null && !title.isBlank())
                .map(String::trim)
                .distinct()
                .sorted(String.CASE_INSENSITIVE_ORDER)
                .collect(Collectors.toList());
    }

    public List<Course> suggestCourses(String keyword, int limit) {
        if (keyword == null || keyword.isBlank()) {
            return List.of();
        }
        return courseRepository.searchCourses(keyword.trim()).stream()
                .limit(Math.max(1, limit))
                .collect(Collectors.toList());
    }

    public List<String> suggestAuthors(String keyword, int limit) {
        if (keyword == null || keyword.isBlank()) {
            return List.of();
        }
        String q = keyword.trim().toLowerCase(Locale.ROOT);
        return fetchCourses().stream()
                .map(Course::getAuthor)
                .filter(author -> author != null && !author.isBlank())
                .filter(author -> author.toLowerCase(Locale.ROOT).contains(q))
                .distinct()
                .limit(Math.max(1, limit))
                .collect(Collectors.toList());
    }

    private boolean containsIgnoreCase(String value, String keyword) {
        return value != null && value.toLowerCase(Locale.ROOT).contains(keyword);
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
