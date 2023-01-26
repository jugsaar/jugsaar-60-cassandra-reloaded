package de.jugsaar.meeting60;

import com.datastax.oss.driver.api.core.CqlIdentifier;
import com.datastax.oss.driver.api.mapper.annotations.DaoFactory;
import com.datastax.oss.driver.api.mapper.annotations.DaoKeyspace;
import com.datastax.oss.driver.api.mapper.annotations.Mapper;

@Mapper
public interface PetClinicMapper {
    @DaoFactory
    OwnerDao ownerDao(@DaoKeyspace CqlIdentifier keyspace);
}
