package Hsdemy.vn.HsdemyWeb.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import Hsdemy.vn.HsdemyWeb.domain.OrderDetail;

@Repository
public interface OrderDetailRepository extends JpaRepository<OrderDetail, Long> {
    Optional<OrderDetail> findFirstByOrderIdOrderByIdAsc(Long orderId);
    List<OrderDetail> findByOrderIdOrderByIdAsc(Long orderId);

    boolean existsByCourseId(Long courseId);
}
