package Hsdemy.vn.HsdemyWeb.controller.admin;

import java.time.LocalDateTime;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import Hsdemy.vn.HsdemyWeb.domain.Chapter;
import Hsdemy.vn.HsdemyWeb.domain.Course;
import Hsdemy.vn.HsdemyWeb.domain.Lesson;
import Hsdemy.vn.HsdemyWeb.domain.Order;
import Hsdemy.vn.HsdemyWeb.domain.OrderDetail;
import Hsdemy.vn.HsdemyWeb.service.CourseService;
import Hsdemy.vn.HsdemyWeb.service.OrderService;
import Hsdemy.vn.HsdemyWeb.service.UserService;

@Controller
public class DashboardController {
    private final CourseService courseService;
    private final OrderService orderService;
    private final UserService userService;

    public DashboardController(CourseService courseService, OrderService orderService, UserService userService) {
        this.courseService = courseService;
        this.orderService = orderService;
        this.userService = userService;
    }

    @GetMapping("/admin")
    public String getDashboard(Model model) {
        List<Course> courses = courseService.fetchCourses();
        List<Order> orders = orderService.fetchAllOrdersForAdmin();

        int totalCourses = courses.size();
        int totalUsers = userService.getAllUsers().size();
        int totalLessons = 0;
        int previewLessons = 0;
        long paidRevenue = 0;
        Set<Long> paidUserIds = new HashSet<>();

        Map<String, Integer> statusCount = new LinkedHashMap<>();
        statusCount.put("PENDING_PAYMENT", 0);
        statusCount.put("PAID", 0);
        statusCount.put("FAILED", 0);
        statusCount.put("CANCELLED", 0);
        statusCount.put("REFUNDED", 0);

        Map<YearMonth, Set<Long>> activeLearnersByMonth = new LinkedHashMap<>();
        LocalDateTime now = LocalDateTime.now();
        for (int i = 5; i >= 0; i--) {
            activeLearnersByMonth.put(YearMonth.from(now.minusMonths(i)), new HashSet<>());
        }

        Map<String, Integer> categoryEnrollment = new HashMap<>();
        List<CourseDepth> courseDepthList = new ArrayList<>();
        LocalDateTime since30Days = now.minusDays(30);
        Set<Long> activeLearners30d = new HashSet<>();

        for (Course course : courses) {
            int lessonCount = 0;
            if (course.getChapters() != null) {
                for (Chapter chapter : course.getChapters()) {
                    if (chapter.getLessons() == null) {
                        continue;
                    }
                    for (Lesson lesson : chapter.getLessons()) {
                        lessonCount++;
                        totalLessons++;
                        if (lesson.isPreview()) {
                            previewLessons++;
                        }
                    }
                }
            }
            courseDepthList.add(new CourseDepth(course.getName(), lessonCount));
        }

        for (Order order : orders) {
            String status = normalizeStatus(order.getStatus());
            statusCount.put(status, statusCount.getOrDefault(status, 0) + 1);
            if (!"PAID".equals(status)) {
                continue;
            }
            paidRevenue += Math.round(order.getTotalPrice());
            if (order.getUser() != null) {
                paidUserIds.add(order.getUser().getId());
                if (order.getCreatedAt() != null && order.getCreatedAt().isAfter(since30Days)) {
                    activeLearners30d.add(order.getUser().getId());
                }
            }
            if (order.getCreatedAt() != null) {
                YearMonth ym = YearMonth.from(order.getCreatedAt());
                if (activeLearnersByMonth.containsKey(ym) && order.getUser() != null) {
                    activeLearnersByMonth.get(ym).add(order.getUser().getId());
                }
            }
            if (order.getOrderDetails() == null) {
                continue;
            }
            for (OrderDetail detail : order.getOrderDetails()) {
                String category = normalizeCategory(detail.getCourse() == null ? null : detail.getCourse().getTitle());
                categoryEnrollment.put(category, categoryEnrollment.getOrDefault(category, 0) + 1);
            }
        }

        int avgLessonsPerCourse = totalCourses == 0 ? 0 : Math.round((float) totalLessons / totalCourses);
        int previewRate = totalLessons == 0 ? 0 : Math.round((float) (previewLessons * 100) / totalLessons);

        List<String> learnerTrendLabels = new ArrayList<>();
        List<Integer> learnerTrendData = new ArrayList<>();
        DateTimeFormatter monthFmt = DateTimeFormatter.ofPattern("MM/yyyy");
        for (Map.Entry<YearMonth, Set<Long>> entry : activeLearnersByMonth.entrySet()) {
            learnerTrendLabels.add(entry.getKey().format(monthFmt));
            learnerTrendData.add(entry.getValue().size());
        }

        List<String> statusLabels = new ArrayList<>(statusCount.keySet());
        List<Integer> statusData = new ArrayList<>(statusCount.values());

        List<Map.Entry<String, Integer>> categoryEntries = new ArrayList<>(categoryEnrollment.entrySet());
        categoryEntries.sort(Map.Entry.<String, Integer>comparingByValue().reversed());
        if (categoryEntries.size() > 6) {
            categoryEntries = categoryEntries.subList(0, 6);
        }
        List<String> categoryLabels = new ArrayList<>();
        List<Integer> categoryData = new ArrayList<>();
        for (Map.Entry<String, Integer> e : categoryEntries) {
            categoryLabels.add(e.getKey());
            categoryData.add(e.getValue());
        }

        courseDepthList.sort(Comparator.comparingInt(CourseDepth::getLessons).reversed());
        if (courseDepthList.size() > 6) {
            courseDepthList = courseDepthList.subList(0, 6);
        }
        List<String> depthLabels = new ArrayList<>();
        List<Integer> depthData = new ArrayList<>();
        for (CourseDepth item : courseDepthList) {
            depthLabels.add(item.getCourseName());
            depthData.add(item.getLessons());
        }

        model.addAttribute("totalUsers", totalUsers);
        model.addAttribute("totalCourses", totalCourses);
        model.addAttribute("paidLearners", paidUserIds.size());
        model.addAttribute("activeLearners30d", activeLearners30d.size());
        model.addAttribute("avgLessonsPerCourse", avgLessonsPerCourse);
        model.addAttribute("previewRate", previewRate);
        model.addAttribute("paidRevenue", paidRevenue);

        model.addAttribute("learnerTrendLabels", learnerTrendLabels);
        model.addAttribute("learnerTrendData", learnerTrendData);
        model.addAttribute("statusLabels", statusLabels);
        model.addAttribute("statusData", statusData);
        model.addAttribute("categoryLabels", categoryLabels);
        model.addAttribute("categoryData", categoryData);
        model.addAttribute("depthLabels", depthLabels);
        model.addAttribute("depthData", depthData);
        return "admin/dashboard/show";
    }

    private String normalizeStatus(String status) {
        if (status == null || status.isBlank()) {
            return "PENDING_PAYMENT";
        }
        return status.trim().toUpperCase(Locale.ROOT).replace(' ', '_');
    }

    private String normalizeCategory(String title) {
        if (title == null || title.isBlank()) {
            return "UNCATEGORIZED";
        }
        return title.trim().toUpperCase(Locale.ROOT);
    }

    private static class CourseDepth {
        private final String courseName;
        private final int lessons;

        private CourseDepth(String courseName, int lessons) {
            this.courseName = courseName == null || courseName.isBlank() ? "Unknown Course" : courseName;
            this.lessons = lessons;
        }

        public String getCourseName() {
            return courseName;
        }

        public int getLessons() {
            return lessons;
        }
    }
}
