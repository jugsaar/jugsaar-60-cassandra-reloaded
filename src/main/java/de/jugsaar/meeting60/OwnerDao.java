package de.jugsaar.meeting60;

import com.datastax.oss.driver.api.core.PagingIterable;
import com.datastax.oss.driver.api.mapper.annotations.Dao;
import com.datastax.oss.driver.api.mapper.annotations.Delete;
import com.datastax.oss.driver.api.mapper.annotations.Insert;
import com.datastax.oss.driver.api.mapper.annotations.Select;

import java.util.UUID;

@Dao
public interface OwnerDao {
    @Select(customWhereClause = "last_name LIKE :searchString")
    PagingIterable<Owner> findByName(String searchString);

    @Select
    Owner findById(UUID ownerId);

    @Insert
    void save(Owner owner);

    @Delete
    void delete(Owner owner);
}
