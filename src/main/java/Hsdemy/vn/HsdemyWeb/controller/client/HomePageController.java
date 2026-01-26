package Hsdemy.vn.HsdemyWeb.controller.client;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import Hsdemy.vn.HsdemyWeb.domain.Course;
import Hsdemy.vn.HsdemyWeb.domain.dto.RegisterDTO;
import Hsdemy.vn.HsdemyWeb.service.CourseService;

@Controller
public class HomePageController {

    private final CourseService courseService;

    public HomePageController(CourseService courseService) {
        this.courseService = courseService;
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
        return "client/auth/register";
    }

}
