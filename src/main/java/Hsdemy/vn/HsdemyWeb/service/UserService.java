package Hsdemy.vn.HsdemyWeb.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import Hsdemy.vn.HsdemyWeb.domain.Role;
import Hsdemy.vn.HsdemyWeb.domain.User;
import Hsdemy.vn.HsdemyWeb.repository.RoleRepository;
import Hsdemy.vn.HsdemyWeb.repository.UserRepository;

@Service
public class UserService {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;

    public UserService(UserRepository userRepository, RoleRepository roleRepository) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
    }

    public List<User> getAllUsers() {
        return this.userRepository.findAll();
    }

    public List<User> getAllUsersByEmail(String email) {
        return this.userRepository.findByEmail(email);
    }

    @Transactional
    public User handleSaveUser(User user) {

        // ===== FIX LỖI TRANSIENT ROLE =====

        // 1️ LẤY role.name TỪ JSP (path="role.name")
        if (user.getRole() == null || user.getRole().getName() == null) {
            throw new RuntimeException("Role is null");
        }

        String roleName = user.getRole().getName();

        // 2️ LẤY ROLE ĐÃ TỒN TẠI TRONG DB
        Role role = roleRepository.findByName(roleName);

        if (role == null) {
            throw new RuntimeException("Role not found in DB: " + roleName);
        }

        // 3️ GÁN LẠI ROLE ĐÃ PERSIST (QUAN TRỌNG NHẤT)
        user.setRole(role);

        // 4️ SET createdAt nếu là user mới
        if (user.getId() == 0) {
            user.setCreatedAt(LocalDateTime.now());
        }

        // 5️ SAVE SAU KHI ROLE ĐÃ OK
        User savedUser = this.userRepository.save(user);
        System.out.println(savedUser);

        return savedUser;
    }

    public User getUserById(Long id) {
        return this.userRepository.findById(id).orElse(null);
    }

    public void deleteAUser(Long id) {
        this.userRepository.deleteById(id);
    }

    public Role getRoleByName(String name) {
        return this.roleRepository.findByName(name);
    }
}
