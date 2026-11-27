package com.example.assest_management_system.repository;

import com.example.assest_management_system.entity.AssetCategory;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AssetCategoryRepository extends JpaRepository<AssetCategory, Long> {

    // Is this name already used? (ignores upper/lower case)
    boolean existsByCategoryNameIgnoreCase(String categoryName);

    // Same check for renaming: does ANOTHER category already use this name?
    boolean existsByCategoryNameIgnoreCaseAndIdNot(String categoryName, Long id);
}
