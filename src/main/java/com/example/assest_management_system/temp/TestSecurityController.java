package com.example.assest_management_system.temp;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

// TEMPORARY: delete this whole package when the real endpoints exist
@RestController
@RequestMapping("/test")
public class TestSecurityController {

    @GetMapping("/me")
    public Map<String, String> me(Authentication authentication) {
        String role = authentication.getAuthorities().iterator().next()
                .getAuthority().replace("ROLE_", "");
        return Map.of("username", authentication.getName(), "role", role);
    }

    @GetMapping("/admin-only")
    @PreAuthorize("hasRole('ADMIN')")
    public Map<String, String> adminOnly() {
        return Map.of("message", "Hello admin");
    }
}