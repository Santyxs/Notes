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
    android:targetCellWidth="3"
    android:targetCellHeight="3"
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
    android:targetCellWidth="3"
    android:targetCellHeight="3"
    android:updatePeriodMillis="0"
    android:initialLayout="@layout/widget_note"
    android:resizeMode="vertical|horizontal"
    android:widgetCategory="home_screen" />
ZZEOF

mkdir -p app/src/main/res/layout
cat > app/src/main/res/layout/widget_task.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<FrameLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:padding="28dp">

<LinearLayout
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:background="@drawable/widget_card_background">

    <RelativeLayout
        android:id="@+id/widget_header"
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

</FrameLayout>
ZZEOF

mkdir -p app/src/main/res/layout
cat > app/src/main/res/layout/widget_note.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<FrameLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:padding="28dp">

<LinearLayout
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:background="@drawable/widget_card_background">

    <RelativeLayout
        android:id="@+id/widget_note_header"
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

</FrameLayout>
ZZEOF

echo "Widget ocupa 3x3 pero se ve como 2x2. Compilando..."
./gradlew assembleDebug
rm -- "$0"