import SwiftUI

struct SettingsView: View {
    @AppStorage("dailyReminder") private var dailyReminder: Bool = true
    @AppStorage("cloudSync") private var cloudSync: Bool = false
    @State private var showDeleteConfirm = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 8) {
                    settingsRow(
                        title: "Daily reminder",
                        subtitle: "8:00 PM check-in nudge",
                        trailing: AnyView(Toggle("", isOn: $dailyReminder).labelsHidden())
                    )
                    settingsRow(
                        title: "Cloud sync",
                        subtitle: "Encrypted, opt-in",
                        trailing: AnyView(Toggle("", isOn: $cloudSync).labelsHidden())
                    )
                    settingsRow(title: "Guidance tone", subtitle: "Gentle & brief")
                    settingsRow(title: "Export my data", subtitle: "CSV / JSON")
                    settingsRow(
                        title: "Delete all data",
                        subtitle: "Cannot be undone",
                        subtitleColor: GunaColors.rajas
                    )
                    .onTapGesture { showDeleteConfirm = true }
                }
                .padding(20)
            }
            .background(GunaColors.background)
            .navigationTitle("Settings")
            .alert("Delete all data?", isPresented: $showDeleteConfirm) {
                Button("Cancel", role: .cancel) {}
                Button("Delete", role: .destructive) {}
            } message: {
                Text("This removes every check-in and journal note. This cannot be undone.")
            }
        }
    }

    private func settingsRow(
        title: String,
        subtitle: String,
        subtitleColor: Color = GunaColors.muted,
        trailing: AnyView? = nil
    ) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(title).font(.subheadline.bold())
                Text(subtitle).font(.caption).foregroundStyle(subtitleColor)
            }
            Spacer()
            trailing
        }
        .padding(14)
        .background(GunaColors.card)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .shadow(color: .black.opacity(0.05), radius: 3, y: 1)
    }
}

#Preview {
    SettingsView()
}
