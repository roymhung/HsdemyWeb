package Hsdemy.vn.HsdemyWeb.config;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import Hsdemy.vn.HsdemyWeb.domain.User;
import Hsdemy.vn.HsdemyWeb.service.NotificationService;
import Hsdemy.vn.HsdemyWeb.service.UserService;
import jakarta.servlet.http.HttpSession;

@ControllerAdvice(annotations = Controller.class)
public class GlobalUserModelAdvice {

    private final UserService userService;
    private final NotificationService notificationService;

    public GlobalUserModelAdvice(UserService userService, NotificationService notificationService) {
        this.userService = userService;
        this.notificationService = notificationService;
    }

    @ModelAttribute("loggedIn")
    public boolean addLoggedIn(Authentication authentication) {
        return authentication != null
                && authentication.isAuthenticated()
                && !"anonymousUser".equals(authentication.getName());
    }

    @ModelAttribute("currentUser")
    public User addCurrentUser(Authentication authentication) {
        if (authentication == null || !authentication.isAuthenticated()
                || "anonymousUser".equals(authentication.getName())) {
            return null;
        }
        return userService.getUserByEmail(authentication.getName());
    }

    @ModelAttribute("notificationUnreadCount")
    public int addNotificationUnreadCount(Authentication authentication, HttpSession session) {
        if (authentication == null || !authentication.isAuthenticated()
                || "anonymousUser".equals(authentication.getName())) {
            return 0;
        }
        User user = userService.getUserByEmail(authentication.getName());
        if (user == null) {
            return 0;
        }
        return notificationService.getUnreadCount(user, session);
    }
}
