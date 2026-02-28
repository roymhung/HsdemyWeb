package Hsdemy.vn.HsdemyWeb.service;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.Map;
import java.util.TimeZone;
import java.util.TreeMap;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpServletRequest;

@Service
public class VnpayService {
    private static final TimeZone VN_TIME_ZONE = TimeZone.getTimeZone("Asia/Ho_Chi_Minh");

    @Value("${vnpay.tmnCode:4YUP19I4}")
    private String vnpTmnCode;

    @Value("${vnpay.hashSecret:MDUIFDCRAKLNBPOFIAFNEKFRNMFBYEPX}")
    private String vnpHashSecret;

    @Value("${vnpay.payUrl:https://sandbox.vnpayment.vn/paymentv2/vpcpay.html}")
    private String vnpPayUrl;

    @Value("${vnpay.returnUrl:http://localhost:8080/payment/vnpay-return}")
    private String vnpReturnUrl;

    public boolean isConfigured() {
        return vnpTmnCode != null && !vnpTmnCode.isBlank()
                && vnpHashSecret != null && !vnpHashSecret.isBlank();
    }

    public String createPaymentUrl(Long orderId, long amountVnd, String orderInfo, String bankCode, String language,
            HttpServletRequest request) {
        String txnRef = orderId + "-" + System.currentTimeMillis();
        String ipAddr = getIpAddress(request);

        Calendar cal = Calendar.getInstance(VN_TIME_ZONE);
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        formatter.setTimeZone(VN_TIME_ZONE);
        String createDate = formatter.format(cal.getTime());
        cal.add(Calendar.MINUTE, 30);
        String expireDate = formatter.format(cal.getTime());

        Map<String, String> params = new TreeMap<>();
        params.put("vnp_Version", "2.1.0");
        params.put("vnp_Command", "pay");
        params.put("vnp_TmnCode", vnpTmnCode);
        params.put("vnp_Amount", String.valueOf(amountVnd * 100));
        params.put("vnp_CurrCode", "VND");
        params.put("vnp_TxnRef", txnRef);
        params.put("vnp_OrderInfo", orderInfo);
        params.put("vnp_OrderType", "other");
        params.put("vnp_Locale", (language == null || language.isBlank()) ? "vn" : language);
        params.put("vnp_ReturnUrl", vnpReturnUrl);
        params.put("vnp_IpAddr", ipAddr);
        params.put("vnp_CreateDate", createDate);
        params.put("vnp_ExpireDate", expireDate);
        if (bankCode != null && !bankCode.isBlank()) {
            params.put("vnp_BankCode", bankCode);
        }

        StringBuilder hashData = new StringBuilder();
        StringBuilder query = new StringBuilder();

        for (Map.Entry<String, String> entry : params.entrySet()) {
            if (entry.getValue() == null || entry.getValue().isBlank()) {
                continue;
            }
            if (hashData.length() > 0) {
                hashData.append('&');
                query.append('&');
            }
            String encodedKey = URLEncoder.encode(entry.getKey(), StandardCharsets.US_ASCII);
            String encodedValue = URLEncoder.encode(entry.getValue(), StandardCharsets.US_ASCII);
            hashData.append(entry.getKey()).append('=').append(encodedValue);
            query.append(encodedKey).append('=').append(encodedValue);
        }

        String secureHash = hmacSHA512(vnpHashSecret, hashData.toString());
        query.append("&vnp_SecureHash=").append(secureHash);
        return vnpPayUrl + "?" + query;
    }

    public boolean verifyReturnSignature(HttpServletRequest request) {
        Map<String, String> fields = new TreeMap<>();
        Enumeration<String> params = request.getParameterNames();
        while (params.hasMoreElements()) {
            String fieldName = params.nextElement();
            String fieldValue = request.getParameter(fieldName);
            if (fieldValue != null && !fieldValue.isEmpty()
                    && !fieldName.equals("vnp_SecureHash")
                    && !fieldName.equals("vnp_SecureHashType")) {
                fields.put(fieldName, fieldValue);
            }
        }

        StringBuilder hashData = new StringBuilder();
        for (Map.Entry<String, String> entry : fields.entrySet()) {
            if (hashData.length() > 0) {
                hashData.append('&');
            }
            String encodedValue = URLEncoder.encode(entry.getValue(), StandardCharsets.US_ASCII);
            hashData.append(entry.getKey()).append('=').append(encodedValue);
        }

        String signValue = request.getParameter("vnp_SecureHash");
        String computedHash = hmacSHA512(vnpHashSecret, hashData.toString());
        return computedHash.equalsIgnoreCase(signValue);
    }

    private String getIpAddress(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");
        if (ip == null || ip.isBlank()) {
            ip = request.getRemoteAddr();
        }
        if (ip != null && ip.contains(",")) {
            ip = ip.split(",")[0].trim();
        }
        if (ip == null || ip.isBlank() || "::1".equals(ip) || "0:0:0:0:0:0:0:1".equals(ip)) {
            return "127.0.0.1";
        }
        return ip;
    }

    private String hmacSHA512(String key, String data) {
        try {
            Mac hmac = Mac.getInstance("HmacSHA512");
            SecretKeySpec secretKey = new SecretKeySpec(key.getBytes(StandardCharsets.UTF_8), "HmacSHA512");
            hmac.init(secretKey);
            byte[] bytes = hmac.doFinal(data.getBytes(StandardCharsets.UTF_8));
            StringBuilder hash = new StringBuilder();
            for (byte b : bytes) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) {
                    hash.append('0');
                }
                hash.append(hex);
            }
            return hash.toString();
        } catch (Exception e) {
            return "";
        }
    }
}
