package Hsdemy.vn.HsdemyWeb.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import Hsdemy.vn.HsdemyWeb.domain.User;


// crud: create, read, update, delete
@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    User save(User hung);

    void deleteById(long id);

    List<User> findAll();

    User findById(long id);

    List<User> findByEmail(String email);

    List<User> findByEmailAndAddress(String email, String address);

    boolean existsByEmail(String email);
}
