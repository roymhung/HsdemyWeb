package Hsdemy.vn.HsdemyWeb.controller.client;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import Hsdemy.vn.HsdemyWeb.domain.Course;
import Hsdemy.vn.HsdemyWeb.domain.User;
import Hsdemy.vn.HsdemyWeb.domain.dto.RegisterDTO;
import Hsdemy.vn.HsdemyWeb.domain.dto.ResetPasswordDTO;
import Hsdemy.vn.HsdemyWeb.service.CourseService;
import Hsdemy.vn.HsdemyWeb.service.UserService;
import jakarta.validation.Valid;

@Controller
public class HomePageController {

    private final CourseService courseService;
    private final UserService userService;

    public HomePageController(CourseService courseService, UserService userService) {
        this.courseService = courseService;
        this.userService = userService;
    }

    @GetMapping("/")
    public String getHomePage(
            @RequestParam(value = "q", required = false) String keyword,
            Model model) {
        List<Course> courses = this.courseService.searchCourses(keyword);
        model.addAttribute("courses", courses);
        model.addAttribute("searchKeyword", keyword == null ? "" : keyword.trim());
        model.addAttribute("searchMode", keyword != null && !keyword.isBlank());
        return "client/homepage/show";
    }

    @GetMapping("/api/search/suggestions")
    @ResponseBody
    public SearchSuggestionResponse getSearchSuggestions(
            @RequestParam(value = "q", required = false) String keyword) {
        String q = keyword == null ? "" : keyword.trim();
        if (q.isBlank()) {
            return new SearchSuggestionResponse(q, List.of(), List.of(), List.of());
        }

        List<String> keywords = List.of(
                "khóa học " + q,
                q + " cơ bản",
                q + " nâng cao",
                "học " + q + " online",
                q + " cho người mới");

        List<SearchCourseItem> courses = courseService.suggestCourses(q, 5).stream()
                .map(course -> new SearchCourseItem(
                        course.getId(),
                        course.getName(),
                        course.getAuthor() == null ? "Giảng viên" : course.getAuthor(),
                        course.getThumbnail()))
                .toList();

        List<String> authors = courseService.suggestAuthors(q, 3);

        return new SearchSuggestionResponse(q, keywords, courses, authors);
    }

    @GetMapping("/register")
    public String getRegisterPage(Model model) {
        model.addAttribute("registerUser", new RegisterDTO());
        return "client/auth/register";
    }

    @PostMapping("/register")
    public String handleRegister(@ModelAttribute("registerUser") @Valid RegisterDTO registerDTO,
            BindingResult bindingResult) {

        // validate
        if (bindingResult.hasErrors()) {
            return "client/auth/register";
        }
        //

        User user = this.userService.registerDTOtoUser(registerDTO);
        user.setRole(this.userService.getRoleByName("USER"));

        // save
        this.userService.handleSaveUser(user);
        return "redirect:/login";

    }

    @GetMapping("/login")
    public String getLoginPage(Model model) {
        return "client/auth/login";
    }

    @GetMapping("/forgot-password")
    public String getForgotPasswordPage(Model model) {
        model.addAttribute("resetPassword", new ResetPasswordDTO());
        return "client/auth/forgot-password";
    }

    @PostMapping("/forgot-password")
    public String handleForgotPassword(@ModelAttribute("resetPassword") @Valid ResetPasswordDTO resetPassword,
            BindingResult bindingResult) {

        if (!resetPassword.getPassword().equals(resetPassword.getConfirmPassword())) {
            bindingResult.rejectValue("confirmPassword", "password.mismatch", "Mat khau nhap lai khong khop");
        }

        if (!this.userService.checkEmailExist(resetPassword.getEmail())) {
            bindingResult.rejectValue("email", "email.notFound", "Email khong ton tai trong he thong");
        }

        if (bindingResult.hasErrors()) {
            return "client/auth/forgot-password";
        }

        this.userService.resetPasswordByEmail(resetPassword.getEmail(), resetPassword.getPassword());
        return "redirect:/login?resetSuccess";
    }

    public static class SearchSuggestionResponse {
        private final String query;
        private final List<String> keywords;
        private final List<SearchCourseItem> courses;
        private final List<String> authors;

        public SearchSuggestionResponse(String query, List<String> keywords, List<SearchCourseItem> courses,
                List<String> authors) {
            this.query = query;
            this.keywords = keywords;
            this.courses = courses;
            this.authors = authors;
        }

        public String getQuery() {
            return query;
        }

        public List<String> getKeywords() {
            return keywords;
        }

        public List<SearchCourseItem> getCourses() {
            return courses;
        }

        public List<String> getAuthors() {
            return authors;
        }
    }

    public static class SearchCourseItem {
        private final Long id;
        private final String name;
        private final String author;
        private final String thumbnail;

        public SearchCourseItem(Long id, String name, String author, String thumbnail) {
            this.id = id;
            this.name = name;
            this.author = author;
            this.thumbnail = thumbnail;
        }

        public Long getId() {
            return id;
        }

        public String getName() {
            return name;
        }

        public String getAuthor() {
            return author;
        }

        public String getThumbnail() {
            return thumbnail;
        }
    }
}
