package Hsdemy.vn.HsdemyWeb.controller.admin;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.UriComponentsBuilder;

import Hsdemy.vn.HsdemyWeb.domain.Order;
import Hsdemy.vn.HsdemyWeb.domain.OrderDetail;
import Hsdemy.vn.HsdemyWeb.service.OrderService;

@Controller
public class OrderController {
    private static final int ORDERS_PER_PAGE = 9;
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    private static final DateTimeFormatter TIME_FORMATTER = DateTimeFormatter.ofPattern("HH:mm");

    private final OrderService orderService;

    public OrderController(OrderService orderService) {
        this.orderService = orderService;
    }

    @GetMapping("/admin/order")
    public String getDashboard(
            @RequestParam(value = "q", required = false) String keyword,
            @RequestParam(value = "status", required = false, defaultValue = "ALL") String statusFilter,
            @RequestParam(value = "page", defaultValue = "1") int page,
            Model model) {
        List<Order> orders = orderService.fetchAllOrdersForAdmin();
        List<AdminOrderRow> rows = new ArrayList<>();

        int pendingCount = 0;
        int paidCount = 0;
        int failedCount = 0;
        double totalRevenue = 0;

        for (Order order : orders) {
            String normalizedStatus = normalizeStatus(order.getStatus());
            if ("PENDING_PAYMENT".equals(normalizedStatus)) {
                pendingCount++;
            } else if ("PAID".equals(normalizedStatus)) {
                paidCount++;
                totalRevenue += order.getTotalPrice();
            } else if ("FAILED".equals(normalizedStatus)) {
                failedCount++;
            }
            rows.add(toRow(order, normalizedStatus));
        }

        rows = applyFilters(rows, keyword, statusFilter);
        rows.sort(Comparator.comparing(AdminOrderRow::getId, Comparator.nullsLast(Comparator.naturalOrder())));

        int totalFilteredOrders = rows.size();
        int totalPages = Math.max(1, (int) Math.ceil((double) totalFilteredOrders / ORDERS_PER_PAGE));
        int currentPage = Math.max(1, Math.min(page, totalPages));
        int fromIndex = (currentPage - 1) * ORDERS_PER_PAGE;
        int toIndex = Math.min(fromIndex + ORDERS_PER_PAGE, totalFilteredOrders);
        List<AdminOrderRow> pageRows = fromIndex >= toIndex ? List.of() : rows.subList(fromIndex, toIndex);

        model.addAttribute("orders", pageRows);
        model.addAttribute("keyword", keyword == null ? "" : keyword);
        model.addAttribute("selectedStatus", statusFilter == null ? "ALL" : statusFilter.toUpperCase(Locale.ROOT));
        model.addAttribute("totalOrders", orders.size());
        model.addAttribute("pendingOrders", pendingCount);
        model.addAttribute("paidOrders", paidCount);
        model.addAttribute("failedOrders", failedCount);
        model.addAttribute("totalRevenue", Math.round(totalRevenue));
        model.addAttribute("statusOptions", List.of("PENDING_PAYMENT", "PAID", "FAILED", "CANCELLED", "REFUNDED"));
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalPages", totalPages);
        return "admin/order/show";
    }

    @PostMapping("/admin/order/{orderId}/status")
    public String updateOrderStatus(@PathVariable("orderId") Long orderId,
            @RequestParam(value = "newStatus", required = false) String newStatus,
            @RequestParam(value = "status", required = false) String status,
            @RequestParam(value = "q", required = false) String keyword,
            @RequestParam(value = "statusFilter", required = false, defaultValue = "ALL") String statusFilter,
            @RequestParam(value = "page", defaultValue = "1") int page,
            RedirectAttributes redirectAttributes) {
        String statusToUpdate = (newStatus != null && !newStatus.isBlank()) ? newStatus : status;
        boolean updated = orderService.updateOrderStatus(orderId, statusToUpdate);
        String msg = updated
                ? "Đã cập nhật trạng thái đơn #" + orderId + " thành " + statusToUpdate + "."
                : "Không thể cập nhật đơn #" + orderId + ".";
        redirectAttributes.addFlashAttribute("message", msg);
        String qValue = keyword == null ? "" : keyword.trim();
        String sfValue = statusFilter == null ? "ALL" : statusFilter;
        String redirectUrl = UriComponentsBuilder.fromPath("/admin/order")
                .queryParam("q", qValue)
                .queryParam("status", sfValue)
                .queryParam("page", page)
                .build()
                .toUriString();
        return "redirect:" + redirectUrl;
    }

