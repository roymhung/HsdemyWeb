package Hsdemy.vn.HsdemyWeb.controller.client;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import Hsdemy.vn.HsdemyWeb.domain.Course;
import Hsdemy.vn.HsdemyWeb.domain.Order;
import Hsdemy.vn.HsdemyWeb.domain.User;
import Hsdemy.vn.HsdemyWeb.service.CourseService;
import Hsdemy.vn.HsdemyWeb.service.OrderService;
import Hsdemy.vn.HsdemyWeb.service.UserService;
import Hsdemy.vn.HsdemyWeb.service.VnpayService;
import jakarta.servlet.http.HttpServletRequest;

@Controller
public class PaymentController {

    private final CourseService courseService;
    private final UserService userService;
    private final OrderService orderService;
    private final VnpayService vnpayService;

    public PaymentController(CourseService courseService, UserService userService, OrderService orderService,
            VnpayService vnpayService) {
        this.courseService = courseService;
        this.userService = userService;
        this.orderService = orderService;
        this.vnpayService = vnpayService;
    }

    @GetMapping("/payment/checkout/{courseId}")
    public String checkoutPage(@PathVariable Long courseId, Model model, Principal principal) {
        Course course = courseService.getActiveCourseById(courseId);
        if (course == null) {
            return "redirect:/";
        }
        if (isFreeCourse(course)) {
            return "redirect:/learning/course/" + courseId;
        }
        if (principal == null) {
            return "redirect:/login";
        }

        boolean purchased = orderService.hasPurchasedCourse(getCurrentUser(principal).getId(), courseId);
        if (purchased) {
            return "redirect:/learning/course/" + courseId;
        }

        model.addAttribute("course", course);
        model.addAttribute("vnpayReady", vnpayService.isConfigured());
        return "client/course/checkout";
    }

    @GetMapping({"/payment/checkout", "/payment/checkout/"})
    public String checkoutPageByQuery(@RequestParam(value = "courseId", required = false) Long courseId) {
        if (courseId == null) {
            return "redirect:/";
        }
        return "redirect:/payment/checkout/" + courseId;
    }

    @PostMapping("/payment/vnpay/create")
    public String createVnpayPayment(@RequestParam("courseId") Long courseId, Principal principal,
            @RequestParam(value = "bankCode", required = false) String bankCode,
            @RequestParam(value = "language", required = false, defaultValue = "vn") String language,
            HttpServletRequest request) {
        if (principal == null) {
            return "redirect:/login";
        }
        Course course = courseService.getActiveCourseById(courseId);
        if (course == null) {
            return "redirect:/";
        }
        if (isFreeCourse(course)) {
            return "redirect:/learning/course/" + courseId;
        }
        if (!vnpayService.isConfigured()) {
            return "redirect:/payment/checkout/" + courseId + "?configError=true";
        }

        User currentUser = getCurrentUser(principal);
        if (currentUser == null) {
            return "redirect:/login";
        }

        Order order = orderService.createPendingOrderForCourse(currentUser, course);
        String payUrl = vnpayService.createPaymentUrl(order.getId(), Math.round(course.getPrice()),
                "Thanh toan khoa hoc #" + course.getId(), bankCode, language, request);
        return "redirect:" + payUrl;
    }

    @GetMapping("/payment/vnpay/quick/{courseId}")
    public String quickCreateVnpayPayment(@PathVariable Long courseId, Principal principal,
            HttpServletRequest request) {
        if (principal == null) {
            return "redirect:/login";
        }
        Course course = courseService.getActiveCourseById(courseId);
        if (course == null) {
            return "redirect:/";
        }
        if (isFreeCourse(course)) {
            return "redirect:/learning/course/" + courseId;
        }
        if (!vnpayService.isConfigured()) {
            return "redirect:/payment/checkout/" + courseId + "?configError=true";
        }
        User currentUser = getCurrentUser(principal);
        if (currentUser == null) {
            return "redirect:/login";
        }
        Order order = orderService.createPendingOrderForCourse(currentUser, course);
        String payUrl = vnpayService.createPaymentUrl(order.getId(), Math.round(course.getPrice()),
                "Thanh toan khoa hoc #" + course.getId(), null, "vn", request);
        return "redirect:" + payUrl;
    }

