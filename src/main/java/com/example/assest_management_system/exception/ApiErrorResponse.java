package com.example.assest_management_system.exception;

import org.springframework.http.HttpStatus;

import java.time.LocalDateTime;
import java.util.List;

public record ApiErrorResponse(
        LocalDateTime timestamp,
        int status,
        String error,
        String message,
        String path,
        List<FieldErrorDetail> fieldErrors) {

    // Shortcut for errors that have no field-level details
    public static ApiErrorResponse of(HttpStatus status, String message, String path) {
        return new ApiErrorResponse(
                LocalDateTime.now(),
                status.value(),
                status.getReasonPhrase(),
                message,
                path,
                List.of());
    }
}