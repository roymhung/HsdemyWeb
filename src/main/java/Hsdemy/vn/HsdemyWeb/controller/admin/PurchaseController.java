package Hsdemy.vn.HsdemyWeb.controller.admin;

import org.springframework.web.bind.annotation.GetMapping;

public class PurchaseController {

    @GetMapping("/admin/purchse")
    public String getDashboard() {
        return "admin/purchse/show";
    }
}
