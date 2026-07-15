import Foundation

/// A percentage split across the three gunas. Values are expected to sum to
/// roughly 1.0 but are normalized defensively wherever used.
struct GunaBlend {
    var sattva: Double
    var rajas: Double
    var tamas: Double

    static let empty = GunaBlend(sattva: 0, rajas: 0, tamas: 0)

    var total: Double { sattva + rajas + tamas }

    var normalized: GunaBlend {
        guard total > 0 else { return GunaBlend(sattva: 1.0 / 3, rajas: 1.0 / 3, tamas: 1.0 / 3) }
        return GunaBlend(sattva: sattva / total, rajas: rajas / total, tamas: tamas / total)
    }

    var dominant: Guna {
        if sattva >= rajas && sattva >= tamas { return .sattva }
        if rajas >= sattva && rajas >= tamas { return .rajas }
        return .tamas
    }

    func percent(for guna: Guna) -> Int {
        let n = normalized
        switch guna {
        case .sattva: return Int((n.sattva * 100).rounded())
        case .rajas: return Int((n.rajas * 100).rounded())
        case .tamas: return Int((n.tamas * 100).rounded())
        }
    }

    static func average(_ blends: [GunaBlend]) -> GunaBlend {
        guard !blends.isEmpty else { return .empty }
        let count = Double(blends.count)
        return GunaBlend(
            sattva: blends.reduce(0) { $0 + $1.sattva } / count,
            rajas: blends.reduce(0) { $0 + $1.rajas } / count,
            tamas: blends.reduce(0) { $0 + $1.tamas } / count
        )
    }
}
