package com.example.app

import android.os.Bundle
import com.afollestad.materialdialogs.MaterialDialog
import com.afollestad.materialdialogs.Theme
import com.example.app.scanticket.ScanTicketActivity
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
    initFlutterChannel()
  }

  private fun initFlutterChannel() {
    val channel = MethodChannel(flutterView, "flutter.theconcert/scan")
    channel.setMethodCallHandler { methodCall, result ->
      val args = methodCall.arguments as List<*>
      val param = args.first() as String

      when (methodCall.method) {
        "openCamera" -> openSecondActivity(param)
        "showDialog" -> showDialog(param, result)
        else -> return@setMethodCallHandler
      }
    }
  }


  private fun openSecondActivity(info: String) {
    startActivity(ScanTicketActivity.createIntent(this@MainActivity,0,info))
  }


  private fun showDialog(content: String, channelResult: MethodChannel.Result) {
    MaterialDialog.Builder(this).title("Native Dialog")
            .content(content)
            .theme(Theme.LIGHT)
            .positiveText("Ok")
            .negativeText("Cancel")
            .onPositive { _, _ -> channelResult.success("Ok was clicked") }
            .onNegative { _, _ -> channelResult.success("Cancel was clicked") }
            .show()
  }
}
