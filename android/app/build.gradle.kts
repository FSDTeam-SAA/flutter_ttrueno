plugins {
    id("com.android.application")
    id("kotlin-android")
    id("com.google.android.libraries.mapsplatform.secrets-gradle-plugin")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.ttrueno_fo827e642a0c4"
    compileSdk = 36

    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.ttrueno_fo827e642a0c4"
        minSdk = flutter.minSdkVersion
        targetSdk = 35
        versionCode = project.properties["flutter.versionCode"]?.toString()?.toInt() ?: 1
        versionName = project.properties["flutter.versionName"]?.toString() ?: "1.0.0"
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

// Secrets Gradle Plugin configuration
secrets {
    // This is your secrets file containing your real keys (should NOT be checked into git)
    propertiesFileName = "secrets.properties"

    // Optional default secrets file (can be checked in, with dummy/fallback keys)
    defaultPropertiesFileName = "local.defaults.properties"
}

flutter {
    source = "../.."
}
