package Hsdemy.vn.HsdemyWeb.controller.client;


import java.security.Principal;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import Hsdemy.vn.HsdemyWeb.domain.Chapter;
import Hsdemy.vn.HsdemyWeb.domain.Course;
import Hsdemy.vn.HsdemyWeb.domain.Lesson;
import Hsdemy.vn.HsdemyWeb.domain.User;
import Hsdemy.vn.HsdemyWeb.service.ChapterService;
import Hsdemy.vn.HsdemyWeb.service.CourseService;
import Hsdemy.vn.HsdemyWeb.service.OrderService;
import Hsdemy.vn.HsdemyWeb.service.UserService;

@Controller
public class CourseDetailController {

    private final CourseService courseService;
    private final ChapterService chapterService;
    private final UserService userService;
    private final OrderService orderService;

    public CourseDetailController(CourseService courseService, ChapterService chapterService, UserService userService,
            OrderService orderService) {
        this.courseService = courseService;
        this.chapterService = chapterService;
        this.userService = userService;
        this.orderService = orderService;
    }

    @GetMapping("/course/{id}")
    public String getCourseDetailPage(Model model, @PathVariable long id) {
        Course course = this.courseService.getCourseById(id);
        java.util.List<Chapter> chapters = this.chapterService.fetchByCourseId(id);

        int totalVideos = 0;
        int totalMinutes = 0;
        String firstPreviewVideoUrl = "";
        String firstPreviewVideoTitle = "Xem trước khóa học";
        for (Chapter chapter : chapters) {
            if (chapter.getLessons() == null) {
                continue;
            }
            totalVideos += chapter.getLessons().size();
            for (Lesson lesson : chapter.getLessons()) {
                totalMinutes += lesson.getDuration();
                if (firstPreviewVideoUrl.isEmpty() && lesson.isPreview()) {
                    firstPreviewVideoUrl = lesson.getVideoUrl() == null ? "" : lesson.getVideoUrl();
                    firstPreviewVideoTitle = lesson.getTitle() == null ? "Xem trước khóa học" : lesson.getTitle();
                }
            }
        }

        model.addAttribute("course", course);
        model.addAttribute("chapters", chapters);
        model.addAttribute("totalVideos", totalVideos);
        model.addAttribute("totalMinutes", totalMinutes);
        model.addAttribute("firstPreviewVideoUrl", firstPreviewVideoUrl);
        model.addAttribute("firstPreviewVideoTitle", firstPreviewVideoTitle);
        model.addAttribute("id", id);
        return "client/course/detail";
    }

    @GetMapping("/course/{id}/start")
    public String startCourse(@PathVariable long id, Principal principal) {
        Course course = this.courseService.getCourseById(id);
        if (course == null) {
            return "redirect:/";
        }

        if (isFreeCourse(course)) {
            return "redirect:/learning/course/" + id;
        }

        User currentUser = getCurrentUser(principal);
        if (currentUser == null) {
            return "redirect:/login";
        }

        boolean purchased = orderService.hasPurchasedCourse(currentUser.getId(), course.getId());
        if (purchased) {
            return "redirect:/learning/course/" + id;
        }
        return "redirect:/payment/checkout/" + id;
    }

    @GetMapping("/learning/course/{id}")
    public String learningCoursePage(@PathVariable long id, Principal principal, Model model) {
        Course course = this.courseService.getCourseById(id);
        if (course == null) {
            return "redirect:/";
        }

        boolean freeCourse = isFreeCourse(course);
        User currentUser = getCurrentUser(principal);
        boolean purchased = currentUser != null && orderService.hasPurchasedCourse(currentUser.getId(), course.getId());

        if (!freeCourse && !purchased) {
            return "redirect:/payment/checkout/" + id;
        }

        java.util.List<Chapter> chapters = this.chapterService.fetchByCourseId(id);
        String defaultVideoUrl = "";
        String defaultVideoTitle = "";
        for (Chapter chapter : chapters) {
            if (chapter.getLessons() == null || chapter.getLessons().isEmpty()) {
                continue;
            }
            Lesson firstLesson = chapter.getLessons().get(0);
            defaultVideoUrl = firstLesson.getVideoUrl() == null ? "" : firstLesson.getVideoUrl();
            defaultVideoTitle = firstLesson.getTitle() == null ? "" : firstLesson.getTitle();
            break;
        }

        model.addAttribute("course", course);
        model.addAttribute("chapters", chapters);
        model.addAttribute("defaultVideoUrl", defaultVideoUrl);
        model.addAttribute("defaultVideoTitle", defaultVideoTitle);
        return "client/course/learning";
    }

    private boolean isFreeCourse(Course course) {
        return course != null && course.getPrice() <= 0;
    }

    private User getCurrentUser(Principal principal) {
        if (principal == null) {
            return null;
        }
        return userService.getUserByEmail(principal.getName());
    }
}


