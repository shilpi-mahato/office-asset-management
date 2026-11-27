package com.example.assest_management_system.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record LoginRequest(
        @NotBlank(message = "username must not be blank")
        @Size(max = 50, message = "username must be at most 50 characters")
        String username,

        @NotBlank(message = "password must not be blank")
        @Size(max = 72, message = "password must be at most 72 characters")
        String password) {
}