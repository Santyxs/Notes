package com.santos.tareas

import android.app.DownloadManager
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Environment
import androidx.core.content.FileProvider
import org.json.JSONObject
import java.io.BufferedReader
import java.io.File
import java.io.InputStreamReader
import java.net.HttpURLConnection
import java.net.URL

/**
 * Comprueba si hay una nueva versión publicada como GitHub Release en el
 * repositorio del proyecto y, si la hay, descarga el APK directamente
 * (sin pasar por el navegador) usando DownloadManager, y ofrece instalarlo.
 *
 * Cada push a `main` genera automáticamente (vía GitHub Actions) un Release
 * público con tag "v<versionCode>" y el APK adjunto como asset.
 */
object UpdateManager {

    private const val REPO_OWNER = "Santyxs"
    private const val REPO_NAME = "Notes"
    private const val LATEST_RELEASE_URL =
        "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/releases/latest"

    private const val PREFS_NAME = "update_manager_prefs"
    private const val KEY_DOWNLOAD_ID = "pending_download_id"
    private const val KEY_DOWNLOAD_URL = "pending_download_url"

    data class UpdateInfo(
        val versionCode: Int,
        val tagName: String,
        val downloadUrl: String,
        val releaseNotes: String
    )

    sealed class CheckResult {
        data class UpdateAvailable(val info: UpdateInfo) : CheckResult()
        object UpToDate : CheckResult()
        data class Error(val message: String) : CheckResult()
    }

    /** Consulta el último Release en GitHub. Debe llamarse en un hilo de fondo. */
    fun checkForUpdate(context: Context): CheckResult {
        return try {
            val json = fetchJson(LATEST_RELEASE_URL)
                ?: return CheckResult.Error(context.getString(R.string.actualizacion_error_red))

            val tagName = json.optString("tag_name", "")
            val remoteVersionCode = tagName.trim().removePrefix("v").toIntOrNull()
                ?: return CheckResult.Error(context.getString(R.string.actualizacion_error_formato))

            val currentVersionCode = BuildConfig.VERSION_CODE

            if (remoteVersionCode <= currentVersionCode) {
                return CheckResult.UpToDate
            }

            val assets = json.optJSONArray("assets")
            var apkUrl: String? = null
            if (assets != null) {
                for (i in 0 until assets.length()) {
                    val asset = assets.getJSONObject(i)
                    val name = asset.optString("name", "")
                    if (name.endsWith(".apk")) {
                        apkUrl = asset.optString("browser_download_url", null)
                        break
                    }
                }
            }

            if (apkUrl == null) {
                return CheckResult.Error(context.getString(R.string.actualizacion_error_apk))
            }

            CheckResult.UpdateAvailable(
                UpdateInfo(
                    versionCode = remoteVersionCode,
                    tagName = tagName,
                    downloadUrl = apkUrl,
                    releaseNotes = json.optString("body", "")
                )
            )
        } catch (e: Exception) {
            CheckResult.Error(context.getString(R.string.actualizacion_error_red))
        }
    }

    private fun fetchJson(urlString: String): JSONObject? {
        val connection = URL(urlString).openConnection() as HttpURLConnection
        return try {
            connection.requestMethod = "GET"
            connection.setRequestProperty("Accept", "application/vnd.github+json")
            connection.connectTimeout = 10_000
            connection.readTimeout = 10_000
            if (connection.responseCode != HttpURLConnection.HTTP_OK) return null

            val reader = BufferedReader(InputStreamReader(connection.inputStream))
            val text = reader.use { it.readText() }
            JSONObject(text)
        } finally {
            connection.disconnect()
        }
    }

    /** Lanza la descarga directa del APK con el DownloadManager del sistema. */
    fun downloadUpdate(context: Context, info: UpdateInfo) {
        val request = DownloadManager.Request(Uri.parse(info.downloadUrl))
            .setTitle(context.getString(R.string.app_name))
            .setDescription(context.getString(R.string.actualizacion_descargando, info.tagName))
            .setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED)
            .setDestinationInExternalFilesDir(
                context,
                Environment.DIRECTORY_DOWNLOADS + "/updates",
                "notas-${info.tagName}.apk"
            )
            .setMimeType("application/vnd.android.package-archive")

        val downloadManager = context.getSystemService(Context.DOWNLOAD_SERVICE) as DownloadManager
        val downloadId = downloadManager.enqueue(request)

        context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE).edit()
            .putLong(KEY_DOWNLOAD_ID, downloadId)
            .putString(KEY_DOWNLOAD_URL, info.downloadUrl)
            .apply()
    }

    private fun installApk(context: Context, downloadId: Long) {
        val downloadManager = context.getSystemService(Context.DOWNLOAD_SERVICE) as DownloadManager
        val uri = downloadManager.getUriForDownloadedFile(downloadId) ?: return

        // getUriForDownloadedFile ya devuelve un content:// Uri válido para
        // destinos en el almacenamiento específico de la app en API 24+,
        // así que se puede usar directamente sin FileProvider adicional.
        val installIntent = Intent(Intent.ACTION_VIEW).apply {
            setDataAndType(uri, "application/vnd.android.package-archive")
            addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
        }
        context.startActivity(installIntent)
    }

    /** Recibe el evento de descarga completada y lanza la instalación. */
    class DownloadCompleteReceiver : BroadcastReceiver() {
        override fun onReceive(context: Context, intent: Intent) {
            if (intent.action != DownloadManager.ACTION_DOWNLOAD_COMPLETE) return

            val completedId = intent.getLongExtra(DownloadManager.EXTRA_DOWNLOAD_ID, -1L)
            if (completedId == -1L) return

            val prefs = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
            val pendingId = prefs.getLong(KEY_DOWNLOAD_ID, -1L)
            if (completedId != pendingId) return

            prefs.edit().remove(KEY_DOWNLOAD_ID).remove(KEY_DOWNLOAD_URL).apply()
            installApk(context, completedId)
        }
    }
}
