package Hsdemy.vn.HsdemyWeb.controller.client;

import java.security.Principal;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
        Course course = courseService.getCourseById(courseId);
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
        Course course = courseService.getCourseById(courseId);
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
        Course course = courseService.getCourseById(courseId);
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

    @GetMapping("/payment/vnpay-return")
    public String vnpayReturn(HttpServletRequest request, Model model) {
        String txnRef = request.getParameter("vnp_TxnRef");
        String responseCode = request.getParameter("vnp_ResponseCode");
        String transStatus = request.getParameter("vnp_TransactionStatus");
        String amount = request.getParameter("vnp_Amount");

        Long orderId = parseOrderId(txnRef);
        boolean validSign = vnpayService.verifyReturnSignature(request);
        boolean success = validSign && "00".equals(responseCode) && "00".equals(transStatus);

        if (orderId != null) {
            if (success) {
                orderService.markOrderPaid(orderId);
            } else {
                orderService.markOrderFailed(orderId);
            }
        }

        model.addAttribute("success", success);
        model.addAttribute("orderId", orderId);
        model.addAttribute("purchasedCourseId",
                success ? orderService.getFirstCourseIdInOrder(orderId) : null);
        model.addAttribute("txnRef", txnRef);
        model.addAttribute("amount", amount == null ? "0" : amount);
        model.addAttribute("responseCode", responseCode);
        return "client/course/payment-result";
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
}
