package Hsdemy.vn.HsdemyWeb.controller.admin;

import java.time.LocalDateTime;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import Hsdemy.vn.HsdemyWeb.domain.Course;
import Hsdemy.vn.HsdemyWeb.domain.Order;
import Hsdemy.vn.HsdemyWeb.domain.OrderDetail;
import Hsdemy.vn.HsdemyWeb.service.CourseService;
import Hsdemy.vn.HsdemyWeb.service.OrderService;

@Controller
public class AnalyticsController {
    private final OrderService orderService;
    private final CourseService courseService;

    public AnalyticsController(OrderService orderService, CourseService courseService) {
        this.orderService = orderService;
        this.courseService = courseService;
    }

    @GetMapping("/admin/analytics/revenue")
    public String revenueChartPage(Model model) {
        List<Order> orders = orderService.fetchAllOrdersForAdmin();
        Map<YearMonth, Long> revenueByMonth = new LinkedHashMap<>();

        LocalDateTime now = LocalDateTime.now();
        for (int i = 5; i >= 0; i--) {
            YearMonth ym = YearMonth.from(now.minusMonths(i));
            revenueByMonth.put(ym, 0L);
        }

        for (Order order : orders) {
            if (!"PAID".equals(normalizeStatus(order.getStatus())) || order.getCreatedAt() == null) {
                continue;
            }
            YearMonth ym = YearMonth.from(order.getCreatedAt());
            if (revenueByMonth.containsKey(ym)) {
                revenueByMonth.put(ym, revenueByMonth.get(ym) + Math.round(order.getTotalPrice()));
            }
        }

        List<String> labels = new ArrayList<>();
        List<Long> data = new ArrayList<>();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM/yyyy");
        for (Map.Entry<YearMonth, Long> e : revenueByMonth.entrySet()) {
            labels.add(e.getKey().format(formatter));
            data.add(e.getValue());
        }

        model.addAttribute("chartLabels", labels);
        model.addAttribute("chartData", data);
        model.addAttribute("pageTitle", "Biểu đồ doanh thu 6 tháng");
        model.addAttribute("pageDescription", "Theo dõi doanh thu từ các đơn hàng PAID theo từng tháng.");
        return "admin/analytics/revenue";
    }

    @GetMapping("/admin/analytics/orders")
    public String orderStatusChartPage(Model model) {
        List<Order> orders = orderService.fetchAllOrdersForAdmin();
        Map<String, Integer> statusCount = new LinkedHashMap<>();
        statusCount.put("PENDING_PAYMENT", 0);
        statusCount.put("PAID", 0);
        statusCount.put("FAILED", 0);
        statusCount.put("CANCELLED", 0);
        statusCount.put("REFUNDED", 0);

        for (Order order : orders) {
            String status = normalizeStatus(order.getStatus());
            if (!statusCount.containsKey(status)) {
                statusCount.put(status, 0);
            }
            statusCount.put(status, statusCount.get(status) + 1);
        }

        model.addAttribute("chartLabels", new ArrayList<>(statusCount.keySet()));
        model.addAttribute("chartData", new ArrayList<>(statusCount.values()));
        model.addAttribute("pageTitle", "Biểu đồ trạng thái đơn hàng");
        model.addAttribute("pageDescription", "Quan sát tỷ lệ đơn chờ thanh toán, thành công, lỗi và hoàn tiền.");
        return "admin/analytics/orders";
    }

