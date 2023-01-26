package de.jugsaar.meeting60;

import com.datastax.oss.driver.api.mapper.annotations.Entity;
import com.datastax.oss.driver.api.mapper.annotations.PartitionKey;
import lombok.Data;

import java.util.UUID;

@Data
@Entity
public class Owner {
    @PartitionKey private UUID id;
    private String firstName;
    private String lastName;
    private String address;
    private String city;
    private String telephone;
}
