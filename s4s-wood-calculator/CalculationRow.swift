import Foundation

struct CalculationRow: Identifiable {
    let id: UUID
    var a: Double?
    var b: Double?
    var c: Double?
    var multiplier: Double

    init(id: UUID = UUID(), a: Double? = nil, b: Double? = nil, c: Double? = nil, multiplier: Double = 1) {
        self.id = id
        self.a = a
        self.b = b
        self.c = c
        self.multiplier = multiplier
    }

    var result: Double {
        (a ?? 0) * (b ?? 0) * (c ?? 0) * multiplier
    }
}
