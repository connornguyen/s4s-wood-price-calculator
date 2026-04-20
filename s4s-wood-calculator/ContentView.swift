import SwiftUI

struct ContentView: View {
    @StateObject private var store = CalculationStore()
    @State private var showClearConfirm = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                List {
                    Section {
                        HStack(spacing: 8) {
                            header("Chiều dài")
                            header("Chiều rộng")
                            header("Giá")
                            header("Phân").frame(minWidth: 60)
                            header("KQ").frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }

                    ForEach($store.rows) { $row in
                        RowView(row: $row)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    if let index = store.rows.firstIndex(where: { $0.id == row.id }) {
                                        store.deleteRows(at: IndexSet(integer: index))
                                    }
                                } label: {
                                    Label("Xoá", systemImage: "trash")
                                }
                            }
                    }
                }
                .listStyle(.plain)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                    }
                }

                TotalFooterView(total: store.total)
            }
            .navigationTitle("S4S Wood Calculator")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    if !store.rows.isEmpty {
                        Button(role: .destructive) {
                            showClearConfirm = true
                        } label: {
                            Image(systemName: "trash")
                        }
                    }
                    Button(action: store.addRow) {
                        Label("Add", systemImage: "plus")
                    }
                }
            }
            .confirmationDialog("Xoá tất cả?", isPresented: $showClearConfirm, titleVisibility: .visible) {
                Button("Xoá tất cả", role: .destructive) { store.rows.removeAll() }
                Button("Huỷ", role: .cancel) {}
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
