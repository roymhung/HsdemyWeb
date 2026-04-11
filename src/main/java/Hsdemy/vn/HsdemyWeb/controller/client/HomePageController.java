package Hsdemy.vn.HsdemyWeb.controller.client;

import java.util.List;
import java.util.ArrayList;
import java.util.Set;
import java.util.HashSet;
import java.util.HashMap;
import java.util.Map;
import java.util.LinkedHashSet;
import java.util.Comparator;
import java.util.Locale;
import java.util.stream.Collectors;
import java.security.Principal;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import Hsdemy.vn.HsdemyWeb.domain.Course;
import Hsdemy.vn.HsdemyWeb.domain.Order;
import Hsdemy.vn.HsdemyWeb.domain.OrderDetail;
import Hsdemy.vn.HsdemyWeb.domain.User;
import Hsdemy.vn.HsdemyWeb.domain.dto.RegisterDTO;
import Hsdemy.vn.HsdemyWeb.domain.dto.ResetPasswordDTO;
import Hsdemy.vn.HsdemyWeb.service.CourseService;
import Hsdemy.vn.HsdemyWeb.service.LessonService;
import Hsdemy.vn.HsdemyWeb.service.OpenAiAdvisorService;
import Hsdemy.vn.HsdemyWeb.service.OrderService;
import Hsdemy.vn.HsdemyWeb.service.UserService;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class HomePageController {
    private static final int COURSES_PER_PAGE = 9;
    private static final String ADVISOR_HISTORY_SESSION_KEY = "advisorChatHistory";
    private static final int ADVISOR_MAX_HISTORY_MESSAGES = 10;

    private final CourseService courseService;
    private final UserService userService;
    private final OrderService orderService;
    private final LessonService lessonService;
    private final OpenAiAdvisorService openAiAdvisorService;

    public HomePageController(
            CourseService courseService,
            UserService userService,
            OrderService orderService,
            LessonService lessonService,
            OpenAiAdvisorService openAiAdvisorService) {
        this.courseService = courseService;
        this.userService = userService;
        this.orderService = orderService;
        this.lessonService = lessonService;
        this.openAiAdvisorService = openAiAdvisorService;
    }

    @GetMapping("/")
    public String getHomePage(
            @RequestParam(value = "q", required = false) String keyword,
            Principal principal,
            HttpServletResponse response,
            Model model) {
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        List<Course> courses = this.courseService.searchCourses(keyword);
        Set<Long> enrolledCourseIds = new HashSet<>();
        if (principal != null && principal.getName() != null && !principal.getName().isBlank()) {
            User currentUser = userService.getUserByEmail(principal.getName());
            if (currentUser != null) {
                enrolledCourseIds = orderService.getPaidCoursesByUserId(currentUser.getId()).stream()
                        .map(Course::getId)
                        .filter(id -> id != null)
                        .collect(Collectors.toSet());
            }
        }
        model.addAttribute("courses", courses);
        model.addAttribute("enrolledCourseIds", enrolledCourseIds);
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
            @RequestParam(value = "ids", required = false) List<Long> ids,
            Principal principal) {
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

        Set<Long> purchasedIds = new HashSet<>();
        if (principal != null && principal.getName() != null && !principal.getName().isBlank()) {
            User currentUser = userService.getUserByEmail(principal.getName());
            if (currentUser != null) {
                purchasedIds = orderService.getPaidCoursesByUserId(currentUser.getId()).stream()
                        .map(Course::getId)
                        .filter(id -> id != null)
                        .collect(Collectors.toSet());
            }
        }

        return new CartCourseDetailsResponse(courses, purchasedIds);
    }

    @GetMapping("/api/chat/course-advisor")
    @ResponseBody
    public CourseAdvisorResponse getCourseAdvisorResponse(
            @RequestParam(value = "message", required = false) String message,
            Principal principal,
            HttpSession session) {
        try {
            String normalizedMessage = message == null ? "" : message.trim();
            List<Course> activeCourses = courseService.fetchCourses();

            final Set<Long> enrolledIds = new HashSet<>();
            if (principal != null && principal.getName() != null && !principal.getName().isBlank()) {
                User currentUser = userService.getUserByEmail(principal.getName());
                if (currentUser != null) {
                    enrolledIds.addAll(orderService.getPaidCoursesByUserId(currentUser.getId()).stream()
                            .map(Course::getId)
                            .filter(id -> id != null)
                            .collect(Collectors.toSet()));
                }
            }

            if (activeCourses.isEmpty()) {
                return new CourseAdvisorResponse(
                        "Hiện tại chưa có khóa học phù hợp trong hệ thống. Bạn thử lại sau nhé.",
                        List.of());
            }

            Set<String> keywords = extractAdvisorKeywords(normalizedMessage);
            boolean freeOnly = containsAny(normalizedMessage, "miễn phí", "free", "0đ", "0 đ", "khong mat phi");
            boolean paidOnly = containsAny(normalizedMessage, "có phí", "trả phí", "mua");
            String wantedLevel = detectWantedLevel(normalizedMessage);
            boolean askChinesePath = containsAny(normalizedMessage, "tiếng trung", "tieng trung", "hsk", "chinese",
                    "trung van", "hán ngữ", "han ngu", "hoa ngu");
            boolean askJapanesePath = containsAny(normalizedMessage, "tiếng nhật", "tieng nhat", "jlpt", "japanese",
                    "nihongo", "n5", "n4", "n3", "n2", "n1");
            boolean askTopPurchased = containsAny(normalizedMessage, "mua nhiều nhất", "mua nhieu nhat", "phổ biến nhất",
                    "pho bien nhat", "top khóa", "top khoa", "bán chạy", "ban chay");
            boolean askMostVideos = containsAny(normalizedMessage, "nhiều video nhất", "nhieu video nhat",
                    "nhiều bài học nhất", "nhieu bai hoc nhat", "nhiều lesson nhất", "nhieu lesson nhat");

            List<Course> candidateCourses = activeCourses.stream()
                    .filter(course -> askMostVideos || !enrolledIds.contains(course.getId()))
                    .filter(course -> !freeOnly || course.getPrice() <= 0)
                    .filter(course -> !paidOnly || course.getPrice() > 0)
                    .filter(course -> wantedLevel.isBlank()
                            || normalizeLevelCode(course.getLevel()).equals(wantedLevel))
                    .toList();

            if (askChinesePath) {
                candidateCourses = candidateCourses.stream()
                        .filter(this::isChineseCourse)
                        .toList();
            } else if (askJapanesePath) {
                candidateCourses = candidateCourses.stream()
                        .filter(this::isJapaneseCourse)
                        .toList();
            }

            List<Course> recommended;
            if (askMostVideos) {
                Map<Long, Integer> videoCountMap = lessonService.getVideoCountMapByCourseIds(
                        candidateCourses.stream()
                                .map(Course::getId)
                                .filter(id -> id != null)
                                .toList());
                recommended = getTopVideoCourses(candidateCourses, 3, videoCountMap);
            } else if (askTopPurchased) {
                recommended = getTopPurchasedCourses(candidateCourses, enrolledIds, 3);
            } else {
                recommended = candidateCourses.stream()
                    .sorted(Comparator
                            .comparingInt((Course c) -> calculateAdvisorScore(c, keywords, normalizedMessage)).reversed()
                            .thenComparing(Course::getCreatedAt, Comparator.nullsLast(Comparator.reverseOrder())))
                    .limit(3)
                    .toList();
            }

            if (recommended.isEmpty()) {
                List<Course> fallbackPool;
                if (askChinesePath) {
                    fallbackPool = activeCourses.stream().filter(this::isChineseCourse).toList();
                } else if (askJapanesePath) {
                    fallbackPool = activeCourses.stream().filter(this::isJapaneseCourse).toList();
                } else {
                    fallbackPool = activeCourses;
                }
                if (askMostVideos) {
                    Map<Long, Integer> fallbackVideoCountMap = lessonService.getVideoCountMapByCourseIds(
                            fallbackPool.stream()
                                    .map(Course::getId)
                                    .filter(id -> id != null)
                                    .toList());
                    recommended = getTopVideoCourses(fallbackPool, 3, fallbackVideoCountMap);
                } else {
                    recommended = fallbackPool.stream()
                            .filter(course -> !enrolledIds.contains(course.getId()))
                            .sorted(Comparator.comparing(Course::getCreatedAt, Comparator.nullsLast(Comparator.reverseOrder())))
                            .limit(3)
                            .toList();
                }
            }

            List<CourseAdvisorItem> suggestions = recommended.stream()
                    .map(course -> new CourseAdvisorItem(
                            course.getId(),
                            course.getName(),
                            course.getAuthor() == null ? "Giảng viên" : course.getAuthor(),
                            normalizeLevelLabel(course.getLevel()),
                            course.getPrice(),
                            course.getThumbnail() == null ? "" : course.getThumbnail(),
                            "/course/" + course.getId()))
                    .toList();
            Map<Long, Integer> recommendedVideoCountMap = askMostVideos
                    ? lessonService.getVideoCountMapByCourseIds(
                            recommended.stream()
                                    .map(Course::getId)
                                    .filter(id -> id != null)
                                    .toList())
                    : Map.of();

            String fallbackReply;
            if (askChinesePath) {
                fallbackReply = buildChineseRoadmapReply(askTopPurchased || askMostVideos, !suggestions.isEmpty());
            } else if (askJapanesePath) {
                fallbackReply = buildJapaneseRoadmapReply(askTopPurchased || askMostVideos, !suggestions.isEmpty());
            } else if (askMostVideos) {
                fallbackReply = buildTopVideoReply(recommended, recommendedVideoCountMap);
            } else if (askTopPurchased) {
                fallbackReply = "Đây là các khóa học được mua nhiều nhất hiện tại (dựa trên dữ liệu đơn hàng thật):";
            } else {
                fallbackReply = buildAdvisorReply(normalizedMessage, suggestions);
            }

            List<OpenAiAdvisorService.ChatMessage> chatHistory = getAdvisorChatHistory(session);
            String context = buildAdvisorContextForLlm(
                    normalizedMessage,
                    suggestions,
                    askChinesePath,
                    askJapanesePath,
                    askTopPurchased,
                    askMostVideos);
            String reply = openAiAdvisorService.generateAdvisorReply(
                    normalizedMessage,
                    context,
                    chatHistory,
                    fallbackReply);
            appendAdvisorHistory(session, normalizedMessage, reply);

            return new CourseAdvisorResponse(reply, suggestions);
        } catch (Exception ex) {
            return new CourseAdvisorResponse(
                    "Mình đang xử lý nhiều yêu cầu cùng lúc. Bạn thử lại sau ít giây nhé.",
                    List.of());
        }
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
        private final Set<Long> purchasedIds;

        public CartCourseDetailsResponse(List<CartCourseItem> courses, Set<Long> purchasedIds) {
            this.courses = courses;
            this.purchasedIds = purchasedIds == null ? Set.of() : purchasedIds;
        }

        public List<CartCourseItem> getCourses() {
            return courses;
        }

        public Set<Long> getPurchasedIds() {
            return purchasedIds;
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

    public static class CourseAdvisorResponse {
        private final String reply;
        private final List<CourseAdvisorItem> suggestions;

        public CourseAdvisorResponse(String reply, List<CourseAdvisorItem> suggestions) {
            this.reply = reply;
            this.suggestions = suggestions == null ? List.of() : suggestions;
        }

        public String getReply() {
            return reply;
        }

        public List<CourseAdvisorItem> getSuggestions() {
            return suggestions;
        }
    }

    public static class CourseAdvisorItem {
        private final Long id;
        private final String name;
        private final String author;
        private final String level;
        private final double price;
        private final String thumbnail;
        private final String url;

        public CourseAdvisorItem(Long id, String name, String author, String level, double price, String thumbnail, String url) {
            this.id = id;
            this.name = name;
            this.author = author;
            this.level = level;
            this.price = price;
            this.thumbnail = thumbnail;
            this.url = url;
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

        public String getUrl() {
            return url;
        }
    }

    private Set<String> extractAdvisorKeywords(String message) {
        if (message == null || message.isBlank()) {
            return Set.of();
        }
        Set<String> stopWords = Set.of(
                "toi", "tôi", "muon", "muốn", "hoc", "học", "khoa", "khóa", "khóa học", "cho", "va", "và",
                "de", "để", "la", "là", "co", "có", "ve", "về", "nhu", "như", "can", "cần", "giup", "giúp");
        return List.of(message.toLowerCase(Locale.ROOT).replaceAll("[^\\p{L}\\p{Nd}\\s]", " ").split("\\s+"))
                .stream()
                .map(String::trim)
                .filter(token -> token.length() >= 2)
                .filter(token -> !stopWords.contains(token))
                .collect(Collectors.toCollection(LinkedHashSet::new));
    }

    private int calculateAdvisorScore(Course course, Set<String> keywords, String rawMessage) {
        if (course == null) {
            return 0;
        }
        int score = 0;
        String bucket = String.join(" ",
                safeLower(course.getName()),
                safeLower(course.getAuthor()),
                safeLower(course.getTitle()),
                safeLower(course.getShortDesc()),
                safeLower(course.getDetailDesc()));
        for (String keyword : keywords) {
            if (bucket.contains(keyword)) {
                score += 3;
            }
        }
        if (containsAny(rawMessage, "miễn phí", "free") && course.getPrice() <= 0) {
            score += 4;
        }
        if (containsAny(rawMessage, "cơ bản", "mới bắt đầu", "beginner")
                && "BEGINNER".equals(normalizeLevelCode(course.getLevel()))) {
            score += 3;
        }
        if (containsAny(rawMessage, "nâng cao", "advanced")
                && "ADVANCED".equals(normalizeLevelCode(course.getLevel()))) {
            score += 3;
        }
        return score;
    }

    private boolean isChineseCourse(Course course) {
        if (course == null) {
            return false;
        }
        String bucket = String.join(" ",
                safeLower(course.getName()),
                safeLower(course.getTitle()),
                safeLower(course.getShortDesc()),
                safeLower(course.getDetailDesc()));
        return containsAny(bucket, "tiếng trung", "tieng trung", "hsk", "chinese", "trung van", "hán ngữ", "han ngu",
                "hoa ngu");
    }

    private boolean isJapaneseCourse(Course course) {
        if (course == null) {
            return false;
        }
        String bucket = String.join(" ",
                safeLower(course.getName()),
                safeLower(course.getTitle()),
                safeLower(course.getShortDesc()),
                safeLower(course.getDetailDesc()));
        return containsAny(bucket, "tiếng nhật", "tieng nhat", "jlpt", "japanese", "nihongo",
                "n5", "n4", "n3", "n2", "n1");
    }

    private List<Course> getTopPurchasedCourses(List<Course> candidateCourses, Set<Long> enrolledIds, int limit) {
        if (candidateCourses == null || candidateCourses.isEmpty()) {
            return List.of();
        }
        final Map<Long, Course> byId = candidateCourses.stream()
                .filter(course -> course != null && course.getId() != null)
                .filter(course -> enrolledIds == null || !enrolledIds.contains(course.getId()))
                .collect(Collectors.toMap(Course::getId, course -> course, (first, second) -> first));
        if (byId.isEmpty()) {
            return List.of();
        }

        final Map<Long, Integer> purchaseCount = new HashMap<>();
        for (Order order : orderService.fetchAllOrdersForAdmin()) {
            if (!isSuccessfulOrderStatus(order == null ? null : order.getStatus())) {
                continue;
            }
            List<OrderDetail> details = order.getOrderDetails();
            if (details == null) {
                continue;
            }
            for (OrderDetail detail : details) {
                Course course = detail == null ? null : detail.getCourse();
                Long id = course == null ? null : course.getId();
                if (id != null && byId.containsKey(id)) {
                    purchaseCount.put(id, purchaseCount.getOrDefault(id, 0) + 1);
                }
            }
        }

        return byId.values().stream()
                .sorted(Comparator
                        .comparingInt((Course c) -> purchaseCount.getOrDefault(c.getId(), 0)).reversed()
                        .thenComparing(Course::getCreatedAt, Comparator.nullsLast(Comparator.reverseOrder())))
                .limit(Math.max(1, limit))
                .toList();
    }

    private List<Course> getTopVideoCourses(
            List<Course> candidateCourses,
            int limit,
            Map<Long, Integer> videoCountMap) {
        if (candidateCourses == null || candidateCourses.isEmpty()) {
            return List.of();
        }
        return candidateCourses.stream()
                .filter(course -> course != null && course.getId() != null)
                .filter(course -> videoCountMap.getOrDefault(course.getId(), 0) > 0)
                .sorted(Comparator
                        .comparingInt((Course c) -> videoCountMap.getOrDefault(c.getId(), 0)).reversed()
                        .thenComparing(Course::getCreatedAt, Comparator.nullsLast(Comparator.reverseOrder())))
                .limit(Math.max(1, limit))
                .toList();
    }

    private boolean isSuccessfulOrderStatus(String status) {
        if (status == null || status.isBlank()) {
            return false;
        }
        String normalized = status.trim().toUpperCase(Locale.ROOT).replace(' ', '_');
        return normalized.contains("PAID")
                || normalized.contains("SUCCESS")
                || normalized.contains("COMPLETE")
                || normalized.contains("FREE_ENROLLED")
                || normalized.contains("THANH_CONG")
                || normalized.contains("THANHCONG");
    }

    private String buildChineseRoadmapReply(boolean topPurchasedMode, boolean hasSuggestions) {
        StringBuilder sb = new StringBuilder();
        sb.append("Lộ trình học tiếng Trung thực dụng:\n")
                .append("1) 0-1 tháng: nắm pinyin + thanh điệu + 300 từ cơ bản.\n")
                .append("2) 1-3 tháng: học HSK1-2, luyện mẫu câu giao tiếp hàng ngày.\n")
                .append("3) 3-6 tháng: luyện nghe - nói theo chủ đề công việc/du lịch, tiến lên HSK3.\n")
                .append("4) 6+ tháng: luyện đề HSK4+, tăng đọc viết và phản xạ hội thoại.");
        if (!hasSuggestions) {
            sb.append("\nHiện hệ thống chưa có khóa tiếng Trung khớp từ khóa của bạn, bạn có thể xem nhóm Ngoại ngữ để chọn lộ trình gần nhất.");
        } else if (topPurchasedMode) {
            sb.append("\nMình đã ưu tiên hiển thị các khóa tiếng Trung được mua nhiều nhất ngay bên dưới.");
        } else {
            sb.append("\nMình đã gợi ý các khóa phù hợp để bạn vào học ngay.");
        }
        return sb.toString();
    }

    private String buildJapaneseRoadmapReply(boolean topPurchasedMode, boolean hasSuggestions) {
        StringBuilder sb = new StringBuilder();
        sb.append("Lộ trình học tiếng Nhật thực dụng:\n")
                .append("1) 0-1 tháng: thuộc 2 bảng chữ Hiragana + Katakana, luyện phát âm chuẩn.\n")
                .append("2) 1-3 tháng: học ngữ pháp và từ vựng nền tảng N5, luyện nghe câu ngắn.\n")
                .append("3) 3-6 tháng: nâng lên N4, tập hội thoại theo tình huống đời sống/công việc.\n")
                .append("4) 6+ tháng: ôn JLPT N3+, tăng tốc đọc hiểu và phản xạ giao tiếp.");
        if (!hasSuggestions) {
            sb.append("\nHiện hệ thống chưa có khóa tiếng Nhật khớp từ khóa của bạn, mình không gợi ý khóa không liên quan để tránh sai logic.");
        } else if (topPurchasedMode) {
            sb.append("\nMình đã ưu tiên hiển thị các khóa tiếng Nhật được mua nhiều nhất ngay bên dưới.");
        } else {
            sb.append("\nMình đã gợi ý các khóa tiếng Nhật phù hợp để bạn bắt đầu.");
        }
        return sb.toString();
    }

    private String buildTopVideoReply(List<Course> courses, Map<Long, Integer> videoCountMap) {
        if (courses == null || courses.isEmpty()) {
            return "Hiện tại mình chưa tìm được khóa học có dữ liệu video rõ ràng. Bạn thử lại sau nhé.";
        }
        StringBuilder sb = new StringBuilder("Đây là các khóa học có nhiều video/bài học nhất hiện tại:\n");
        int index = 1;
        for (Course course : courses) {
            int count = course == null || course.getId() == null ? 0 : videoCountMap.getOrDefault(course.getId(), 0);
            sb.append(index++)
                    .append(") ")
                    .append(course.getName() == null ? "Khóa học" : course.getName())
                    .append(" - ")
                    .append(count)
                    .append(" video\n");
        }
        return sb.toString().trim();
    }

    private String buildAdvisorContextForLlm(
            String userMessage,
            List<CourseAdvisorItem> suggestions,
            boolean askChinesePath,
            boolean askJapanesePath,
            boolean askTopPurchased,
            boolean askMostVideos) {
        StringBuilder context = new StringBuilder();
        context.append("Người dùng hỏi: ").append(userMessage == null ? "" : userMessage).append("\n");
        context.append("Cờ nhận diện: ")
                .append("chinesePath=").append(askChinesePath).append(", ")
                .append("japanesePath=").append(askJapanesePath).append(", ")
                .append("topPurchased=").append(askTopPurchased).append(", ")
                .append("topVideos=").append(askMostVideos).append("\n");
        context.append("Khóa học gợi ý hiện tại:\n");
        if (suggestions == null || suggestions.isEmpty()) {
            context.append("- (không có)\n");
            return context.toString();
        }
        int index = 1;
        for (CourseAdvisorItem item : suggestions) {
            String price = item.getPrice() <= 0
                    ? "Miễn phí"
                    : Math.round(item.getPrice()) + " VND";
            context.append(index++)
                    .append(") ")
                    .append(item.getName())
                    .append(" | tác giả: ").append(item.getAuthor())
                    .append(" | cấp độ: ").append(item.getLevel())
                    .append(" | giá: ").append(price)
                    .append(" | url: ").append(item.getUrl())
                    .append("\n");
        }
        return context.toString();
    }

    @SuppressWarnings("unchecked")
    private List<OpenAiAdvisorService.ChatMessage> getAdvisorChatHistory(HttpSession session) {
        if (session == null) {
            return List.of();
        }
        Object raw = session.getAttribute(ADVISOR_HISTORY_SESSION_KEY);
        if (!(raw instanceof List<?> list)) {
            return List.of();
        }
        List<OpenAiAdvisorService.ChatMessage> history = new ArrayList<>();
        for (Object item : list) {
            if (item instanceof OpenAiAdvisorService.ChatMessage message) {
                history.add(message);
            }
        }
        return history;
    }

    private void appendAdvisorHistory(HttpSession session, String userMessage, String assistantReply) {
        if (session == null) {
            return;
        }
        List<OpenAiAdvisorService.ChatMessage> history = new ArrayList<>(getAdvisorChatHistory(session));
        if (userMessage != null && !userMessage.isBlank()) {
            history.add(new OpenAiAdvisorService.ChatMessage("user", userMessage.trim()));
        }
        if (assistantReply != null && !assistantReply.isBlank()) {
            history.add(new OpenAiAdvisorService.ChatMessage("assistant", assistantReply.trim()));
        }

        int maxMessages = ADVISOR_MAX_HISTORY_MESSAGES * 2;
        if (history.size() > maxMessages) {
            history = new ArrayList<>(history.subList(history.size() - maxMessages, history.size()));
        }
        session.setAttribute(ADVISOR_HISTORY_SESSION_KEY, history);
    }

    private String buildAdvisorReply(String message, List<CourseAdvisorItem> suggestions) {
        if (suggestions == null || suggestions.isEmpty()) {
            return "Mình chưa tìm được khóa học thật phù hợp. Bạn thử nêu rõ chủ đề (ví dụ: Java, IELTS, Marketing) hoặc mức giá mong muốn nhé.";
        }
        if (message == null || message.isBlank()) {
            return "Mình gợi ý vài khóa học đang phù hợp để bạn bắt đầu ngay:";
        }
        if (containsAny(message, "miễn phí", "free")) {
            return "Đây là các khóa học miễn phí phù hợp với nhu cầu của bạn:";
        }
        return "Dựa trên nhu cầu bạn vừa nhập, đây là các khóa học mình gợi ý:";
    }

    private String detectWantedLevel(String message) {
        if (message == null || message.isBlank()) {
            return "";
        }
        if (containsAny(message, "cơ bản", "beginner", "mới bắt đầu")) {
            return "BEGINNER";
        }
        if (containsAny(message, "trung cấp", "intermediate")) {
            return "INTERMEDIATE";
        }
        if (containsAny(message, "nâng cao", "advanced")) {
            return "ADVANCED";
        }
        return "";
    }

    private String normalizeLevelCode(String level) {
        if (level == null || level.isBlank()) {
            return "";
        }
        String normalized = level.trim().toUpperCase(Locale.ROOT);
        if ("BIGINNER".equals(normalized)) {
            return "BEGINNER";
        }
        return normalized;
    }

    private String normalizeLevelLabel(String level) {
        return switch (normalizeLevelCode(level)) {
            case "BEGINNER" -> "Cơ bản";
            case "INTERMEDIATE" -> "Trung cấp";
            case "ADVANCED" -> "Nâng cao";
            default -> "Tất cả cấp độ";
        };
    }

    private boolean containsAny(String source, String... keywords) {
        if (source == null || source.isBlank() || keywords == null) {
            return false;
        }
        String text = source.toLowerCase(Locale.ROOT);
        for (String keyword : keywords) {
            if (keyword != null && !keyword.isBlank() && text.contains(keyword.toLowerCase(Locale.ROOT))) {
                return true;
            }
        }
        return false;
    }

    private String safeLower(String value) {
        return value == null ? "" : value.toLowerCase(Locale.ROOT);
    }
}
