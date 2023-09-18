## Create jar file and run app from task 9

1. Add manifest configuration
```kotlin
tasks.jar {
    manifest.attributes["Main-Class"] = "com.danilovfa.Main"
}
```

2. Create jar file
```bash
> cd src/main/java/com/danilovfa/task9
> gradle jar
```

3. Run jar file
```bash
> cd build/libs
> java -jar task9-1.0-SNAPSHOT.jar
```