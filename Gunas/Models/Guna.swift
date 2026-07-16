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

    /// Name of the imageset in Assets.xcassets used to represent this guna.
    var imageName: String {
        switch self {
        case .sattva: return "GunaSattva"
        case .rajas: return "GunaRajas"
        case .tamas: return "GunaTamas"
        }
    }

    /// A longer, plain-language explanation for readers unfamiliar with the concept.
    /// Shown on the Guna Guide screen.
    var about: String {
        switch self {
        case .sattva:
            return "Sattva is the quality of clarity and balance. It's the state behind a clear, quiet mind — when you feel present, content, and unhurried, with nothing pulling you in different directions. In the Bhagavad Gita's framework, sattva is described as luminous and untroubled: not excitement, just ease."
        case .rajas:
            return "Rajas is the quality of motion and desire. It shows up as drive, ambition, restlessness, or craving — the energy that gets things done but can just as easily tip into agitation, impatience, or burnout when it runs unchecked. Most modern \"productive but wired\" days lean rajasic."
        case .tamas:
            return "Tamas is the quality of inertia and heaviness. It's the fog, the flatness, the pull toward the couch instead of the task — sometimes genuine rest your body needs, sometimes avoidance or stagnation. Tamas isn't \"bad\"; it's a signal to slow down and figure out which one it is."
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
