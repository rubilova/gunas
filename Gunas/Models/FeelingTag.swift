import Foundation

/// A tappable feeling word, pre-weighted toward one or more gunas.
/// Mirrors the tag set defined in the Gunas concept doc, section 5.1.
struct FeelingTag: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let blend: GunaBlend

    static func == (lhs: FeelingTag, rhs: FeelingTag) -> Bool { lhs.id == rhs.id }
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
}

enum FeelingTags {
    static let all: [FeelingTag] = [
        // Sattva-leaning
        FeelingTag(name: "Calm", blend: GunaBlend(sattva: 1.0, rajas: 0, tamas: 0)),
        FeelingTag(name: "Focused", blend: GunaBlend(sattva: 0.9, rajas: 0.1, tamas: 0)),
        FeelingTag(name: "Grateful", blend: GunaBlend(sattva: 0.9, rajas: 0.1, tamas: 0)),
        FeelingTag(name: "Content", blend: GunaBlend(sattva: 1.0, rajas: 0, tamas: 0)),
        FeelingTag(name: "Peaceful", blend: GunaBlend(sattva: 1.0, rajas: 0, tamas: 0)),
        FeelingTag(name: "Clear-headed", blend: GunaBlend(sattva: 0.9, rajas: 0.1, tamas: 0)),

        // Rajas-leaning
        FeelingTag(name: "Anxious", blend: GunaBlend(sattva: 0, rajas: 0.7, tamas: 0.3)),
        FeelingTag(name: "Restless", blend: GunaBlend(sattva: 0, rajas: 1.0, tamas: 0)),
        FeelingTag(name: "Driven", blend: GunaBlend(sattva: 0.1, rajas: 0.9, tamas: 0)),
        FeelingTag(name: "Irritable", blend: GunaBlend(sattva: 0, rajas: 0.8, tamas: 0.2)),
        FeelingTag(name: "Craving", blend: GunaBlend(sattva: 0, rajas: 0.9, tamas: 0.1)),
        FeelingTag(name: "Wired", blend: GunaBlend(sattva: 0, rajas: 1.0, tamas: 0)),

        // Tamas-leaning
        FeelingTag(name: "Foggy", blend: GunaBlend(sattva: 0, rajas: 0, tamas: 1.0)),
        FeelingTag(name: "Exhausted", blend: GunaBlend(sattva: 0, rajas: 0.1, tamas: 0.9)),
        FeelingTag(name: "Numb", blend: GunaBlend(sattva: 0, rajas: 0, tamas: 1.0)),
        FeelingTag(name: "Stuck", blend: GunaBlend(sattva: 0, rajas: 0.1, tamas: 0.9)),
        FeelingTag(name: "Apathetic", blend: GunaBlend(sattva: 0, rajas: 0, tamas: 1.0)),
        FeelingTag(name: "Heavy", blend: GunaBlend(sattva: 0, rajas: 0, tamas: 1.0)),
    ]
}
