<div align="center">

# Project Ebonhold ElvUI Pack

![Version](https://img.shields.io/badge/version-v1.0.1-blue.svg?style=for-the-badge)
![Downloads](https://img.shields.io/github/downloads/Xurkon/PE-ElvUI/total?style=for-the-badge&color=e67e22)
[![Documentation](https://img.shields.io/badge/Documentation-View%20Docs-58a6ff?style=for-the-badge)](https://xurkon.github.io/PE-ElvUI/)
[![Patreon](https://img.shields.io/badge/Patreon-F96854?style=for-the-badge&logo=patreon&logoColor=white)](https://www.patreon.com/Xurkon)
[![PayPal](https://img.shields.io/badge/PayPal-00457C?style=for-the-badge&logo=paypal&logoColor=white)](https://www.paypal.me/Xurkon)
![Platform](https://img.shields.io/badge/PLATFORM-PROJECT%20EBONHOLD-blue?style=for-the-badge&logo=windows&logoColor=white)

<br/>
**Curated ElvUI + Modules collection for Project Ascension 3.3.5a**
<br/>
[⬇ **Download Latest**](https://github.com/Xurkon/PE-ElvUI/releases/latest) &nbsp;&nbsp;•&nbsp;&nbsp; [📂 **View Source**](https://github.com/Xurkon/PE-ElvUI)

</div>

---



This repository contains the curated ElvUI + Modules collection for **Project Ebonhold** (Ascension 3.3.5a), patched with critical stability fixes.

## Critical Fixes Included

### 1. Minimap Freeze Resolution
**Issue**: `ElvUI_Enhanced` (Minimap Button Grabber) and `MinimapButtonFrame` (MBF) would continuously fight for control over minimap buttons, causing an infinite loop that froze the game client on reload.
**Fix**: `ElvUI_Enhanced` now proactively detects if `MinimapButtonFrame` is loaded during initialization. If detected, the Button Grabber module automatically **disables itself**, yielding full control to MBF. This eliminates the conflict and prevents the freeze.

### 2. SwingBar Recursion Check
**Issue**: `ElvUI_SwingBar` could enter a recursive loop during `PLAYER_ENTERING_WORLD` due to unsafe event handling.
**Fix**: Added guards to initialization logic to prevent re-entrant calls.

### 3. Ebonhold Skin Recursion Check
**Issue**: The Ebonhold skin initialization logic contained an unsafe polling loop and lacked recursion guards on the `SetScale` hook. This caused it to fight with other addons attempting to control the frame scale, resulting in an infinite loop freeze.
**Fix**:
- Replaced polling timer with `PLAYER_ENTERING_WORLD` event.
- Added recursion guard to `SetScale` hook.
- Implemented "Anti-Fight Logic" to yield execution if conflict is detected.

### 4. Version Check Popup Disabled
**Issue**: ElvUI would display a "ElvUI was updated while the game is still running" popup if the version check logic triggered, even if no update had occurred (common with manual installations).
**Fix**: Disabled the version check logic entirely to prevent false positives and unnecessary popups.

## Installation
1. Download the `ElvUI-Ebonhold.zip` from the [Releases](https://github.com/Xurkon/PE-ElvUI/releases) page.
2. Extract the contents to your `WoW\Interface\AddOns` folder.
3. Reload your UI.

## Credits

- **[Qt (RosemyneH)](https://github.com/RosemyneH/ElvUI_Ebonhold)** - Initial compatibility fixes for Ebonhold.
- **Xurkon** - Stability fixes, Freeze Resolutions, and Pack Maintenance.
 
