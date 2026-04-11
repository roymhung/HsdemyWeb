package Hsdemy.vn.HsdemyWeb.service;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import org.springframework.stereotype.Service;

import Hsdemy.vn.HsdemyWeb.domain.Course;
import Hsdemy.vn.HsdemyWeb.domain.Order;
import Hsdemy.vn.HsdemyWeb.domain.User;
import jakarta.servlet.http.HttpSession;

@Service
public class NotificationService {
    private static final DateTimeFormatter TIME_FMT = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
    private final OrderService orderService;
    private final CourseService courseService;

    public NotificationService(OrderService orderService, CourseService courseService) {
        this.orderService = orderService;
        this.courseService = courseService;
    }

    public List<NotificationItem> getNotificationsForUser(User user, HttpSession session) {
        if (user == null) {
            return List.of();
        }
        List<Order> orders = orderService.getOrdersByUserId(user.getId());
        List<Course> paidCourses = orderService.getPaidCoursesByUserId(user.getId());
        List<Course> allCourses = courseService.fetchCourses();

        Set<String> readIds = getReadIds(user, session);
        List<NotificationItem> items = new ArrayList<>();

        for (Order order : orders.stream().limit(5).toList()) {
            String status = normalizeStatus(order.getStatus());
            String id = "ORDER-" + order.getId() + "-" + status;
            String time = order.getCreatedAt() == null ? "Vừa xong" : order.getCreatedAt().format(TIME_FMT);
            if ("PAID".equals(status)) {
                items.add(new NotificationItem(
                        id,
                        "payment",
                        "Thanh toán thành công",
                        "Đơn #" + order.getId() + " đã thanh toán thành công lúc " + time + ".",
                        "/account/purchase-history",
                        order.getCreatedAt(),
                        readIds.contains(id)));
            } else if ("PENDING_PAYMENT".equals(status)) {
                items.add(new NotificationItem(
                        id,
                        "reminder",
                        "Đơn hàng đang chờ thanh toán",
                        "Đơn #" + order.getId() + " chưa hoàn tất. Hoàn tất sớm để không mất quyền truy cập khóa học.",
                        "/cart",
                        order.getCreatedAt(),
                        readIds.contains(id)));
            } else if ("FAILED".equals(status) || "CANCELLED".equals(status)) {
                items.add(new NotificationItem(
                        id,
                        "warning",
                        "Thanh toán chưa thành công",
                        "Đơn #" + order.getId() + " chưa thành công. Bạn có thể thử lại thanh toán.",
                        "/cart",
                        order.getCreatedAt(),
                        readIds.contains(id)));
            }
        }

        if (paidCourses.isEmpty()) {
            String id = "RECOMMEND-FIRST-COURSE";
            items.add(new NotificationItem(
                    id,
                    "tip",
                    "Gợi ý bắt đầu học",
                    "Bạn chưa sở hữu khóa học nào. Khám phá các khóa học phù hợp để bắt đầu lộ trình học.",
                    "/",
                    LocalDateTime.now().minusMinutes(5),
                    readIds.contains(id)));
        } else {
            String id = "STUDY-HABIT-" + paidCourses.size();
            items.add(new NotificationItem(
                    id,
                    "tip",
                    "Duy trì thói quen học tập",
                    "Bạn đã sở hữu " + paidCourses.size()
                            + " khóa học. Mỗi ngày học 20-30 phút để tăng tỷ lệ hoàn thành.",
                    "/home/my-courses/learning",
                    LocalDateTime.now().minusMinutes(2),
                    readIds.contains(id)));
        }

        if (isBlank(user.getPhone()) || isBlank(user.getAddress())) {
            String id = "PROFILE-COMPLETE";
            items.add(new NotificationItem(
                    id,
                    "profile",
                    "Hoàn thiện hồ sơ",
                    "Hồ sơ của bạn chưa đầy đủ. Cập nhật số điện thoại/địa chỉ để hỗ trợ thanh toán và CSKH tốt hơn.",
                    "/account/profile",
                    LocalDateTime.now().minusMinutes(1),
                    readIds.contains(id)));
        }

        NotificationItem rec = buildCategoryRecommendation(user, paidCourses, allCourses, readIds);
        if (rec != null) {
            items.add(rec);
        }

        items.sort(Comparator.comparing(NotificationItem::getCreatedAt, Comparator.nullsLast(Comparator.reverseOrder())));
        return items;
    }

