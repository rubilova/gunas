import SwiftUI

struct OnboardingView: View {
    var onFinish: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Three energies, one you")
                .font(.title2.bold())
                .padding(.bottom, 6)

            Text("Every state you're in leans toward one of these. Gunas helps you notice which.")
                .font(.subheadline)
                .foregroundStyle(GunaColors.muted)
                .padding(.bottom, 20)

            VStack(spacing: 12) {
                ForEach(Guna.allCases) { guna in
                    HStack(spacing: 12) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(GunaColors.color(for: guna))
                            .frame(width: 34, height: 34)

                        VStack(alignment: .leading, spacing: 2) {
                            Text(guna.rawValue)
                                .font(.subheadline.bold())
                                .foregroundStyle(GunaColors.color(for: guna))
                            Text(guna.quality)
                                .font(.caption)
                                .foregroundStyle(GunaColors.muted)
                        }
                        Spacer()
                    }
                    .padding(14)
                    .background(GunaColors.card)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(color: .black.opacity(0.05), radius: 3, y: 1)
                }
            }

            Spacer()

            Button(action: onFinish) {
                Text("Get started")
                    .font(.subheadline.bold())
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(GunaColors.ink)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
            }
        }
        .padding(20)
        .background(GunaColors.background)
    }
}

#Preview {
    OnboardingView(onFinish: {})
}
