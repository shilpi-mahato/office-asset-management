package com.example.assest_management_system.service;

import com.example.assest_management_system.dto.LoginRequest;
import com.example.assest_management_system.dto.LoginResponse;
import com.example.assest_management_system.security.JwtService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class AuthService {

    private final AuthenticationManager authenticationManager;
    private final JwtService jwtService;

    @Value("${jwt.expiration-ms}")
    private long expirationMs;

    @Transactional(readOnly = true)
    public LoginResponse login(LoginRequest request) {
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        request.username().trim(), request.password()));

        String username = authentication.getName();
        String role = authentication.getAuthorities().iterator().next()
                .getAuthority().replace("ROLE_", "");

        String token = jwtService.generateToken(username, role);
        return new LoginResponse(token, "Bearer", role, expirationMs);
    }
}