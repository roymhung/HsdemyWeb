package Hsdemy.vn.HsdemyWeb.config;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import Hsdemy.vn.HsdemyWeb.domain.User;
import Hsdemy.vn.HsdemyWeb.service.UserService;

@ControllerAdvice(annotations = Controller.class)
public class GlobalUserModelAdvice {

    private final UserService userService;

    public GlobalUserModelAdvice(UserService userService) {
        this.userService = userService;
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
}
