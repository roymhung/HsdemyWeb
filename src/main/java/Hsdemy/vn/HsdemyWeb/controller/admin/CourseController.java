package Hsdemy.vn.HsdemyWeb.controller.admin;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import Hsdemy.vn.HsdemyWeb.domain.Chapter;
import Hsdemy.vn.HsdemyWeb.domain.Course;
import Hsdemy.vn.HsdemyWeb.service.ChapterService;
import Hsdemy.vn.HsdemyWeb.service.CourseService;
import Hsdemy.vn.HsdemyWeb.service.UploadService;

@Controller
public class CourseController {
    private static final int COURSES_PER_PAGE = 9;

    private final CourseService courseService;
    private final ChapterService chapterService;
    private final UploadService uploadService;

    public CourseController(CourseService courseService, ChapterService chapterService, UploadService uploadService) {
        this.courseService = courseService;
        this.chapterService = chapterService;
        this.uploadService = uploadService;
    }

    // ================= LIST =================
    @GetMapping("/admin/course")
    public String getcoursePage(
            @RequestParam(value = "view", defaultValue = "active") String view,
            @RequestParam(value = "page", defaultValue = "1") int page,
            Model model) {
        boolean trashView = "trash".equalsIgnoreCase(view);
        int currentPage = Math.max(1, page);
        Pageable pageable = PageRequest.of(currentPage - 1, COURSES_PER_PAGE, Sort.by("id").ascending());
        Page<Course> coursePage = this.courseService.fetchCoursesByView(trashView, pageable);

        if (currentPage > coursePage.getTotalPages() && coursePage.getTotalPages() > 0) {
            currentPage = coursePage.getTotalPages();
            pageable = PageRequest.of(currentPage - 1, COURSES_PER_PAGE, Sort.by("id").ascending());
            coursePage = this.courseService.fetchCoursesByView(trashView, pageable);
        }

        model.addAttribute("courses", coursePage.getContent());
        model.addAttribute("selectedView", trashView ? "trash" : "active");
        model.addAttribute("activeCount", this.courseService.fetchCourses().size());
        model.addAttribute("trashCount", this.courseService.fetchDeletedCourses().size());
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalPages", Math.max(1, coursePage.getTotalPages()));
        return "admin/course/show";
    }

    // ===================== DETAIL =====================
    @GetMapping("/admin/course/{id}")
    public String getCourseDetailPage(Model model, @PathVariable long id) {
        Course course = this.courseService.getCourseById(id);
        List<Chapter> chapters = this.chapterService.fetchByCourseId(id);
        int nextSrNo = chapters.isEmpty() ? 1 : chapters.get(chapters.size() - 1).getPosition() + 1;

        model.addAttribute("course", course);
        model.addAttribute("chapters", chapters);
        if (!model.containsAttribute("newChapter")) {
            Chapter chapter = new Chapter();
            chapter.setPosition(nextSrNo);
            chapter.setStatus("ACTIVE");
            model.addAttribute("newChapter", chapter);
        }
        model.addAttribute("id", id);
        return "admin/course/detail";
    }

    // ================= CREATE =================
    @GetMapping("/admin/course/create")
    public String getCreateCoursePage(Model model) {
        model.addAttribute("newCourse", new Course());
        return "admin/course/create";
    }

    @PostMapping("/admin/course/create")
    public String postCreateCourse(@ModelAttribute("newCourse") @Validated Course course,
            BindingResult newCourseBindingResult,
            @RequestParam("thumbnailFile") MultipartFile file) {

        if (newCourseBindingResult.hasErrors()) {
            return "admin/course/create";
        }

        // upload thumbnail
        String thumbnail = this.uploadService.handleSaveUploadFile(file, "course");
        course.setThumbnail(thumbnail);

        this.courseService.createProduct(course);
        return "redirect:/admin/course";
    }

    // ================= UPDATE =================
    @GetMapping("/admin/course/update/{id}")
    public String getUpdateCoursePage(Model model, @PathVariable long id) {
        Course currentCourse = this.courseService.getCourseById(id);
        model.addAttribute("newCourse", currentCourse);
        return "admin/course/update";
    }

    @PostMapping("/admin/course/update")
    public String postUpdateCourse(Model model,
            @ModelAttribute("newCourse") @Validated Course course,
            BindingResult newCourseBindingResult,
            @RequestParam("thumbnailFile") MultipartFile file) {

        // validate
        if (newCourseBindingResult.hasErrors()) {
            return "admin/course/update";
        }
        //

        Course currentCourse = this.courseService.getCourseById(course.getId());
        if (currentCourse != null) {

            // update info
            currentCourse.setName(course.getName());
            currentCourse.setAuthor(course.getAuthor());
            currentCourse.setPrice(course.getPrice());
            currentCourse.setShortDesc(course.getShortDesc());
            currentCourse.setDetailDesc(course.getDetailDesc());
            currentCourse.setLevel(course.getLevel());
            currentCourse.setTitle(course.getTitle());

            // không update createdAt (chỉ set lúc tạo)
            // currentCourse.setCreatedAt(course.getCreatedAt());

            // CHỈ update thumbnail nếu có file mới
            if (file != null && !file.isEmpty()) {
                // xoá ảnh cũ
                this.uploadService.handleDeleteUploadFile(currentCourse.getThumbnail(), "course");

                // lưu ảnh mới
                String newThumbnail = this.uploadService.handleSaveUploadFile(file, "course");
                currentCourse.setThumbnail(newThumbnail);
            }

            courseService.saveCourse(currentCourse);
        }

        return "redirect:/admin/course";
    }


