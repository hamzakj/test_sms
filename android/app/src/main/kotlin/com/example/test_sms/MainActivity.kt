package com.example.test_sms

import android.provider.Settings
import android.telephony.SmsManager
import android.widget.Toast
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import org.json.JSONObject
import java.lang.Exception

class MainActivity: FlutterActivity() {

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "sms").setMethodCallHandler {
            call, result ->

            if(call.method.equals("sendSMS"))
            {
                val argMap = (call.arguments as List<String>)
                sendSMS(argMap)
            }
        }
    }
    fun sendSMS(arguments: List<String> ) {
        for (x in arguments) {
          try {
              var smsManager = SmsManager.getDefault()
              smsManager.sendTextMessage(x, null, x, null, null)
              Toast.makeText(this, x+"true", Toast.LENGTH_LONG).show()
          }  catch(e:Exception) {
              Toast.makeText(this, x+"false", Toast.LENGTH_LONG).show()
          }
        }

    }

}
