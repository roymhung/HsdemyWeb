package Hsdemy.vn.HsdemyWeb.service;

import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import Hsdemy.vn.HsdemyWeb.domain.Role;
import Hsdemy.vn.HsdemyWeb.domain.User;
import Hsdemy.vn.HsdemyWeb.domain.dto.RegisterDTO;
import Hsdemy.vn.HsdemyWeb.repository.RoleRepository;
import Hsdemy.vn.HsdemyWeb.repository.UserRepository;

@Service
public class UserService {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final PasswordEncoder passwordEncoder;

    public UserService(UserRepository userRepository, RoleRepository roleRepository,
            PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.passwordEncoder = passwordEncoder;
    }

    public List<User> getAllUsers() {
        return this.userRepository.findAll();
    }

    public List<User> getAllUsersByEmail(String email) {
        return this.userRepository.findAllByEmail(email);
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

    public User registerDTOtoUser(RegisterDTO registerDTO) {
        User user = new User();
        user.setFullName(registerDTO.getFirstName() + " " + registerDTO.getLastName());
        user.setEmail(registerDTO.getEmail());
        // user.setPassword(registerDTO.getPassword());
        user.setPassword(passwordEncoder.encode(registerDTO.getPassword()));
        return user;
    }

    public boolean checkEmailExist(String email) {
        return this.userRepository.existsByEmail(email);
    }

    public User getUserByEmail(String email) {
        return this.userRepository.findByEmail(email);
    }

    public boolean resetPasswordByEmail(String email, String newRawPassword) {
        User user = this.userRepository.findByEmail(email);
        if (user == null) {
            return false;
        }
        user.setPassword(this.passwordEncoder.encode(newRawPassword));
        this.userRepository.save(user);
        return true;
    }

    public User updateProfile(Long userId, User incomingUser) {
        User currentUser = this.getUserById(userId);
        if (currentUser == null) {
            return null;
        }
        if (incomingUser.getEmail() != null && !incomingUser.getEmail().isBlank()) {
            currentUser.setEmail(incomingUser.getEmail().trim());
        }
        if (incomingUser.getFullName() != null && !incomingUser.getFullName().isBlank()) {
            currentUser.setFullName(incomingUser.getFullName().trim());
        }

        String normalizedPhone = incomingUser.getPhone() == null ? null : incomingUser.getPhone().trim();
        currentUser.setPhone(normalizedPhone == null || normalizedPhone.isEmpty() ? null : normalizedPhone);

        String normalizedAddress = incomingUser.getAddress() == null ? null : incomingUser.getAddress().trim();
        currentUser.setAddress(normalizedAddress == null || normalizedAddress.isEmpty() ? null : normalizedAddress);
        return this.userRepository.save(currentUser);
    }

}
