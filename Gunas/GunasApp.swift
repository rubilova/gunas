import SwiftUI

@main
struct GunasApp: App {
    @AppStorage("hasOnboarded") private var hasOnboarded: Bool = false

    var body: some Scene {
        WindowGroup {
            if hasOnboarded {
                ContentView()
            } else {
                OnboardingView {
                    hasOnboarded = true
                }
            }
        }
    }
}
