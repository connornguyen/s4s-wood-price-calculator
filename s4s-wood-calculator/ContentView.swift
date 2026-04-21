import SwiftUI

struct ContentView: View {
    @StateObject private var store = CalculationStore()
    @State private var showClearConfirm = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                List {
                    Section {
                        HStack(spacing: 6) {
                            header("Phân").frame(minWidth: 55)
                            header("Dài").frame(minWidth: 46)
                            header("Rộng").frame(minWidth: 46)
                            header("KL").frame(minWidth: 50, alignment: .trailing)
                            header("Giá").frame(minWidth: 46)
                            header("Tiền").frame(minWidth: 50, alignment: .trailing)
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
