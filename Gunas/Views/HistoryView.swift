import SwiftUI
import SwiftData

struct HistoryView: View {
    @Query(sort: \CheckInEntry.date, order: .reverse) private var entries: [CheckInEntry]
    @State private var selectedDay: DaySelection?

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 4), count: 7)

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Your last 30 days")
                        .font(.title2.bold())
                        .padding(.bottom, 4)

                    Text("Each square is a day's dominant guna.")
                        .font(.subheadline)
                        .foregroundStyle(GunaColors.muted)
                        .padding(.bottom, 16)

                    if entries.isEmpty {
                        emptyState
                    } else {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("THIS MONTH")
                                .font(.caption2.bold())
                                .foregroundStyle(GunaColors.muted)

                            LazyVGrid(columns: columns, spacing: 4) {
                                ForEach(last30Days, id: \.self) { day in
                                    dayCell(for: day)
                                }
                            }
                        }
                        .padding(14)
                        .background(GunaColors.card)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(color: .black.opacity(0.05), radius: 3, y: 1)
                        .padding(.bottom, 14)

                        insightCard
                    }
                }
                .padding(20)
            }
            .background(GunaColors.background)
            .navigationTitle("History")
            .sheet(item: $selectedDay) { selection in
                DayDetailView(day: selection.date, entries: dayEntries(for: selection.date))
            }
        }
    }

    // MARK: - Empty state

    private var emptyState: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("No check-ins yet")
                .font(.subheadline.bold())
            Text("Head to the Check-in tab — your history will build up here.")
                .font(.caption)
                .foregroundStyle(GunaColors.muted)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background(GunaColors.card)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    // MARK: - Heatmap

    /// Newest day first, so today lands top-left in the grid.
    private var last30Days: [Date] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: .now)
        return (0..<30).compactMap { offset in
            calendar.date(byAdding: .day, value: -offset, to: today)
        }
    }

    private func dayEntries(for day: Date) -> [CheckInEntry] {
        let calendar = Calendar.current
        return entries.filter { calendar.isDate($0.date, inSameDayAs: day) }
    }

    private func blend(onDay day: Date) -> GunaBlend? {
        let dayEntries = dayEntries(for: day)
        guard !dayEntries.isEmpty else { return nil }
        return GunaBlend.average(dayEntries.map(\.blend))
    }

    private func dayCell(for day: Date) -> some View {
        let dayBlend = blend(onDay: day)
        return RoundedRectangle(cornerRadius: 4)
            .fill(dayBlend.map { GunaColors.color(for: $0.dominant) } ?? GunaColors.border.opacity(0.5))
            .aspectRatio(1, contentMode: .fit)
            .contentShape(Rectangle())
            .onTapGesture {
                selectedDay = DaySelection(date: day)
            }
    }

    // MARK: - Insight

    private var dominantGunaOverall: Guna? {
        let counts = Dictionary(grouping: entries, by: \.blend.dominant).mapValues(\.count)
        return counts.max(by: { $0.value < $1.value })?.key
    }

    private var insightCard: some View {
        Group {
            if entries.count < 3 {
                insightText(Text("A few more check-ins and I'll start showing you patterns."))
            } else if let top = dominantGunaOverall {
                insightText(
                    Text("Lately you've mostly been in ")
                    + Text(top.rawValue).bold().foregroundStyle(GunaColors.color(for: top))
                    + Text(".")
                )
            }
        }
    }

    private func insightText(_ text: Text) -> some View {
        text
            .font(.subheadline)
            .foregroundStyle(GunaColors.ink)
            .padding(14)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(GunaColors.sattvaSoft)
            .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}

/// Wraps a Date so it can drive a `.sheet(item:)` presentation.
private struct DaySelection: Identifiable {
    let date: Date
    var id: Date { date }
}

#Preview {
    HistoryView()
        .modelContainer(for: CheckInEntry.self, inMemory: true)
}
