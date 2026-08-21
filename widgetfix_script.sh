#!/bin/bash
set -e

mkdir -p app/src/main/res/xml
cat > app/src/main/res/xml/task_widget_info.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<appwidget-provider xmlns:android="http://schemas.android.com/apk/res/android"
    android:label="@string/tareas"
    android:minWidth="40dp"
    android:minHeight="40dp"
    android:minResizeWidth="40dp"
    android:minResizeHeight="40dp"
    android:maxResizeWidth="360dp"
    android:maxResizeHeight="360dp"
    android:targetCellWidth="1"
    android:targetCellHeight="1"
    android:updatePeriodMillis="0"
    android:initialLayout="@layout/widget_task"
    android:resizeMode="vertical|horizontal"
    android:widgetCategory="home_screen" />
ZZEOF

mkdir -p app/src/main/res/xml
cat > app/src/main/res/xml/note_widget_info.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<appwidget-provider xmlns:android="http://schemas.android.com/apk/res/android"
    android:label="@string/notas"
    android:minWidth="40dp"
    android:minHeight="40dp"
    android:minResizeWidth="40dp"
    android:minResizeHeight="40dp"
    android:maxResizeWidth="360dp"
    android:maxResizeHeight="360dp"
    android:targetCellWidth="1"
    android:targetCellHeight="1"
    android:updatePeriodMillis="0"
    android:initialLayout="@layout/widget_note"
    android:resizeMode="vertical|horizontal"
    android:widgetCategory="home_screen" />
ZZEOF

mkdir -p app/src/main/res/drawable
cat > app/src/main/res/drawable/widget_header_background.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android"
    android:shape="rectangle">
    <solid android:color="#F7D68A" />
    <corners
        android:topLeftRadius="20dp"
        android:topRightRadius="20dp"
        android:bottomLeftRadius="0dp"
        android:bottomRightRadius="0dp" />
</shape>
ZZEOF

mkdir -p app/src/main/res/drawable
cat > app/src/main/res/drawable/widget_add_button_background.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android"
    android:shape="oval">
    <gradient
        android:startColor="#FFC15A"
        android:endColor="#F0972A"
        android:angle="270" />
    <stroke android:width="1dp" android:color="#FFFFFF" />
</shape>
ZZEOF

mkdir -p app/src/main/res/drawable
cat > app/src/main/res/drawable/ic_plus.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="24dp"
    android:height="24dp"
    android:viewportWidth="24"
    android:viewportHeight="24"
    android:tint="@color/white">
    <path
        android:fillColor="@android:color/white"
        android:pathData="M13,5c0,-0.55 -0.45,-1 -1,-1s-1,0.45 -1,1v6H5c-0.55,0 -1,0.45 -1,1s0.45,1 1,1h6v6c0,0.55 0.45,1 1,1s1,-0.45 1,-1v-6h6c0.55,0 1,-0.45 1,-1s-0.45,-1 -1,-1h-6L13,5z" />
</vector>
ZZEOF

mkdir -p app/src/main/res/layout
cat > app/src/main/res/layout/widget_task.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:background="@drawable/widget_card_background">

    <RelativeLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:background="@drawable/widget_header_background"
        android:paddingHorizontal="16dp"
        android:paddingVertical="12dp">

        <TextView
            android:id="@+id/widget_title"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:layout_centerVertical="true"
            android:text="@string/tareas"
            android:textColor="@color/text_brown"
            android:textSize="20sp"
            android:textStyle="bold"
            android:fontFamily="casual" />

        <ImageView
            android:id="@+id/widget_add_button"
            android:layout_width="34dp"
            android:layout_height="34dp"
            android:layout_alignParentEnd="true"
            android:layout_centerVertical="true"
            android:background="@drawable/widget_add_button_background"
            android:padding="7dp"
            android:src="@drawable/ic_plus"
            android:contentDescription="@string/anadir_tarea" />
    </RelativeLayout>

    <ListView
        android:id="@+id/widget_list"
        android:layout_width="match_parent"
        android:layout_height="0dp"
        android:layout_weight="1"
        android:paddingHorizontal="16dp"
        android:paddingTop="8dp"
        android:divider="@null"
        android:dividerHeight="4dp"
        android:listSelector="@android:color/transparent" />

    <TextView
        android:id="@+id/widget_empty"
        android:layout_width="match_parent"
        android:layout_height="0dp"
        android:layout_weight="1"
        android:gravity="center"
        android:text="@string/sin_tareas"
        android:textColor="@color/text_brown_light"
        android:textSize="14sp" />

</LinearLayout>
ZZEOF

mkdir -p app/src/main/res/layout
cat > app/src/main/res/layout/widget_note.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:background="@drawable/widget_card_background">

    <RelativeLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:background="@drawable/widget_header_background"
        android:paddingHorizontal="16dp"
        android:paddingVertical="12dp">

        <TextView
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:layout_centerVertical="true"
            android:text="@string/notas"
            android:textColor="@color/text_brown"
            android:textSize="20sp"
            android:textStyle="bold"
            android:fontFamily="casual" />

        <ImageView
            android:id="@+id/widget_note_add_button"
            android:layout_width="34dp"
            android:layout_height="34dp"
            android:layout_alignParentEnd="true"
            android:layout_centerVertical="true"
            android:background="@drawable/widget_add_button_background"
            android:padding="7dp"
            android:src="@drawable/ic_plus"
            android:contentDescription="@string/anadir_nota" />
    </RelativeLayout>

    <ListView
        android:id="@+id/widget_note_list"
        android:layout_width="match_parent"
        android:layout_height="0dp"
        android:layout_weight="1"
        android:paddingHorizontal="16dp"
        android:paddingTop="8dp"
        android:divider="@null"
        android:dividerHeight="4dp"
        android:listSelector="@android:color/transparent" />

    <TextView
        android:id="@+id/widget_note_empty"
        android:layout_width="match_parent"
        android:layout_height="0dp"
        android:layout_weight="1"
        android:gravity="center"
        android:text="@string/sin_notas"
        android:textColor="@color/text_brown_light"
        android:textSize="14sp" />

</LinearLayout>
ZZEOF

echo "Widgets con nombre, boton + mejorado, franja de cabecera y tamano minimo mas chico. Compilando..."
./gradlew assembleDebug