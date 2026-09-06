plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
}

android {
    namespace = "com.santos.tareas"
    compileSdk = 34

    val appVersionCode = (project.findProperty("versionCode") as String?)?.toIntOrNull() ?: 1

    defaultConfig {
        applicationId = "com.santos.tareas"
        minSdk = 24
        targetSdk = 34
        versionCode = appVersionCode
        versionName = "1.$appVersionCode"
    }

    signingConfigs {
        create("release") {
            val keystorePath = project.findProperty("RELEASE_KEYSTORE_PATH") as String?
            if (keystorePath != null) {
                storeFile = file(keystorePath)
                storePassword = project.findProperty("RELEASE_KEYSTORE_PASSWORD") as String?
                keyAlias = project.findProperty("RELEASE_KEY_ALIAS") as String?
                keyPassword = project.findProperty("RELEASE_KEY_PASSWORD") as String?
            }
        }
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            // Si no se pasan las propiedades de firma (build local), cae de
            // vuelta a la firma debug para que `assembleRelease` siga
            // funcionando sin configuración adicional.
            signingConfig = if (project.hasProperty("RELEASE_KEYSTORE_PATH")) {
                signingConfigs.getByName("release")
            } else {
                signingConfigs.getByName("debug")
            }
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    buildFeatures {
        viewBinding = true
    }
}

dependencies {
    implementation("androidx.core:core-ktx:1.13.1")
    implementation("androidx.appcompat:appcompat:1.7.0")
    implementation("androidx.recyclerview:recyclerview:1.3.2")
    implementation("com.google.android.material:material:1.12.0")
    implementation("androidx.constraintlayout:constraintlayout:2.1.4")
    implementation("androidx.biometric:biometric:1.1.0")
}
