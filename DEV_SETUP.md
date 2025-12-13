# NewPipe Custom UI - Development Setup Guide

## 📋 Project Overview

**NewPipe Custom UI** is a customized fork of NewPipe, a libre lightweight streaming front-end for Android.

- **Project Type**: Android Application
- **Build System**: Gradle 9.2.1 with Kotlin DSL
- **Language**: Java + Kotlin
- **Min SDK**: 21 (Android 5.0)
- **Target SDK**: 35 (Android 14)
- **Compile SDK**: 36
- **Current Version**: 0.28.0

## 🏗️ Project Structure

```
NewPipe-Custom-UI/
├── app/                          # Main application module
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/             # Java/Kotlin source code
│   │   │   │   └── org/schabi/newpipe/
│   │   │   │       ├── MainActivity.java
│   │   │   │       ├── fragments/
│   │   │   │       ├── player/
│   │   │   │       ├── settings/
│   │   │   │       ├── local/
│   │   │   │       └── views/
│   │   │   ├── res/              # Resources (layouts, drawables, values)
│   │   │   │   ├── layout/       # 116 XML layout files
│   │   │   │   ├── drawable/     # 144 drawable resources
│   │   │   │   ├── values/       # Styles, colors, strings, dimensions
│   │   │   │   └── values-*/     # Localized resources (150+ languages)
│   │   │   └── AndroidManifest.xml
│   │   ├── debug/
│   │   ├── test/
│   │   └── androidTest/
│   └── build.gradle.kts          # App-level build configuration
├── build.gradle.kts              # Root build configuration
├── settings.gradle.kts           # Gradle settings
└── gradle/                       # Gradle wrapper files
```

## 🎨 Current UI Theme System

