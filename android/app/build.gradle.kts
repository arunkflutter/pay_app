import java.util.Properties

plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    // Flutter Gradle plugin must be last
    id("dev.flutter.flutter-gradle-plugin")
}

// Load local.properties
val localProperties = Properties()
val localPropertiesFile = rootProject.file("local.properties")
if (localPropertiesFile.exists()) {
    localPropertiesFile.inputStream().use {
        localProperties.load(it)
    }
}

val flutterVersionCode: Int =
    localProperties.getProperty("flutter.versionCode")?.toInt() ?: 1

val flutterVersionName: String =
    localProperties.getProperty("flutter.versionName") ?: "1.0"

android {

    namespace = "com.codetribe.alp_pay_flutter"
    compileSdk = 36
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    sourceSets {
        getByName("main").java.srcDirs("src/main/kotlin")
    }

    defaultConfig {
        applicationId = "com.codetribe.alp_pay_flutter"
        minSdk = 24
        targetSdk = flutter.targetSdkVersion
        versionCode = flutterVersionCode
        versionName = flutterVersionName

        // (Optional) manifest placeholder if needed by SDK
        manifestPlaceholders["applicationName"] = "com.codetribe.alp_pay_flutter"
    }

    android {
        buildTypes {
            release {
                signingConfig = signingConfigs.getByName("debug") // Use your actual release signingConfig

                // Disable minification (R8) for testing
                isMinifyEnabled = false
                isShrinkResources = false

                // Proguard files
                proguardFiles(
                    getDefaultProguardFile("proguard-android-optimize.txt"),
                    file("proguard-rules.pro")
                )
            }
        }
    }
}
    flutter {
    source = "../.."
}

dependencies {
    implementation("androidx.multidex:multidex:2.0.1")
    implementation("androidx.core:core-ktx:1.2.0")
    implementation("androidx.appcompat:appcompat:1.7.0")
    implementation("com.google.android.material:material:1.12.0")
    implementation("androidx.constraintlayout:constraintlayout:2.1.4")

    // ✅ Bluecode SDK
    implementation("at.bluecode.sdk:bluecode-sdk:7.2.55")

    // Desugaring
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")
}
