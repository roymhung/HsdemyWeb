package Hsdemy.vn.HsdemyWeb.controller.admin;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import Hsdemy.vn.HsdemyWeb.domain.Course;
import Hsdemy.vn.HsdemyWeb.service.CourseService;

@Controller
public class CategoryController {
    private static final int CATEGORIES_PER_PAGE = 9;
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    private static final DateTimeFormatter TIME_FORMATTER = DateTimeFormatter.ofPattern("HH:mm");

    private final CourseService courseService;

    public CategoryController(CourseService courseService) {
        this.courseService = courseService;
    }

    @GetMapping("/admin/category")
    public String getDashboard(
            @RequestParam(value = "q", required = false) String keyword,
            @RequestParam(value = "sort", required = false, defaultValue = "latest_desc") String sort,
            @RequestParam(value = "page", defaultValue = "1") int page,
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

        int totalFilteredCategories = categories.size();
        int totalPages = Math.max(1, (int) Math.ceil((double) totalFilteredCategories / CATEGORIES_PER_PAGE));
        int currentPage = Math.max(1, Math.min(page, totalPages));
        int fromIndex = (currentPage - 1) * CATEGORIES_PER_PAGE;
        int toIndex = Math.min(fromIndex + CATEGORIES_PER_PAGE, totalFilteredCategories);
        List<CategorySummary> pageCategories = fromIndex >= toIndex ? List.of() : categories.subList(fromIndex, toIndex);

        long uncategorized = courses.stream()
                .filter(course -> normalizeTitleKey(course.getTitle()).equals("UNCATEGORIZED"))
                .count();
        String topCategory = categories.isEmpty() ? "-" : categories.get(0).displayName;

        model.addAttribute("categories", pageCategories);
        model.addAttribute("allCategories", categories);
        model.addAttribute("selectedSort", sort);
        model.addAttribute("keyword", keyword == null ? "" : keyword);
        model.addAttribute("totalCategoryCount", grouped.size());
        model.addAttribute("totalCourseCount", courses.size());
        model.addAttribute("uncategorizedCount", uncategorized);
        model.addAttribute("topCategory", topCategory);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalPages", totalPages);
        return "admin/category/show";
    }

    @PostMapping("/admin/category/rename")
    public String renameCategory(
            @RequestParam("oldTitle") String oldTitle,
            @RequestParam("newTitle") String newTitle,
            RedirectAttributes redirectAttributes) {
        int affected = courseService.renameCategoryTitle(oldTitle, newTitle);
        if (affected <= 0) {
            redirectAttributes.addFlashAttribute("message", "Không có khóa học nào được cập nhật.");
            return "redirect:/admin/category";
        }
        redirectAttributes.addFlashAttribute("message", "Đã cập nhật category cho " + affected + " khóa học.");
        return "redirect:/admin/category";
    }

    private void applySort(List<CategorySummary> categories, String sort) {
        if ("latest_desc".equals(sort)) {
            categories.sort(Comparator.comparing(CategorySummary::getLastCreatedAt,
                    Comparator.nullsLast(Comparator.reverseOrder())));
            return;
        }
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

        public String getLatestDateDisplay() {
            if (lastCreatedAt == null) {
                return "-";
            }
            return lastCreatedAt.format(DATE_FORMATTER);
        }

        public String getLatestTimeDisplay() {
            if (lastCreatedAt == null) {
                return "-";
            }
            return lastCreatedAt.format(TIME_FORMATTER);
        }
    }
}