### Theme Variants
The app supports **3 theme variants**:
1. **Light Theme** - Light background with dark text
2. **Dark Theme** - Dark gray background (#222222)
3. **Black Theme** - Pure black background (#000000) for OLED screens

### Key UI Resources

#### Colors (`app/src/main/res/values/colors.xml`)
- **Light Theme**: 
  - Primary: YouTube red (#CD201F)
  - Background: #EEEEEE
  - Accent: #e53935
- **Dark Theme**:
  - Primary: YouTube red
  - Background: #222222
  - Accent: #ff5252
- **Black Theme**:
  - Background: #000000
  - Inherits other colors from Dark Theme

#### Styles (`app/src/main/res/values/styles.xml`)
- Base themes extending `Theme.AppCompat.DayNight.NoActionBar`
- Custom attributes for:
  - Separator colors
  - Contrast backgrounds
  - Card item backgrounds
  - Border colors
  - Ripple effects
  - Progress bars

#### Layout Files (116 total)
Key layouts to focus on for UI updates:
- `activity_main.xml` - Main app container
- `fragment_video_detail.xml` - Video player screen (39KB - largest)
- `player.xml` - Video player UI (39KB)
- `fragment_feed.xml` - Home feed
- `fragment_search.xml` - Search interface
- `list_stream_*.xml` - Video list items (card, grid, mini variants)
- `drawer_*.xml` - Navigation drawer

## 🛠️ Development Environment Setup

### Prerequisites
1. **Java Development Kit (JDK) 17**
   - Required by the project's Java toolchain
   - Check: `java -version`

2. **Android SDK**
   - Android SDK Platform 36 (for compilation)
   - Android SDK Platform 35 (target)
   - Build Tools

3. **Git**
   - For version control

### Initial Setup Steps

#### 1. Verify Gradle Installation
```powershell
# The project uses Gradle Wrapper, so Gradle will auto-download
.\gradlew.bat --version
```

#### 2. Sync Dependencies
```powershell
# Download all project dependencies
.\gradlew.bat build --refresh-dependencies
```

#### 3. Build the Project
```powershell
# Build debug APK
.\gradlew.bat assembleDebug

# Build release APK
.\gradlew.bat assembleRelease
```

#### 4. Run Code Quality Checks
```powershell
# Run Checkstyle (Java)
.\gradlew.bat runCheckstyle

# Run ktlint (Kotlin)
.\gradlew.bat runKtlint

# Auto-format Kotlin code
.\gradlew.bat formatKtlint
```

## 📱 Key Dependencies

### UI & Design
- **Material Design**: `com.google.android.material`
- **AndroidX Libraries**:
  - AppCompat
  - ConstraintLayout
  - RecyclerView
  - CardView
  - ViewPager2
  - SwipeRefreshLayout
- **Groupie**: Complex RecyclerView layouts
- **Picasso**: Image loading

### Media Player
- **ExoPlayer**: Video/audio playback
  - Core, DASH, HLS, SmoothStreaming
  - UI components
  - MediaSession integration

### Architecture
- **Room**: Local database
- **RxJava 3**: Reactive programming
- **LiveData & ViewModel**: Architecture components

## 🎯 UI Update Strategy

### Phase 1: Theme & Color System
1. **Update Color Palette**
   - Modernize color scheme in `values/colors.xml`
   - Add Material Design 3 color tokens
   - Implement dynamic color support (Android 12+)

2. **Enhance Themes**
   - Update `values/styles.xml`
   - Add Material 3 theme attributes
   - Implement elevation overlays
   - Add custom shape theming

### Phase 2: Layout Modernization
1. **Main Screens**
   - `activity_main.xml` - Modern navigation
   - `fragment_video_detail.xml` - Enhanced player UI
   - `fragment_feed.xml` - Improved feed layout

2. **List Items**
   - Update all `list_stream_*.xml` files
   - Add rounded corners
   - Improve spacing and typography
   - Add subtle shadows/elevation

3. **Components**
   - Modernize buttons and FABs
   - Update dialogs
   - Enhance search interface
   - Improve player controls

### Phase 3: Visual Enhancements
1. **Typography**
   - Implement Material Design type scale
   - Add custom fonts (if desired)
   - Improve text hierarchy

2. **Animations**
   - Add smooth transitions
   - Implement shared element transitions
   - Add micro-interactions

3. **Icons & Graphics**
   - Update icon set
   - Add vector drawables
   - Implement adaptive icons

## 📝 Development Workflow

### Making UI Changes

1. **Edit Resource Files**
   ```
   app/src/main/res/
   ├── values/colors.xml       # Color definitions
   ├── values/styles.xml       # Theme styles
   ├── values/dimens.xml       # Dimensions
   ├── layout/*.xml            # Layout files
   └── drawable/*.xml          # Vector graphics
   ```

2. **Build & Test**
   ```powershell
   # Quick build
   .\gradlew.bat assembleDebug
   
   # Install on connected device
   .\gradlew.bat installDebug
   ```

3. **Code Quality**
   ```powershell
   # Auto-format before commit
   .\gradlew.bat formatKtlint
   
   # Run all checks
   .\gradlew.bat runCheckstyle runKtlint
   ```

### Build Variants
- **Debug**: Development builds with debugging enabled
  - App ID suffix: `.debug`
  - App name: "NewPipe Debug" (or branch name)
- **Release**: Production builds with ProGuard
  - Minification enabled
  - Requires signing configuration

## 🔧 Useful Gradle Tasks

```powershell
# List all tasks
.\gradlew.bat tasks

# Clean build
.\gradlew.bat clean

# Build debug APK
.\gradlew.bat assembleDebug

# Run unit tests
.\gradlew.bat test

# Run instrumented tests
.\gradlew.bat connectedAndroidTest

# Generate dependency report
.\gradlew.bat dependencies
```

## 📚 Important Files for UI Development

### Must-Know Files
1. **`app/src/main/res/values/colors.xml`** - All color definitions
2. **`app/src/main/res/values/styles.xml`** - Theme definitions
3. **`app/src/main/res/values/dimens.xml`** - Spacing, sizes
4. **`app/src/main/res/values/strings.xml`** - Text strings (67KB)
5. **`app/build.gradle.kts`** - Dependencies and build config

### Key Java/Kotlin Files
1. **`MainActivity.java`** - Main activity (43KB)
2. **`App.java`** - Application class
3. **`fragments/`** - All fragment implementations
4. **`player/`** - Video player logic
5. **`views/`** - Custom view components

## 🎨 Design Guidelines

### Material Design Principles
- Use elevation for hierarchy
- Implement consistent spacing (8dp grid)
- Follow Material motion guidelines
- Use appropriate typography scale
- Maintain touch target sizes (48dp minimum)

### NewPipe-Specific
- Maintain YouTube-like familiarity
- Ensure accessibility
- Support all theme variants
- Keep performance in mind
- Maintain backward compatibility (API 21+)

## 🚀 Next Steps

1. ✅ **Environment Setup** - Install JDK 17, Android SDK
2. ⏳ **Gradle Sync** - Complete dependency download
3. 📋 **UI Audit** - Review current UI components
4. 🎨 **Design System** - Create modern color palette & styles
5. 🔨 **Implementation** - Update layouts and themes
6. 🧪 **Testing** - Test on multiple devices and themes
7. 📦 **Build** - Generate APK for testing

## 📞 Resources

- **NewPipe Website**: https://newpipe.net
- **GitHub**: https://github.com/TeamNewPipe/NewPipe
- **Documentation**: https://teamnewpipe.github.io/documentation/
- **Material Design**: https://m3.material.io/

---

**Status**: Development environment setup in progress
**Last Updated**: 2025-12-13
