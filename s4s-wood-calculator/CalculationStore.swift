import Foundation
import Combine
import SwiftUI

final class CalculationStore: ObservableObject {
    @Published var rows: [CalculationRow] = []

    var total: Double {
        rows.reduce(0) { $0 + $1.result }
    }

    func addRow() {
        let last = rows.last
        rows.append(CalculationRow(c: last?.c, multiplier: last?.multiplier))
    }

    func deleteRows(at offsets: IndexSet) {
        rows.remove(atOffsets: offsets)
    }
}
