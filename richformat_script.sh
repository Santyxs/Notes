#!/bin/bash
set -e

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
    <string name="pendiente_de_completar">Pendiente de completar</string>
    <string name="completado">Completado</string>
    <string name="todo_completado">Sin tareas</string>
    <string name="deshacer">Deshacer</string>
    <string name="rehacer">Rehacer</string>
    <string name="tipografia">Tipografía</string>
    <string name="dibujar">Dibujar</string>
    <string name="insertar_imagen">Insertar imagen</string>
    <string name="insertar_tabla">Insertar tabla</string>
    <string name="guardar_dibujo">Guardar dibujo</string>
    <string name="borrar_todo">Borrar todo</string>
    <string name="filas">Filas</string>
    <string name="columnas">Columnas</string>
    <string name="crear_tabla">Crear tabla</string>
    <string name="eliminar_adjunto">Eliminar adjunto</string>
    <string name="predeterminada">Predeterminada</string>
    <string name="sans_serif">Sans-serif</string>
    <string name="serif">Serif</string>
    <string name="monoespaciada">Monoespaciada</string>
    <string name="dictar_voz">Dictar por voz</string>
    <string name="di_algo">Di algo...</string>
    <string name="cuerpo">Cuerpo</string>
    <string name="formato_texto">Formato de texto</string>
    <string name="color_de_texto">Color de texto</string>
    <string name="aa_boton">Aa</string>
</resources>
ZZEOF

mkdir -p app/src/main/res/values
cat > app/src/main/res/values/themes.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <style name="Theme.Tareas" parent="Theme.MaterialComponents.DayNight.NoActionBar">
        <item name="colorPrimary">@color/accent_yellow</item>
        <item name="android:statusBarColor">@color/dark_bg</item>
        <item name="android:windowBackground">@color/dark_bg</item>
    </style>

    <style name="Theme.Tareas.Dialog" parent="Theme.MaterialComponents.DayNight.NoActionBar">
        <item name="android:statusBarColor">@color/dark_bg</item>
        <item name="android:windowBackground">@color/dark_bg</item>
        <item name="windowNoTitle">true</item>
    </style>

    <style name="FormatButton">
        <item name="android:layout_width">0dp</item>
        <item name="android:layout_height">40dp</item>
        <item name="android:layout_marginEnd">4dp</item>
        <item name="android:gravity">center</item>
        <item name="android:textColor">@color/white</item>
        <item name="android:background">@drawable/format_button_bg</item>
    </style>

    <style name="FormatIconButton">
        <item name="android:layout_width">0dp</item>
        <item name="android:layout_height">40dp</item>
        <item name="android:layout_marginEnd">4dp</item>
        <item name="android:padding">10dp</item>
        <item name="android:background">@drawable/format_button_bg</item>
        <item name="android:scaleType">centerInside</item>
    </style>
</resources>
ZZEOF

mkdir -p app/src/main/res/drawable
cat > app/src/main/res/drawable/ic_align_left.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="20dp" android:height="20dp" android:viewportWidth="24" android:viewportHeight="24" android:tint="@color/white">
    <path android:fillColor="@android:color/white" android:pathData="M3,5h18v2H3zM3,9h12v2H3zM3,13h18v2H3zM3,17h12v2H3z" />
</vector>
ZZEOF

mkdir -p app/src/main/res/drawable
cat > app/src/main/res/drawable/ic_align_center.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="20dp" android:height="20dp" android:viewportWidth="24" android:viewportHeight="24" android:tint="@color/white">
    <path android:fillColor="@android:color/white" android:pathData="M3,5h18v2H3zM6,9h12v2H6zM3,13h18v2H3zM6,17h12v2H6z" />
</vector>
ZZEOF

mkdir -p app/src/main/res/drawable
cat > app/src/main/res/drawable/ic_align_right.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="20dp" android:height="20dp" android:viewportWidth="24" android:viewportHeight="24" android:tint="@color/white">
    <path android:fillColor="@android:color/white" android:pathData="M3,5h18v2H3zM9,9h12v2H9zM3,13h18v2H3zM9,17h12v2H9z" />
</vector>
ZZEOF

mkdir -p app/src/main/res/drawable
cat > app/src/main/res/drawable/ic_list_numbered.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="20dp" android:height="20dp" android:viewportWidth="24" android:viewportHeight="24" android:tint="@color/white">
    <path android:fillColor="@android:color/white" android:pathData="M2,17h2v0.5L3,17.5v1L4,18.5v0.5L2,19v1h3v-4L2,16zM3,8h1L4,4L2,4v1h1zM2,12h1.8L2,14.1v0.9h3v-1L3.2,14L5,11.9V11L2,11zM8,4v2h13L21,4L8,4zM8,19h13v-2L8,17v2zM8,13h13v-2L8,11v2z" />
</vector>
ZZEOF

mkdir -p app/src/main/res/drawable
cat > app/src/main/res/drawable/ic_list_bullet.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="20dp" android:height="20dp" android:viewportWidth="24" android:viewportHeight="24" android:tint="@color/white">
    <path android:fillColor="@android:color/white" android:pathData="M4,10.5c-0.83,0 -1.5,0.67 -1.5,1.5s0.67,1.5 1.5,1.5 1.5,-0.67 1.5,-1.5 -0.67,-1.5 -1.5,-1.5zM4,4.5c-0.83,0 -1.5,0.67 -1.5,1.5S3.17,7.5 4,7.5 5.5,6.83 5.5,6 4.83,4.5 4,4.5zM4,16.5c-0.83,0 -1.5,0.68 -1.5,1.5s0.68,1.5 1.5,1.5 1.5,-0.68 1.5,-1.5 -0.67,-1.5 -1.5,-1.5zM7,19h14v-2L7,17v2zM7,13h14v-2L7,11v2zM7,5v2h14L21,5L7,5z" />
</vector>
ZZEOF

mkdir -p app/src/main/res/drawable
cat > app/src/main/res/drawable/ic_checklist.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="20dp" android:height="20dp" android:viewportWidth="24" android:viewportHeight="24" android:tint="@color/white">
    <path android:fillColor="@android:color/white" android:pathData="M3,5v4h4L7,5L3,5zM3.5,5.5h3v3h-3v-3zM9,5v2h12L21,5L9,5zM9,17v2h12v-2L9,17zM9,11v2h12v-2L9,11zM3.9,9.28L2.6,7.9 1.9,8.6l2,2 4,-4 -0.71,-0.71z" />
</vector>
ZZEOF

mkdir -p app/src/main/res/drawable
cat > app/src/main/res/drawable/ic_indent_increase.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="20dp" android:height="20dp" android:viewportWidth="24" android:viewportHeight="24" android:tint="@color/white">
    <path android:fillColor="@android:color/white" android:pathData="M3,5h18v2H3zM3,17h18v2H3zM3,9v6l4,-3zM11,11h10v2L11,13z" />
</vector>
ZZEOF

mkdir -p app/src/main/res/drawable
cat > app/src/main/res/drawable/ic_indent_decrease.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="20dp" android:height="20dp" android:viewportWidth="24" android:viewportHeight="24" android:tint="@color/white">
    <path android:fillColor="@android:color/white" android:pathData="M3,5h18v2H3zM3,17h18v2H3zM7,9v6l-4,-3zM11,11h10v2L11,13z" />
