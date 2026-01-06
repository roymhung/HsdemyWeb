package Hsdemy.vn.HsdemyWeb.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


// @RestController
// public class UserController {

// private UserService userService;


// public UserController(UserService userService) {
// this.userService = userService;
// }


// @GetMapping("")
// public String getHomePage() {
// return this.userService.handleHello();
// };
// }

@Controller
public class UserController {

    @RequestMapping("/")
    public String getHomePage() {
        return "hello";
    };
}