    @GetMapping("/admin/order/{orderId}/status")
    public String fallbackOrderStatusPath(
            @PathVariable("orderId") Long orderId,
            @RequestParam(value = "q", required = false) String keyword,
            @RequestParam(value = "status", required = false, defaultValue = "ALL") String statusFilter,
            @RequestParam(value = "page", defaultValue = "1") int page,
            RedirectAttributes redirectAttributes) {
        redirectAttributes.addFlashAttribute("message",
                "Đường dẫn cập nhật đơn #" + orderId + " không hợp lệ, vui lòng thử lại.");
        String qValue = keyword == null ? "" : keyword.trim();
        String sfValue = statusFilter == null ? "ALL" : statusFilter;
        String redirectUrl = UriComponentsBuilder.fromPath("/admin/order")
                .queryParam("q", qValue)
                .queryParam("status", sfValue)
                .queryParam("page", page)
                .build()
                .toUriString();
        return "redirect:" + redirectUrl;
    }

    private List<AdminOrderRow> applyFilters(List<AdminOrderRow> rows, String keyword, String statusFilter) {
        List<AdminOrderRow> result = new ArrayList<>(rows);
        if (statusFilter != null && !statusFilter.equalsIgnoreCase("ALL")) {
            String statusValue = statusFilter.trim().toUpperCase(Locale.ROOT);
            result = result.stream()
                    .filter(row -> row.getStatus().equalsIgnoreCase(statusValue))
                    .collect(java.util.stream.Collectors.toCollection(ArrayList::new));
        }
        if (keyword != null && !keyword.isBlank()) {
            String q = keyword.trim().toLowerCase(Locale.ROOT);
            result = result.stream()
                    .filter(row -> String.valueOf(row.getId()).contains(q)
                            || row.getUserName().toLowerCase(Locale.ROOT).contains(q)
                            || row.getUserEmail().toLowerCase(Locale.ROOT).contains(q)
                            || row.getCourseNames().toLowerCase(Locale.ROOT).contains(q))
                    .collect(java.util.stream.Collectors.toCollection(ArrayList::new));
        }
        return result;
    }

    private AdminOrderRow toRow(Order order, String normalizedStatus) {
        String userName = "Unknown User";
        String userEmail = "-";
        if (order.getUser() != null) {
            if (order.getUser().getFullName() != null && !order.getUser().getFullName().isBlank()) {
                userName = order.getUser().getFullName();
            }
            if (order.getUser().getEmail() != null && !order.getUser().getEmail().isBlank()) {
                userEmail = order.getUser().getEmail();
            }
        }

        List<String> names = new ArrayList<>();
        if (order.getOrderDetails() != null) {
            for (OrderDetail detail : order.getOrderDetails()) {
                if (detail.getCourse() != null && detail.getCourse().getName() != null) {
                    names.add(detail.getCourse().getName());
                }
            }
        }
        String courseNames = names.isEmpty() ? "-" : String.join(", ", names);

        return new AdminOrderRow(
                order.getId(),
                userName,
                userEmail,
                courseNames,
                order.getTotalPrice(),
                normalizedStatus,
                order.getCreatedAt());
    }

    private String normalizeStatus(String status) {
        if (status == null || status.isBlank()) {
            return "PENDING_PAYMENT";
        }
        return status.trim().toUpperCase(Locale.ROOT).replace(' ', '_');
    }

    public static class AdminOrderRow {
        private final Long id;
        private final String userName;
        private final String userEmail;
        private final String courseNames;
        private final double totalPrice;
        private final String status;
        private final LocalDateTime createdAt;

        public AdminOrderRow(Long id, String userName, String userEmail, String courseNames, double totalPrice, String status,
                LocalDateTime createdAt) {
            this.id = id;
            this.userName = userName;
            this.userEmail = userEmail;
            this.courseNames = courseNames;
            this.totalPrice = totalPrice;
            this.status = status;
            this.createdAt = createdAt;
        }

        public Long getId() {
            return id;
        }

        public String getUserName() {
            return userName;
        }

        public String getUserEmail() {
            return userEmail;
        }

        public String getCourseNames() {
            return courseNames;
        }

        public double getTotalPrice() {
            return totalPrice;
        }

        public String getStatus() {
            return status;
        }

        public LocalDateTime getCreatedAt() {
            return createdAt;
        }

        public String getCreatedDateDisplay() {
            if (createdAt == null) {
                return "-";
            }
            return createdAt.format(DATE_FORMATTER);
        }

        public String getCreatedTimeDisplay() {
            if (createdAt == null) {
                return "-";
            }
            return createdAt.format(TIME_FORMATTER);
        }
    }
}
