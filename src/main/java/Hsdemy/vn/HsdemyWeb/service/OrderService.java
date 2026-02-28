package Hsdemy.vn.HsdemyWeb.service;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import Hsdemy.vn.HsdemyWeb.domain.Course;
import Hsdemy.vn.HsdemyWeb.domain.Order;
import Hsdemy.vn.HsdemyWeb.domain.OrderDetail;
import Hsdemy.vn.HsdemyWeb.repository.OrderRepository;

@Service
public class OrderService {

    private final OrderRepository orderRepository;

    public OrderService(OrderRepository orderRepository) {
        this.orderRepository = orderRepository;
    }

    public List<Order> getOrdersByUserId(Long userId) {
        return orderRepository.findByUserIdOrderByCreatedAtDesc(userId);
    }

    public List<Course> getPaidCoursesByUserId(Long userId) {
        List<Order> orders = getOrdersByUserId(userId);
        Map<Long, Course> purchasedCourses = new LinkedHashMap<>();

        for (Order order : orders) {
            if (!isSuccessfulOrder(order)) {
                continue;
            }
            List<OrderDetail> details = order.getOrderDetails();
            if (details == null) {
                continue;
            }
            for (OrderDetail detail : details) {
                Course course = detail.getCourse();
                if (course != null && course.getId() != null && !purchasedCourses.containsKey(course.getId())) {
                    purchasedCourses.put(course.getId(), course);
                }
            }
        }
        return new ArrayList<>(purchasedCourses.values());
    }

    public boolean hasPurchasedCourse(Long userId, Long courseId) {
        if (userId == null || courseId == null) {
            return false;
        }
        return getPaidCoursesByUserId(userId).stream()
                .anyMatch(course -> course != null && course.getId() != null && course.getId().equals(courseId));
    }

    private boolean isSuccessfulOrder(Order order) {
        if (order == null || order.getStatus() == null) {
            return false;
        }
        String normalizedStatus = order.getStatus().trim().toUpperCase().replace(" ", "_");
        return normalizedStatus.contains("SUCCESS")
                || normalizedStatus.contains("PAID")
                || normalizedStatus.contains("COMPLETE")
                || normalizedStatus.contains("THANH_CONG")
                || normalizedStatus.contains("THANHCONG");
    }
}
