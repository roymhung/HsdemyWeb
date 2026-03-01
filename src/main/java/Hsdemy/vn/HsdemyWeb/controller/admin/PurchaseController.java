package Hsdemy.vn.HsdemyWeb.controller.admin;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
import java.util.Set;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import Hsdemy.vn.HsdemyWeb.domain.Course;
import Hsdemy.vn.HsdemyWeb.domain.Order;
import Hsdemy.vn.HsdemyWeb.domain.OrderDetail;
import Hsdemy.vn.HsdemyWeb.service.OrderService;

@Controller
public class PurchaseController {
    private static final int PURCHASES_PER_PAGE = 9;
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    private static final DateTimeFormatter TIME_FORMATTER = DateTimeFormatter.ofPattern("HH:mm");

    private final OrderService orderService;

    public PurchaseController(OrderService orderService) {
        this.orderService = orderService;
    }

    @GetMapping("/admin/purchase")
    public String getPurchasePage(
            @RequestParam(value = "q", required = false) String keyword,
            @RequestParam(value = "status", required = false, defaultValue = "ALL") String statusFilter,
            @RequestParam(value = "category", required = false, defaultValue = "ALL") String categoryFilter,
            @RequestParam(value = "page", defaultValue = "1") int page,
            Model model) {
        List<Order> orders = orderService.fetchAllOrdersForAdmin();
        List<PurchaseRow> rows = new ArrayList<>();
        Set<String> categories = new HashSet<>();

        long totalRevenue = 0;
        int paidPurchaseCount = 0;
        Set<Long> uniqueStudentIds = new HashSet<>();

        for (Order order : orders) {
            String normalizedStatus = normalizeStatus(order.getStatus());
            if (order.getUser() != null) {
                uniqueStudentIds.add(order.getUser().getId());
            }
            if (order.getOrderDetails() == null) {
                continue;
            }
            for (OrderDetail detail : order.getOrderDetails()) {
                Course course = detail.getCourse();
                String category = normalizeCategory(course == null ? null : course.getTitle());
                categories.add(category);

                if ("PAID".equals(normalizedStatus)) {
                    paidPurchaseCount++;
                    totalRevenue += Math.round(detail.getPrice());
                }

                rows.add(new PurchaseRow(
                        detail.getId(),
                        order.getId(),
                        order.getUser() == null ? "-" : safeText(order.getUser().getFullName(), "Unknown User"),
                        order.getUser() == null ? "-" : safeText(order.getUser().getEmail(), "-"),
                        course == null ? "-" : safeText(course.getName(), "-"),
                        category,
                        detail.getPrice(),
                        normalizedStatus,
                        order.getCreatedAt()));
            }
        }

        rows = applyFilters(rows, keyword, statusFilter, categoryFilter);
        rows.sort(Comparator.comparing(PurchaseRow::getPurchaseId, Comparator.nullsLast(Comparator.naturalOrder())));
        int totalPurchaseCount = rows.size();
        int totalPages = Math.max(1, (int) Math.ceil((double) totalPurchaseCount / PURCHASES_PER_PAGE));
        int currentPage = Math.max(1, Math.min(page, totalPages));
        int fromIndex = (currentPage - 1) * PURCHASES_PER_PAGE;
        int toIndex = Math.min(fromIndex + PURCHASES_PER_PAGE, totalPurchaseCount);
        List<PurchaseRow> pageRows = fromIndex >= toIndex ? List.of() : rows.subList(fromIndex, toIndex);

        List<String> sortedCategories = new ArrayList<>(categories);
        sortedCategories.sort(String::compareTo);

        model.addAttribute("rows", pageRows);
        model.addAttribute("keyword", keyword == null ? "" : keyword);
        model.addAttribute("selectedStatus", statusFilter == null ? "ALL" : statusFilter.toUpperCase(Locale.ROOT));
        model.addAttribute("selectedCategory", categoryFilter == null ? "ALL" : categoryFilter.toUpperCase(Locale.ROOT));
        model.addAttribute("statusOptions", List.of("PENDING_PAYMENT", "PAID", "FAILED", "CANCELLED", "REFUNDED"));
        model.addAttribute("categoryOptions", sortedCategories);
        model.addAttribute("totalPurchaseCount", totalPurchaseCount);
        model.addAttribute("paidPurchaseCount", paidPurchaseCount);
        model.addAttribute("totalRevenue", totalRevenue);
        model.addAttribute("uniqueStudents", uniqueStudentIds.size());
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalPages", totalPages);
        return "admin/purchase/show";
    }

