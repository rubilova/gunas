import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CheckInView()
                .tabItem {
                    Label("Check-in", systemImage: "sparkles")
                }

            HistoryView()
                .tabItem {
                    Label("History", systemImage: "calendar")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
        .tint(GunaColors.ink)
    }
}

#Preview {
    ContentView()
}
