package com.kgplife.erpalerts


import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Intent
import android.provider.CalendarContract
//import io.flutter.embedding.android.FlutterFragmentActivity

//class MainActivity: FlutterFragmentActivity() {
//}

class MainActivity: FlutterActivity(){
    private val CHANNEL = "com.kgplife.erpalerts/calendar"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "addEventToCalendar") {
                val title = call.argument<String>("title")
                val description = call.argument<String>("description")
                val location = call.argument<String>("location")
                val startDate = call.argument<Long>("startDate")
                val endDate = call.argument<Long>("endDate")

                addEvent(title, description, location, startDate, endDate)
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun addEvent(title: String?, description: String?, location: String?, startDate: Long?, endDate: Long?) {
        val intent = Intent(Intent.ACTION_INSERT).apply {
            data = CalendarContract.Events.CONTENT_URI
            putExtra(CalendarContract.Events.TITLE, title)
            putExtra(CalendarContract.Events.DESCRIPTION, description)
            putExtra(CalendarContract.Events.EVENT_LOCATION, location)
            putExtra(CalendarContract.EXTRA_EVENT_BEGIN_TIME, startDate)
            putExtra(CalendarContract.EXTRA_EVENT_END_TIME, endDate)
        }
        startActivity(intent)
        // Set the reminders. This will only work if the calendar app supports it.
        intent.putExtra(CalendarContract.Reminders.MINUTES, arrayOf(60, 30, 10))
        intent.putExtra(CalendarContract.Reminders.METHOD, CalendarContract.Reminders.METHOD_ALERT)
    }
}