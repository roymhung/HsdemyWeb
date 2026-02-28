package Hsdemy.vn.HsdemyWeb.controller.client;

import java.security.Principal;
import java.util.List;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import Hsdemy.vn.HsdemyWeb.domain.Course;
import Hsdemy.vn.HsdemyWeb.domain.Order;
import Hsdemy.vn.HsdemyWeb.domain.User;
import Hsdemy.vn.HsdemyWeb.service.NotificationService;
import Hsdemy.vn.HsdemyWeb.service.OrderService;
import Hsdemy.vn.HsdemyWeb.service.UploadService;
import Hsdemy.vn.HsdemyWeb.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class ClientAccountController {

    private final UserService userService;
    private final UploadService uploadService;
    private final OrderService orderService;
    private final NotificationService notificationService;

    public ClientAccountController(UserService userService, UploadService uploadService, OrderService orderService,
            NotificationService notificationService) {
        this.userService = userService;
        this.uploadService = uploadService;
        this.orderService = orderService;
        this.notificationService = notificationService;
    }

    @GetMapping("/home/my-courses/learning")
    public String getMyCoursesPage(Model model, Principal principal) {
        User currentUser = getCurrentUser(principal);
        if (currentUser == null) {
            return "redirect:/login";
        }
        List<Course> paidCourses = orderService.getPaidCoursesByUserId(currentUser.getId());
        model.addAttribute("courses", paidCourses);
        return "client/account/my-courses";
    }

    @GetMapping("/account/profile")
    public String getProfilePage(Model model, Principal principal) {
        User currentUser = getCurrentUser(principal);
        if (currentUser == null) {
            return "redirect:/login";
        }
        model.addAttribute("newUser", currentUser);
        return "client/account/profile";
    }

    @PostMapping("/account/profile/update")
    public String updateProfile(@ModelAttribute("newUser") User newUser,
            @RequestParam("avatarFile") MultipartFile avatarFile,
            HttpServletRequest request,
            HttpServletResponse response,
            Principal principal) {
        User currentUser = getCurrentUser(principal);
        if (currentUser == null) {
            return "redirect:/login";
        }

        boolean emailChanged = newUser.getEmail() != null
                && !newUser.getEmail().equalsIgnoreCase(currentUser.getEmail());

        userService.updateProfile(currentUser.getId(), newUser);
        User savedUser = userService.getUserById(currentUser.getId());

        if (savedUser != null && avatarFile != null && !avatarFile.isEmpty()) {
            uploadService.handleDeleteUploadFile(savedUser.getAvatar(), "avatar");
            String newAvatar = uploadService.handleSaveUploadFile(avatarFile, "avatar");
            savedUser.setAvatar(newAvatar);
            userService.handleSaveUser(savedUser);
        }

        if (emailChanged) {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            new SecurityContextLogoutHandler().logout(request, response, authentication);
            return "redirect:/login";
        }

        return "redirect:/account/profile";
    }

    @GetMapping("/account/purchase-history")
    public String getPurchaseHistoryPage(Model model, Principal principal) {
        User currentUser = getCurrentUser(principal);
        if (currentUser == null) {
            return "redirect:/login";
        }
        List<Order> orders = orderService.getOrdersByUserId(currentUser.getId());
        model.addAttribute("orders", orders);
        return "client/account/purchase-history";
    }

    @GetMapping("/cart")
    public String getCartPage() {
        return "client/account/cart";
    }

    @GetMapping("/notifications")
    public String getNotificationPage(Model model, Principal principal, HttpSession session) {
        User currentUser = getCurrentUser(principal);
        if (currentUser == null) {
            return "redirect:/login";
        }
        model.addAttribute("notifications", notificationService.getNotificationsForUser(currentUser, session));
        model.addAttribute("unreadCount", notificationService.getUnreadCount(currentUser, session));
        return "client/account/notifications";
    }

    @PostMapping("/notifications/read-all")
    public String markAllNotificationsAsRead(Principal principal, HttpSession session) {
        User currentUser = getCurrentUser(principal);
        if (currentUser == null) {
            return "redirect:/login";
        }
        notificationService.markAllAsRead(currentUser, session);
        return "redirect:/notifications";
    }

    @PostMapping("/notifications/{notificationId}/read")
    public String markNotificationAsRead(@PathVariable String notificationId, Principal principal, HttpSession session) {
        User currentUser = getCurrentUser(principal);
        if (currentUser == null) {
            return "redirect:/login";
        }
        notificationService.markAsRead(currentUser, session, notificationId);
        return "redirect:/notifications";
    }

    private User getCurrentUser(Principal principal) {
        if (principal == null) {
            return null;
        }
        return userService.getUserByEmail(principal.getName());
    }
}
