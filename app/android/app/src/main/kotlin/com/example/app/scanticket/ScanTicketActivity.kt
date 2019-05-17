package com.example.app.scanticket

import android.Manifest
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Bundle
import android.support.v4.app.ActivityCompat
import android.support.v7.app.AppCompatActivity
import android.util.Log
import android.view.KeyEvent
import com.afollestad.materialdialogs.MaterialDialog
import com.afollestad.materialdialogs.Theme
import com.example.app.R
import com.google.zxing.BarcodeFormat
import com.google.zxing.ResultPoint
import com.google.zxing.client.android.BeepManager
import com.journeyapps.barcodescanner.BarcodeCallback
import com.journeyapps.barcodescanner.BarcodeResult
import com.journeyapps.barcodescanner.DefaultDecoderFactory
import kotlinx.android.synthetic.main.scan_activity.*
import java.util.*


class ScanTicketActivity : AppCompatActivity() {

    private lateinit var beepManager: BeepManager
    private var productId: Int? = 0
    private var context: Context? = null

    companion object {
        private const val KEY_PRODUCT_ID = "KEY_PRODUCT_ID"
        private const val KEY_PRODUCT_NAME = "KEY_PRODUCT_NAME"
        fun createIntent(context: Context, productId: Int, productName: String): Intent {
            val intent = Intent(context, ScanTicketActivity::class.java)
            intent.putExtra(KEY_PRODUCT_ID, productId)
            intent.putExtra(KEY_PRODUCT_NAME, productName)
            return intent
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.scan_activity)

//        initObj()
        initView()
        initListener()
//        handleFireBaseRealTime()

//        ScanStatusSuccessDialog.newInstance().showNow(supportFragmentManager , null)
    }

//    private fun initObj() {
//        productId = intent.getIntExtra(KEY_PRODUCT_ID, 0)
//        context = this
//        beepManager = BeepManager(this)
//        scanTicketViewModel = ViewModelProviders.of(this).get(ScanTicketViewModel::class.java)
//    }
//
//    private fun handleFireBaseRealTime() {
//        val fireBase = FireBaseDatabaseHelper()
//        fireBase.setOnFireBaseDataChangeListener(HandleOnFireBaseDataChange())
//        fireBase.getEvent(productId.toString())
//    }
//
//    inner class HandleOnFireBaseDataChange : FireBaseDatabaseHelper.OnFireBaseDataChange {
//        override fun OnChange(countModel: CountModel) {
//            tvCheckInCount.text = countModel.checkin.toString()
//            tvTicketAll.text = countModel.all.toString()
//        }
//    }

    private fun initView() {
        ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.CAMERA), 1)
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)

        if (requestCode == 1) {
            if (grantResults.isEmpty() || grantResults[0] != PackageManager.PERMISSION_GRANTED) {
                Log.i("ScanTicketActivity", "Permission has been denied by user")
            } else {
                Log.i("ScanTicketActivity", "Permission has been granted by user")
                // QR View
                val formats = Arrays.asList(BarcodeFormat.QR_CODE, BarcodeFormat.CODE_39)
                decoratedBarcodeView.barcodeView.decoderFactory = DefaultDecoderFactory(formats)
                decoratedBarcodeView.decodeContinuous(ScanCallback())
                decoratedBarcodeView.setStatusText("")
            }
        }
    }

    inner class ScanCallback : BarcodeCallback {
        override fun barcodeResult(result: BarcodeResult?) {
            beepManager.playBeepSoundAndVibrate()
            decoratedBarcodeView.pauseAndWait()

            result?.text?.let { data ->
                MaterialDialog.Builder(this@ScanTicketActivity).title("Native Dialog")
                        .content(data)
                        .theme(Theme.LIGHT)
                        .positiveText("Ok")
                        .negativeText("Cancel")
                        .onPositive { _, _ -> decoratedBarcodeView.resume() }
                        .onNegative { _, _ -> decoratedBarcodeView.resume()}
                        .show()
            }
        }

        override fun possibleResultPoints(resultPoints: MutableList<ResultPoint>?) {
            //
        }
    }

    private fun initListener() {
//        toolbar.setNavigationOnClickListener {
//            finish()
//        }
    }

    override fun onResume() {
        super.onResume()
        decoratedBarcodeView.resume()
    }

    override fun onPause() {
        super.onPause()
        decoratedBarcodeView.pause()
    }

    override fun onKeyDown(keyCode: Int, event: KeyEvent?): Boolean {
        return decoratedBarcodeView.onKeyDown(keyCode, event) || super.onKeyDown(keyCode, event)
    }

}