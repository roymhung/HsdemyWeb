package Hsdemy.vn.HsdemyWeb.controller.client;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import Hsdemy.vn.HsdemyWeb.domain.Course;
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
}