</vector>
ZZEOF

mkdir -p app/src/main/res/drawable
cat > app/src/main/res/drawable/ic_text_color.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="20dp" android:height="20dp" android:viewportWidth="24" android:viewportHeight="24" android:tint="@color/white">
    <path android:fillColor="@android:color/white" android:pathData="M11,3L5.5,17h2.25l1.12,-3h6.25l1.12,3h2.25L13,3h-2zM9.63,12L12,5.67 14.38,12h-4.75zM3,20h18v2L3,22z" />
</vector>
ZZEOF

mkdir -p app/src/main/res/drawable
cat > app/src/main/res/drawable/ic_dropdown.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="16dp" android:height="16dp" android:viewportWidth="24" android:viewportHeight="24" android:tint="@color/dark_text_secondary">
    <path android:fillColor="@android:color/white" android:pathData="M7,10l5,5 5,-5z" />
</vector>
ZZEOF

mkdir -p app/src/main/res/drawable
cat > app/src/main/res/drawable/format_button_bg.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android" android:shape="rectangle">
    <solid android:color="@color/dark_surface_light" />
    <corners android:radius="10dp" />
</shape>
ZZEOF

mkdir -p app/src/main/res/drawable
cat > app/src/main/res/drawable/format_button_bg_selected.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android" android:shape="rectangle">
    <solid android:color="@color/accent_blue" />
    <corners android:radius="10dp" />
</shape>
ZZEOF

mkdir -p app/src/main/res/layout
cat > app/src/main/res/layout/formatting_toolbar.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:id="@+id/formattingPanel"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:orientation="vertical"
    android:background="@color/dark_surface"
    android:padding="10dp"
    android:visibility="gone">

    <!-- Fila 1: encabezados -->
    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:orientation="horizontal"
        android:layout_marginBottom="8dp">

        <TextView android:id="@+id/btnH1" style="@style/FormatButton" android:layout_weight="1" android:text="H1" android:textSize="16sp" />
        <TextView android:id="@+id/btnH2" style="@style/FormatButton" android:layout_weight="1" android:text="H2" android:textSize="15sp" />
        <TextView android:id="@+id/btnH3" style="@style/FormatButton" android:layout_weight="1" android:text="H3" android:textSize="14sp" />
        <TextView android:id="@+id/btnH4" style="@style/FormatButton" android:layout_weight="1" android:text="H4" android:textSize="13sp" />
        <TextView android:id="@+id/btnBody" style="@style/FormatButton" android:layout_weight="1.3" android:text="@string/cuerpo" android:textSize="13sp" />
    </LinearLayout>

    <!-- Fila 2: negrita, cursiva, subrayado, tachado, sangría -->
    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:orientation="horizontal"
        android:layout_marginBottom="8dp">

        <TextView android:id="@+id/btnBold" style="@style/FormatButton" android:layout_weight="1" android:text="B" android:textStyle="bold" android:textSize="17sp" />
        <TextView android:id="@+id/btnItalic" style="@style/FormatButton" android:layout_weight="1" android:text="I" android:textStyle="italic" android:textSize="17sp" />
        <TextView android:id="@+id/btnUnderline" style="@style/FormatButton" android:layout_weight="1" android:text="U" android:textSize="17sp" />
        <TextView android:id="@+id/btnStrike" style="@style/FormatButton" android:layout_weight="1" android:text="S" android:textSize="17sp" />
        <ImageView android:id="@+id/btnIndentDec" style="@style/FormatIconButton" android:layout_weight="1" android:src="@drawable/ic_indent_decrease" />
        <ImageView android:id="@+id/btnIndentInc" style="@style/FormatIconButton" android:layout_weight="1" android:src="@drawable/ic_indent_increase" />
    </LinearLayout>

    <!-- Fila 3: listas y alineación -->
    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:orientation="horizontal"
        android:layout_marginBottom="8dp">

        <ImageView android:id="@+id/btnListNumbered" style="@style/FormatIconButton" android:layout_weight="1" android:src="@drawable/ic_list_numbered" />
        <ImageView android:id="@+id/btnListBullet" style="@style/FormatIconButton" android:layout_weight="1" android:src="@drawable/ic_list_bullet" />
        <ImageView android:id="@+id/btnChecklist" style="@style/FormatIconButton" android:layout_weight="1" android:src="@drawable/ic_checklist" />
        <ImageView android:id="@+id/btnAlignLeft" style="@style/FormatIconButton" android:layout_weight="1" android:src="@drawable/ic_align_left" />
        <ImageView android:id="@+id/btnAlignCenter" style="@style/FormatIconButton" android:layout_weight="1" android:src="@drawable/ic_align_center" />
        <ImageView android:id="@+id/btnAlignRight" style="@style/FormatIconButton" android:layout_weight="1" android:src="@drawable/ic_align_right" />
    </LinearLayout>

    <!-- Fila 4: color de texto -->
    <LinearLayout
        android:id="@+id/btnTextColor"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:orientation="horizontal"
        android:gravity="center_vertical"
        android:background="@drawable/format_button_bg"
        android:padding="10dp">

        <ImageView
            android:layout_width="20dp"
            android:layout_height="20dp"
            android:src="@drawable/ic_text_color"
            android:layout_marginEnd="6dp" />

        <ImageView
            android:layout_width="16dp"
            android:layout_height="16dp"
            android:src="@drawable/ic_dropdown" />

    </LinearLayout>

</LinearLayout>
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

            <HorizontalScrollView
                android:id="@+id/attachmentsScroll"
                android:layout_width="match_parent"
                android:layout_height="wrap_content"
                android:layout_marginTop="12dp"
                android:visibility="gone"
                android:scrollbars="none">

                <LinearLayout
                    android:id="@+id/attachmentsContainer"
                    android:layout_width="wrap_content"
                    android:layout_height="wrap_content"
                    android:orientation="horizontal" />

            </HorizontalScrollView>

        </LinearLayout>

    </ScrollView>

    <include layout="@layout/formatting_toolbar" android:id="@+id/formattingPanelInclude" />

    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:orientation="horizontal"
        android:gravity="center"
        android:paddingVertical="10dp"
        android:background="@color/dark_surface">

        <ImageView
            android:id="@+id/undoButton"
            android:layout_width="40dp"
            android:layout_height="40dp"
            android:padding="9dp"
            android:src="@drawable/ic_undo"
            android:contentDescription="@string/deshacer" />

        <ImageView
            android:id="@+id/redoButton"
            android:layout_width="40dp"
            android:layout_height="40dp"
            android:layout_marginStart="4dp"
            android:padding="9dp"
            android:src="@drawable/ic_redo"
            android:contentDescription="@string/rehacer" />

        <View
            android:layout_width="0dp"
            android:layout_height="1dp"
            android:layout_weight="1" />

        <TextView
            android:id="@+id/formatToggleButton"
            android:layout_width="40dp"
            android:layout_height="40dp"
            android:gravity="center"
            android:text="@string/aa_boton"
            android:textColor="@color/white"
            android:textStyle="bold"
            android:contentDescription="@string/formato_texto" />

        <ImageView
            android:id="@+id/fontButton"
            android:layout_width="40dp"
            android:layout_height="40dp"
            android:layout_marginStart="4dp"
            android:padding="9dp"
            android:src="@drawable/ic_font"
            android:contentDescription="@string/tipografia" />

        <ImageView
            android:id="@+id/drawButton"
            android:layout_width="40dp"
            android:layout_height="40dp"
            android:layout_marginStart="4dp"
            android:padding="9dp"
            android:src="@drawable/ic_draw"
            android:contentDescription="@string/dibujar" />

        <ImageView
            android:id="@+id/imageButton"
            android:layout_width="40dp"
            android:layout_height="40dp"
            android:layout_marginStart="4dp"
            android:padding="9dp"
            android:src="@drawable/ic_image"
            android:contentDescription="@string/insertar_imagen" />

        <ImageView
            android:id="@+id/tableButton"
            android:layout_width="40dp"
            android:layout_height="40dp"
            android:layout_marginStart="4dp"
            android:padding="9dp"
            android:src="@drawable/ic_table"
            android:contentDescription="@string/insertar_tabla" />

        <ImageView
            android:id="@+id/micButton"
            android:layout_width="40dp"
            android:layout_height="40dp"
            android:layout_marginStart="4dp"
            android:padding="9dp"
            android:src="@drawable/ic_mic"
            android:contentDescription="@string/dictar_voz" />

    </LinearLayout>

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

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/HeadingSpan.kt << 'ZZEOF'
package com.santos.tareas

