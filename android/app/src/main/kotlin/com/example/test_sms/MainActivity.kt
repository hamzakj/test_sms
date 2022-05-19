package com.example.test_sms

import android.telephony.SmsManager
import android.widget.Toast
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.lang.Exception

class MainActivity: FlutterActivity() {

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "sms").setMethodCallHandler {
            call, result ->

            if(call.method.equals("sendSMS"))
            {
                val argMap = (call.arguments as Map<String,String>)
                val numsMap = argMap["nums"] as List<String>
                val contentsMap = argMap["contents"] as List<String>
                sendSMS(numsMap,contentsMap)
            }
        }
    }
    fun sendSMS(arguments: List<String>, contentsMap: List<String>) {
        for (x in arguments.indices) {
            if (arguments[x].length > 6) {
                try {
                    var smsManager = SmsManager.getDefault()
                    smsManager.sendTextMessage(arguments[x], null, contentsMap[x], null, null)
                    Toast.makeText(this, arguments[x] + "true", Toast.LENGTH_LONG).show()
                } catch (e: Exception) {
                    Toast.makeText(this, arguments[x] + "false", Toast.LENGTH_LONG).show()
                }
            }
        }

    }

}
