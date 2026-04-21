import SwiftUI

struct TotalFooterView: View {
    let total: Double
    @State private var showAccountPicker = false
    @State private var selectedAccount: BankAccount?

    var body: some View {
        HStack {
            Text("Tổng Tiền")
                .font(.headline)
            Spacer()
            Text(formatted)
                .font(.headline.monospacedDigit())

            Button {
                showAccountPicker = true
            } label: {
                Image(systemName: "qrcode")
                    .font(.title3)
                    .padding(.leading, 8)
            }
            .disabled(total <= 0)
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .background(.ultraThinMaterial)
        .overlay(Divider(), alignment: .top)
        .confirmationDialog("Chọn tài khoản", isPresented: $showAccountPicker, titleVisibility: .visible) {
            ForEach(BankAccount.all) { account in
                Button(account.label) { selectedAccount = account }
            }
            Button("Huỷ", role: .cancel) {}
        }
        .sheet(item: $selectedAccount) { account in
            VietQRSheet(total: total, account: account)
        }
    }

    private var formatted: String {
        String(format: "%.2f", total)
    }
}
