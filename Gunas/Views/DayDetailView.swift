import SwiftUI

/// Sheet shown when tapping a day in the History heatmap — lists every
/// check-in logged that day.
struct DayDetailView: View {
    let day: Date
    let entries: [CheckInEntry]
    @Environment(\.dismiss) private var dismiss

    private var dayTitle: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d"
        return formatter.string(from: day)
    }

    private var sortedEntries: [CheckInEntry] {
        entries.sorted { $0.date > $1.date }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    if entries.isEmpty {
                        emptyState
                    } else {
                        ForEach(sortedEntries) { entry in
                            entryCard(entry)
                        }
                    }
                }
                .padding(20)
            }
            .background(GunaColors.background)
            .navigationTitle(dayTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
        .presentationDetents([.medium, .large])
    }

    private var emptyState: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("No check-ins this day")
                .font(.subheadline.bold())
            Text("Nothing was logged on \(dayTitle).")
                .font(.caption)
                .foregroundStyle(GunaColors.muted)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background(GunaColors.card)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private func entryCard(_ entry: CheckInEntry) -> some View {
        let dominant = entry.blend.dominant
        let trimmedNote = entry.note.trimmingCharacters(in: .whitespacesAndNewlines)

        return VStack(alignment: .leading, spacing: 10) {
            HStack {
                Circle()
                    .fill(GunaColors.color(for: dominant))
                    .frame(width: 10, height: 10)
                Text(dominant.rawValue)
                    .font(.subheadline.bold())
                    .foregroundStyle(GunaColors.color(for: dominant))
                Spacer()
                Text(entry.date, format: .dateTime.hour().minute())
                    .font(.caption)
                    .foregroundStyle(GunaColors.muted)
            }

            HStack(spacing: 14) {
                percentLabel(.sattva, entry.blend)
                percentLabel(.rajas, entry.blend)
                percentLabel(.tamas, entry.blend)
            }

            if !trimmedNote.isEmpty {
                Text(trimmedNote)
                    .font(.caption)
                    .foregroundStyle(GunaColors.ink)
                    .padding(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(GunaColors.softColor(for: dominant))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
        .padding(14)
        .background(GunaColors.card)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.05), radius: 3, y: 1)
    }

    private func percentLabel(_ guna: Guna, _ blend: GunaBlend) -> some View {
        HStack(spacing: 4) {
            Circle().fill(GunaColors.color(for: guna)).frame(width: 7, height: 7)
            Text("\(guna.rawValue) \(blend.percent(for: guna))%")
                .font(.caption2)
                .foregroundStyle(GunaColors.muted)
        }
    }
}

#Preview {
    DayDetailView(day: .now, entries: [])
}
