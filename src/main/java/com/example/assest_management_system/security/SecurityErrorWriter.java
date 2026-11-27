package com.example.assest_management_system.security;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.http.HttpStatus;

import java.io.IOException;
import java.time.LocalDateTime;

public final class SecurityErrorWriter {

    private SecurityErrorWriter() {
    }

    public static void write(HttpServletRequest request, HttpServletResponse response,
                             HttpStatus status, String message) throws IOException {
        response.setStatus(status.value());
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String json = "{"
                + "\"timestamp\":\"" + LocalDateTime.now() + "\","
                + "\"status\":" + status.value() + ","
                + "\"error\":\"" + status.getReasonPhrase() + "\","
                + "\"message\":\"" + escape(message) + "\","
                + "\"path\":\"" + escape(request.getRequestURI()) + "\","
                + "\"fieldErrors\":[]"
                + "}";
        response.getWriter().write(json);
    }

    private static String escape(String text) {
        return text.replace("\\", "\\\\").replace("\"", "\\\"");
    }
}