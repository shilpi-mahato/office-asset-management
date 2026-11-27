package com.example.assest_management_system.dto;

public record LoginResponse(String token, String tokenType, String role, long expiresInMs) {
}