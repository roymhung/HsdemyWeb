package Hsdemy.vn.HsdemyWeb.controller.admin;

import org.springframework.web.bind.annotation.GetMapping;

public class CourseController {

    @GetMapping("/admin/course")
    public String getDashboard() {
        return "admin/course/show";
    }
}
