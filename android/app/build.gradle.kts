import java.util.Properties
import java.io.FileInputStream

val localProperties = Properties().apply {
    val localPropertiesFile = rootProject.file("local.properties")
    if (localPropertiesFile.exists()) {
        localPropertiesFile.inputStream().use { load(it) }
    }
}

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("com.google.android.libraries.mapsplatform.secrets-gradle-plugin")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")

}

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "com.hoplift.app"
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
        applicationId = "com.hoplift.app"
        manifestPlaceholders.put("appAuthRedirectScheme", "com.hoplift.app")
        minSdk = flutter.minSdkVersion
        targetSdk = 35
        versionCode = project.properties["flutter.versionCode"]?.toString()?.toInt() ?: 5
        versionName = project.properties["flutter.versionName"]?.toString() ?: "1.0.1"
    }

    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String
            keyPassword = keystoreProperties["keyPassword"] as String
            storeFile = keystoreProperties["storeFile"]?.let { file(it) }
            storePassword = keystoreProperties["storePassword"] as String
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
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

dependencies {
    // ✅ Kotlin DSL uses double quotes, not single quotes
    implementation("com.facebook.android:facebook-login:16.2.0")
}