import android.text.style.RelativeSizeSpan

/** Igual que RelativeSizeSpan pero identificable aparte, para poder quitar
 * solo los encabezados aplicados por la barra de formato sin tocar otros
 * cambios de tamaño que el usuario haya hecho por su cuenta. */
class HeadingSpan(scale: Float) : RelativeSizeSpan(scale)
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/TextFormatter.kt << 'ZZEOF'
package com.santos.tareas

import android.graphics.Typeface
import android.text.Layout
import android.text.Spanned
import android.text.style.AlignmentSpan
import android.text.style.StrikethroughSpan
import android.text.style.StyleSpan
import android.text.style.UnderlineSpan
import android.text.style.ForegroundColorSpan
import android.widget.EditText

/**
 * Aplica formato de texto enriquecido (negrita, cursiva, subrayado, tachado,
 * encabezados, listas, alineación, sangría, color) directamente sobre el
 * Editable de un EditText usando spans nativos de Android.
 */
object TextFormatter {

    private fun selectionRange(editText: EditText): Pair<Int, Int> {
        val start = editText.selectionStart.coerceAtLeast(0)
        val end = editText.selectionEnd.coerceAtLeast(0)
        return if (start <= end) start to end else end to start
    }

    /** Si no hay selección, usa la línea completa donde está el cursor. */
    private fun effectiveRange(editText: EditText): Pair<Int, Int> {
        val (start, end) = selectionRange(editText)
        if (start != end) return start to end
        val text = editText.text
        var lineStart = start
        while (lineStart > 0 && text[lineStart - 1] != '\n') lineStart--
        var lineEnd = start
        while (lineEnd < text.length && text[lineEnd] != '\n') lineEnd++
        return lineStart to lineEnd
    }

    private fun lineRanges(editText: EditText): List<Pair<Int, Int>> {
        val (selStart, selEnd) = effectiveRange(editText)
        val text = editText.text
        val ranges = mutableListOf<Pair<Int, Int>>()
        var pos = selStart
        while (pos <= selEnd) {
            var lineStart = pos
            while (lineStart > 0 && text[lineStart - 1] != '\n') lineStart--
            var lineEnd = pos
            while (lineEnd < text.length && text[lineEnd] != '\n') lineEnd++
            ranges.add(lineStart to lineEnd)
            pos = lineEnd + 1
        }
        return ranges
    }

    fun toggleBold(editText: EditText) = toggleStyle(editText, Typeface.BOLD)
    fun toggleItalic(editText: EditText) = toggleStyle(editText, Typeface.ITALIC)

    private fun toggleStyle(editText: EditText, style: Int) {
        val (start, end) = selectionRange(editText)
        if (start == end) return
        val editable = editText.text
        val spans = editable.getSpans(start, end, StyleSpan::class.java).filter { it.style == style }
        val covered = spans.any { editable.getSpanStart(it) <= start && editable.getSpanEnd(it) >= end }
        if (covered) {
            spans.forEach { editable.removeSpan(it) }
        } else {
            editable.setSpan(StyleSpan(style), start, end, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE)
        }
    }

    fun toggleUnderline(editText: EditText) {
        val (start, end) = selectionRange(editText)
        if (start == end) return
        val editable = editText.text
        val spans = editable.getSpans(start, end, UnderlineSpan::class.java)
        val covered = spans.any { editable.getSpanStart(it) <= start && editable.getSpanEnd(it) >= end }
        if (covered) {
            spans.forEach { editable.removeSpan(it) }
        } else {
            editable.setSpan(UnderlineSpan(), start, end, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE)
        }
    }

    fun toggleStrikethrough(editText: EditText) {
        val (start, end) = selectionRange(editText)
        if (start == end) return
        val editable = editText.text
        val spans = editable.getSpans(start, end, StrikethroughSpan::class.java)
        val covered = spans.any { editable.getSpanStart(it) <= start && editable.getSpanEnd(it) >= end }
        if (covered) {
            spans.forEach { editable.removeSpan(it) }
        } else {
            editable.setSpan(StrikethroughSpan(), start, end, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE)
        }
    }

    fun applyHeading(editText: EditText, scale: Float?) {
        val (start, end) = effectiveRange(editText)
        if (start == end) return
        val editable = editText.text
        editable.getSpans(start, end, HeadingSpan::class.java).forEach { editable.removeSpan(it) }
        if (scale != null) {
            editable.setSpan(HeadingSpan(scale), start, end, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE)
        }
    }

    fun applyAlignment(editText: EditText, alignment: Layout.Alignment) {
        for ((start, end) in listOf(effectiveRange(editText))) {
            val editable = editText.text
            editable.getSpans(start, end, AlignmentSpan::class.java).forEach { editable.removeSpan(it) }
            editable.setSpan(AlignmentSpan.Standard(alignment), start, end, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE)
        }
    }

    fun applyTextColor(editText: EditText, color: Int) {
        val (start, end) = selectionRange(editText)
        if (start == end) return
        val editable = editText.text
        editable.getSpans(start, end, ForegroundColorSpan::class.java).forEach { editable.removeSpan(it) }
        editable.setSpan(ForegroundColorSpan(color), start, end, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE)
    }

    fun toggleLinePrefix(editText: EditText, prefix: String, numbered: Boolean = false) {
        val editable = editText.text
        val ranges = lineRanges(editText)
        val alreadyAllPrefixed = ranges.all { (s, _) ->
            val lineText = editable.substring(s, minOf(s + prefix.length, editable.length))
            lineText == prefix || (numbered && Regex("^\\d+\\. ").containsMatchIn(editable.substring(s, minOf(s + 4, editable.length))))
        }

        // Aplicamos de atrás hacia adelante para no desajustar los índices
        var counter = ranges.size
        for ((s, _) in ranges.reversed()) {
            if (alreadyAllPrefixed) {
                if (numbered) {
                    val match = Regex("^\\d+\\. ").find(editable.substring(s, minOf(s + 6, editable.length)))
                    if (match != null) editable.delete(s, s + match.value.length)
                } else {
                    val end = minOf(s + prefix.length, editable.length)
                    if (editable.substring(s, end) == prefix) editable.delete(s, end)
                }
            } else {
                val insertText = if (numbered) "$counter. " else prefix
                editable.insert(s, insertText)
            }
            counter--
        }
    }