    @GetMapping("/admin/analytics/categories")
    public String categoryChartPage(Model model) {
        List<Course> courses = courseService.fetchCourses();
        Map<String, CategoryData> categoryMap = new LinkedHashMap<>();

        for (Course course : courses) {
            String category = normalizeCategory(course.getTitle());
            CategoryData data = categoryMap.computeIfAbsent(category, key -> new CategoryData());
            data.count += 1;
            data.totalPrice += course.getPrice();
        }

        List<String> labels = new ArrayList<>();
        List<Integer> countData = new ArrayList<>();
        List<Long> avgPriceData = new ArrayList<>();

        List<Map.Entry<String, CategoryData>> entries = new ArrayList<>(categoryMap.entrySet());
        entries.sort(Comparator.comparingInt((Map.Entry<String, CategoryData> e) -> e.getValue().count).reversed());

        for (Map.Entry<String, CategoryData> e : entries) {
            labels.add(e.getKey());
            countData.add(e.getValue().count);
            long avg = e.getValue().count == 0 ? 0 : Math.round(e.getValue().totalPrice / e.getValue().count);
            avgPriceData.add(avg);
        }

        model.addAttribute("chartLabels", labels);
        model.addAttribute("countData", countData);
        model.addAttribute("avgPriceData", avgPriceData);
        model.addAttribute("pageTitle", "Biểu đồ phân bổ category");
        model.addAttribute("pageDescription", "So sánh số lượng khóa học và giá trung bình giữa các category.");
        return "admin/analytics/categories";
    }

    @GetMapping("/admin/analytics/purchases")
    public String purchaseChartPage(Model model) {
        List<Order> orders = orderService.fetchAllOrdersForAdmin();
        Map<String, Integer> topCoursePurchaseCount = new LinkedHashMap<>();
        Map<YearMonth, Integer> purchasesByMonth = new LinkedHashMap<>();

        LocalDateTime now = LocalDateTime.now();
        for (int i = 5; i >= 0; i--) {
            purchasesByMonth.put(YearMonth.from(now.minusMonths(i)), 0);
        }

        for (Order order : orders) {
            String status = normalizeStatus(order.getStatus());
            if (!"PAID".equals(status)) {
                continue;
            }
            if (order.getCreatedAt() != null) {
                YearMonth ym = YearMonth.from(order.getCreatedAt());
                if (purchasesByMonth.containsKey(ym)) {
                    purchasesByMonth.put(ym, purchasesByMonth.get(ym) + 1);
                }
            }
            if (order.getOrderDetails() == null) {
                continue;
            }
            for (OrderDetail detail : order.getOrderDetails()) {
                String courseName = (detail.getCourse() != null && detail.getCourse().getName() != null)
                        ? detail.getCourse().getName()
                        : "Unknown Course";
                topCoursePurchaseCount.put(courseName, topCoursePurchaseCount.getOrDefault(courseName, 0) + 1);
            }
        }

        List<Map.Entry<String, Integer>> topEntries = new ArrayList<>(topCoursePurchaseCount.entrySet());
        topEntries.sort(Map.Entry.<String, Integer>comparingByValue().reversed());
        if (topEntries.size() > 6) {
            topEntries = topEntries.subList(0, 6);
        }

        List<String> topCourseLabels = new ArrayList<>();
        List<Integer> topCourseData = new ArrayList<>();
        for (Map.Entry<String, Integer> e : topEntries) {
            topCourseLabels.add(e.getKey());
            topCourseData.add(e.getValue());
        }

        List<String> monthLabels = new ArrayList<>();
        List<Integer> monthData = new ArrayList<>();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM/yyyy");
        for (Map.Entry<YearMonth, Integer> e : purchasesByMonth.entrySet()) {
            monthLabels.add(e.getKey().format(formatter));
            monthData.add(e.getValue());
        }

        model.addAttribute("topCourseLabels", topCourseLabels);
        model.addAttribute("topCourseData", topCourseData);
        model.addAttribute("monthLabels", monthLabels);
        model.addAttribute("monthData", monthData);
        model.addAttribute("pageTitle", "Biểu đồ lượt mua khóa học");
        model.addAttribute("pageDescription", "Theo dõi xu hướng mua theo tháng và top khóa học có lượt mua cao.");
        return "admin/analytics/purchases";
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

    private static class CategoryData {
        private int count;
        private double totalPrice;
    }
}
