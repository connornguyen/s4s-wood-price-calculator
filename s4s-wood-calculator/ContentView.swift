import SwiftUI

struct ContentView: View {
    @StateObject private var store = CalculationStore()

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                List {
                    Section {
                        HStack(spacing: 8) {
                            header("a")
                            header("b")
                            header("c")
                            header("×").frame(minWidth: 60)
                            header("Result").frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }

                    ForEach($store.rows) { $row in
                        RowView(row: $row)
                    }
                    .onDelete(perform: store.deleteRows)
                }
                .listStyle(.plain)

                TotalFooterView(total: store.total)
            }
            .navigationTitle("S4S Wood Calculator")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: store.addRow) {
                        Label("Add", systemImage: "plus")
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
        }
        .environmentObject(store)
    }

    private func header(_ text: String) -> some View {
        Text(text)
            .font(.caption.weight(.semibold))
            .foregroundStyle(.secondary)
    }
}

#Preview {
    ContentView()
}
