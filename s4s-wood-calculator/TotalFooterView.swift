import SwiftUI

struct TotalFooterView: View {
    let total: Double

    var body: some View {
        HStack {
            Text("Tổng Tiền")
                .font(.headline)
            Spacer()
            Text(formatted)
                .font(.headline.monospacedDigit())
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .background(.ultraThinMaterial)
        .overlay(Divider(), alignment: .top)
    }

    private var formatted: String {
        String(format: "%.2f", total)
    }
}