    public int getUnreadCount(User user, HttpSession session) {
        return (int) getNotificationsForUser(user, session).stream().filter(item -> !item.isRead()).count();
    }

    public void markAsRead(User user, HttpSession session, String notificationId) {
        if (user == null || notificationId == null || notificationId.isBlank()) {
            return;
        }
        Set<String> readIds = getReadIds(user, session);
        readIds.add(notificationId);
        session.setAttribute(getSessionKey(user), readIds);
    }

    public void markAllAsRead(User user, HttpSession session) {
        if (user == null) {
            return;
        }
        List<NotificationItem> items = getNotificationsForUser(user, session);
        Set<String> readIds = getReadIds(user, session);
        for (NotificationItem item : items) {
            readIds.add(item.getId());
        }
        session.setAttribute(getSessionKey(user), readIds);
    }

    @SuppressWarnings("unchecked")
    private Set<String> getReadIds(User user, HttpSession session) {
        Object value = session.getAttribute(getSessionKey(user));
        if (value instanceof Set<?>) {
            return new HashSet<>((Set<String>) value);
        }
        return new HashSet<>();
    }

    private String getSessionKey(User user) {
        return "READ_NOTIFICATIONS_USER_" + user.getId();
    }

    private String normalizeStatus(String status) {
        if (status == null || status.isBlank()) {
            return "PENDING_PAYMENT";
        }
        return status.trim().toUpperCase(Locale.ROOT).replace(' ', '_');
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }

    private NotificationItem buildCategoryRecommendation(User user, List<Course> paidCourses, List<Course> allCourses,
            Set<String> readIds) {
        if (paidCourses.isEmpty() || allCourses.isEmpty()) {
            return null;
        }
        Map<String, Integer> categoryScore = new HashMap<>();
        Set<Long> ownedCourseIds = new HashSet<>();
        for (Course c : paidCourses) {
            if (c.getId() != null) {
                ownedCourseIds.add(c.getId());
            }
            String title = c.getTitle() == null ? "UNCATEGORIZED" : c.getTitle().trim().toUpperCase(Locale.ROOT);
            categoryScore.put(title, categoryScore.getOrDefault(title, 0) + 1);
        }
        String topCategory = categoryScore.entrySet().stream()
                .max(Map.Entry.comparingByValue())
                .map(Map.Entry::getKey)
                .orElse(null);
        if (topCategory == null) {
            return null;
        }

        Course suggestion = null;
        for (Course c : allCourses) {
            String title = c.getTitle() == null ? "UNCATEGORIZED" : c.getTitle().trim().toUpperCase(Locale.ROOT);
            if (title.equals(topCategory) && c.getId() != null && !ownedCourseIds.contains(c.getId())) {
                suggestion = c;
                break;
            }
        }
        if (suggestion == null) {
            return null;
        }

        String id = "RECOMMEND-" + user.getId() + "-" + suggestion.getId();
        return new NotificationItem(
                id,
                "recommendation",
                "Đề xuất khóa học cho bạn",
                "Dựa trên lịch sử học, bạn có thể quan tâm khóa \"" + suggestion.getName() + "\".",
                "/course/" + suggestion.getId(),
                LocalDateTime.now().minus(Duration.ofMinutes(3)),
                readIds.contains(id));
    }

    public static class NotificationItem {
        private final String id;
        private final String type;
        private final String title;
        private final String message;
        private final String actionUrl;
        private final LocalDateTime createdAt;
        private final boolean read;

        public NotificationItem(String id, String type, String title, String message, String actionUrl,
                LocalDateTime createdAt, boolean read) {
            this.id = id;
            this.type = type;
            this.title = title;
            this.message = message;
            this.actionUrl = actionUrl;
            this.createdAt = createdAt;
            this.read = read;
        }

        public String getId() {
            return id;
        }

        public String getType() {
            return type;
        }

        public String getTitle() {
            return title;
        }

        public String getMessage() {
            return message;
        }

        public String getActionUrl() {
            return actionUrl;
        }

        public LocalDateTime getCreatedAt() {
            return createdAt;
        }

        public boolean isRead() {
            return read;
        }
    }
}
