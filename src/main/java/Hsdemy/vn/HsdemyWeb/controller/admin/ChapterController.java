package Hsdemy.vn.HsdemyWeb.controller.admin;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import Hsdemy.vn.HsdemyWeb.domain.Chapter;
import Hsdemy.vn.HsdemyWeb.domain.Course;
import Hsdemy.vn.HsdemyWeb.service.ChapterService;
import Hsdemy.vn.HsdemyWeb.service.CourseService;

@Controller
public class ChapterController {

    private final ChapterService chapterService;
    private final CourseService courseService;

    public ChapterController(ChapterService chapterService, CourseService courseService) {
        this.chapterService = chapterService;
        this.courseService = courseService;
    }

    @PostMapping("/admin/course/{courseId}/chapter/create")
    public String postCreateChapter(@PathVariable Long courseId,
            @ModelAttribute("newChapter") @Validated Chapter chapter,
            BindingResult bindingResult,
            Model model) {

        Course course = courseService.getCourseById(courseId);
        if (course == null) {
            return "redirect:/admin/course";
        }

        if (chapterService.existsPositionInCourse(courseId, chapter.getPosition())) {
            bindingResult.rejectValue("position", "duplicate.position", "Sr No đã tồn tại trong course này");
        }

        if (bindingResult.hasErrors()) {
            List<Chapter> chapters = chapterService.fetchByCourseId(courseId);
            model.addAttribute("course", course);
            model.addAttribute("chapters", chapters);
            model.addAttribute("id", courseId);
            return "admin/course/detail";
        }

        chapter.setCourse(course);
        if (chapter.getStatus() == null || chapter.getStatus().isBlank()) {
            chapter.setStatus("ACTIVE");
        }
        chapterService.save(chapter);

        return "redirect:/admin/course/" + courseId;
    }

    @GetMapping("/admin/course/{courseId}/chapter/{chapterId}/update")
    public String getUpdateChapterPage(@PathVariable Long courseId, @PathVariable Long chapterId, Model model) {
        Course course = courseService.getCourseById(courseId);
        Chapter chapter = chapterService.getById(chapterId);
        if (course == null || chapter == null || chapter.getCourse() == null
                || !chapter.getCourse().getId().equals(courseId)) {
            return "redirect:/admin/course";
        }

        model.addAttribute("course", course);
        model.addAttribute("newChapter", chapter);
        return "admin/chapter/update";
    }

    @PostMapping("/admin/course/{courseId}/chapter/update")
    public String postUpdateChapter(@PathVariable Long courseId,
            @ModelAttribute("newChapter") @Validated Chapter chapter,
            BindingResult bindingResult,
            Model model) {
        Course course = courseService.getCourseById(courseId);
        if (course == null) {
            return "redirect:/admin/course";
        }

        Chapter currentChapter = chapterService.getById(chapter.getId());
        if (currentChapter == null || currentChapter.getCourse() == null
                || !currentChapter.getCourse().getId().equals(courseId)) {
            return "redirect:/admin/course/" + courseId;
        }

        if (chapterService.existsPositionInCourseExcludeChapter(courseId, chapter.getPosition(), chapter.getId())) {
            bindingResult.rejectValue("position", "duplicate.position", "Sr No đã tồn tại trong course này");
        }

        if (bindingResult.hasErrors()) {
            model.addAttribute("course", course);
            return "admin/chapter/update";
        }

        currentChapter.setPosition(chapter.getPosition());
        currentChapter.setTitle(chapter.getTitle());
        currentChapter.setDescription(chapter.getDescription());
        currentChapter.setStatus(chapter.getStatus());
        chapterService.save(currentChapter);

        return "redirect:/admin/course/" + courseId;
    }

    @PostMapping("/admin/course/{courseId}/chapter/{chapterId}/delete")
    public String postDeleteChapter(@PathVariable Long courseId, @PathVariable Long chapterId) {
        Chapter chapter = chapterService.getById(chapterId);
        if (chapter == null || chapter.getCourse() == null || !chapter.getCourse().getId().equals(courseId)) {
            return "redirect:/admin/course/" + courseId;
        }

        chapterService.deleteById(chapterId);
        return "redirect:/admin/course/" + courseId;
    }
}