    fun increaseIndent(editText: EditText) {
        val editable = editText.text
        for ((s, _) in lineRanges(editText).reversed()) {
            editable.insert(s, "    ")
        }
    }

    fun decreaseIndent(editText: EditText) {
        val editable = editText.text
        for ((s, _) in lineRanges(editText).reversed()) {
            val end = minOf(s + 4, editable.length)
            if (editable.substring(s, end) == "    ") {
                editable.delete(s, end)
            } else if (s < editable.length && editable[s] == '\t') {
                editable.delete(s, s + 1)
            }
        }
    }
}
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/HtmlUtils.kt << 'ZZEOF'
package com.santos.tareas

import android.text.Html
import android.text.Spanned

/**
 * El cuerpo de la nota se guarda como HTML (para conservar negrita, colores,
 * alineación, etc.), pero las vistas previas (lista, widget, papelera,
 * compartir) necesitan texto plano legible.
 */
object HtmlUtils {

    fun toHtml(spanned: Spanned): String {
        return Html.toHtml(spanned, Html.TO_HTML_PARAGRAPH_LINES_CONSECUTIVE)
    }

    fun fromHtml(html: String): Spanned {
        return Html.fromHtml(html, Html.FROM_HTML_MODE_LEGACY)
    }

    fun toPlainText(html: String): String {
        return Html.fromHtml(html, Html.FROM_HTML_MODE_LEGACY).toString().trim()
    }
}
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/AddEditNoteActivity.kt << 'ZZEOF'
package com.santos.tareas

import android.Manifest
import android.app.AlertDialog
import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import android.graphics.Typeface
import android.os.Bundle
import android.speech.RecognizerIntent
import android.text.Editable
import android.text.TextWatcher
import android.view.Gravity
import android.view.View
import android.view.ViewGroup
import android.widget.EditText
import android.widget.FrameLayout
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.PopupMenu
import android.widget.TableLayout
import android.widget.TableRow
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.biometric.BiometricManager
import androidx.biometric.BiometricPrompt
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import com.santos.tareas.databinding.ActivityAddEditNoteBinding
import java.io.File
import java.io.FileOutputStream
import java.util.Locale
import java.util.UUID

class AddEditNoteActivity : AppCompatActivity() {

    companion object {
        const val EXTRA_NOTE_ID = "extra_note_id"
        private const val REQUEST_IMAGE_PICK = 100
        private const val REQUEST_DRAWING = 101
        private const val REQUEST_SPEECH = 102
        private const val REQUEST_RECORD_AUDIO_PERMISSION = 200

        val NOTE_COLORS: List<String?> = listOf(
            null, "#3A3A3E", "#2D4B73", "#2F5D50", "#6B3350", "#7A5A24"
        )

        val FONT_OPTIONS: List<Pair<String, Typeface?>> = listOf(
            "predeterminada" to Typeface.create("casual", Typeface.NORMAL),
            "sans" to Typeface.SANS_SERIF,
            "serif" to Typeface.SERIF,
            "monospace" to Typeface.MONOSPACE
        )
    }

    private lateinit var binding: ActivityAddEditNoteBinding
    private var editingNoteId: Long? = null
    private var currentNote: Note? = null
    private var attachments: MutableList<String> = mutableListOf()

    // Deshacer / rehacer del cuerpo de texto
    private val undoStack = mutableListOf<String>()
    private val redoStack = mutableListOf<String>()
    private var suppressWatcher = false
    private val debounceHandler = android.os.Handler(android.os.Looper.getMainLooper())
    private var debounceRunnable: Runnable? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityAddEditNoteBinding.inflate(layoutInflater)
        setContentView(binding.root)

        binding.backButton.setOnClickListener { saveAndFinish() }
        binding.cancelButton.setOnClickListener { finish() }
        binding.saveButton.setOnClickListener { saveAndFinish() }
        binding.menuButton.setOnClickListener { showOptionsMenu() }

        binding.undoButton.setOnClickListener { performUndo() }
        binding.redoButton.setOnClickListener { performRedo() }
        binding.fontButton.setOnClickListener { showFontMenu() }
        binding.drawButton.setOnClickListener {
            startActivityForResult(Intent(this, DrawingActivity::class.java), REQUEST_DRAWING)
        }
        binding.imageButton.setOnClickListener {
            val intent = Intent(Intent.ACTION_GET_CONTENT).apply { type = "image/*" }
            startActivityForResult(intent, REQUEST_IMAGE_PICK)
        }
        binding.tableButton.setOnClickListener { showTableSizeDialog() }
        binding.micButton.setOnClickListener { startVoiceRecognition() }

        setupFormattingToolbar()

        undoStack.add("")
        binding.bodyInput.addTextChangedListener(object : TextWatcher {
            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {}
            override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {}
            override fun afterTextChanged(s: Editable?) {
                if (suppressWatcher) return
                debounceRunnable?.let { debounceHandler.removeCallbacks(it) }
                debounceRunnable = Runnable {
                    val text = s.toString()
                    if (undoStack.lastOrNull() != text) {
                        undoStack.add(text)
                        redoStack.clear()
                    }
                }
                debounceHandler.postDelayed(debounceRunnable!!, 600)
            }
        })

