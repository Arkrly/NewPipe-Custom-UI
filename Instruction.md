# Instruction File: NewPipe UI Modernization (GitHub Nightlight & Glassmorphism)

## 1. Project Overview
**Goal:** Completely reskin the NewPipe Android application (Java/Kotlin/XML) to match a modern "GitHub Dark/Nightlight" aesthetic with Glassmorphism elements and Material Design 3 (M3) shapes.
**Base:** Native Android (XML Layouts, standard Views, and some Custom Views).
**Constraint:** Do **NOT** suggest Web technologies (React, CSS, Tailwind). This is strictly Android XML and Java/Kotlin.

---

## 2. Design System & Aesthetics

### A. Color Palette (The "Nightlight" Theme)
**Target File:** `app/src/main/res/values/colors.xml` (and `values-night/colors.xml`)

We are replacing the standard Red/Gray theme with high-contrast dark blues and neon accents.

| UI Element | New Hex Code | Description | NewPipe Resource Mapping |
| :--- | :--- | :--- | :--- |
| **Window Background** | `#0d1117` | Deep Slate | `dark_background`, `background_holo_dark` |
| **Surface (Cards/Lists)** | `#161b22` | Dark Blue-Gray | `dark_surface`, `list_background` |
| **Glass Overlay** | `#CC161b22` | 80% Opacity Surface | `glass_background` (New resource) |
| **Primary Accent** | `#58a6ff` | Neon Blue | `newpipe_red`, `holo_blue_light` |
| **Secondary Accent** | `#bc8cff` | Soft Purple | `subscribe_background_color` |
| **Primary Text** | `#c9d1d9` | Off-White | `white`, `light_text_primary` |
| **Secondary Text** | `#8b949e` | Muted Gray | `light_text_secondary` |
| **Borders/Dividers** | `#30363d` | Dark Border | `separator_color` |

### B. Typography & Shapes
**Target File:** `app/src/main/res/values/dimens.xml` & `styles.xml`

* **Corner Radius:** Increase from standard 2dp/4dp to **16dp** (Cards) and **24dp** (Dialogs/Sheets) to match Material 3.
* **Fonts:** Use `sans-serif-medium` for headers to add weight.
* **Spacing:** Use an 8dp grid system (`8dp`, `16dp`, `24dp`).

---

## 3. Implementation Plan

### Phase 1: Resource Foundation
1.  **Update `colors.xml`:** Replace the hex codes for the core branding colors with the Palette defined above.
2.  **Create Glass Drawables (`res/drawable/`):**
    * Create `bg_glass_panel.xml`: A shape with the `Glass Overlay` color, `16dp` corners, and a `1dp` stroke using `#1Affffff` (subtle white border).
    * Create `bg_glass_input.xml`: For search bars/inputs, darker background `#010409` with neon blue stroke on focus.

### Phase 2: Component Overhaul

#### Video List Items (`layout/list_stream_item.xml`)
* **CardView:** Set `app:cardCornerRadius="16dp"` and `app:cardElevation="0dp"`.
* **Background:** Use the `Surface` color (`#161b22`).
* **Borders:** Add a 1dp stroke color (`#30363d`) to the CardView (requires MaterialCardView).
* **Thumbnail:** Ensure corners are rounded to match the card.

#### Main Navigation (`layout/activity_main.xml`)
* **Bottom Navigation / Tabs:**
    * Change background to `bg_glass_panel` (semi-transparent).
    * Set `android:elevation="8dp"` so it floats above content.
* **Top Toolbar:**
    * Remove solid shadow. Use a transparent background with a bottom border (`#30363d`).

#### Player UI (`layout/player.xml` & `layout/player_control_view.xml`)
* **Controls Overlay:**
    * Change the black transparent background to a blurred/tinted dark slate.
    * Update Play/Pause/Seek icons to use the **Primary Accent** (`#58a6ff`) instead of White.
* **Seekbar:** Customize the thumb and progress tint to `#58a6ff`.

### Phase 3: Animations (`res/anim/` & `res/animator/`)
* **Press State:** Add `scale_up.xml` (95% -> 100%) on card clicks.
* **Transitions:** Add `fade_in.xml` and `slide_up.xml` for fragment transitions to make the app feel fluid.

---

## 4. Coding Rules & Constraints

1.  **Library Usage:** Do not add heavy external libraries unless absolutely necessary for Blur. Try to simulate Glassmorphism first using **Alpha colors** and **Strokes**.
2.  **Legacy Support:** NewPipe supports older Android versions. Ensure `vectorDrawables` are handled correctly and use `?attr/` references for colors where possible to support theme switching.
3.  **Preserve Logic:** Do **not** modify `StreamExtractor`, `Downloader`, or Service logic. Only touch the `res/` folder and `View` binding logic in Activities/Fragments.
4.  **XML Precision:** When I ask for code, provide the **full XML block** for the specific element being modified, not just one line.

## 5. First Task
Start by generating the updated content for `app/src/main/res/values/colors.xml`. Map the "Nightlight" palette to the existing NewPipe color names (like `newpipe_red` -> Neon Blue) so the theme applies globally immediately.