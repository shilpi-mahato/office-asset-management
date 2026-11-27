package com.example.assest_management_system.temp;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;

// TEMPORARY: lets Postman reach the test endpoints without login.
// Delete this file when you build the real security in Step 5.
@Configuration
public class TempSecurityConfig {

    @Bean
    public SecurityFilterChain tempFilterChain(HttpSecurity http) throws Exception {
        http.csrf(csrf -> csrf.disable())
                .authorizeHttpRequests(auth -> auth.anyRequest().permitAll());
        return http.build();
    }
}