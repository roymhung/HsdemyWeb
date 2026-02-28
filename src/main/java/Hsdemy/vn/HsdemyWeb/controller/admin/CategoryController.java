package Hsdemy.vn.HsdemyWeb.controller.admin;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import Hsdemy.vn.HsdemyWeb.domain.Course;
import Hsdemy.vn.HsdemyWeb.service.CourseService;

@Controller
public class CategoryController {
    private final CourseService courseService;

    public CategoryController(CourseService courseService) {
        this.courseService = courseService;
    }

    @GetMapping("/admin/category")
    public String getDashboard(
            @RequestParam(value = "q", required = false) String keyword,
            @RequestParam(value = "sort", required = false, defaultValue = "courses_desc") String sort,
            @RequestParam(value = "msg", required = false) String msg,
            Model model) {
        List<Course> courses = courseService.fetchCourses();
        Map<String, CategorySummary> grouped = new HashMap<>();

        for (Course course : courses) {
            String key = normalizeTitleKey(course.getTitle());
            CategorySummary summary = grouped.computeIfAbsent(key, CategorySummary::new);
            summary.courseCount++;
            summary.totalRevenue += Math.round(course.getPrice());
            summary.totalPrice += course.getPrice();
            if (course.getCreatedAt() != null
                    && (summary.lastCreatedAt == null || course.getCreatedAt().isAfter(summary.lastCreatedAt))) {
                summary.lastCreatedAt = course.getCreatedAt();
            }
        }

        List<CategorySummary> categories = new ArrayList<>(grouped.values());
        for (CategorySummary category : categories) {
            category.avgPrice = category.courseCount == 0 ? 0 : Math.round(category.totalPrice / category.courseCount);
            category.displayName = displayLabel(category.key);
        }

        if (keyword != null && !keyword.isBlank()) {
            String q = keyword.trim().toLowerCase(Locale.ROOT);
            categories = categories.stream()
                    .filter(item -> item.key.toLowerCase(Locale.ROOT).contains(q)
                            || item.displayName.toLowerCase(Locale.ROOT).contains(q))
                    .toList();
        }

        applySort(categories, sort);

        long uncategorized = courses.stream()
                .filter(course -> normalizeTitleKey(course.getTitle()).equals("UNCATEGORIZED"))
                .count();
        String topCategory = categories.isEmpty() ? "-" : categories.get(0).displayName;

        model.addAttribute("categories", categories);
        model.addAttribute("selectedSort", sort);
        model.addAttribute("keyword", keyword == null ? "" : keyword);
        model.addAttribute("totalCategoryCount", grouped.size());
        model.addAttribute("totalCourseCount", courses.size());
        model.addAttribute("uncategorizedCount", uncategorized);
        model.addAttribute("topCategory", topCategory);
        model.addAttribute("message", msg);
        return "admin/category/show";
    }

    @PostMapping("/admin/category/rename")
    public String renameCategory(
            @RequestParam("oldTitle") String oldTitle,
            @RequestParam("newTitle") String newTitle) {
        int affected = courseService.renameCategoryTitle(oldTitle, newTitle);
        if (affected <= 0) {
            return "redirect:/admin/category?msg=Không có khóa học nào được cập nhật.";
        }
        return "redirect:/admin/category?msg=Đã cập nhật category cho " + affected + " khóa học.";
    }

    private void applySort(List<CategorySummary> categories, String sort) {
        if ("name_asc".equals(sort)) {
            categories.sort(Comparator.comparing(item -> item.displayName));
            return;
        }
        if ("revenue_desc".equals(sort)) {
            categories.sort(Comparator.comparingLong((CategorySummary item) -> item.totalRevenue).reversed());
            return;
        }
        categories.sort(Comparator.comparingInt((CategorySummary item) -> item.courseCount).reversed());
    }

    private String normalizeTitleKey(String rawTitle) {
        if (rawTitle == null || rawTitle.isBlank()) {
            return "UNCATEGORIZED";
        }
        return rawTitle.trim().toUpperCase(Locale.ROOT);
    }

    private String displayLabel(String key) {
        return switch (key) {
            case "LANGUAGE" -> "Ngoại ngữ";
            case "SOFT_SKILLS" -> "Kỹ năng mềm";
            case "BUSINESS_MARKETING" -> "Kinh doanh & Marketing";
            case "IT_DESIGN" -> "Tin học & Thiết kế";
            case "UNCATEGORIZED" -> "Chưa phân loại";
            default -> key.replace('_', ' ');
        };
    }

    public static class CategorySummary {
        private final String key;
        private String displayName;
        private int courseCount;
        private long totalRevenue;
        private double totalPrice;
        private long avgPrice;
        private LocalDateTime lastCreatedAt;

        public CategorySummary(String key) {
            this.key = key;
        }

        public String getKey() {
            return key;
        }

        public String getDisplayName() {
            return displayName;
        }

        public int getCourseCount() {
            return courseCount;
        }

        public long getTotalRevenue() {
            return totalRevenue;
        }

        public long getAvgPrice() {
            return avgPrice;
        }

        public LocalDateTime getLastCreatedAt() {
            return lastCreatedAt;
        }
    }
}
