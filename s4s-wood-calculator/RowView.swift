import SwiftUI

struct RowView: View {
    @Binding var row: CalculationRow
    @FocusState private var focusedField: Field?

    private enum Field { case a, b, c }
    private static let multiplierOptions: [Double] = [1, 1.5, 2, 2.5, 3, 4, 5, 6, 7]

    var body: some View {
        HStack(spacing: 8) {
            numberField("dài", value: $row.a, field: .a)
            numberField("rộng", value: $row.b, field: .b)
            numberField("Giá", value: $row.c, field: .c)

            Picker("×", selection: $row.multiplier) {
                ForEach(Self.multiplierOptions, id: \.self) { value in
                    Text(format(value)).tag(value)
                }
            }
            .pickerStyle(.menu)
            .labelsHidden()
            .frame(minWidth: 60)

            Text(format(row.result))
                .font(.body.monospacedDigit())
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") { focusedField = nil }
            }
        }
    }

    private func numberField(_ placeholder: String, value: Binding<Double?>, field: Field) -> some View {
        TextField(placeholder, value: value, format: .number)
            .keyboardType(.decimalPad)
            .textFieldStyle(.roundedBorder)
            .multilineTextAlignment(.trailing)
            .frame(minWidth: 50)
            .focused($focusedField, equals: field)
    }

    private func format(_ value: Double) -> String {
        String(format: "%.2f", value)
    }
}
