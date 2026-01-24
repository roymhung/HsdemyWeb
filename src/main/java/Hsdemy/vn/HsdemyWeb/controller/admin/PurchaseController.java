package Hsdemy.vn.HsdemyWeb.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PurchaseController {

    @GetMapping("/admin/purchase")
    public String getDashboard() {
        return "admin/purchase/show";
    }
}
