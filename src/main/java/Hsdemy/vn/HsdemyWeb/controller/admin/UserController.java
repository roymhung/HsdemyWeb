package Hsdemy.vn.HsdemyWeb.controller.admin;


import java.util.Comparator;
import java.util.List;
import java.util.Locale;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import Hsdemy.vn.HsdemyWeb.domain.User;
import Hsdemy.vn.HsdemyWeb.service.UploadService;
import Hsdemy.vn.HsdemyWeb.service.UserService;



@Controller
public class UserController {
    private static final int USERS_PER_PAGE = 9;

    // DI : dependency injection
    private final UserService userService;
    private final UploadService uploadService;
    private final PasswordEncoder passwordEncoder;

    public UserController(UserService userService, UploadService uploadService,
            PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.uploadService = uploadService;
        this.passwordEncoder = passwordEncoder;
    }

    @RequestMapping("/")
    public String getHomePage(Model model) {
        List<User> arrUsers = this.userService.getAllUsersByEmail("h@gmail.com");
        System.out.println(arrUsers);
        model.addAttribute("roy", "test");
        model.addAttribute("hung", "haha2026");
        return "hello";
    }

    @RequestMapping("/admin/user")
    public String getUserPage(
            @RequestParam(value = "q", required = false) String keyword,
            @RequestParam(value = "role", required = false, defaultValue = "ALL") String roleFilter,
            @RequestParam(value = "page", defaultValue = "1") int page,
            Model model) {
        List<User> users = this.userService.getAllUsers();
        List<User> filteredUsers = users.stream()
                .filter(user -> {
                    if (roleFilter == null || roleFilter.equalsIgnoreCase("ALL")) {
                        return true;
                    }
                    return user.getRole() != null
                            && user.getRole().getName() != null
                            && user.getRole().getName().equalsIgnoreCase(roleFilter.trim());
                })
                .filter(user -> {
                    if (keyword == null || keyword.isBlank()) {
                        return true;
                    }
                    String q = keyword.trim().toLowerCase(Locale.ROOT);
                    String email = user.getEmail() == null ? "" : user.getEmail().toLowerCase(Locale.ROOT);
                    String fullName = user.getFullName() == null ? "" : user.getFullName().toLowerCase(Locale.ROOT);
                    String phone = user.getPhone() == null ? "" : user.getPhone().toLowerCase(Locale.ROOT);
                    return email.contains(q) || fullName.contains(q) || phone.contains(q)
                            || String.valueOf(user.getId()).contains(q);
                })
                .sorted(Comparator.comparingLong(User::getId))
                .toList();

        int totalUsers = users.size();
        int adminUsers = (int) users.stream()
                .filter(user -> user.getRole() != null && "ADMIN".equalsIgnoreCase(user.getRole().getName()))
                .count();
        int learnerUsers = totalUsers - adminUsers;

        List<String> roleOptions = users.stream()
                .filter(user -> user.getRole() != null && user.getRole().getName() != null)
                .map(user -> user.getRole().getName().toUpperCase(Locale.ROOT))
                .distinct()
                .sorted()
                .toList();

        int totalFiltered = filteredUsers.size();
        int totalPages = Math.max(1, (int) Math.ceil((double) totalFiltered / USERS_PER_PAGE));
        int currentPage = Math.max(1, Math.min(page, totalPages));
        int fromIndex = (currentPage - 1) * USERS_PER_PAGE;
        int toIndex = Math.min(fromIndex + USERS_PER_PAGE, totalFiltered);
        List<User> pageUsers = fromIndex >= toIndex ? List.of() : filteredUsers.subList(fromIndex, toIndex);

        model.addAttribute("users1", pageUsers);
        model.addAttribute("keyword", keyword == null ? "" : keyword.trim());
        model.addAttribute("selectedRole", roleFilter == null ? "ALL" : roleFilter.toUpperCase(Locale.ROOT));
        model.addAttribute("roleOptions", roleOptions);
        model.addAttribute("totalUsers", totalUsers);
        model.addAttribute("adminUsers", adminUsers);
        model.addAttribute("learnerUsers", learnerUsers);
        model.addAttribute("filteredUsers", totalFiltered);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalPages", totalPages);
        return "admin/user/show";
    }

    @RequestMapping("/admin/user/{id}")
    public String getUserDetailPage(Model model, @PathVariable long id) {
        User user = this.userService.getUserById(id);
        model.addAttribute("user", user);
        return "admin/user/detail";
    }


    @RequestMapping("/admin/user/create") // GET
    public String getCreateUserPage(Model model) {
        model.addAttribute("newUser", new User());
        return "admin/user/create";
    }

    @PostMapping("/admin/user/create")
    public String createUserPage(Model model, @ModelAttribute("newUser") @Validated User royhung,
            BindingResult newUserBindingResult, @RequestParam("hungFile") MultipartFile file) {

        // validate
        List<FieldError> errors = newUserBindingResult.getFieldErrors();
        for (FieldError error : errors) {
            System.out.println(error.getField() + " - " + error.getDefaultMessage());
        }

        if (newUserBindingResult.hasErrors()) {
            return "admin/user/create";
        }
        //

        String avatar = this.uploadService.handleSaveUploadFile(file, "avatar");
        String hashPassword = this.passwordEncoder.encode(royhung.getPassword());
        royhung.setAvatar(avatar);
        royhung.setPassword(hashPassword);
        royhung.setRole(this.userService.getRoleByName(royhung.getRole().getName()));
        this.userService.handleSaveUser(royhung);
        return "redirect:/admin/user";
    }

    @RequestMapping("/admin/user/update/{id}")
    public String getUpdateUserPage(Model model, @PathVariable long id) {
        User currentUser = this.userService.getUserById(id);
        model.addAttribute("newUser", currentUser);
        return "admin/user/update";
    }

    @PostMapping("admin/user/update")
    public String postUpdateUser(Model model, @ModelAttribute("newUser") User royhung,
            @RequestParam("hungFile") MultipartFile file) {
        User currentUser = this.userService.getUserById(royhung.getId());

        if (currentUser != null) {

            // update info
            currentUser.setAddress(royhung.getAddress());
            currentUser.setFullName(royhung.getFullName());
            currentUser.setPhone(royhung.getPhone());

            // CHỈ xử lý avatar khi user upload file mới
            if (file != null && !file.isEmpty()) {

                // 1. xoá avatar cũ
                this.uploadService.handleDeleteUploadFile(currentUser.getAvatar(), "avatar");

                // 2. lưu avatar mới
                String newAvatar = this.uploadService.handleSaveUploadFile(file, "avatar");
                currentUser.setAvatar(newAvatar);
            }

            // role
            currentUser.setRole(this.userService.getRoleByName(currentUser.getRole().getName()));

            this.userService.handleSaveUser(currentUser);
        }
        return "redirect:/admin/user";
    }

    @GetMapping("/admin/user/delete/{id}")
    public String getDeleteUserPage(Model model, @PathVariable long id) {
        model.addAttribute("id", id);
        // User user = new User();
        // user.setId(id);
        // model.addAttribute("newUser", user);
        model.addAttribute("newUser", new User());
        return "admin/user/delete";
    }


    @PostMapping("/admin/user/delete")
    public String postDeleteUser(Model model, @ModelAttribute("newUser") User royhung1) {
        System.out.println("run here");
        this.userService.deleteAUser(royhung1.getId());
        return "redirect:/admin/user";
    }

}


