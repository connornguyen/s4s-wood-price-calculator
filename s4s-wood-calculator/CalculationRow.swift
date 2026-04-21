import Foundation

struct CalculationRow: Identifiable {
    let id: UUID
    var a: Double?
    var b: Double?
    var c: Double?
    var multiplier: Double?

    init(id: UUID = UUID(), a: Double? = nil, b: Double? = nil, c: Double? = nil, multiplier: Double? = nil) {
        self.id = id
        self.a = a
        self.b = b
        self.c = c
        self.multiplier = multiplier
    }

    var volume: Double {
        (a ?? 0) * (b ?? 0) * (multiplier ?? 0)
    }

    var result: Double {
        volume * (c ?? 0)
    }
}
