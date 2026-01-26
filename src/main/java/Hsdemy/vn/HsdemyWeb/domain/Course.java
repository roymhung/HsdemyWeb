package Hsdemy.vn.HsdemyWeb.domain;


import java.time.LocalDateTime;
import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

@Entity
@Table(name = "courses")
public class Course {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Size(min = 3, max = 255, message = "Tên sản phẩm không được để trống phải từ 3 đến 255 ký tự")
    private String name;

    @DecimalMin(value = "0", inclusive = false, message = "Giá phải lớn hơn 0")
    private double price;
    private String thumbnail;

    @Size(min = 5, max = 255,
            message = "Mô tả ngắn không được để trống phải có ít nhất từ 5 đến 255 ký tự")
    private String shortDesc;

    @NotNull
    @Size(min = 10, message = "Mô tả chi tiết không được để trống phải có ít nhất 10 ký tự")
    @Column(columnDefinition = "MEDIUMTEXT")
    private String detailDesc;

    private String level;
    private LocalDateTime createdAt;

    @OneToMany(mappedBy = "course")
    private List<Chapter> chapters;

    @OneToMany(mappedBy = "course")
    private List<OrderDetail> orderDetails;

    // getter & setter
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }

    public String getShortDesc() {
        return shortDesc;
    }

    public void setShortDesc(String shortDesc) {
        this.shortDesc = shortDesc;
    }

    public String getDetailDesc() {
        return detailDesc;
    }

    public void setDetailDesc(String detailDesc) {
        this.detailDesc = detailDesc;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public List<Chapter> getChapters() {
        return chapters;
    }

    public void setChapters(List<Chapter> chapters) {
        this.chapters = chapters;
    }

    public List<OrderDetail> getOrderDetails() {
        return orderDetails;
    }

    public void setOrderDetails(List<OrderDetail> orderDetails) {
        this.orderDetails = orderDetails;
    }



}
