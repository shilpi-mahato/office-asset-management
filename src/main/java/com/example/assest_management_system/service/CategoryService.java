package com.example.assest_management_system.service;

import com.example.assest_management_system.dto.CategoryRequest;
import com.example.assest_management_system.dto.CategoryResponse;
import com.example.assest_management_system.dto.PageResponse;
import com.example.assest_management_system.entity.AssetCategory;
import com.example.assest_management_system.exception.ConflictException;
import com.example.assest_management_system.exception.ResourceNotFoundException;
import com.example.assest_management_system.repository.AssetCategoryRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class CategoryService {

    private final AssetCategoryRepository repository;

    @Transactional
    public CategoryResponse create(CategoryRequest request) {
        String name = request.name().trim();
        if (repository.existsByCategoryNameIgnoreCase(name)) {
            throw new ConflictException("Category '" + name + "' already exists");
        }
        AssetCategory category = new AssetCategory();
        category.setCategoryName(name);
        return toResponse(repository.save(category));
    }

    @Transactional(readOnly = true)
    public PageResponse<CategoryResponse> list(Pageable pageable) {
        return PageResponse.from(repository.findAll(pageable).map(this::toResponse));
    }

    @Transactional
    public CategoryResponse update(Long id, CategoryRequest request) {
        AssetCategory category = repository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Category " + id + " not found"));

        String name = request.name().trim();
        if (repository.existsByCategoryNameIgnoreCaseAndIdNot(name, id)) {
            throw new ConflictException("Category '" + name + "' already exists");
        }
        // No save() needed: the entity is managed, so the change is written on commit
        category.setCategoryName(name);
        return toResponse(category);
    }

    private CategoryResponse toResponse(AssetCategory category) {
        return new CategoryResponse(category.getId(), category.getCategoryName());
    }
}
