package Hsdemy.vn.HsdemyWeb.controller.admin;

import org.springframework.web.bind.annotation.GetMapping;

public class DashboardController {
    @GetMapping("/admin")
    public String getDashboard() {
        return "admin/dashboard/show";
    }
}
