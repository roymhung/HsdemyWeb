package Hsdemy.vn.HsdemyWeb.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import Hsdemy.vn.HsdemyWeb.service.UserService;


@Controller
public class UserController {

    private UserService userService;


    public UserController(UserService userService) {
        this.userService = userService;
    }

    @RequestMapping("/") // user: vao website
    public String getHomePage(Model model) {// controller
        String test = this.userService.handleHello();// model: goi toi model xu ly du lieu
        model.addAttribute("roy", test); // sau khi model co data gui lai cho controller
        model.addAttribute("royhung", "test h2 from controller with model"); // controller xu li
                                                                             // data roi gui lai cho
                                                                             // view
        return "hello"; // view: render ra du lieu roi gui lai cho user
    };
}

