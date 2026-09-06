# Mantener intacto todo el código propio de la app: la app es pequeña, así
# que el ahorro real de tamaño viene de que R8 elimine el código NO USADO
# de las librerías (AndroidX/Material), no del código propio. Mantenerlo
# evita cualquier riesgo de que algo se rompa por ofuscación/eliminación
# (reflexión, vistas infladas por nombre desde XML, receivers, etc.).
-keep class com.santos.tareas.** { *; }
-keepclassmembers class com.santos.tareas.** { *; }

# Los ViewBinding generados se referencian por reflexión de forma indirecta
# en algunos casos; nos aseguramos de que no se toquen.
-keep class com.santos.tareas.databinding.** { *; }

# Vistas personalizadas infladas por nombre de clase desde XML (DrawingView).
-keep public class * extends android.view.View {
    public <init>(android.content.Context);
    public <init>(android.content.Context, android.util.AttributeSet);
    public <init>(android.content.Context, android.util.AttributeSet, int);
}

# org.json se usa con acceso normal (no reflexión), pero se mantiene por
# seguridad ya que forma parte del framework Android.
-dontwarn org.json.**