    // ===================== DELETE =====================
    @GetMapping("/admin/course/delete/{id}")
    public String getDeleteCoursePage(Model model, @PathVariable long id) {
        model.addAttribute("id", id);
        model.addAttribute("newCourse", new Course());
        return "admin/course/delete";
    }

    @PostMapping("/admin/course/delete")
    public String postDeleteCourse(Model model, @ModelAttribute("newCourse") Course course,
            RedirectAttributes redirectAttributes) {

        Course currentCourse = this.courseService.getCourseById(course.getId());

        if (currentCourse == null) {
            redirectAttributes.addFlashAttribute("messageType", "warning");
            redirectAttributes.addFlashAttribute("message", "Khóa học không tồn tại hoặc đã bị xóa.");
            return "redirect:/admin/course?view=active";
        }

        CourseService.DeleteCourseResult result = this.courseService.deleteCourseSmart(course.getId());
        switch (result) {
            case HARD_DELETED -> {
                this.uploadService.handleDeleteUploadFile(currentCourse.getThumbnail(), "course");
                redirectAttributes.addFlashAttribute("messageType", "success");
                redirectAttributes.addFlashAttribute("message", "Đã xóa vĩnh viễn khóa học khỏi hệ thống.");
            }
            case SOFT_DELETED -> {
                redirectAttributes.addFlashAttribute("messageType", "warning");
                redirectAttributes.addFlashAttribute("message",
                        "Khóa học đã được ẩn (xóa mềm) vì có dữ liệu đơn hàng liên quan.");
            }
            case ALREADY_DELETED -> {
                redirectAttributes.addFlashAttribute("messageType", "info");
                redirectAttributes.addFlashAttribute("message", "Khóa học này đã được ẩn trước đó.");
            }
            case NOT_FOUND -> {
                redirectAttributes.addFlashAttribute("messageType", "warning");
                redirectAttributes.addFlashAttribute("message", "Khóa học không tồn tại.");
            }
        }

        return "redirect:/admin/course?view=active";
    }

    @PostMapping("/admin/course/restore/{id}")
    public String restoreCourse(@PathVariable long id, RedirectAttributes redirectAttributes) {
        CourseService.RestoreCourseResult result = this.courseService.restoreCourse(id);
        switch (result) {
            case RESTORED -> {
                redirectAttributes.addFlashAttribute("messageType", "success");
                redirectAttributes.addFlashAttribute("message", "Đã khôi phục khóa học.");
            }
            case ALREADY_ACTIVE -> {
                redirectAttributes.addFlashAttribute("messageType", "info");
                redirectAttributes.addFlashAttribute("message", "Khóa học này đang ở trạng thái hiển thị.");
            }
            case NOT_FOUND -> {
                redirectAttributes.addFlashAttribute("messageType", "warning");
                redirectAttributes.addFlashAttribute("message", "Không tìm thấy khóa học để khôi phục.");
            }
        }
        return "redirect:/admin/course?view=trash";
    }

    @PostMapping("/admin/course/purge/{id}")
    public String purgeCourse(@PathVariable long id, RedirectAttributes redirectAttributes) {
        Course currentCourse = this.courseService.getCourseById(id);
        CourseService.PurgeCourseResult result = this.courseService.purgeDeletedCourse(id);
        switch (result) {
            case PURGED -> {
                if (currentCourse != null) {
                    this.uploadService.handleDeleteUploadFile(currentCourse.getThumbnail(), "course");
                }
                redirectAttributes.addFlashAttribute("messageType", "success");
                redirectAttributes.addFlashAttribute("message", "Đã xóa vĩnh viễn khóa học trong thùng rác.");
            }
            case HAS_ORDER_DETAILS -> {
                redirectAttributes.addFlashAttribute("messageType", "warning");
                redirectAttributes.addFlashAttribute("message",
                        "Không thể xóa vĩnh viễn vì khóa học còn dữ liệu đơn hàng liên quan.");
            }
            case NOT_IN_TRASH -> {
                redirectAttributes.addFlashAttribute("messageType", "info");
                redirectAttributes.addFlashAttribute("message", "Khóa học chưa nằm trong thùng rác.");
            }
            case NOT_FOUND -> {
                redirectAttributes.addFlashAttribute("messageType", "warning");
                redirectAttributes.addFlashAttribute("message", "Không tìm thấy khóa học.");
            }
        }
        return "redirect:/admin/course?view=trash";
    }
}
