import SwiftUI

struct HistoryView: View {
    // Mock data standing in for real check-in history: 0 = sattva, 1 = rajas, 2 = tamas.
    private let mockDays: [Guna] = [
        .rajas, .rajas, .sattva, .tamas, .sattva, .rajas, .tamas,
        .sattva, .rajas, .rajas, .tamas, .tamas, .sattva, .rajas,
        .rajas, .sattva, .tamas, .rajas, .rajas, .sattva, .tamas,
        .rajas, .rajas, .sattva, .tamas, .sattva, .rajas, .rajas,
        .tamas, .sattva,
    ]

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

                    VStack(alignment: .leading, spacing: 8) {
                        Text("THIS MONTH")
                            .font(.caption2.bold())
                            .foregroundStyle(GunaColors.muted)

                        LazyVGrid(columns: columns, spacing: 4) {
                            ForEach(Array(mockDays.enumerated()), id: \.offset) { _, guna in
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(GunaColors.color(for: guna))
                                    .aspectRatio(1, contentMode: .fit)
                            }
                        }
                    }
                    .padding(14)
                    .background(GunaColors.card)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(color: .black.opacity(0.05), radius: 3, y: 1)
                    .padding(.bottom, 14)

                    (
                        Text("Pattern: ").bold().foregroundStyle(GunaColors.sattva)
                        + Text("You trend Rajas on Monday & Tuesday mornings, and Tamas by Thursday evening.")
                            .foregroundStyle(GunaColors.ink)
                    )
                    .font(.subheadline)
                    .padding(14)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(GunaColors.sattvaSoft)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                }
                .padding(20)
            }
            .background(GunaColors.background)
            .navigationTitle("History")
        }
    }
}

#Preview {
    HistoryView()
}
