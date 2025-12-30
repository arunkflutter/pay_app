package com.codetribe.alp_pay_flutter
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import io.flutter.embedding.android.FlutterFragment
import io.flutter.embedding.android.FlutterView
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor

class BluecodeFooter : Fragment() {

    private lateinit var flutterEngine: FlutterEngine
    private lateinit var flutterView: FlutterView

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        flutterEngine = FlutterEngine(requireContext())
        flutterEngine?.navigationChannel?.setInitialRoute("/custom_footer")
        flutterEngine?.dartExecutor?.executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
        )
        FlutterEngineCache.getInstance().put("custom_layout_footer", flutterEngine)
    }


    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        flutterView = FlutterView(requireContext())

        flutterView.attachToFlutterEngine(flutterEngine)

        return flutterView
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
