package Hsdemy.vn.HsdemyWeb.controller.client;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import Hsdemy.vn.HsdemyWeb.domain.Course;
import Hsdemy.vn.HsdemyWeb.domain.User;
import Hsdemy.vn.HsdemyWeb.domain.dto.RegisterDTO;
import Hsdemy.vn.HsdemyWeb.domain.dto.ResetPasswordDTO;
import Hsdemy.vn.HsdemyWeb.service.CourseService;
import Hsdemy.vn.HsdemyWeb.service.UserService;
import jakarta.validation.Valid;

@Controller
public class HomePageController {

    private final CourseService courseService;
    private final UserService userService;

    public HomePageController(CourseService courseService, UserService userService) {
        this.courseService = courseService;
        this.userService = userService;
    }

    @GetMapping("/")
    public String getHomePage(Model model) {
        List<Course> courses = this.courseService.fetchCourses();
        model.addAttribute("courses", courses);
        return "client/homepage/show";
    }

    @GetMapping("/register")
    public String getRegisterPage(Model model) {
        model.addAttribute("registerUser", new RegisterDTO());
        return "client/auth/register";
    }

    @PostMapping("/register")
    public String handleRegister(@ModelAttribute("registerUser") @Valid RegisterDTO registerDTO,
            BindingResult bindingResult) {

        // validate
        if (bindingResult.hasErrors()) {
            return "client/auth/register";
        }
        //

        User user = this.userService.registerDTOtoUser(registerDTO);
        user.setRole(this.userService.getRoleByName("USER"));

        // save
        this.userService.handleSaveUser(user);
        return "redirect:/login";

    }

    @GetMapping("/login")
    public String getLoginPage(Model model) {
        return "client/auth/login";
    }

    @GetMapping("/forgot-password")
    public String getForgotPasswordPage(Model model) {
        model.addAttribute("resetPassword", new ResetPasswordDTO());
        return "client/auth/forgot-password";
    }

    @PostMapping("/forgot-password")
    public String handleForgotPassword(@ModelAttribute("resetPassword") @Valid ResetPasswordDTO resetPassword,
            BindingResult bindingResult) {

        if (!resetPassword.getPassword().equals(resetPassword.getConfirmPassword())) {
            bindingResult.rejectValue("confirmPassword", "password.mismatch", "Mat khau nhap lai khong khop");
        }

        if (!this.userService.checkEmailExist(resetPassword.getEmail())) {
            bindingResult.rejectValue("email", "email.notFound", "Email khong ton tai trong he thong");
        }

        if (bindingResult.hasErrors()) {
            return "client/auth/forgot-password";
        }

        this.userService.resetPasswordByEmail(resetPassword.getEmail(), resetPassword.getPassword());
        return "redirect:/login?resetSuccess";
    }
}
