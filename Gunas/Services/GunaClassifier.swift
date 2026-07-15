import Foundation

/// Combines tap-tag and free-text signals into a single guna blend.
///
/// `classifyText(_:)` below is a local, rule-based placeholder standing in
/// for the AI classification step described in the concept doc (section 5.2):
/// in production this is replaced by a call to Claude with a system prompt
/// grounded in the classical sattva/rajas/tamas descriptions, returning a
/// structured { sattva, rajas, tamas, dominant, reflection } result.
enum GunaClassifier {
    static func classifyText(_ text: String) -> GunaBlend? {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return nil }
        let lowered = trimmed.lowercased()

        let rajasWords = ["can't focus", "cant focus", "wired", "restless", "anxious", "racing",
                           "jump", "craving", "rushed", "irritable", "on edge", "driven"]
        let tamasWords = ["tired", "foggy", "heavy", "numb", "stuck", "exhausted",
                           "flat", "unmotivated", "sluggish", "drained"]
        let sattvaWords = ["calm", "clear", "grateful", "content", "peaceful", "focused",
                            "present", "steady", "balanced"]

        func score(_ words: [String]) -> Double {
            Double(words.filter { lowered.contains($0) }.count)
        }

        let r = score(rajasWords), t = score(tamasWords), s = score(sattvaWords)
        guard r + t + s > 0 else { return nil }
        return GunaBlend(sattva: s, rajas: r, tamas: t).normalized
    }

    /// Tags act as a fast baseline (~40% weight); free text refines it (~60% weight),
    /// per the combination rule in the concept doc, section 5.3.
    static func combine(tagBlend: GunaBlend?, textBlend: GunaBlend?) -> GunaBlend {
        switch (tagBlend, textBlend) {
        case let (.some(t), .some(x)):
            return GunaBlend(
                sattva: t.sattva * 0.4 + x.sattva * 0.6,
                rajas: t.rajas * 0.4 + x.rajas * 0.6,
                tamas: t.tamas * 0.4 + x.tamas * 0.6
            ).normalized
        case let (.some(t), .none):
            return t.normalized
        case let (.none, .some(x)):
            return x.normalized
        default:
            return .empty
        }
    }
}