    @GetMapping("/payment/vnpay/quick/cart")
    public String quickCreateVnpayPaymentForCart(@RequestParam(value = "ids", required = false) List<Long> ids,
            Principal principal,
            HttpServletRequest request,
            RedirectAttributes redirectAttributes) {
        if (principal == null) {
            return "redirect:/login";
        }
        if (ids == null || ids.isEmpty()) {
            redirectAttributes.addFlashAttribute("flashType", "warning");
            redirectAttributes.addFlashAttribute("flashMessage", "Giỏ hàng đang trống.");
            return "redirect:/cart";
        }
        if (!vnpayService.isConfigured()) {
            redirectAttributes.addFlashAttribute("flashType", "warning");
            redirectAttributes.addFlashAttribute("flashMessage", "Cấu hình VNPAY chưa sẵn sàng.");
            return "redirect:/cart";
        }

        User currentUser = getCurrentUser(principal);
        if (currentUser == null) {
            return "redirect:/login";
        }

        Map<Long, Course> activeCourseMap = courseService.getActiveCourseMapByIds(ids);
        List<Course> paidCourses = new ArrayList<>();
        for (Long id : ids) {
            Course course = activeCourseMap.get(id);
            if (course == null) {
                continue;
            }
            if (orderService.hasPurchasedCourse(currentUser.getId(), course.getId())) {
                continue;
            }
            if (isFreeCourse(course)) {
                orderService.createFreeEnrollmentForCourse(currentUser, course);
            } else {
                paidCourses.add(course);
            }
        }

        if (paidCourses.isEmpty()) {
            redirectAttributes.addFlashAttribute("flashType", "success");
            redirectAttributes.addFlashAttribute("flashMessage",
                    "Không có khóa học trả phí trong giỏ. Các khóa miễn phí đã được ghi danh.");
            return "redirect:/home/my-courses/learning?payment=success";
        }

        Order order = orderService.createPendingOrderForCourses(currentUser, paidCourses);
        if (order == null) {
            redirectAttributes.addFlashAttribute("flashType", "danger");
            redirectAttributes.addFlashAttribute("flashMessage", "Không thể tạo đơn thanh toán. Vui lòng thử lại.");
            return "redirect:/cart";
        }

        String payUrl = vnpayService.createPaymentUrl(order.getId(), Math.round(order.getTotalPrice()),
                "Thanh toan gio hang " + paidCourses.size() + " khoa hoc", null, "vn", request);
        return "redirect:" + payUrl;
    }

    @GetMapping("/payment/vnpay-return")
    public String vnpayReturn(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        String txnRef = request.getParameter("vnp_TxnRef");
        String responseCode = request.getParameter("vnp_ResponseCode");
        String transStatus = request.getParameter("vnp_TransactionStatus");

        Long orderId = parseOrderId(txnRef);
        boolean validSign = vnpayService.verifyReturnSignature(request);
        boolean successCode = "00".equals(responseCode) && "00".equals(transStatus);
        boolean success = successCode && (validSign || vnpayService.isSandboxMode());
        if (orderId != null) {
            if (success) {
                orderService.markOrderPaid(orderId);
            } else {
                orderService.markOrderFailed(orderId);
            }
        }

        if (success) {
            List<Long> paidCourseIds = orderService.getCourseIdsInOrder(orderId);
            redirectAttributes.addFlashAttribute("flashType", "success");
            redirectAttributes.addFlashAttribute("flashMessage", "Thanh toán thành công. Bạn có thể vào học ngay.");
            return "redirect:/home/my-courses/learning?payment=success" + buildPaidCourseQuery(paidCourseIds);
        }

        if (successCode && !validSign) {
            redirectAttributes.addFlashAttribute("flashType", "warning");
            redirectAttributes.addFlashAttribute("flashMessage",
                    "Thanh toán đã được ghi nhận ở môi trường thử nghiệm, nhưng chữ ký phản hồi không hợp lệ.");
        } else {
            redirectAttributes.addFlashAttribute("flashType", "danger");
            redirectAttributes.addFlashAttribute("flashMessage",
                    "Thanh toán chưa thành công. Vui lòng thử lại hoặc chọn phương thức khác.");
        }
        if (orderId != null) {
            Long failedCourseId = orderService.getFirstCourseIdInOrder(orderId);
            if (failedCourseId != null) {
                return "redirect:/payment/checkout/" + failedCourseId;
            }
        }
        return "redirect:/account/purchase-history";
    }

    private User getCurrentUser(Principal principal) {
        if (principal == null) {
            return null;
        }
        return userService.getUserByEmail(principal.getName());
    }

    private Long parseOrderId(String txnRef) {
        if (txnRef == null || txnRef.isBlank()) {
            return null;
        }
        String[] parts = txnRef.split("-");
        try {
            return Long.parseLong(parts[0]);
        } catch (Exception e) {
            return null;
        }
    }

    private boolean isFreeCourse(Course course) {
        return course != null && course.getPrice() <= 0;
    }

    private String buildPaidCourseQuery(List<Long> paidCourseIds) {
        if (paidCourseIds == null || paidCourseIds.isEmpty()) {
            return "";
        }
        StringBuilder query = new StringBuilder();
        for (Long id : paidCourseIds) {
            if (id == null) {
                continue;
            }
            query.append("&paidCourseId=").append(id);
        }
        return query.toString();
    }
}
