package de.jugsaar.meeting60;

import com.datastax.oss.driver.api.core.CqlIdentifier;
import com.datastax.oss.driver.api.core.CqlSession;
import com.datastax.oss.driver.api.core.PagingIterable;

public class Demo02 {

    public static void main(String[] args) {
        try (CqlSession session = CqlSession.builder().build()) {
            final PetClinicMapper mapper = new PetClinicMapperBuilder(session).build();
            final OwnerDao ownerDao = mapper.ownerDao(CqlIdentifier.fromCql("petclinic"));
            final PagingIterable<Owner> owners = ownerDao.findByName("%dav%");
            for(Owner owner: owners) {
                System.out.println(owner);
            }
        }
    }

}