        val noteId = intent.getLongExtra(EXTRA_NOTE_ID, -1L)
        if (noteId != -1L) {
            editingNoteId = noteId
            val note = NoteRepository.getNotes(this).find { it.id == noteId }
            if (note != null && note.locked) {
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
        binding.bodyInput.setText(HtmlUtils.fromHtml(note.text))
        binding.dateLabel.visibility = View.VISIBLE
        binding.dateLabel.text = DateUtils.format(note.createdAt)
        applyColor(note.color)
        applyFont(note.fontFamily)
        attachments = note.attachments.toMutableList()
        renderAttachments()
        undoStack.clear()
        undoStack.add(binding.bodyInput.text.toString())
    }

    private fun applyColor(color: String?) {
        val bg = if (color != null) Color.parseColor(color) else ContextCompat.getColor(this, R.color.dark_bg)
        binding.rootLayout.setBackgroundColor(bg)
    }

    private fun applyFont(fontKey: String?) {
        val typeface = FONT_OPTIONS.find { it.first == fontKey }?.second
            ?: Typeface.create("casual", Typeface.NORMAL)
        binding.bodyInput.typeface = typeface
    }

    // ---------- Deshacer / rehacer ----------

    private fun performUndo() {
        if (undoStack.size <= 1) return
        redoStack.add(undoStack.removeAt(undoStack.size - 1))
        val previous = undoStack.last()
        setBodyTextSilently(previous)
    }

    private fun performRedo() {
        if (redoStack.isEmpty()) return
        val next = redoStack.removeAt(redoStack.size - 1)
        undoStack.add(next)
        setBodyTextSilently(next)
    }

    private fun setBodyTextSilently(text: String) {
        suppressWatcher = true
        binding.bodyInput.setText(text)
        binding.bodyInput.setSelection(text.length)
        suppressWatcher = false
    }

    // ---------- Tipografía ----------

    private fun showFontMenu() {
        val popup = PopupMenu(this, binding.fontButton)
        popup.menu.add(0, 0, 0, getString(R.string.predeterminada))
        popup.menu.add(0, 1, 1, getString(R.string.sans_serif))
        popup.menu.add(0, 2, 2, getString(R.string.serif))
        popup.menu.add(0, 3, 3, getString(R.string.monoespaciada))
        popup.setOnMenuItemClickListener { item ->
            val key = when (item.itemId) {
                1 -> "sans"
                2 -> "serif"
                3 -> "monospace"
                else -> "predeterminada"
            }
            applyFont(key)
            currentNote?.let { NoteRepository.setFontFamily(this, it.id, key) }
            true
        }
        popup.show()
    }

    // ---------- Dictado por voz ----------

    private fun startVoiceRecognition() {
        if (ContextCompat.checkSelfPermission(this, Manifest.permission.RECORD_AUDIO)
            != PackageManager.PERMISSION_GRANTED
        ) {
            ActivityCompat.requestPermissions(
                this, arrayOf(Manifest.permission.RECORD_AUDIO), REQUEST_RECORD_AUDIO_PERMISSION
            )
            return
        }
        launchSpeechRecognizer()
    }

    private fun launchSpeechRecognizer() {
        val intent = Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH).apply {
            putExtra(RecognizerIntent.EXTRA_LANGUAGE_MODEL, RecognizerIntent.LANGUAGE_MODEL_FREE_FORM)
            putExtra(RecognizerIntent.EXTRA_LANGUAGE, Locale("es", "ES"))
            putExtra(RecognizerIntent.EXTRA_PROMPT, getString(R.string.di_algo))
        }
        try {
            startActivityForResult(intent, REQUEST_SPEECH)
        } catch (e: Exception) {
            Toast.makeText(this, R.string.dictar_voz, Toast.LENGTH_SHORT).show()
        }
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode == REQUEST_RECORD_AUDIO_PERMISSION &&
            grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED
        ) {
            launchSpeechRecognizer()
        }
    }

    private fun insertRecognizedText(text: String) {
        val current = binding.bodyInput.text
        val cursor = binding.bodyInput.selectionStart.coerceAtLeast(0)
        val prefix = if (current.isNotEmpty() && cursor > 0 && current[cursor - 1] != ' ' && current[cursor - 1] != '\n') " " else ""
        current.insert(cursor, "$prefix$text")
    }

    // ---------- Barra de formato de texto ----------

    private fun setupFormattingToolbar() {
        val panel = binding.formattingPanelInclude
        binding.formatToggleButton.setOnClickListener {
            panel.formattingPanel.visibility =
                if (panel.formattingPanel.visibility == View.VISIBLE) View.GONE else View.VISIBLE
        }

        panel.btnH1.setOnClickListener { TextFormatter.applyHeading(binding.bodyInput, 1.8f) }
        panel.btnH2.setOnClickListener { TextFormatter.applyHeading(binding.bodyInput, 1.5f) }
        panel.btnH3.setOnClickListener { TextFormatter.applyHeading(binding.bodyInput, 1.3f) }
        panel.btnH4.setOnClickListener { TextFormatter.applyHeading(binding.bodyInput, 1.15f) }
        panel.btnBody.setOnClickListener { TextFormatter.applyHeading(binding.bodyInput, null) }

        panel.btnBold.setOnClickListener { TextFormatter.toggleBold(binding.bodyInput) }
        panel.btnItalic.setOnClickListener { TextFormatter.toggleItalic(binding.bodyInput) }
        panel.btnUnderline.setOnClickListener { TextFormatter.toggleUnderline(binding.bodyInput) }
        panel.btnStrike.setOnClickListener { TextFormatter.toggleStrikethrough(binding.bodyInput) }
        panel.btnIndentInc.setOnClickListener { TextFormatter.increaseIndent(binding.bodyInput) }
        panel.btnIndentDec.setOnClickListener { TextFormatter.decreaseIndent(binding.bodyInput) }

        panel.btnListNumbered.setOnClickListener {
            TextFormatter.toggleLinePrefix(binding.bodyInput, "", numbered = true)
        }
        panel.btnListBullet.setOnClickListener {
            TextFormatter.toggleLinePrefix(binding.bodyInput, "• ")
        }
        panel.btnChecklist.setOnClickListener {
            TextFormatter.toggleLinePrefix(binding.bodyInput, "☐ ")
        }
        panel.btnAlignLeft.setOnClickListener {
            TextFormatter.applyAlignment(binding.bodyInput, android.text.Layout.Alignment.ALIGN_NORMAL)
        }
        panel.btnAlignCenter.setOnClickListener {
            TextFormatter.applyAlignment(binding.bodyInput, android.text.Layout.Alignment.ALIGN_CENTER)
        }
        panel.btnAlignRight.setOnClickListener {
            TextFormatter.applyAlignment(binding.bodyInput, android.text.Layout.Alignment.ALIGN_OPPOSITE)
        }
        panel.btnTextColor.setOnClickListener { showTextColorPicker() }
    }

    private fun showTextColorPicker() {
        val colors = listOf(
            "#FFFFFF", "#F5A623", "#E5484D", "#4A9EFF", "#4CC38A", "#B784E0"
        )
        val row = LinearLayout(this).apply {
            orientation = LinearLayout.HORIZONTAL
            setPadding(32, 32, 32, 32)
        }
        for (colorHex in colors) {
            val swatch = View(this)
            val size = 120
            val params = LinearLayout.LayoutParams(size, size).apply { setMargins(10, 0, 10, 0) }
            swatch.layoutParams = params
            val drawable = android.graphics.drawable.GradientDrawable()
            drawable.shape = android.graphics.drawable.GradientDrawable.OVAL
            drawable.setColor(Color.parseColor(colorHex))
            drawable.setStroke(2, ContextCompat.getColor(this, R.color.dark_text_secondary))
            swatch.background = drawable
            row.addView(swatch)
            swatch.setOnClickListener {
                TextFormatter.applyTextColor(binding.bodyInput, Color.parseColor(colorHex))
            }
        }
        AlertDialog.Builder(this)
            .setTitle(R.string.color_de_texto)
            .setView(row)
            .setPositiveButton(android.R.string.ok, null)
            .show()
    }

    // ---------- Bloqueo ----------

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
                override fun onAuthenticationFailed() {}
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
            PinDialogHelper.showCreatePinDialog(this) { onSuccess() }
        }
    }

    // ---------- Menú de opciones (⋮) ----------

    private fun showOptionsMenu() {
        val note = currentNote ?: return
        val popup = PopupMenu(this, binding.menuButton)
        popup.menu.add(0, 0, 0, getString(if (note.pinned) R.string.desanclar else R.string.anclar))
            .setIcon(R.drawable.ic_pin)
        popup.menu.add(0, 1, 1, getString(if (note.locked) R.string.desbloquear else R.string.bloquear))
            .setIcon(R.drawable.ic_lock)
        popup.menu.add(0, 2, 2, getString(R.string.compartir)).setIcon(R.drawable.ic_share)
        popup.menu.add(0, 3, 3, getString(R.string.color_de_fondo)).setIcon(R.drawable.ic_palette)
        popup.menu.add(0, 4, 4, getString(R.string.eliminar_nota)).setIcon(R.drawable.ic_trash)
        MenuIconHelper.forceShowIcons(popup)
        popup.setOnMenuItemClickListener { item ->
            when (item.itemId) {
                0 -> togglePinned()
                1 -> toggleLocked()
                2 -> shareNote()
                3 -> showColorPicker()
                4 -> deleteNote()
            }
            true
        }
        popup.show()
    }

    private fun deleteNote() {
        val note = currentNote ?: return
        NoteRepository.deleteNote(this, note.id)
        finish()
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
        val plainText = HtmlUtils.toPlainText(note.text)
        val shareText = if (note.title.isNotBlank()) "${note.title}\n\n$plainText" else plainText
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

        val dialog = AlertDialog.Builder(this)
            .setTitle(R.string.color_de_fondo)
            .setView(row)
            .setPositiveButton(android.R.string.ok, null)
            .show()
        dialog.getButton(AlertDialog.BUTTON_POSITIVE)
            ?.setTextColor(ContextCompat.getColor(this, R.color.accent_yellow))
    }

    // ---------- Adjuntos (imágenes, dibujos, tablas) ----------

    private fun renderAttachments() {
        binding.attachmentsContainer.removeAllViews()
        binding.attachmentsScroll.visibility = if (attachments.isEmpty()) View.GONE else View.VISIBLE

        for (path in attachments) {
            val frame = FrameLayout(this)
            val frameParams = LinearLayout.LayoutParams(220, 220).apply { setMargins(0, 0, 16, 0) }
            frame.layoutParams = frameParams

            val imageView = ImageView(this)
            imageView.layoutParams = FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.MATCH_PARENT,
                FrameLayout.LayoutParams.MATCH_PARENT
            )
            imageView.scaleType = ImageView.ScaleType.CENTER_CROP
            val bitmap = android.graphics.BitmapFactory.decodeFile(path)
            if (bitmap != null) imageView.setImageBitmap(bitmap)
            frame.addView(imageView)

            val deleteButton = ImageView(this)
            val deleteSize = 48
            val deleteParams = FrameLayout.LayoutParams(deleteSize, deleteSize).apply {
                gravity = Gravity.TOP or Gravity.END
                setMargins(0, 6, 6, 0)
            }
            deleteButton.layoutParams = deleteParams
            deleteButton.setImageResource(R.drawable.ic_close_circle)
            deleteButton.contentDescription = getString(R.string.eliminar_adjunto)
            deleteButton.setOnClickListener {
                attachments.remove(path)
                currentNote?.let { NoteRepository.removeAttachment(this, it.id, path) }
                renderAttachments()
            }
            frame.addView(deleteButton)

            binding.attachmentsContainer.addView(frame)
        }
    }

    private fun addAttachment(path: String) {
        attachments.add(path)
        currentNote?.let {
            NoteRepository.addAttachment(this, it.id, path)
        } ?: run {
            // Nota nueva todavía sin guardar: se persistirá al pulsar Guardar
        }
        renderAttachments()
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (resultCode != RESULT_OK || data == null) return

        when (requestCode) {
            REQUEST_DRAWING -> {
                val path = data.getStringExtra(DrawingActivity.EXTRA_RESULT_PATH)
                if (path != null) addAttachment(path)
            }
            REQUEST_IMAGE_PICK -> {
                val uri = data.data ?: return
                try {
                    val dir = File(filesDir, "images").apply { mkdirs() }
                    val outFile = File(dir, "${UUID.randomUUID()}.jpg")
                    contentResolver.openInputStream(uri)?.use { input ->
                        FileOutputStream(outFile).use { output -> input.copyTo(output) }
                    }
                    addAttachment(outFile.absolutePath)
                } catch (e: Exception) {
                    // si falla la copia, simplemente no se añade el adjunto
                }
            }
            REQUEST_SPEECH -> {
                val results = data.getStringArrayListExtra(RecognizerIntent.EXTRA_RESULTS)
                val recognized = results?.firstOrNull()
                if (!recognized.isNullOrBlank()) {
                    insertRecognizedText(recognized)
                }
            }
        }
    }

    // ---------- Tablas ----------

    private fun showTableSizeDialog() {
        val container = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            setPadding(48, 24, 48, 0)
        }
        val rowsInput = EditText(this).apply {
            hint = getString(R.string.filas)
            inputType = android.text.InputType.TYPE_CLASS_NUMBER
            setText("3")
        }
        val colsInput = EditText(this).apply {
            hint = getString(R.string.columnas)
            inputType = android.text.InputType.TYPE_CLASS_NUMBER
            setText("3")
        }
        container.addView(rowsInput)
        container.addView(colsInput)

        AlertDialog.Builder(this)
            .setTitle(R.string.crear_tabla)
            .setView(container)
            .setPositiveButton(android.R.string.ok) { _, _ ->
                val rows = (rowsInput.text.toString().toIntOrNull() ?: 3).coerceIn(1, 8)
                val cols = (colsInput.text.toString().toIntOrNull() ?: 3).coerceIn(1, 8)
                showTableEditorDialog(rows, cols)
            }
            .setNegativeButton(android.R.string.cancel, null)
            .show()
    }

    private fun showTableEditorDialog(rows: Int, cols: Int) {
        val table = TableLayout(this).apply {
            setPadding(24, 24, 24, 24)
        }
        val cellInputs = Array(rows) { arrayOfNulls<EditText>(cols) }

        for (r in 0 until rows) {
            val row = TableRow(this)
            for (c in 0 until cols) {
                val cell = EditText(this)
                cell.layoutParams = TableRow.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f)
                cell.setPadding(12, 12, 12, 12)
                cell.textSize = 13f
                row.addView(cell)
                cellInputs[r][c] = cell
            }
            table.addView(row)
        }

        val scroll = android.widget.ScrollView(this)
        scroll.addView(table)

        AlertDialog.Builder(this)
            .setTitle(R.string.crear_tabla)
            .setView(scroll)
            .setPositiveButton(android.R.string.ok) { _, _ ->
                val texts = Array(rows) { r -> Array(cols) { c -> cellInputs[r][c]?.text?.toString().orEmpty() } }
                val bitmap = renderTableBitmap(rows, cols, texts)
                val dir = File(filesDir, "tables").apply { mkdirs() }
                val file = File(dir, "${UUID.randomUUID()}.png")
                FileOutputStream(file).use { out -> bitmap.compress(Bitmap.CompressFormat.PNG, 100, out) }
                addAttachment(file.absolutePath)
            }
            .setNegativeButton(android.R.string.cancel, null)
            .show()
    }

    private fun renderTableBitmap(rows: Int, cols: Int, texts: Array<Array<String>>): Bitmap {
        val cellWidth = 180
        val cellHeight = 90
        val width = cellWidth * cols
        val height = cellHeight * rows
        val bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888)
        val canvas = Canvas(bitmap)
        canvas.drawColor(Color.WHITE)

        val linePaint = Paint().apply {
            color = Color.parseColor("#5C4322")
            strokeWidth = 3f
        }
        val textPaint = Paint().apply {
            color = Color.parseColor("#5C4322")
            textSize = 26f
            isAntiAlias = true
        }

        for (r in 0..rows) {
            canvas.drawLine(0f, (r * cellHeight).toFloat(), width.toFloat(), (r * cellHeight).toFloat(), linePaint)
        }
        for (c in 0..cols) {
            canvas.drawLine((c * cellWidth).toFloat(), 0f, (c * cellWidth).toFloat(), height.toFloat(), linePaint)
        }
        for (r in 0 until rows) {
            for (c in 0 until cols) {
                val text = texts[r][c]
                canvas.drawText(
                    text,
                    (c * cellWidth + 12).toFloat(),
                    (r * cellHeight + cellHeight / 2 + 8).toFloat(),
                    textPaint
                )
            }
        }
        return bitmap
    }

    // ---------- Guardar ----------

    private fun saveAndFinish() {
        val title = binding.titleInput.text.toString().trim()
        val bodyPlain = binding.bodyInput.text.toString().trim()
        val bodyHtml = HtmlUtils.toHtml(binding.bodyInput.text)

        if (title.isEmpty() && bodyPlain.isEmpty() && attachments.isEmpty()) {
            finish()
            return
        }

        val existing = currentNote
        if (existing != null) {
            NoteRepository.updateNote(this, existing.copy(title = title, text = bodyHtml, attachments = attachments))
        } else {
            NoteRepository.addNote(this, title, bodyHtml)
            // Si se añadieron adjuntos antes de guardar por primera vez, los enlazamos ahora
            if (attachments.isNotEmpty()) {
                val created = NoteRepository.getNotes(this).firstOrNull { it.title == title && it.text == bodyHtml }
                created?.let { note ->
                    NoteRepository.updateNote(this, note.copy(attachments = attachments))
                }
            }
        }
        finish()
    }
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
                binding.text.text = HtmlUtils.toPlainText(note.text)
            } else {
                binding.noteTitle.visibility = View.GONE
                binding.text.text = HtmlUtils.toPlainText(note.text)
            }

            binding.noteDate.text = DateUtils.format(note.createdAt)
            binding.root.setOnClickListener { onClick(note) }
            binding.deleteButton.setOnClickListener { onDelete(note) }
        }
    }
}
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/NoteRemoteViewsFactory.kt << 'ZZEOF'
package com.santos.tareas

