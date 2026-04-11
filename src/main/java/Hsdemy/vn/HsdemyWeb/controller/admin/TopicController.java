package Hsdemy.vn.HsdemyWeb.controller.admin;

import java.util.List;
import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import Hsdemy.vn.HsdemyWeb.domain.Chapter;
import Hsdemy.vn.HsdemyWeb.domain.Lesson;
import Hsdemy.vn.HsdemyWeb.service.ChapterService;
import Hsdemy.vn.HsdemyWeb.service.LessonService;
import Hsdemy.vn.HsdemyWeb.service.UploadService;

@Controller
public class TopicController {

    private final ChapterService chapterService;
    private final LessonService lessonService;
    private final UploadService uploadService;

    public TopicController(ChapterService chapterService, LessonService lessonService, UploadService uploadService) {
        this.chapterService = chapterService;
        this.lessonService = lessonService;
        this.uploadService = uploadService;
    }

    @GetMapping("/admin/chapter/{chapterId}/topic/create")
    public String getCreateTopicPage(@PathVariable Long chapterId, Model model) {
        Chapter chapter = chapterService.getById(chapterId);
        if (chapter == null || chapter.getCourse() == null) {
            return "redirect:/admin/course";
        }

        List<Lesson> topics = lessonService.fetchByChapterId(chapterId);
        int nextSrNo = topics.isEmpty() ? 1 : topics.get(topics.size() - 1).getPosition() + 1;

        Lesson newTopic = new Lesson();
        newTopic.setPosition(nextSrNo);

        model.addAttribute("chapter", chapter);
        model.addAttribute("course", chapter.getCourse());
        model.addAttribute("topics", topics);
        model.addAttribute("newTopic", newTopic);
        return "admin/topic/create";
    }

    @PostMapping("/admin/chapter/{chapterId}/topic/create")
    public String postCreateTopic(@PathVariable Long chapterId,
            @ModelAttribute("newTopic") @Validated Lesson topic,
            BindingResult bindingResult,
            @RequestParam("videoFile") MultipartFile videoFile,
            Model model) {
        Chapter chapter = chapterService.getById(chapterId);
        if (chapter == null || chapter.getCourse() == null) {
            return "redirect:/admin/course";
        }

        if (lessonService.existsPositionInChapter(chapterId, topic.getPosition())) {
            bindingResult.rejectValue("position", "duplicate.position", "Sr No đã tồn tại trong chapter này");
        }

        String fileName = videoFile == null ? "" : videoFile.getOriginalFilename();
        String lowerName = fileName == null ? "" : fileName.toLowerCase(Locale.ROOT);
        if (videoFile == null || videoFile.isEmpty()) {
            bindingResult.rejectValue("videoUrl", "video.required", "Video là bắt buộc");
        } else if (!(lowerName.endsWith(".mp4") || lowerName.endsWith(".mov"))) {
            bindingResult.rejectValue("videoUrl", "video.invalid", "Chỉ chấp nhận file mp4 hoặc mov");
        }

        if (bindingResult.hasErrors()) {
            List<Lesson> topics = lessonService.fetchByChapterId(chapterId);
            model.addAttribute("chapter", chapter);
            model.addAttribute("course", chapter.getCourse());
            model.addAttribute("topics", topics);
            return "admin/topic/create";
        }

        String videoPath = uploadService.handleSaveVideoUpload(videoFile);
        if (videoPath.isEmpty()) {
            bindingResult.rejectValue("videoUrl", "video.upload.failed", "Không thể upload video, vui lòng thử lại");
            List<Lesson> topics = lessonService.fetchByChapterId(chapterId);
            model.addAttribute("chapter", chapter);
            model.addAttribute("course", chapter.getCourse());
            model.addAttribute("topics", topics);
            return "admin/topic/create";
        }
        topic.setVideoUrl(videoPath);
        topic.setChapter(chapter);
        lessonService.save(topic);

        return "redirect:/admin/chapter/" + chapterId + "/topic/create";
    }

    @PostMapping("/admin/course/{courseId}/chapter/{chapterId}/topic/create-inline")
    public String postCreateTopicInline(@PathVariable Long courseId,
            @PathVariable Long chapterId,
            @RequestParam("position") Integer position,
            @RequestParam("title") String title,
            @RequestParam(value = "description", required = false) String description,
            @RequestParam(value = "duration", required = false, defaultValue = "0") Integer duration,
            @RequestParam(value = "preview", required = false, defaultValue = "false") boolean preview,
            @RequestParam("videoFile") MultipartFile videoFile) {
        Chapter chapter = chapterService.getById(chapterId);
        if (chapter == null || chapter.getCourse() == null || !chapter.getCourse().getId().equals(courseId)) {
            return "redirect:/admin/course/" + courseId;
        }

        if (position == null || position < 1 || title == null || title.isBlank()
                || lessonService.existsPositionInChapter(chapterId, position)) {
            return "redirect:/admin/course/" + courseId;
        }

        String fileName = videoFile == null ? "" : videoFile.getOriginalFilename();
        String lowerName = fileName == null ? "" : fileName.toLowerCase(Locale.ROOT);
        if (videoFile == null || videoFile.isEmpty() || !(lowerName.endsWith(".mp4") || lowerName.endsWith(".mov"))) {
            return "redirect:/admin/course/" + courseId;
        }

        String videoPath = uploadService.handleSaveVideoUpload(videoFile);
        if (videoPath.isEmpty()) {
            return "redirect:/admin/course/" + courseId;
        }

        Lesson topic = new Lesson();
        topic.setPosition(position);
        topic.setTitle(title);
        topic.setDescription(description);
        topic.setDuration(duration == null ? 0 : duration);
        topic.setPreview(preview);
        topic.setVideoUrl(videoPath);
        topic.setChapter(chapter);
        lessonService.save(topic);

        return "redirect:/admin/course/" + courseId;
    }
}
