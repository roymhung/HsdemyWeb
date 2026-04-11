package Hsdemy.vn.HsdemyWeb.service;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class OpenAiAdvisorService {
    private final ObjectMapper objectMapper;
    private final HttpClient httpClient;

    @Value("${openai.chat.enabled:true}")
    private boolean enabled;

    @Value("${openai.api-key:}")
    private String apiKey;

    @Value("${openai.model:gpt-4o-mini}")
    private String model;

    @Value("${openai.base-url:https://api.openai.com/v1}")
    private String baseUrl;

    public OpenAiAdvisorService(ObjectMapper objectMapper) {
        this.objectMapper = objectMapper;
        this.httpClient = HttpClient.newBuilder()
                .connectTimeout(Duration.ofSeconds(10))
                .build();
    }

    public String generateAdvisorReply(
            String userMessage,
            String context,
            List<ChatMessage> history,
            String fallbackReply) {
        if (!isAvailable()) {
            return fallbackReply;
        }

        try {
            String promptMessage = (userMessage == null || userMessage.isBlank())
                    ? "Hãy tư vấn khóa học phù hợp cho tôi."
                    : userMessage.trim();
            String promptContext = context == null ? "" : context.trim();
            List<Map<String, String>> messages = new ArrayList<>();
            messages.add(Map.of(
                    "role", "system",
                    "content",
                    "Bạn là trợ lý tư vấn khóa học tiếng Việt cho nền tảng Hstudemy. "
                            + "Mục tiêu: trả lời thực dụng, ngắn gọn, có lộ trình rõ ràng nếu người dùng hỏi lộ trình. "
                            + "Ưu tiên bám sát dữ liệu khóa học được cung cấp, không bịa thông tin. "
                            + "Giọng điệu thân thiện, chuyên nghiệp, tối đa 8 dòng nếu không được yêu cầu dài."));
            if (history != null) {
                for (ChatMessage item : history) {
                    if (item == null || item.getContent() == null || item.getContent().isBlank()) {
                        continue;
                    }
                    String role = "assistant".equalsIgnoreCase(item.getRole()) ? "assistant" : "user";
                    messages.add(Map.of("role", role, "content", item.getContent()));
                }
            }
            messages.add(Map.of(
                    "role", "user",
                    "content", "Ngữ cảnh dữ liệu khóa học:\n" + promptContext
                            + "\n\nYêu cầu người dùng:\n" + promptMessage));

            Map<String, Object> payload = new LinkedHashMap<>();
            payload.put("model", model);
            payload.put("temperature", 0.5);
            payload.put("max_tokens", 480);
            payload.put("messages", messages);

            String jsonPayload = objectMapper.writeValueAsString(payload);
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(normalizeBaseUrl(baseUrl) + "/chat/completions"))
                    .header("Authorization", "Bearer " + apiKey.trim())
                    .header("Content-Type", "application/json")
                    .timeout(Duration.ofSeconds(24))
                    .POST(HttpRequest.BodyPublishers.ofString(jsonPayload))
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            if (response.statusCode() < 200 || response.statusCode() >= 300) {
                return fallbackReply;
            }

            JsonNode root = objectMapper.readTree(response.body());
            JsonNode contentNode = root.path("choices").path(0).path("message").path("content");
            if (contentNode.isMissingNode() || contentNode.asText("").isBlank()) {
                return fallbackReply;
            }
            return contentNode.asText().trim();
        } catch (Exception ex) {
            return fallbackReply;
        }
    }

    private boolean isAvailable() {
        return enabled && apiKey != null && !apiKey.isBlank();
    }

    private String normalizeBaseUrl(String value) {
        if (value == null || value.isBlank()) {
            return "https://api.openai.com/v1";
        }
        String trimmed = value.trim();
        if (trimmed.endsWith("/")) {
            return trimmed.substring(0, trimmed.length() - 1);
        }
        return trimmed;
    }

    public static class ChatMessage {
        private final String role;
        private final String content;

        public ChatMessage(String role, String content) {
            this.role = role == null ? "user" : role;
            this.content = content == null ? "" : content;
        }

        public String getRole() {
            return role;
        }

        public String getContent() {
            return content;
        }
    }
}