import android.content.Context
import android.content.Intent
import android.widget.RemoteViews
import android.widget.RemoteViewsService.RemoteViewsFactory

class NoteRemoteViewsFactory(private val context: Context) : RemoteViewsFactory {

    private var notes: List<Note> = emptyList()

    override fun onCreate() {
        notes = NoteRepository.getNotes(context)
    }

    override fun onDataSetChanged() {
        notes = NoteRepository.getNotes(context)
    }

    override fun onDestroy() {
        notes = emptyList()
    }

    override fun getCount(): Int = notes.size

    override fun getViewAt(position: Int): RemoteViews {
        val note = notes[position]
        val views = RemoteViews(context.packageName, R.layout.widget_note_item)
        val display = if (note.title.isNotBlank()) note.title else HtmlUtils.toPlainText(note.text)
        views.setTextViewText(R.id.note_item_text, display)

        val fillInIntent = Intent().apply {
            putExtra(AddEditNoteActivity.EXTRA_NOTE_ID, note.id)
        }
        views.setOnClickFillInIntent(R.id.note_item_row, fillInIntent)

        return views
    }

    override fun getLoadingView(): RemoteViews? = null
    override fun getViewTypeCount(): Int = 1
    override fun getItemId(position: Int): Long = notes[position].id
    override fun hasStableIds(): Boolean = true
}
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/TrashActivity.kt << 'ZZEOF'
package com.santos.tareas

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.santos.tareas.databinding.ActivityTrashBinding
import com.santos.tareas.databinding.ItemTrashRowBinding

