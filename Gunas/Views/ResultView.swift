import SwiftUI

struct ResultView: View {
    let blend: GunaBlend
    var tagNames: [String] = []
    var hadNote: Bool = false

    private var dominant: Guna { blend.dominant }

    private var basedOnText: String {
        switch (tagNames.isEmpty, hadNote) {
        case (false, true):
            return "Based on: \(tagNames.joined(separator: ", ")) + your note"
        case (false, false):
            return "Based on: \(tagNames.joined(separator: ", "))"
        case (true, true):
            return "Based on your note"
        case (true, false):
            return "Based on your note (no strong signal found — try a tag too)"
        }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Text("You're mostly in \(dominant.rawValue)")
                    .font(.title2.bold())
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 4)

                Text(basedOnText)
                    .font(.subheadline)
                    .foregroundStyle(GunaColors.muted)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 16)

                GunaDonut(blend: blend)
                    .padding(.bottom, 14)

                HStack(spacing: 16) {
                    legendItem(.rajas)
                    legendItem(.tamas)
                    legendItem(.sattva)
                }
                .padding(.bottom, 20)

                VStack(alignment: .leading, spacing: 6) {
                    Text("REFLECTION")
                        .font(.caption2.bold())
                        .foregroundStyle(GunaColors.color(for: dominant))
                    Text(dominant.reflection)
                        .font(.subheadline)
                        .foregroundStyle(GunaColors.ink)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(14)
                .background(GunaColors.softColor(for: dominant))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.bottom, 12)

                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 9)
                        .fill(GunaColors.softColor(for: dominant))
                        .frame(width: 32, height: 32)

                    VStack(alignment: .leading, spacing: 2) {
                        Text(dominant.suggestedActionTitle)
                            .font(.subheadline.bold())
                        Text(dominant.suggestedActionSubtitle)
                            .font(.caption)
                            .foregroundStyle(GunaColors.muted)
                    }
                    Spacer()
                }
                .padding(12)
                .background(GunaColors.card)
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .shadow(color: .black.opacity(0.05), radius: 3, y: 1)
            }
            .padding(20)
        }
        .background(GunaColors.background)
        .navigationTitle("Result")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func legendItem(_ guna: Guna) -> some View {
        HStack(spacing: 5) {
            Circle()
                .fill(GunaColors.color(for: guna))
                .frame(width: 9, height: 9)
            Text("\(guna.rawValue) \(blend.percent(for: guna))%")
                .font(.caption)
                .foregroundStyle(GunaColors.muted)
        }
    }
}

#Preview {
    NavigationStack {
        ResultView(blend: GunaBlend(sattva: 0.2, rajas: 0.55, tamas: 0.25))
    }
}
