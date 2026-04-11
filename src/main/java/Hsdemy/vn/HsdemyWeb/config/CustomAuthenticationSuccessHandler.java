package Hsdemy.vn.HsdemyWeb.config;

import java.io.IOException;
import java.util.List;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.session.SessionInformation;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {

    private final SessionRegistry sessionRegistry;

    public CustomAuthenticationSuccessHandler(SessionRegistry sessionRegistry) {
        this.sessionRegistry = sessionRegistry;
    }

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
            Authentication authentication) throws IOException, ServletException {

        String currentSessionId = request.getSession(false) != null ? request.getSession(false).getId() : null;
        List<SessionInformation> sessions = sessionRegistry.getAllSessions(authentication.getPrincipal(), true);
        boolean loggedInElsewhere = sessions.stream()
                .anyMatch(session -> currentSessionId == null || !session.getSessionId().equals(currentSessionId));

        for (GrantedAuthority authority : authentication.getAuthorities()) {
            if ("ROLE_ADMIN".equals(authority.getAuthority())) {
                response.sendRedirect(loggedInElsewhere ? "/admin?concurrentLogin=1" : "/admin");
                return;
            }
        }
        response.sendRedirect(loggedInElsewhere ? "/?concurrentLogin=1" : "/");
    }
}
