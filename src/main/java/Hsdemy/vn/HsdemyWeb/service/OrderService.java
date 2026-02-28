package Hsdemy.vn.HsdemyWeb.service;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.time.LocalDateTime;

import org.springframework.stereotype.Service;

import Hsdemy.vn.HsdemyWeb.domain.Course;
import Hsdemy.vn.HsdemyWeb.domain.Order;
import Hsdemy.vn.HsdemyWeb.domain.OrderDetail;
import Hsdemy.vn.HsdemyWeb.domain.User;
import Hsdemy.vn.HsdemyWeb.repository.OrderDetailRepository;
import Hsdemy.vn.HsdemyWeb.repository.OrderRepository;

@Service
public class OrderService {

    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;

    public OrderService(OrderRepository orderRepository, OrderDetailRepository orderDetailRepository) {
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
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

    public Order createPendingOrderForCourse(User user, Course course) {
        Order order = new Order();
        order.setUser(user);
        order.setStatus("PENDING_PAYMENT");
        order.setTotalPrice(course.getPrice());
        order.setCreatedAt(LocalDateTime.now());
        Order savedOrder = orderRepository.save(order);

        OrderDetail detail = new OrderDetail();
        detail.setOrder(savedOrder);
        detail.setCourse(course);
        detail.setPrice(course.getPrice());
        orderDetailRepository.save(detail);

        return savedOrder;
    }

    public Order getOrderById(Long id) {
        return orderRepository.findById(id).orElse(null);
    }

    public void markOrderPaid(Long orderId) {
        Order order = getOrderById(orderId);
        if (order == null) {
            return;
        }
        order.setStatus("PAID");
        orderRepository.save(order);
    }

    public void markOrderFailed(Long orderId) {
        Order order = getOrderById(orderId);
        if (order == null) {
            return;
        }
        order.setStatus("FAILED");
        orderRepository.save(order);
    }

    public Long getFirstCourseIdInOrder(Long orderId) {
        if (orderId == null) {
            return null;
        }
        return orderDetailRepository.findFirstByOrderIdOrderByIdAsc(orderId)
                .map(OrderDetail::getCourse)
                .map(Course::getId)
                .orElse(null);
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
