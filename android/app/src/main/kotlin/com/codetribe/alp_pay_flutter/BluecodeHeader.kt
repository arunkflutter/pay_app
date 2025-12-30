package com.codetribe.alp_pay_flutter
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.FrameLayout
import androidx.core.content.ContentProviderCompat.requireContext
import androidx.fragment.app.Fragment
import io.flutter.embedding.android.FlutterView
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import kotlin.math.roundToInt

class BluecodeHeader: Fragment() {

    private lateinit var flutterEngine: FlutterEngine
    private lateinit var flutterView: FlutterView

    companion object{
        private val HEADER_HEIGHT = "header_height"

        fun getCustomHeader(heightDp: Int): BluecodeHeader{
            val args = Bundle()
            args.putInt(HEADER_HEIGHT, heightDp)
            val fragment = BluecodeHeader()
            fragment.arguments = args
            return fragment
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        flutterEngine = FlutterEngine(requireContext())
        flutterEngine?.navigationChannel?.setInitialRoute("/custom_header")
        flutterEngine?.dartExecutor?.executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
        )
        FlutterEngineCache.getInstance().put("custom_layout_header", flutterEngine)
    }


    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        flutterView = FlutterView(requireContext())
        flutterView.attachToFlutterEngine(flutterEngine)

        val layoutHeightDp = arguments?.getInt(HEADER_HEIGHT) ?: 100
        val layoutHeightPx = dpToPx(layoutHeightDp)

        val layout = FrameLayout(requireContext())
        val layoutParams = FrameLayout.LayoutParams(
            FrameLayout.LayoutParams.MATCH_PARENT,
            layoutHeightPx
        )
        layout.addView(flutterView, layoutParams)

        return layout
    }

    fun dpToPx(dp: Int): Int {
        val density = resources.displayMetrics.density
        return (dp * density).roundToInt()
    }

    override fun onDestroyView() {
        super.onDestroyView()
        flutterView.detachFromFlutterEngine()

    }

    override fun onDestroy() {
        super.onDestroy()
        flutterEngine.destroy()
    }
}