private data class TrashItem(val id: Long, val text: String, val isNote: Boolean)

class TrashActivity : AppCompatActivity() {

    private lateinit var binding: ActivityTrashBinding
    private lateinit var adapter: TrashAdapter

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityTrashBinding.inflate(layoutInflater)
        setContentView(binding.root)

        adapter = TrashAdapter(
            onRestore = { item ->
                if (item.isNote) NoteRepository.restoreNote(this, item.id)
                else TaskRepository.restoreTask(this, item.id)
                load()
            },
            onDeleteForever = { item ->
                if (item.isNote) NoteRepository.permanentlyDeleteNote(this, item.id)
                else TaskRepository.permanentlyDeleteTask(this, item.id)
                load()
            }
        )
        binding.recyclerView.layoutManager = LinearLayoutManager(this)
        binding.recyclerView.adapter = adapter

        binding.backButton.setOnClickListener { finish() }
        binding.emptyTrashButton.setOnClickListener {
            NoteRepository.emptyTrash(this)
            TaskRepository.emptyTrash(this)
            load()
        }
    }

    override fun onResume() {
        super.onResume()
        load()
    }

    private fun load() {
        val notes = NoteRepository.getDeletedNotes(this).map {
            TrashItem(it.id, it.title.ifBlank { HtmlUtils.toPlainText(it.text) }.ifBlank { getString(R.string.notas) }, true)
        }
        val tasks = TaskRepository.getDeletedTasks(this).map {
            TrashItem(it.id, it.title, false)
        }
        val all = notes + tasks
        adapter.submitList(all)
        binding.emptyView.visibility = if (all.isEmpty()) View.VISIBLE else View.GONE
    }
}

private class TrashAdapter(
    private val onRestore: (TrashItem) -> Unit,
    private val onDeleteForever: (TrashItem) -> Unit
) : RecyclerView.Adapter<TrashAdapter.ViewHolder>() {

    private var items: List<TrashItem> = emptyList()

    fun submitList(newItems: List<TrashItem>) {
        items = newItems
        notifyDataSetChanged()
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val binding = ItemTrashRowBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        return ViewHolder(binding)
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        holder.bind(items[position])
    }

    override fun getItemCount(): Int = items.size

    inner class ViewHolder(private val binding: ItemTrashRowBinding) :
        RecyclerView.ViewHolder(binding.root) {
        fun bind(item: TrashItem) {
            binding.itemText.text = item.text
            binding.restoreButton.setOnClickListener { onRestore(item) }
            binding.deleteForeverButton.setOnClickListener { onDeleteForever(item) }
        }
    }
}
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/MainActivity.kt << 'ZZEOF'
package com.santos.tareas

import android.content.Intent
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.Gravity
import android.widget.PopupMenu
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.LinearLayoutManager
import com.santos.tareas.databinding.ActivityMainBinding

enum class ViewMode { LIST, CARD, GRID }

class MainActivity : AppCompatActivity() {

    companion object {
        const val EXTRA_SHOW_NOTES = "extra_show_notes"
    }

    private lateinit var binding: ActivityMainBinding
    private lateinit var noteAdapter: NoteAdapter
    private lateinit var taskAdapter: TaskAdapter

