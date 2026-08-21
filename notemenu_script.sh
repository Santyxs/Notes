#!/bin/bash
set -e

mkdir -p app
cat > app/build.gradle.kts << 'ZZEOF'
plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
}

android {
    namespace = "com.santos.tareas"
    compileSdk = 34

    defaultConfig {
        applicationId = "com.santos.tareas"
        minSdk = 24
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"
    }

    buildTypes {
        release {
            isMinifyEnabled = false
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
ZZEOF

mkdir -p app/src/main
cat > app/src/main/AndroidManifest.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android">

    <uses-permission android:name="android.permission.USE_BIOMETRIC" />

    <application
        android:allowBackup="true"
        android:icon="@mipmap/ic_launcher"
        android:label="@string/app_name"
        android:roundIcon="@mipmap/ic_launcher_round"
        android:supportsRtl="true"
        android:theme="@style/Theme.Tareas">

        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:label="@string/app_name">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>

        <activity
            android:name=".TasksActivity"
            android:exported="false"
            android:label="@string/tareas" />

        <activity
            android:name=".NotesActivity"
            android:exported="false"
            android:label="@string/notas" />

        <activity
            android:name=".TrashActivity"
            android:exported="false"
            android:label="@string/papelera"
            android:theme="@style/Theme.Tareas.Dialog" />

        <activity
            android:name=".SettingsActivity"
            android:exported="false"
            android:label="@string/ajustes"
            android:theme="@style/Theme.Tareas.Dialog" />

        <activity
            android:name=".AddEditTaskActivity"
            android:exported="false"
            android:label="@string/tareas"
            android:theme="@style/Theme.Tareas.Dialog" />

        <activity
            android:name=".AddEditNoteActivity"
            android:exported="false"
            android:label="@string/notas"
            android:theme="@style/Theme.Tareas.Dialog" />

        <receiver
            android:name=".TaskWidgetProvider"
            android:exported="false"
            android:label="">
            <intent-filter>
                <action android:name="android.appwidget.action.APPWIDGET_UPDATE" />
            </intent-filter>
            <meta-data
                android:name="android.appwidget.provider"
                android:resource="@xml/task_widget_info" />
        </receiver>

        <receiver
            android:name=".NoteWidgetProvider"
            android:exported="false"
            android:label="">
            <intent-filter>
                <action android:name="android.appwidget.action.APPWIDGET_UPDATE" />
            </intent-filter>
            <meta-data
                android:name="android.appwidget.provider"
                android:resource="@xml/note_widget_info" />
        </receiver>

        <service
            android:name=".TaskWidgetService"
            android:exported="false"
            android:permission="android.permission.BIND_REMOTEVIEWS" />

        <service
            android:name=".NoteWidgetService"
            android:exported="false"
            android:permission="android.permission.BIND_REMOTEVIEWS" />

    </application>

</manifest>
ZZEOF

mkdir -p app/src/main/res/values
cat > app/src/main/res/values/strings.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="app_name">Notas</string>
    <string name="notas">Notas</string>
    <string name="tareas">Tareas</string>
    <string name="buscar">Buscar</string>
    <string name="sin_tareas">No hay tareas todavía</string>
    <string name="sin_notas">No hay notas todavía</string>
    <string name="tocar_para_editar">Tocar para crear una tarea</string>
    <string name="titulo">Título</string>
    <string name="anota_algo">Anota algo</string>
    <string name="anadir">Añadir</string>
    <string name="guardar">Guardar</string>
    <string name="cancelar">Cancelar</string>
    <string name="anadir_tarea">Añadir tarea</string>
    <string name="anadir_nota">Añadir nota</string>
    <string name="marcar_tarea">Marcar tarea</string>
    <string name="eliminar_tarea">Eliminar tarea</string>
    <string name="eliminar_nota">Eliminar nota</string>
    <string name="vista_lista">Vista de lista</string>
    <string name="vista_tarjeta">Vista de tarjeta</string>
    <string name="vista_cuadricula">Vista de cuadrícula</string>
    <string name="todas_las_notas">Todas las notas</string>
    <string name="todas_las_tareas">Todas las tareas</string>
    <string name="papelera">Papelera</string>
    <string name="ajustes">Ajustes</string>
    <string name="papelera_vacia">La papelera está vacía</string>
    <string name="vaciar_papelera">Vaciar papelera</string>
    <string name="restaurar">Restaurar</string>
    <string name="eliminar_definitivamente">Eliminar definitivamente</string>
    <string name="acerca_de">Acerca de</string>
    <string name="nota_bloqueada">Nota bloqueada</string>
    <string name="anclar">Anclar</string>
    <string name="desanclar">Desanclar</string>
    <string name="bloquear">Bloquear</string>
    <string name="desbloquear">Desbloquear</string>
    <string name="compartir">Compartir</string>
    <string name="color_de_fondo">Color de fondo</string>
    <string name="desbloquear_nota">Desbloquea la nota para continuar</string>
</resources>
ZZEOF

mkdir -p app/src/main/res/drawable
cat > app/src/main/res/drawable/ic_share.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="22dp"
    android:height="22dp"
    android:viewportWidth="24"
    android:viewportHeight="24"
    android:tint="@color/white">
    <path
        android:fillColor="@android:color/white"
        android:pathData="M18,16.08c-0.76,0 -1.44,0.3 -1.96,0.77L8.91,12.7c0.05,-0.23 0.09,-0.46 0.09,-0.7s-0.04,-0.47 -0.09,-0.7l7.05,-4.11c0.54,0.5 1.25,0.81 2.04,0.81c1.66,0 3,-1.34 3,-3s-1.34,-3 -3,-3 -3,1.34 -3,3c0,0.24 0.04,0.47 0.09,0.7L7.04,9.81C6.5,9.31 5.79,9 5,9c-1.66,0 -3,1.34 -3,3s1.34,3 3,3c0.79,0 1.5,-0.31 2.04,-0.81l7.12,4.16c-0.05,0.21 -0.08,0.43 -0.08,0.65c0,1.61 1.31,2.92 2.92,2.92c1.61,0 2.92,-1.31 2.92,-2.92s-1.31,-2.92 -2.92,-2.92z" />
</vector>
ZZEOF

mkdir -p app/src/main/res/drawable
cat > app/src/main/res/drawable/ic_palette.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="22dp"
    android:height="22dp"
    android:viewportWidth="24"
    android:viewportHeight="24"
    android:tint="@color/white">
    <path
        android:fillColor="@android:color/white"
        android:pathData="M12,3c-4.97,0 -9,4.03 -9,9s4.03,9 9,9c0.83,0 1.5,-0.67 1.5,-1.5c0,-0.39 -0.15,-0.74 -0.39,-1.01 -0.23,-0.26 -0.38,-0.61 -0.38,-0.99 0,-0.83 0.67,-1.5 1.5,-1.5H16c2.76,0 5,-2.24 5,-5 0,-4.42 -4.03,-8 -9,-8zM6.5,13.5C5.67,13.5 5,12.83 5,12s0.67,-1.5 1.5,-1.5S8,11.17 8,12s-0.67,1.5 -1.5,1.5zM9.5,9.5C8.67,9.5 8,8.83 8,8s0.67,-1.5 1.5,-1.5S11,7.17 11,8s-0.67,1.5 -1.5,1.5zM14.5,9.5C13.67,9.5 13,8.83 13,8s0.67,-1.5 1.5,-1.5S16,7.17 16,8s-0.67,1.5 -1.5,1.5zM17.5,13.5c-0.83,0 -1.5,-0.67 -1.5,-1.5s0.67,-1.5 1.5,-1.5S19,11.17 19,12s-0.67,1.5 -1.5,1.5z" />
</vector>
ZZEOF

mkdir -p app/src/main/res/drawable
cat > app/src/main/res/drawable/ic_pin.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="20dp"
    android:height="20dp"
    android:viewportWidth="24"
    android:viewportHeight="24">
    <path
        android:fillColor="#FF000000"
        android:pathData="M16,12V4h1V2H7v2h1v8l-2,2v2h5.2v6h1.6v-6H18v-2l-2,-2z" />
</vector>
ZZEOF

mkdir -p app/src/main/res/drawable
cat > app/src/main/res/drawable/ic_lock.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="20dp"
    android:height="20dp"
    android:viewportWidth="24"
    android:viewportHeight="24"
    android:tint="@color/text_brown_light">
    <path
        android:fillColor="@android:color/white"
        android:pathData="M18,8h-1V6c0,-2.76 -2.24,-5 -5,-5S7,3.24 7,6v2H6c-1.1,0 -2,0.9 -2,2v10c0,1.1 0.9,2 2,2h12c1.1,0 2,-0.9 2,-2L20,10c0,-1.1 -0.9,-2 -2,-2zM12,17c-1.1,0 -2,-0.9 -2,-2s0.9,-2 2,-2 2,0.9 2,2 -0.9,2 -2,2zM15.1,8L8.9,8L8.9,6c0,-1.71 1.39,-3.1 3.1,-3.1 1.71,0 3.1,1.39 3.1,3.1v2z" />
</vector>
ZZEOF

mkdir -p app/src/main/res/drawable
cat > app/src/main/res/drawable/ic_more_vert.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="24dp"
    android:height="24dp"
    android:viewportWidth="24"
    android:viewportHeight="24"
    android:tint="@android:color/white">
    <path
        android:fillColor="@android:color/white"
        android:pathData="M12,8c1.1,0 2,-0.9 2,-2s-0.9,-2 -2,-2 -2,0.9 -2,2 0.9,2 2,2zM12,10c-1.1,0 -2,0.9 -2,2s0.9,2 2,2 2,-0.9 2,-2 -0.9,-2 -2,-2zM12,16c-1.1,0 -2,0.9 -2,2s0.9,2 2,2 2,-0.9 2,-2 -0.9,-2 -2,-2z" />
</vector>
ZZEOF

mkdir -p app/src/main/res/layout
cat > app/src/main/res/layout/activity_add_edit_note.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:id="@+id/rootLayout"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:background="@color/dark_bg">

    <RelativeLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:padding="16dp">

        <ImageView
            android:id="@+id/backButton"
            android:layout_width="44dp"
            android:layout_height="44dp"
            android:layout_alignParentStart="true"
            android:background="@drawable/circle_button_dark"
            android:padding="11dp"
            android:src="@drawable/ic_back" />

        <ImageView
            android:id="@+id/menuButton"
            android:layout_width="44dp"
            android:layout_height="44dp"
            android:layout_alignParentEnd="true"
            android:background="@drawable/circle_button_dark"
            android:padding="11dp"
            android:src="@drawable/ic_more_vert" />

    </RelativeLayout>

    <ScrollView
        android:layout_width="match_parent"
        android:layout_height="0dp"
        android:layout_weight="1">

        <LinearLayout
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:orientation="vertical"
            android:padding="20dp">

            <EditText
                android:id="@+id/titleInput"
                android:layout_width="match_parent"
                android:layout_height="wrap_content"
                android:hint="@string/titulo"
                android:textColor="@color/white"
                android:textColorHint="@color/dark_text_secondary"
                android:textSize="24sp"
                android:textStyle="bold"
                android:background="@android:color/transparent"
                android:fontFamily="casual" />

            <TextView
                android:id="@+id/dateLabel"
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                android:layout_marginTop="4dp"
                android:textColor="@color/dark_text_secondary"
                android:textSize="12sp"
                android:visibility="gone" />

            <EditText
                android:id="@+id/bodyInput"
                android:layout_width="match_parent"
                android:layout_height="wrap_content"
                android:layout_marginTop="12dp"
                android:hint="@string/anota_algo"
                android:textColor="@color/white"
                android:textColorHint="@color/dark_text_secondary"
                android:textSize="16sp"
                android:minLines="8"
                android:gravity="top"
                android:background="@android:color/transparent" />

        </LinearLayout>

    </ScrollView>

    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:orientation="horizontal"
        android:gravity="end"
        android:padding="16dp">

        <TextView
            android:id="@+id/cancelButton"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="@string/cancelar"
            android:textColor="@color/dark_text_secondary"
            android:padding="10dp" />

        <TextView
            android:id="@+id/saveButton"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="@string/guardar"
            android:textColor="@color/accent_yellow"
            android:textStyle="bold"
            android:padding="10dp"
            android:layout_marginStart="8dp" />

    </LinearLayout>

</LinearLayout>
ZZEOF

mkdir -p app/src/main/res/layout
cat > app/src/main/res/layout/item_note_row.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:orientation="horizontal"
    android:gravity="center_vertical"
    android:background="@drawable/dark_row_background"
    android:layout_marginBottom="8dp"
    android:padding="14dp">

    <LinearLayout
        android:layout_width="0dp"
        android:layout_height="wrap_content"
        android:layout_weight="1"
        android:orientation="vertical">

        <LinearLayout
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:orientation="horizontal"
            android:gravity="center_vertical">

            <ImageView
                android:id="@+id/pinIcon"
                android:layout_width="14dp"
                android:layout_height="14dp"
                android:layout_marginEnd="6dp"
                android:src="@drawable/ic_pin"
                android:visibility="gone" />

            <TextView
                android:id="@+id/noteTitle"
                android:layout_width="0dp"
                android:layout_height="wrap_content"
                android:layout_weight="1"
                android:textColor="@color/white"
                android:textSize="16sp"
                android:textStyle="bold"
                android:maxLines="1"
                android:ellipsize="end"
                android:visibility="gone" />

            <ImageView
                android:id="@+id/lockIcon"
                android:layout_width="14dp"
                android:layout_height="14dp"
                android:layout_marginStart="6dp"
                android:src="@drawable/ic_lock"
                android:visibility="gone" />

        </LinearLayout>

        <TextView
            android:id="@+id/text"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:layout_marginTop="2dp"
            android:maxLines="3"
            android:ellipsize="end"
            android:textColor="@color/dark_text_secondary"
            android:textSize="14sp" />

        <TextView
            android:id="@+id/noteDate"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:layout_marginTop="6dp"
            android:textColor="@color/dark_text_secondary"
            android:textSize="11sp"
            android:alpha="0.7" />

    </LinearLayout>

    <ImageView
        android:id="@+id/deleteButton"
        android:layout_width="22dp"
        android:layout_height="22dp"
        android:layout_marginStart="10dp"
        android:padding="1dp"
        android:src="@drawable/ic_trash"
        android:contentDescription="@string/eliminar_nota" />

</LinearLayout>
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/Note.kt << 'ZZEOF'
package com.santos.tareas

data class Note(
    val id: Long,
    var title: String = "",
    var text: String,
    var deleted: Boolean = false,
    var createdAt: Long = System.currentTimeMillis(),
    var pinned: Boolean = false,
    var locked: Boolean = false,
    var color: String? = null
)
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/NoteRepository.kt << 'ZZEOF'
package com.santos.tareas

import android.content.Context
import org.json.JSONArray
import org.json.JSONObject

object NoteRepository {

    private const val PREFS = "notas_prefs"
    private const val KEY_NOTES = "notes_json"
    private const val KEY_NEXT_ID = "next_id"

    private fun getAllRaw(context: Context): MutableList<Note> {
        val prefs = context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
        val json = prefs.getString(KEY_NOTES, null)
        if (json == null) {
            val now = System.currentTimeMillis()
            val seed = mutableListOf(
                Note(id = nextId(context), title = "Bienvenido a Notas", text = "", createdAt = now),
                Note(id = nextId(context), title = "", text = "Toca + para crear una nota nueva", createdAt = now)
            )
            saveNotes(context, seed)
            return seed
        }
        val array = JSONArray(json)
        val list = mutableListOf<Note>()
        for (i in 0 until array.length()) {
            val o = array.getJSONObject(i)
            list.add(
                Note(
                    id = o.getLong("id"),
                    title = if (o.has("title")) o.getString("title") else "",
                    text = o.getString("text"),
                    deleted = if (o.has("deleted")) o.getBoolean("deleted") else false,
                    createdAt = if (o.has("createdAt")) o.getLong("createdAt") else 0L,
                    pinned = if (o.has("pinned")) o.getBoolean("pinned") else false,
                    locked = if (o.has("locked")) o.getBoolean("locked") else false,
                    color = if (o.has("color") && !o.isNull("color")) o.getString("color") else null
                )
            )
        }
        return list
    }

    /** Notas activas (no eliminadas), ancladas primero. */
    fun getNotes(context: Context): MutableList<Note> =
        getAllRaw(context).filter { !it.deleted }
            .sortedByDescending { it.pinned }
            .toMutableList()

    fun getDeletedNotes(context: Context): MutableList<Note> =
        getAllRaw(context).filter { it.deleted }.toMutableList()

    private fun saveNotes(context: Context, notes: List<Note>) {
        val array = JSONArray()
        for (n in notes) {
            val o = JSONObject()
            o.put("id", n.id)
            o.put("title", n.title)
            o.put("text", n.text)
            o.put("deleted", n.deleted)
            o.put("createdAt", n.createdAt)
            o.put("pinned", n.pinned)
            o.put("locked", n.locked)
            o.put("color", n.color)
            array.put(o)
        }
        context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
            .edit()
            .putString(KEY_NOTES, array.toString())
            .apply()
    }

    private fun nextId(context: Context): Long {
        val prefs = context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
        val id = prefs.getLong(KEY_NEXT_ID, 1L)
        prefs.edit().putLong(KEY_NEXT_ID, id + 1).apply()
        return id
    }

    fun addNote(context: Context, title: String, text: String) {
        val notes = getAllRaw(context)
        notes.add(0, Note(id = nextId(context), title = title, text = text, createdAt = System.currentTimeMillis()))
        saveNotes(context, notes)
        WidgetUpdater.updateAll(context)
    }

    fun updateNote(context: Context, note: Note) {
        val notes = getAllRaw(context)
        val idx = notes.indexOfFirst { it.id == note.id }
        if (idx >= 0) {
            // Preserva metadatos que esta pantalla no gestiona directamente
            notes[idx] = note.copy(
                createdAt = notes[idx].createdAt,
                pinned = notes[idx].pinned,
                locked = notes[idx].locked,
                color = notes[idx].color
            )
            saveNotes(context, notes)
            WidgetUpdater.updateAll(context)
        }
    }

    fun deleteNote(context: Context, id: Long) {
        val notes = getAllRaw(context)
        val idx = notes.indexOfFirst { it.id == id }
        if (idx >= 0) {
            notes[idx] = notes[idx].copy(deleted = true)
            saveNotes(context, notes)
            WidgetUpdater.updateAll(context)
        }
    }

    fun restoreNote(context: Context, id: Long) {
        val notes = getAllRaw(context)
        val idx = notes.indexOfFirst { it.id == id }
        if (idx >= 0) {
            notes[idx] = notes[idx].copy(deleted = false)
            saveNotes(context, notes)
            WidgetUpdater.updateAll(context)
        }
    }

    fun permanentlyDeleteNote(context: Context, id: Long) {
        val notes = getAllRaw(context)
        notes.removeAll { it.id == id }
        saveNotes(context, notes)
        WidgetUpdater.updateAll(context)
    }

    fun emptyTrash(context: Context) {
        val notes = getAllRaw(context)
        notes.removeAll { it.deleted }
        saveNotes(context, notes)
        WidgetUpdater.updateAll(context)
    }

    fun setPinned(context: Context, id: Long, pinned: Boolean) {
        val notes = getAllRaw(context)
        val idx = notes.indexOfFirst { it.id == id }
        if (idx >= 0) {
            notes[idx] = notes[idx].copy(pinned = pinned)
            saveNotes(context, notes)
            WidgetUpdater.updateAll(context)
        }
    }

    fun setLocked(context: Context, id: Long, locked: Boolean) {
        val notes = getAllRaw(context)
        val idx = notes.indexOfFirst { it.id == id }
        if (idx >= 0) {
            notes[idx] = notes[idx].copy(locked = locked)
            saveNotes(context, notes)
            WidgetUpdater.updateAll(context)
        }
    }

    fun setColor(context: Context, id: Long, color: String?) {
        val notes = getAllRaw(context)
        val idx = notes.indexOfFirst { it.id == id }
        if (idx >= 0) {
            notes[idx] = notes[idx].copy(color = color)
            saveNotes(context, notes)
            WidgetUpdater.updateAll(context)
        }
    }

    fun getNote(context: Context, id: Long): Note? =
        getAllRaw(context).find { it.id == id }
}
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/NoteAdapter.kt << 'ZZEOF'
package com.santos.tareas

import android.graphics.Color
import android.graphics.drawable.GradientDrawable
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.core.content.ContextCompat
import androidx.recyclerview.widget.RecyclerView
import com.santos.tareas.databinding.ItemNoteRowBinding

class NoteAdapter(
    private val onClick: (Note) -> Unit,
    private val onDelete: (Note) -> Unit
) : RecyclerView.Adapter<NoteAdapter.NoteViewHolder>() {

    private var items: List<Note> = emptyList()
    var flatStyle: Boolean = false

    fun submitList(newItems: List<Note>) {
        items = newItems
        notifyDataSetChanged()
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): NoteViewHolder {
        val binding = ItemNoteRowBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        return NoteViewHolder(binding)
    }

    override fun onBindViewHolder(holder: NoteViewHolder, position: Int) {
        holder.bind(items[position])
    }

    override fun getItemCount(): Int = items.size

    inner class NoteViewHolder(private val binding: ItemNoteRowBinding) :
        RecyclerView.ViewHolder(binding.root) {

        fun bind(note: Note) {
            val context = binding.root.context

            if (flatStyle) {
                binding.root.setBackgroundResource(R.drawable.dark_row_flat_background)
            } else {
                val bg = ContextCompat.getDrawable(context, R.drawable.dark_row_background)
                    ?.mutate() as GradientDrawable
                bg.setColor(
                    if (note.color != null) Color.parseColor(note.color)
                    else ContextCompat.getColor(context, R.color.dark_surface)
                )
                binding.root.background = bg
            }

            binding.pinIcon.visibility = if (note.pinned) View.VISIBLE else View.GONE
            binding.lockIcon.visibility = if (note.locked) View.VISIBLE else View.GONE

            if (note.locked) {
                binding.noteTitle.visibility = View.VISIBLE
                binding.noteTitle.text = context.getString(R.string.nota_bloqueada)
                binding.text.text = ""
            } else if (note.title.isNotBlank()) {
                binding.noteTitle.visibility = View.VISIBLE
                binding.noteTitle.text = note.title
                binding.text.text = note.text
            } else {
                binding.noteTitle.visibility = View.GONE
                binding.text.text = note.text
            }

            binding.noteDate.text = DateUtils.format(note.createdAt)
            binding.root.setOnClickListener { onClick(note) }
            binding.deleteButton.setOnClickListener { onDelete(note) }
        }
    }
}
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/PinLockManager.kt << 'ZZEOF'
package com.santos.tareas

import android.content.Context

object PinLockManager {
    private const val PREFS = "security_prefs"
    private const val KEY_PIN = "app_pin"

    fun hasPin(context: Context): Boolean {
        val prefs = context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
        return prefs.getString(KEY_PIN, null) != null
    }

    fun setPin(context: Context, pin: String) {
        context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
            .edit()
            .putString(KEY_PIN, pin)
            .apply()
    }

    fun verifyPin(context: Context, pin: String): Boolean {
        val prefs = context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
        return prefs.getString(KEY_PIN, null) == pin
    }
}
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/PinDialogHelper.kt << 'ZZEOF'
package com.santos.tareas

import android.app.AlertDialog
import android.content.Context
import android.text.InputType
import android.widget.EditText
import android.widget.Toast

object PinDialogHelper {

    /** Pide crear un PIN de 4 dígitos (dos veces, para confirmar). */
    fun showCreatePinDialog(context: Context, onCreated: (String) -> Unit) {
        askPin(context, "Crea un PIN de 4 dígitos") { firstPin ->
            if (firstPin.length != 4) {
                Toast.makeText(context, "El PIN debe tener 4 dígitos", Toast.LENGTH_SHORT).show()
                return@askPin
            }
            askPin(context, "Confirma el PIN") { secondPin ->
                if (firstPin == secondPin) {
                    PinLockManager.setPin(context, firstPin)
                    onCreated(firstPin)
                } else {
                    Toast.makeText(context, "Los PIN no coinciden", Toast.LENGTH_SHORT).show()
                }
            }
        }
    }

    /** Pide el PIN existente y verifica contra el guardado. */
    fun showEnterPinDialog(context: Context, onCorrect: () -> Unit, onCancel: (() -> Unit)? = null) {
        askPin(context, "Introduce tu PIN", onCancel) { pin ->
            if (PinLockManager.verifyPin(context, pin)) {
                onCorrect()
            } else {
                Toast.makeText(context, "PIN incorrecto", Toast.LENGTH_SHORT).show()
                onCancel?.invoke()
            }
        }
    }

    private fun askPin(
        context: Context,
        title: String,
        onCancel: (() -> Unit)? = null,
        onSubmit: (String) -> Unit
    ) {
        val input = EditText(context)
        input.inputType = InputType.TYPE_CLASS_NUMBER or InputType.TYPE_NUMBER_VARIATION_PASSWORD
        input.hint = "••••"

        AlertDialog.Builder(context)
            .setTitle(title)
            .setView(input)
            .setPositiveButton("Aceptar") { _, _ -> onSubmit(input.text.toString()) }
            .setNegativeButton("Cancelar") { _, _ -> onCancel?.invoke() }
            .setCancelable(false)
            .show()
    }
}
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/AddEditNoteActivity.kt << 'ZZEOF'
package com.santos.tareas

import android.app.AlertDialog
import android.content.Intent
import android.graphics.Color
import android.os.Bundle
import android.view.View
import android.widget.LinearLayout
import android.widget.PopupMenu
import androidx.appcompat.app.AppCompatActivity
import androidx.biometric.BiometricManager
import androidx.biometric.BiometricPrompt
import androidx.core.content.ContextCompat
import com.santos.tareas.databinding.ActivityAddEditNoteBinding

class AddEditNoteActivity : AppCompatActivity() {

    companion object {
        const val EXTRA_NOTE_ID = "extra_note_id"

        // Colores disponibles para el fondo de la nota (null = color por defecto)
        val NOTE_COLORS: List<String?> = listOf(
            null, "#3A3A3E", "#2D4B73", "#2F5D50", "#6B3350", "#7A5A24"
        )
    }

    private lateinit var binding: ActivityAddEditNoteBinding
    private var editingNoteId: Long? = null
    private var currentNote: Note? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityAddEditNoteBinding.inflate(layoutInflater)
        setContentView(binding.root)

        binding.backButton.setOnClickListener { saveAndFinish() }
        binding.cancelButton.setOnClickListener { finish() }
        binding.saveButton.setOnClickListener { saveAndFinish() }
        binding.menuButton.setOnClickListener { showOptionsMenu() }

        val noteId = intent.getLongExtra(EXTRA_NOTE_ID, -1L)
        if (noteId != -1L) {
            editingNoteId = noteId
            val note = NoteRepository.getNotes(this).find { it.id == noteId }
            if (note != null && note.locked) {
                // No cargamos el contenido hasta que se desbloquee
                requestUnlock(
                    onSuccess = { loadNote(note) },
                    onFail = { finish() }
                )
            } else if (note != null) {
                loadNote(note)
            }
        } else {
            binding.menuButton.visibility = View.GONE
        }
    }

    private fun loadNote(note: Note) {
        currentNote = note
        binding.titleInput.setText(note.title)
        binding.bodyInput.setText(note.text)
        binding.dateLabel.visibility = View.VISIBLE
        binding.dateLabel.text = DateUtils.format(note.createdAt)
        applyColor(note.color)
    }

    private fun applyColor(color: String?) {
        val bg = if (color != null) Color.parseColor(color) else ContextCompat.getColor(this, R.color.dark_bg)
        binding.rootLayout.setBackgroundColor(bg)
    }

    private fun requestUnlock(onSuccess: () -> Unit, onFail: () -> Unit) {
        val biometricManager = BiometricManager.from(this)
        val canUseBiometric = biometricManager.canAuthenticate(
            BiometricManager.Authenticators.BIOMETRIC_WEAK or BiometricManager.Authenticators.DEVICE_CREDENTIAL
        ) == BiometricManager.BIOMETRIC_SUCCESS

        if (canUseBiometric) {
            val executor = ContextCompat.getMainExecutor(this)
            val prompt = BiometricPrompt(this, executor, object : BiometricPrompt.AuthenticationCallback() {
                override fun onAuthenticationSucceeded(result: BiometricPrompt.AuthenticationResult) {
                    onSuccess()
                }
                override fun onAuthenticationError(errorCode: Int, errString: CharSequence) {
                    onFail()
                }
                override fun onAuthenticationFailed() {
                    // el usuario puede reintentar; no cerramos aquí
                }
            })
            val promptInfo = BiometricPrompt.PromptInfo.Builder()
                .setTitle(getString(R.string.nota_bloqueada))
                .setSubtitle(getString(R.string.desbloquear_nota))
                .setAllowedAuthenticators(
                    BiometricManager.Authenticators.BIOMETRIC_WEAK or BiometricManager.Authenticators.DEVICE_CREDENTIAL
                )
                .build()
            prompt.authenticate(promptInfo)
        } else if (PinLockManager.hasPin(this)) {
            PinDialogHelper.showEnterPinDialog(this, onCorrect = onSuccess, onCancel = onFail)
        } else {
            // No hay biometría ni PIN configurado todavía: pedimos crear uno
            PinDialogHelper.showCreatePinDialog(this) { onSuccess() }
        }
    }

    private fun showOptionsMenu() {
        val note = currentNote ?: return
        val popup = PopupMenu(this, binding.menuButton)
        popup.menu.add(0, 0, 0, getString(if (note.pinned) R.string.desanclar else R.string.anclar))
        popup.menu.add(0, 1, 1, getString(if (note.locked) R.string.desbloquear else R.string.bloquear))
        popup.menu.add(0, 2, 2, getString(R.string.compartir))
        popup.menu.add(0, 3, 3, getString(R.string.color_de_fondo))
        popup.setOnMenuItemClickListener { item ->
            when (item.itemId) {
                0 -> togglePinned()
                1 -> toggleLocked()
                2 -> shareNote()
                3 -> showColorPicker()
            }
            true
        }
        popup.show()
    }

    private fun togglePinned() {
        val note = currentNote ?: return
        val updated = note.copy(pinned = !note.pinned)
        currentNote = updated
        NoteRepository.setPinned(this, note.id, updated.pinned)
    }

    private fun toggleLocked() {
        val note = currentNote ?: return
        if (!note.locked && !PinLockManager.hasPin(this)) {
            val biometricManager = BiometricManager.from(this)
            val canUseBiometric = biometricManager.canAuthenticate(
                BiometricManager.Authenticators.BIOMETRIC_WEAK
            ) == BiometricManager.BIOMETRIC_SUCCESS
            if (!canUseBiometric) {
                // sin huella disponible en el dispositivo: pedimos crear un PIN antes de bloquear
                PinDialogHelper.showCreatePinDialog(this) {
                    applyLock(note, true)
                }
                return
            }
        }
        applyLock(note, !note.locked)
    }

    private fun applyLock(note: Note, locked: Boolean) {
        val updated = note.copy(locked = locked)
        currentNote = updated
        NoteRepository.setLocked(this, note.id, locked)
    }

    private fun shareNote() {
        val note = currentNote ?: return
        val shareText = if (note.title.isNotBlank()) "${note.title}\n\n${note.text}" else note.text
        val intent = Intent(Intent.ACTION_SEND).apply {
            type = "text/plain"
            putExtra(Intent.EXTRA_TEXT, shareText)
        }
        startActivity(Intent.createChooser(intent, getString(R.string.compartir)))
    }

    private fun showColorPicker() {
        val note = currentNote ?: return
        val row = LinearLayout(this).apply {
            orientation = LinearLayout.HORIZONTAL
            setPadding(32, 32, 32, 32)
        }
        for (colorHex in NOTE_COLORS) {
            val swatch = View(this)
            val size = 140
            val params = LinearLayout.LayoutParams(size, size).apply { setMargins(12, 0, 12, 0) }
            swatch.layoutParams = params
            val drawable = android.graphics.drawable.GradientDrawable()
            drawable.shape = android.graphics.drawable.GradientDrawable.OVAL
            drawable.setColor(
                if (colorHex != null) Color.parseColor(colorHex) else ContextCompat.getColor(this, R.color.dark_surface)
            )
            drawable.setStroke(3, ContextCompat.getColor(this, R.color.dark_text_secondary))
            swatch.background = drawable
            row.addView(swatch)

            swatch.setOnClickListener {
                val updated = note.copy(color = colorHex)
                currentNote = updated
                NoteRepository.setColor(this, note.id, colorHex)
                applyColor(colorHex)
            }
        }

        AlertDialog.Builder(this)
            .setTitle(R.string.color_de_fondo)
            .setView(row)
            .setPositiveButton(android.R.string.ok, null)
            .show()
    }

    private fun saveAndFinish() {
        val title = binding.titleInput.text.toString().trim()
        val body = binding.bodyInput.text.toString().trim()

        if (title.isEmpty() && body.isEmpty()) {
            finish()
            return
        }

        val existing = currentNote
        if (existing != null) {
            NoteRepository.updateNote(this, existing.copy(title = title, text = body))
        } else {
            NoteRepository.addNote(this, title, body)
        }
        finish()
    }
}
ZZEOF

echo "Anclar, bloquear, compartir y color de nota listos. Compilando..."
./gradlew assembleDebug