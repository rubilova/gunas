import Foundation

enum Guna: String, CaseIterable, Identifiable {
    case sattva = "Sattva"
    case rajas = "Rajas"
    case tamas = "Tamas"

    var id: String { rawValue }

    var quality: String {
        switch self {
        case .sattva: return "Clarity, harmony"
        case .rajas: return "Passion, activity"
        case .tamas: return "Inertia, dullness"
        }
    }

    var feelsLike: String {
        switch self {
        case .sattva: return "Calm, focused, content, present, light"
        case .rajas: return "Driven, restless, wired, craving, agitated"
        case .tamas: return "Foggy, heavy, numb, stuck, exhausted"
        }
    }

    var reflection: String {
        switch self {
        case .sattva:
            return "You're clear and steady right now. A good moment for focused work or something you've been putting off."
        case .rajas:
            return "Your mind is moving faster than your body can keep up with — restlessness with an undertone of drive."
        case .tamas:
            return "Things feel heavy and slow. Your system may be asking for rest rather than a push."
        }
    }

    var suggestedActionTitle: String {
        switch self {
        case .sattva: return "Ride the clarity"
        case .rajas: return "2-min breath reset"
        case .tamas: return "Gentle movement"
        }
    }

    var suggestedActionSubtitle: String {
        switch self {
        case .sattva: return "Start the thing you've been avoiding"
        case .rajas: return "Slow exhale, 4 rounds"
        case .tamas: return "A short walk or stretch"
        }
    }
}
