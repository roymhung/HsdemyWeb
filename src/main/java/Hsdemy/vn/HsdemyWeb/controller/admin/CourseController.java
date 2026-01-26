package Hsdemy.vn.HsdemyWeb.controller.admin;

import java.util.List;

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

import Hsdemy.vn.HsdemyWeb.domain.Course;
import Hsdemy.vn.HsdemyWeb.service.CourseService;
import Hsdemy.vn.HsdemyWeb.service.UploadService;

@Controller
public class CourseController {

    private final CourseService courseService;
    private final UploadService uploadService;

    public CourseController(CourseService courseService, UploadService uploadService) {
        this.courseService = courseService;
        this.uploadService = uploadService;
    }

    // ================= LIST =================
    @GetMapping("/admin/course")
    public String getcoursePage(Model model) {
        List<Course> courses = this.courseService.fetchCourses();
        model.addAttribute("courses", courses);
        return "admin/course/show";
    }

    // ===================== DETAIL =====================
    @GetMapping("/admin/course/{id}")
    public String getCourseDetailPage(Model model, @PathVariable long id) {
        Course course = this.courseService.getCourseById(id);
        model.addAttribute("course", course);
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
            @ModelAttribute("newProduct") @Validated Course course,
            BindingResult newUserBindingResult, @RequestParam("thumbnailFile") MultipartFile file) {


        // validate
        List<FieldError> errors = newUserBindingResult.getFieldErrors();
        for (FieldError error : errors) {
            System.out.println(error.getField() + " - " + error.getDefaultMessage());
        }

        // validate
        if (newUserBindingResult.hasErrors()) {
            return "admin/course/update";
        }
        //

        Course currentCourse = this.courseService.getCourseById(course.getId());
        if (currentCourse != null) {

            // update info
            currentCourse.setName(course.getName());
            currentCourse.setPrice(course.getPrice());
            currentCourse.setShortDesc(course.getShortDesc());
            currentCourse.setDetailDesc(course.getDetailDesc());
            currentCourse.setLevel(course.getLevel());

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
    public String postDeleteCourse(Model model, @ModelAttribute("newCourse") Course course) {

        Course currentCourse = this.courseService.getCourseById(course.getId());

        if (currentCourse != null) {

            // xoá ảnh
            this.uploadService.handleDeleteUploadFile(currentCourse.getThumbnail(), "course");

            // xoá Course
            this.courseService.deleteCourse(course.getId());
        }

        return "redirect:/admin/course";
    }
}
