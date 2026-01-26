package Hsdemy.vn.HsdemyWeb.controller.client;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import Hsdemy.vn.HsdemyWeb.domain.Course;
import Hsdemy.vn.HsdemyWeb.service.CourseService;

@Controller
public class CourseDetailController {

    private final CourseService courseService;

    public CourseDetailController(CourseService courseService) {
        this.courseService = courseService;
    }

    @GetMapping("/course/{id}")
    public String getCourseDetailPage(Model model, @PathVariable long id) {
        Course course = this.courseService.getCourseById(id);
        model.addAttribute("course", course);
        model.addAttribute("id", id);
        return "client/course/detail";
    }
}


