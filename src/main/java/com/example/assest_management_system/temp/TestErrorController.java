package com.example.assest_management_system.temp;

import com.example.assest_management_system.exception.BadRequestException;
import com.example.assest_management_system.exception.ConflictException;
import com.example.assest_management_system.exception.ResourceNotFoundException;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

// TEMPORARY: delete this whole file when Step 4 testing is done
@RestController
@RequestMapping("/test")
public class TestErrorController {

    public record TestBody(@NotBlank(message = "reason must not be blank") String reason) {
    }

    @GetMapping("/not-found")
    public String notFound() {
        throw new ResourceNotFoundException("Request 99 not found");
    }

    @GetMapping("/conflict")
    public String conflict() {
        throw new ConflictException("You already have an open request for this category");
    }

    @GetMapping("/bad-request")
    public String badRequest() {
        throw new BadRequestException("The new manager must have the role MANAGER");
    }

    @GetMapping("/crash")
    public String crash() {
        throw new RuntimeException("secret internal detail that must not reach the client");
    }

    @GetMapping("/number/{id}")
    public String number(@PathVariable Long id) {
        return "ok " + id;
    }

    @PostMapping("/validate")
    public String validate(@Valid @RequestBody TestBody body) {
        return "ok " + body.reason();
    }
}
