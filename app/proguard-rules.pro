# https://developer.android.com/build/shrink-code

# ===============================================
# OPTIMIZATION SETTINGS
# ===============================================

# Enable aggressive optimizations for better runtime performance
-optimizationpasses 5
-allowaccessmodification
-mergeinterfacesaggressively
-repackageclasses ''

# Optimization algorithms - enable all for maximum performance
-optimizations !code/simplification/arithmetic,!code/simplification/cast,!field/*,!class/merging/*,!code/allocation/variable

# Remove unused code for smaller APK and faster execution
-assumenosideeffects class android.util.Log {
    public static boolean isLoggable(java.lang.String, int);
    public static int v(...);
    public static int d(...);
    public static int i(...);
}

# Remove Kotlin intrinsics checks in release for better performance
-assumenosideeffects class kotlin.jvm.internal.Intrinsics {
    public static void checkNotNull(...);
    public static void checkExpressionValueIsNotNull(...);
    public static void checkNotNullExpressionValue(...);
    public static void checkParameterIsNotNull(...);
    public static void checkNotNullParameter(...);
    public static void checkReturnedValueIsNotNull(...);
    public static void checkFieldIsNotNull(...);
    public static void throwUninitializedPropertyAccessException(...);
}

# ===============================================
# REQUIRED KEEP RULES
# ===============================================

## Helps debug release versions
-dontobfuscate

## Rules for NewPipeExtractor
-keep class org.schabi.newpipe.extractor.timeago.patterns.** { *; }
## Rules for Rhino and Rhino Engine
-keep class org.mozilla.javascript.* { *; }
-keep class org.mozilla.javascript.** { *; }
-keep class org.mozilla.javascript.engine.** { *; }
-keep class org.mozilla.classfile.ClassFileWriter
-dontwarn org.mozilla.javascript.JavaToJSONConverters
-dontwarn org.mozilla.javascript.tools.**
-keep class javax.script.** { *; }
-dontwarn javax.script.**
-keep class jdk.dynalink.** { *; }
-dontwarn jdk.dynalink.**

## Rules for ExoPlayer
-keep class com.google.android.exoplayer2.** { *; }

## Rules for OkHttp. Copy pasted from https://github.com/square/okhttp
-dontwarn okhttp3.**
-dontwarn okio.**

## Rules for RxJava
-dontwarn io.reactivex.rxjava3.**
-keep class io.reactivex.rxjava3.** { *; }

## Rules for Picasso
-dontwarn com.squareup.picasso.**
-keep class com.squareup.picasso.** { *; }

## See https://github.com/TeamNewPipe/NewPipe/pull/1441
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    !static !transient <fields>;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
}

## For some reason NotificationModeConfigFragment wasn't kept (only referenced in a preference xml)
-keep class org.schabi.newpipe.settings.notifications.** { *; }

## Keep Room entities and DAOs
-keep class * extends androidx.room.RoomDatabase { *; }
-keep @androidx.room.Entity class * { *; }
-keep @androidx.room.Dao class * { *; }

## Keep Parcelable implementations
-keepclassmembers class * implements android.os.Parcelable {
    public static final android.os.Parcelable$Creator CREATOR;
}

## Keep ViewBinding generated classes
-keep class * implements androidx.viewbinding.ViewBinding {
    public static ** inflate(android.view.LayoutInflater);
    public static ** inflate(android.view.LayoutInflater, android.view.ViewGroup, boolean);
    public static ** bind(android.view.View);
}

## Keep Groupie items
-keep class * extends com.xwray.groupie.Item { *; }

## Keep ACRA crash reporter
-keep class org.acra.** { *; }
-dontwarn org.acra.**
