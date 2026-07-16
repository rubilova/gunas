import Foundation
import SwiftData

/// A single saved check-in: the guna blend computed at the time, plus
/// whatever free-text note the user typed. Persisted with SwiftData so
/// History reflects real check-ins instead of mock data.
@Model
final class CheckInEntry {
    var date: Date
    var sattva: Double
    var rajas: Double
    var tamas: Double
    var note: String
    /// Names of the feeling tags selected for this check-in. Defaults to
    /// empty so existing saved entries migrate automatically.
    var tagNames: [String] = []

    init(date: Date = .now, blend: GunaBlend, note: String = "", tagNames: [String] = []) {
        self.date = date
        self.sattva = blend.sattva
        self.rajas = blend.rajas
        self.tamas = blend.tamas
        self.note = note
        self.tagNames = tagNames
    }

    var blend: GunaBlend {
        GunaBlend(sattva: sattva, rajas: rajas, tamas: tamas)
    }
}
