import SwiftUI

/// A persistent, always-accessible page explaining the three gunas in full —
/// unlike the onboarding cards, which are a quick one-time teaser.
struct GunaGuideView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Text("The three gunas")
                        .font(.title2.bold())
                        .padding(.bottom, 4)

                    Text("Every state you're in leans toward one of these three qualities.")
                        .font(.subheadline)
                        .foregroundStyle(GunaColors.muted)
                        .padding(.bottom, 20)

                    VStack(spacing: 20) {
                        ForEach(Guna.allCases) { guna in
                            gunaCard(guna)
                        }
                    }
                }
                .padding(20)
            }
            .background(GunaColors.background)
            .navigationTitle("Guna Guide")
        }
    }

    private func gunaCard(_ guna: Guna) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(guna.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 170)
                .frame(maxWidth: .infinity)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.bottom, 12)

            HStack(spacing: 8) {
                Circle()
                    .fill(GunaColors.color(for: guna))
                    .frame(width: 10, height: 10)
                Text(guna.rawValue)
                    .font(.headline)
                    .foregroundStyle(GunaColors.color(for: guna))
                Text(guna.quality)
                    .font(.caption)
                    .foregroundStyle(GunaColors.muted)
            }
            .padding(.bottom, 8)

            Text(guna.about)
                .font(.subheadline)
                .foregroundStyle(GunaColors.ink)
                .padding(.bottom, 10)

            HStack(alignment: .top, spacing: 6) {
                Text("FEELS LIKE")
                    .font(.caption2.bold())
                    .foregroundStyle(GunaColors.muted)
                Text(guna.feelsLike)
                    .font(.caption)
                    .foregroundStyle(GunaColors.muted)
            }
        }
        .padding(16)
        .background(GunaColors.card)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
    }
}

#Preview {
    GunaGuideView()
}