    private var showingNotes = true
    private var searchQuery = ""
    private var viewMode = ViewMode.CARD
    private var completedExpanded = false

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        noteAdapter = NoteAdapter(
            onClick = { note ->
                val intent = Intent(this, AddEditNoteActivity::class.java)
                intent.putExtra(AddEditNoteActivity.EXTRA_NOTE_ID, note.id)
                startActivity(intent)
            },
            onDelete = { note ->
                NoteRepository.deleteNote(this, note.id)
                refresh()
            }
        )

        taskAdapter = TaskAdapter(
            onToggle = { task ->
                if (!task.done) {
                    // Marcamos hecha en su sitio y esperamos a que termine de tacharse
                    // antes de reordenar en secciones (para que se vea la animación).
                    TaskRepository.toggleDone(this, task.id)
                    taskAdapter.onAnimationEnd = {
                        binding.recyclerView.postDelayed({
                            refresh()
                            taskAdapter.onAnimationEnd = null
                        }, 900)
                    }
                    taskAdapter.markDoneInPlace(task.id)
                } else {
                    TaskRepository.toggleDone(this, task.id)
                    refresh()
                }
            },
            onClick = { task ->
                val intent = Intent(this, AddEditTaskActivity::class.java)
                intent.putExtra(AddEditTaskActivity.EXTRA_TASK_ID, task.id)
                startActivity(intent)
            },
            onDelete = { task ->
                TaskRepository.deleteTask(this, task.id)
                refresh()
            },
            onHeaderToggle = {
                completedExpanded = !completedExpanded
                refresh()
            }
        )

        binding.tabNotas.setOnClickListener { selectTab(notes = true) }
        binding.tabTareas.setOnClickListener { selectTab(notes = false) }

        binding.fabAdd.setOnClickListener {
            if (showingNotes) {
                startActivity(Intent(this, AddEditNoteActivity::class.java))
            } else {
                startActivity(Intent(this, AddEditTaskActivity::class.java))
            }
        }

        binding.menuButton.setOnClickListener { showViewModeMenu() }

        binding.sidebarButton.setOnClickListener {
            binding.drawerLayout.openDrawer(Gravity.START)
        }
        binding.drawerAllNotes.setOnClickListener {
            binding.drawerLayout.closeDrawer(Gravity.START)
        }
        binding.drawerTrash.setOnClickListener {
            binding.drawerLayout.closeDrawer(Gravity.START)
            startActivity(Intent(this, TrashActivity::class.java))
        }
        binding.drawerSettings.setOnClickListener {
            binding.drawerLayout.closeDrawer(Gravity.START)
            startActivity(Intent(this, SettingsActivity::class.java))
        }

        binding.searchInput.addTextChangedListener(object : TextWatcher {
            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {}
            override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
                searchQuery = s?.toString().orEmpty()
                refresh()
            }
            override fun afterTextChanged(s: Editable?) {}
        })

        applyViewMode()
        val showNotes = intent.getBooleanExtra(EXTRA_SHOW_NOTES, true)
        selectTab(notes = showNotes)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)
        if (intent.hasExtra(EXTRA_SHOW_NOTES)) {
            selectTab(notes = intent.getBooleanExtra(EXTRA_SHOW_NOTES, true))
        }
    }

    override fun onResume() {
        super.onResume()
        refresh()
    }

    private fun showViewModeMenu() {
        val popup = PopupMenu(this, binding.menuButton)
        popup.menu.add(0, 0, 0, getString(R.string.vista_lista)).setIcon(R.drawable.ic_view_list)
        popup.menu.add(0, 1, 1, getString(R.string.vista_tarjeta)).setIcon(R.drawable.ic_view_card)
        popup.menu.add(0, 2, 2, getString(R.string.vista_cuadricula)).setIcon(R.drawable.ic_view_grid)
        MenuIconHelper.forceShowIcons(popup)
        popup.setOnMenuItemClickListener { item ->
            viewMode = when (item.itemId) {
                0 -> ViewMode.LIST
                2 -> ViewMode.GRID
                else -> ViewMode.CARD
            }
            applyViewMode()
            true
        }
        popup.show()
    }

    private fun applyViewMode() {
        if (viewMode == ViewMode.GRID) {
            val gridManager = GridLayoutManager(this, 2)
            gridManager.spanSizeLookup = object : GridLayoutManager.SpanSizeLookup() {
                override fun getSpanSize(position: Int): Int {
                    return if (!showingNotes && taskAdapter.isHeaderAt(position)) 2 else 1
                }
            }
            binding.recyclerView.layoutManager = gridManager
        } else {
            binding.recyclerView.layoutManager = LinearLayoutManager(this)
        }
        val flat = viewMode == ViewMode.LIST
        noteAdapter.flatStyle = flat
        taskAdapter.flatStyle = flat
        refresh()
    }

    private fun selectTab(notes: Boolean) {
        showingNotes = notes
        binding.tabNotas.setBackgroundResource(if (notes) R.drawable.pill_selected_background else 0)
        binding.tabTareas.setBackgroundResource(if (!notes) R.drawable.pill_selected_background else 0)
        binding.tabNotas.setTextColor(
            resources.getColor(if (notes) R.color.accent_yellow else R.color.white, theme)
        )
        binding.tabTareas.setTextColor(
            resources.getColor(if (!notes) R.color.accent_yellow else R.color.white, theme)
        )
        binding.recyclerView.adapter = if (notes) noteAdapter else taskAdapter
        binding.emptyText.text = getString(if (notes) R.string.sin_notas else R.string.sin_tareas)
        binding.drawerAllNotesLabel.text = getString(if (notes) R.string.todas_las_notas else R.string.todas_las_tareas)
        applyViewMode()
    }

    private fun refresh() {
        if (showingNotes) {
            val notes = NoteRepository.getNotes(this).filter {
                searchQuery.isBlank() ||
                    it.title.contains(searchQuery, ignoreCase = true) ||
                    HtmlUtils.toPlainText(it.text).contains(searchQuery, ignoreCase = true)
            }
            noteAdapter.submitList(notes)
            binding.emptyView.visibility = if (notes.isEmpty()) android.view.View.VISIBLE else android.view.View.GONE
        } else {
            val allTasks = TaskRepository.getTasks(this).filter {
                searchQuery.isBlank() || it.title.contains(searchQuery, ignoreCase = true)
            }
            val pending = allTasks.filter { !it.done }
            val completed = allTasks.filter { it.done }

            val sections = mutableListOf<TaskListItem>()
            if (pending.isNotEmpty()) {
                sections.add(TaskListItem.Header(getString(R.string.pendiente_de_completar), collapsible = false, expanded = true))
                sections.addAll(pending.map { TaskListItem.Row(it) })
            }
            if (completed.isNotEmpty()) {
                sections.add(TaskListItem.Header(getString(R.string.completado), collapsible = true, expanded = completedExpanded))
                if (completedExpanded) {
                    sections.addAll(completed.map { TaskListItem.Row(it) })
                }
            }
            taskAdapter.submitSections(sections)
            binding.emptyView.visibility = if (allTasks.isEmpty()) android.view.View.VISIBLE else android.view.View.GONE
        }
    }
}
ZZEOF

echo "Barra de formato de texto lista. Compilando..."
./gradlew assembleDebug
rm -- "$0"