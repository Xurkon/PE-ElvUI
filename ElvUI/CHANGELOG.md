# Changelog

All notable changes to this project will be documented in this file.

## [6.10] - 2026-01-30
### Fixed
- **Critical Freeze Fix**: Resolved a client freeze issue occurring during `Reload UI`.
  - **Refactor**: Completely removed recursive `E:Delay` polling loops in `Ebonhold.lua`.
  - **Event-Driven Initialization**: Switched to `AceEvent-3.0` `PLAYER_ENTERING_WORLD` event for safe initialization of the Project Ebonhold skin module.
  - **Recursion Guard**: Implemented a "fight detection" mechanism in the `SetScale` hook. It now tracks call frequency within the same frame (`GetTime()`) and aborts if it detects a tug-of-war (recursion depth > 20) to prevent synchronous freezes.
- **Module Fix (ElvUI_SwingBar)**: Resolved a separate synchronous infinite loop in the optional SwingBar module.
  - **Recursion Guard**: Applied a recursion guard to the `Update_PlayerFrame` hook in `ElvUI_SwingBar.lua`. The hook was triggering layout updates that recursively called itself, causing an instant freeze. This guard limits execution to 20 calls per frame.

