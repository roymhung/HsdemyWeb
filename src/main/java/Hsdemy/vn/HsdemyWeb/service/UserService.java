package Hsdemy.vn.HsdemyWeb.service;

import java.util.List;

import org.springframework.stereotype.Service;

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

    public User handleSaveUser(User user) {
        User mhung = this.userRepository.save(user);
        System.out.println(mhung);
        return mhung;
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