    private List<PurchaseRow> applyFilters(List<PurchaseRow> rows, String keyword, String statusFilter,
            String categoryFilter) {
        List<PurchaseRow> result = rows;

        if (statusFilter != null && !statusFilter.equalsIgnoreCase("ALL")) {
            String filter = statusFilter.trim().toUpperCase(Locale.ROOT);
            result = result.stream()
                    .filter(row -> row.getStatus().equalsIgnoreCase(filter))
                    .toList();
        }

        if (categoryFilter != null && !categoryFilter.equalsIgnoreCase("ALL")) {
            String filter = categoryFilter.trim().toUpperCase(Locale.ROOT);
            result = result.stream()
                    .filter(row -> row.getCategory().equalsIgnoreCase(filter))
                    .toList();
        }

        if (keyword != null && !keyword.isBlank()) {
            String q = keyword.trim().toLowerCase(Locale.ROOT);
            result = result.stream()
                    .filter(row -> String.valueOf(row.getOrderId()).contains(q)
                            || row.getStudentName().toLowerCase(Locale.ROOT).contains(q)
                            || row.getStudentEmail().toLowerCase(Locale.ROOT).contains(q)
                            || row.getCourseName().toLowerCase(Locale.ROOT).contains(q))
                    .toList();
        }
        return result;
    }

    private String normalizeStatus(String status) {
        if (status == null || status.isBlank()) {
            return "PENDING_PAYMENT";
        }
        return status.trim().toUpperCase(Locale.ROOT).replace(' ', '_');
    }

    private String normalizeCategory(String category) {
        if (category == null || category.isBlank()) {
            return "UNCATEGORIZED";
        }
        return category.trim().toUpperCase(Locale.ROOT);
    }

    private String safeText(String value, String fallback) {
        if (value == null || value.isBlank()) {
            return fallback;
        }
        return value.trim();
    }

    public static class PurchaseRow {
        private final Long purchaseId;
        private final Long orderId;
        private final String studentName;
        private final String studentEmail;
        private final String courseName;
        private final String category;
        private final double amount;
        private final String status;
        private final LocalDateTime purchasedAt;

        public PurchaseRow(Long purchaseId, Long orderId, String studentName, String studentEmail, String courseName,
                String category, double amount, String status, LocalDateTime purchasedAt) {
            this.purchaseId = purchaseId;
            this.orderId = orderId;
            this.studentName = studentName;
            this.studentEmail = studentEmail;
            this.courseName = courseName;
            this.category = category;
            this.amount = amount;
            this.status = status;
            this.purchasedAt = purchasedAt;
        }

        public Long getPurchaseId() {
            return purchaseId;
        }

        public Long getOrderId() {
            return orderId;
        }

        public String getStudentName() {
            return studentName;
        }

        public String getStudentEmail() {
            return studentEmail;
        }

        public String getCourseName() {
            return courseName;
        }

        public String getCategory() {
            return category;
        }

        public double getAmount() {
            return amount;
        }

        public String getStatus() {
            return status;
        }

        public LocalDateTime getPurchasedAt() {
            return purchasedAt;
        }

        public String getPurchasedDateDisplay() {
            if (purchasedAt == null) {
                return "-";
            }
            return purchasedAt.format(DATE_FORMATTER);
        }

        public String getPurchasedTimeDisplay() {
            if (purchasedAt == null) {
                return "-";
            }
            return purchasedAt.format(TIME_FORMATTER);
        }
    }
}
