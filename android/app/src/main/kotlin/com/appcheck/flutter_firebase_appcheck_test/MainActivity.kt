package com.appcheck.flutter_firebase_appcheck_test

import android.util.Log
import androidx.annotation.NonNull
import com.google.firebase.FirebaseApp
import com.google.firebase.appcheck.FirebaseAppCheck
import com.google.firebase.appcheck.debug.DebugAppCheckProviderFactory
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
   override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "method-channel").setMethodCallHandler { call, result ->
            if (call.method == "getFirebaseAppCheckDebugToken") {
                FirebaseApp.initializeApp(this)
                Log.d("configureFlutterEngine", "FirebaseApp.initializeApp")

                val firebaseAppCheck = FirebaseAppCheck.getInstance()
                Log.d("configureFlutterEngine", "firebaseAppCheck")
                firebaseAppCheck.installAppCheckProviderFactory(DebugAppCheckProviderFactory.getInstance())
                Log.d("configureFlutterEngine", "installAppCheckProviderFactory")

                result.success("Yay!")
            }
        }
    }
}
