import SwiftUI

struct GunaDonut: View {
    let blend: GunaBlend
    var diameter: CGFloat = 150
    var lineWidth: CGFloat = 22

    var body: some View {
        let n = blend.normalized
        let rajasEnd = n.rajas
        let tamasEnd = rajasEnd + n.tamas

        ZStack {
            Group {
                Circle()
                    .trim(from: 0, to: max(rajasEnd, 0.0001))
                    .stroke(GunaColors.rajas, style: StrokeStyle(lineWidth: lineWidth, lineCap: .butt))

                Circle()
                    .trim(from: rajasEnd, to: max(tamasEnd, rajasEnd + 0.0001))
                    .stroke(GunaColors.tamas, style: StrokeStyle(lineWidth: lineWidth, lineCap: .butt))

                Circle()
                    .trim(from: tamasEnd, to: 1.0)
                    .stroke(GunaColors.sattva, style: StrokeStyle(lineWidth: lineWidth, lineCap: .butt))
            }
            .rotationEffect(.degrees(-90))

            VStack(spacing: 2) {
                Text("dominant")
                    .font(.system(size: 11))
                    .foregroundStyle(GunaColors.muted)
                Text(blend.dominant.rawValue)
                    .font(.system(size: 18, weight: .heavy))
                    .foregroundStyle(GunaColors.color(for: blend.dominant))
            }
        }
        .frame(width: diameter, height: diameter)
    }
}

#Preview {
    GunaDonut(blend: GunaBlend(sattva: 0.2, rajas: 0.55, tamas: 0.25))
}
