package Hsdemy.vn.HsdemyWeb.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.session.SessionRegistryImpl;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.session.HttpSessionEventPublisher;

import Hsdemy.vn.HsdemyWeb.service.CustomUserDetailsService;
import Hsdemy.vn.HsdemyWeb.service.UserService;
import jakarta.servlet.DispatcherType;


@Configuration
@EnableMethodSecurity(securedEnabled = true)
public class SecurityConfiguration {

    // @Bean
    // public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
    // http.csrf(csrf -> csrf.disable())
    // .authorizeHttpRequests(auth -> auth.anyRequest().permitAll());
    // return http.build();
    // }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public UserDetailsService userDetailsService(UserService userService) {
        return new CustomUserDetailsService(userService);
    }

    @Bean
    public DaoAuthenticationProvider authProvider(PasswordEncoder passwordEncoder,
            UserDetailsService userDetailsService) {

        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setUserDetailsService(userDetailsService);
        authProvider.setPasswordEncoder(passwordEncoder);
        authProvider.setHideUserNotFoundExceptions(false);
        return authProvider;
    }

    @Bean
    SecurityFilterChain filterChain(HttpSecurity http,
            CustomAuthenticationSuccessHandler customAuthenticationSuccessHandler,
            SessionRegistry sessionRegistry,
            UserDetailsService userDetailsService) throws Exception {

        http.authorizeHttpRequests(authorize -> authorize
                .dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.INCLUDE).permitAll()
                .requestMatchers("/", "/login", "/register", "/forgot-password", "/error",
                        "/course/**", "/client/**", "/css/**", "/js/**", "/images/**")
                .permitAll()

                .requestMatchers("/learning/**").hasAnyRole("USER", "ADMIN")
                .requestMatchers("/home/my-courses/**", "/account/**", "/cart/**",
                        "/notifications/**")
                .hasAnyRole("USER", "ADMIN")

                .requestMatchers("/admin/**").hasRole("ADMIN")

                .anyRequest().authenticated())

                .formLogin(form -> form.loginPage("/login").loginProcessingUrl("/login")
                        .successHandler(customAuthenticationSuccessHandler)
                        .failureUrl("/login?error").permitAll())
                .rememberMe(remember -> remember
                        .key("uniqueAndSecretKey")
                        .userDetailsService(userDetailsService)
                        .rememberMeParameter("remember-me")
                        .rememberMeCookieName("remember-me-cookie")
                        .tokenValiditySeconds(30 * 24 * 60 * 60)
                        .alwaysRemember(true))

                .sessionManagement(
                        session -> session.maximumSessions(1).maxSessionsPreventsLogin(false)
                                .expiredUrl("/login?expired").sessionRegistry(sessionRegistry));

        return http.build();
    }

    @Bean
    public SessionRegistry sessionRegistry() {
        return new SessionRegistryImpl();
    }

    @Bean
    public static HttpSessionEventPublisher httpSessionEventPublisher() {
        return new HttpSessionEventPublisher();
    }


}
