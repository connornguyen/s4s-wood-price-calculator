import SwiftUI

struct RowView: View {
    @Binding var row: CalculationRow
    @FocusState private var focusedField: Field?

    private enum Field { case multiplier, a, b, c }

    var body: some View {
        HStack(spacing: 6) {
            numberField("Phân", value: $row.multiplier, field: .multiplier)
            numberField("Dài", value: $row.a, field: .a)
            numberField("Rộng", value: $row.b, field: .b)

            Text(format(row.volume))
                .font(.body.monospacedDigit())
                .frame(minWidth: 50, alignment: .trailing)

            numberField("Giá", value: $row.c, field: .c)

            Text(format(row.result))
                .font(.body.monospacedDigit())
                .frame(minWidth: 50, alignment: .trailing)
        }
        .dynamicTypeSize(.large)
    }

    private func numberField(_ placeholder: String, value: Binding<Double?>, field: Field) -> some View {
        TextField(placeholder, value: value, format: .number)
            .keyboardType(.decimalPad)
            .textFieldStyle(.roundedBorder)
            .multilineTextAlignment(.trailing)
            .frame(minWidth: 46)
            .focused($focusedField, equals: field)
    }

    private func format(_ value: Double) -> String {
        String(format: "%.2f", value)
    }
}
