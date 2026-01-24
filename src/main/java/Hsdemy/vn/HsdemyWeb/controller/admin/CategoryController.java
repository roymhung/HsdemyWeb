package Hsdemy.vn.HsdemyWeb.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CategoryController {

    @GetMapping("/admin/category")
    public String getDashboard() {
        return "admin/category/show";
    }
}
