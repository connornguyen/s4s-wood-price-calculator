import Foundation
import Combine
import SwiftUI

final class CalculationStore: ObservableObject {
    @Published var rows: [CalculationRow] = []

    var total: Double {
        rows.reduce(0) { $0 + $1.result }
    }

    func addRow() {
        let lastGia = rows.last?.c
        rows.append(CalculationRow(c: lastGia))
    }

    func deleteRows(at offsets: IndexSet) {
        rows.remove(atOffsets: offsets)
    }
}
