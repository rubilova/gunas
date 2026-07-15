# Gunas — Xcode Prototype

A SwiftUI implementation of the five mockup screens (Onboarding, Check-in, Result, History, Settings), matching the colors and layout in `Gunas_Mockups.html`.

## Open it

Double-click `Gunas.xcodeproj`, or open it from within Xcode (15.2+, iOS 17 target). Run on the iPhone simulator.

## What's real vs. stubbed

- **Tap-tag detection** is fully implemented — `Models/FeelingTag.swift` holds the weighted tag list, `Models/GunaBlend.swift` blends multiple selections.
- **Free-text detection** in `Services/GunaClassifier.swift` is a simple local keyword matcher, standing in for the Claude-based classifier described in the concept doc (section 5.2). Swap `classifyText(_:)` for a real API call when you're ready to wire up AI classification.
- **History** uses mock data (`Views/HistoryView.swift`) — there's no persistence yet.
- **Settings** toggles are stored in `@AppStorage` (UserDefaults) as placeholders; reminders/cloud sync aren't functionally wired up.

## Before shipping

- Set your own bundle identifier and signing team in the target's *Signing & Capabilities* tab (currently `com.gunas.app`).
- Replace the placeholder `AppIcon` and `AccentColor` in `Assets.xcassets`.
- Add local persistence (e.g. SwiftData) for check-ins if you want History to reflect real data.
