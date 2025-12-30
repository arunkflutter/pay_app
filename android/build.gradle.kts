import java.util.Properties
import org.gradle.authentication.http.BasicAuthentication

// Load local.properties
val properties = Properties()
val localPropertiesFile = rootProject.file("local.properties")
if (localPropertiesFile.exists()) {
    properties.load(localPropertiesFile.inputStream())
}

val repositoryUsername: String =
    properties.getProperty("REPOSITORY_USERNAME") ?: "null"
val repositoryPassword: String =
    properties.getProperty("REPOSITORY_PASSWORD") ?: "null"

allprojects {
    repositories {
        google()
        mavenCentral()

        maven {
            url = uri("https://api.bitbucket.org/2.0/repositories/bluecodemobilesdk/android-sdk/src/releases")

            credentials {
                username = repositoryUsername
                password = repositoryPassword
            }

            authentication {
                create<BasicAuthentication>("basic")
            }
        }
    }
}

/**
 * Custom build directory (Flutter compatible)
 */
val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.set(newBuildDir)

subprojects {
    val newSubprojectBuildDir = newBuildDir.dir(project.name)
    project.layout.buildDirectory.set(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
