# jugsaar-60-cassandra-reloaded

Code &amp; Slides for "Massiv skalierbare und hochverfügbare Datenhaltung mit Apache Cassandra" von Dr. Philipp Walter

## Slides

➡ [Download PDF slides here](slides.pdf)

## Java Code

The Java samples connect to a Cassandra instance at `localhost:9042` and expect the `petclinic` keyspace by default. Possible setups:

1. The Docker-based [official quickstart setup](https://cassandra.apache.org/_/quickstart.html) is easy to set up, but more difficult to enable SASI indexes
(`cassandra` container must be run with a custom `cassandra.yaml`).
2. **Recommended:** set up your local CCM cluster to have more possibilities for experimentation.
SASI indexes can be activated then by editing the config in `~/.ccm`.

## Set up your local CCM cluster

1. Check that you have Python 3.x and Java 11

    ```shell
    $ python --version
    Python 3.10.9
    $ java -version
    openjdk version "11.0.18" 2023-01-17
    OpenJDK Runtime Environment (build 11.0.18+10)
    OpenJDK 64-Bit Server VM (build 11.0.18+10, mixed mode)
    ```

2. Install CCM

    ```shell
    $ virtualenv --python=python3 --clear --always-copy ~/cassandra-venv
    $ source ~/cassandra-venv/bin/activate
    $ pip install ccm
    ```

3. Create your local cluster

    ```shell
    $ ccm create -v 4.1.0 -n 3 jugsaar
    ```

4. Start your cluster

    ```shell
    $ ccm start
    [node2 ERROR] b'OpenJDK 64-Bit Server VM warning: Option UseConcMarkSweepGC was deprecated in version 9.0 and will likely be removed in a future release.'
    [node3 ERROR] b'OpenJDK 64-Bit Server VM warning: Option UseConcMarkSweepGC was deprecated in version 9.0 and will likely be removed in a future release.'
    ```
   Ignore error messages about the deprecated GC.


5. Check your cluster

    ```shell
    $ ccm status
    Cluster: 'jugsaar'
    ------------------
    node1: UP
    node2: UP
    node3: UP
    $ cqlsh
    Connected to jugsaar at 127.0.0.1:9042
    [cqlsh 6.1.0 | Cassandra 4.1.0 | CQL spec 3.4.6 | Native protocol v5]
    Use HELP for help.
    cqlsh> 
    ```

6. Activate SASI indexes and restart your cluster

   ```shell
   $ sed -i.orig '/sasi_indexes_enabled/c sasi_indexes_enabled: true' ~/.ccm/jugsaar/node*/conf/cassandra.yaml
   $ ccm stop
   $ ccm start
   ```

7. Import petclinic keyspace

   ```shell
   cqlsh> source 'petclinic.cql'
   
   Warnings :
   SASI indexes are experimental and are not recommended for production use.

   ```

## Compile and run demos

Cassandra needs Java 11, but the code itself runs on current verions:

```shell
$ JAVA_HOME=/usr/lib/jvm/java-19-openjdk mvn clean package
...
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  2.695 s
[INFO] Finished at: 2023-01-26T17:46:20+01:00
[INFO] ------------------------------------------------------------------------
```

### Demo 1

```shell
JAVA_HOME=/usr/lib/jvm/java-19-openjdk mvn exec:java -Dexec.mainClass="de.jugsaar.meeting60.Demo01"
[INFO] Scanning for projects...
[INFO]
[INFO] -------------------< de.jugsaar.meeting60:cassandra >-------------------
[INFO] Building cassandra 1.0-SNAPSHOT
[INFO] --------------------------------[ jar ]---------------------------------
[INFO]
[INFO] --- exec-maven-plugin:3.1.0:java (default-cli) @ cassandra ---
4.1.0
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  4.715 s
[INFO] Finished at: 2023-01-26T17:57:51+01:00
[INFO] ------------------------------------------------------------------------
```

(Yes, if you see "4.1.0", it works!)

### Demo 2

```shell
JAVA_HOME=/usr/lib/jvm/java-19-openjdk mvn exec:java -Dexec.mainClass="de.jugsaar.meeting60.Demo02"
[INFO] Scanning for projects...
[INFO]
[INFO] -------------------< de.jugsaar.meeting60:cassandra >-------------------
[INFO] Building cassandra 1.0-SNAPSHOT
[INFO] --------------------------------[ jar ]---------------------------------
[INFO]
[INFO] --- exec-maven-plugin:3.1.0:java (default-cli) @ cassandra ---
Owner(id=d7b4c8d4-8a1b-11ed-abd5-14857f0c9b17, firstName=Betty, lastName=Davis, address=638 Cardinal Ave., city=Sun Prairie, telephone=6085551749)
Owner(id=d84f2e7e-8a1b-11ed-9e39-14857f0c9b17, firstName=Harold, lastName=Davis, address=563 Friendly St., city=Windsor, telephone=6085553198)
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  4.175 s
[INFO] Finished at: 2023-01-26T17:59:19+01:00
[INFO] ------------------------------------------------------------------------
```
