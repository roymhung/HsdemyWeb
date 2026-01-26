package Hsdemy.vn.HsdemyWeb.controller.client;

import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import Hsdemy.vn.HsdemyWeb.domain.Course;
import Hsdemy.vn.HsdemyWeb.domain.User;
import Hsdemy.vn.HsdemyWeb.domain.dto.RegisterDTO;
import Hsdemy.vn.HsdemyWeb.service.CourseService;
import Hsdemy.vn.HsdemyWeb.service.UserService;

@Controller
public class HomePageController {

    private final CourseService courseService;
    private final UserService userService;
    private final PasswordEncoder passwordEncoder;

    public HomePageController(CourseService courseService, PasswordEncoder passwordEncoder,
            UserService userService) {
        this.courseService = courseService;
        this.passwordEncoder = passwordEncoder;
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
    public String handleRegister(@ModelAttribute("registerUser") RegisterDTO registerDTO) {
        User user = this.userService.registerDTOtoUser(registerDTO);

        String hashPassword = this.passwordEncoder.encode(user.getPassword());
        user.setPassword(hashPassword);
        user.setRole(this.userService.getRoleByName("USER"));
        // save
        this.userService.handleSaveUser(user);
        return "redirect:/login";

    }

    @GetMapping("/login")
    public String getLoginPage(Model model) {
        return "client/auth/login";
    }
}
