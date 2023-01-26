package de.jugsaar.meeting60;

import com.datastax.oss.driver.api.core.CqlSession;
import com.datastax.oss.driver.api.core.cql.ResultSet;
import com.datastax.oss.driver.api.core.cql.Row;

import java.net.InetSocketAddress;


public class Demo01 {

    public static void main(String[] args) {
        try (CqlSession session = CqlSession.builder()
                .addContactPoint(new InetSocketAddress("127.0.0.1", 9042))
                .withLocalDatacenter("datacenter1")
                .build()) {
            ResultSet rs = session.execute("SELECT release_version FROM system.local");
            Row row = rs.one();
            System.out.println(row.getString("release_version"));
        }
    }

}
