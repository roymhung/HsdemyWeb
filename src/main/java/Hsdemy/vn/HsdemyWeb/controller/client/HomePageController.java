package Hsdemy.vn.HsdemyWeb.controller.client;

import java.util.List;
import java.util.ArrayList;
import java.util.Set;
import java.util.HashSet;
import java.util.Map;
import java.util.Locale;

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
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;

@Controller
public class HomePageController {
    private static final int COURSES_PER_PAGE = 9;

    private final CourseService courseService;
    private final UserService userService;

    public HomePageController(CourseService courseService, UserService userService) {
        this.courseService = courseService;
        this.userService = userService;
    }

    @GetMapping("/")
    public String getHomePage(
            @RequestParam(value = "q", required = false) String keyword,
            HttpServletResponse response,
            Model model) {
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        List<Course> courses = this.courseService.searchCourses(keyword);
        model.addAttribute("courses", courses);
        model.addAttribute("searchKeyword", keyword == null ? "" : keyword.trim());
        model.addAttribute("searchMode", keyword != null && !keyword.isBlank());
        return "client/homepage/show";
    }

    @GetMapping("/courses")
    public String getCoursesPage(
            @RequestParam(value = "q", required = false) String keyword,
            @RequestParam(value = "level", required = false) String level,
            @RequestParam(value = "title", required = false) String title,
            @RequestParam(value = "priceRange", required = false, defaultValue = "ALL") String priceRange,
            @RequestParam(value = "sort", defaultValue = "newest") String sort,
            @RequestParam(value = "page", defaultValue = "1") int page,
            HttpServletResponse response,
            Model model) {
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        List<Course> filteredCourses = new ArrayList<>(courseService.filterCourses(keyword, level, title, priceRange, sort));

        int totalItems = filteredCourses.size();
        int totalPages = Math.max(1, (int) Math.ceil((double) totalItems / COURSES_PER_PAGE));
        int currentPage = Math.max(1, Math.min(page, totalPages));

        int fromIndex = (currentPage - 1) * COURSES_PER_PAGE;
        int toIndex = Math.min(fromIndex + COURSES_PER_PAGE, totalItems);
        List<Course> pageCourses = fromIndex >= toIndex ? List.of() : filteredCourses.subList(fromIndex, toIndex);

        model.addAttribute("courses", pageCourses);
        model.addAttribute("totalItems", totalItems);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("selectedKeyword", keyword == null ? "" : keyword.trim());
        model.addAttribute("selectedLevel",
                level == null || level.isBlank() ? "" : level.trim().toUpperCase(Locale.ROOT));
        model.addAttribute("selectedTitle", title == null ? "" : title.trim());
        model.addAttribute("selectedPriceRange",
                priceRange == null || priceRange.isBlank() ? "ALL" : priceRange.trim().toUpperCase());
        model.addAttribute("selectedSort", sort);
        model.addAttribute("levels", courseService.getDistinctLevels());
        model.addAttribute("titles", courseService.getDistinctTitles());
        return "client/course/show";
    }

    @GetMapping("/learning-path")
    public String getLearningPathPage() {
        return "client/homepage/learning-path";
    }

    @GetMapping("/about-us")
    public String getAboutUsPage() {
        return "client/homepage/about-us";
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

    @GetMapping("/api/courses/active-ids")
    @ResponseBody
    public ActiveCourseIdsResponse getActiveCourseIds(
            @RequestParam(value = "ids", required = false) List<Long> ids) {
        List<Long> activeIds = courseService.getActiveCourseIds(ids == null ? List.of() : ids);
        return new ActiveCourseIdsResponse(new HashSet<>(activeIds));
    }

    @GetMapping("/api/courses/cart-details")
    @ResponseBody
    public CartCourseDetailsResponse getCartCourseDetails(
            @RequestParam(value = "ids", required = false) List<Long> ids) {
        Map<Long, Course> activeCourses = courseService.getActiveCourseMapByIds(ids == null ? List.of() : ids);
        List<CartCourseItem> courses = activeCourses.values().stream()
                .map(course -> new CartCourseItem(
                        course.getId(),
                        course.getName(),
                        course.getAuthor() == null ? "" : course.getAuthor(),
                        course.getLevel() == null ? "" : course.getLevel(),
                        course.getPrice(),
                        course.getThumbnail() == null ? "" : course.getThumbnail()))
                .toList();
        return new CartCourseDetailsResponse(courses);
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

    @GetMapping("/access-denied")
    public String getAccessDeniedPage() {
        return "client/error/access-denied";
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

    public static class ActiveCourseIdsResponse {
        private final Set<Long> activeIds;

        public ActiveCourseIdsResponse(Set<Long> activeIds) {
            this.activeIds = activeIds;
        }

        public Set<Long> getActiveIds() {
            return activeIds;
        }
    }

    public static class CartCourseDetailsResponse {
        private final List<CartCourseItem> courses;

        public CartCourseDetailsResponse(List<CartCourseItem> courses) {
            this.courses = courses;
        }

        public List<CartCourseItem> getCourses() {
            return courses;
        }
    }

    public static class CartCourseItem {
        private final Long id;
        private final String name;
        private final String author;
        private final String level;
        private final double price;
        private final String thumbnail;

        public CartCourseItem(Long id, String name, String author, String level, double price, String thumbnail) {
            this.id = id;
            this.name = name;
            this.author = author;
            this.level = level;
            this.price = price;
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

        public String getLevel() {
            return level;
        }

        public double getPrice() {
            return price;
        }

        public String getThumbnail() {
            return thumbnail;
        }
    }
}
