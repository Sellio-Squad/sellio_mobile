pluginManagement {
    val flutterSdkPath = run {
        val properties = java.util.Properties()
        file("local.properties").inputStream().use { properties.load(it) }
        val flutterSdkPath = properties.getProperty("flutter.sdk")
        require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
        flutterSdkPath
    }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "9.3.2" apply false
    // START: FlutterFire Configuration
    id("com.google.gms.google-services") version("4.5.0") apply false
    // END: FlutterFire Configuration
    id("org.jetbrains.kotlin.android") version "2.3.21" apply false
}

include(":app")

// Force plugin subprojects to compile against a modern Android SDK
// (e.g. country_detector ships with compileSdk 33 but requires 34+)
gradle.afterProject {
    if (path == ":") return@afterProject
    extensions.findByName("android")?.withGroovyBuilder {
        val current = getProperty("compileSdk") as? Int ?: return@withGroovyBuilder
        if (current < 37) {
            setProperty("compileSdk", 37)
        }
    }
}
