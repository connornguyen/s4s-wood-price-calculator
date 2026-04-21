import SwiftUI

struct VietQRSheet: View {
    let total: Double
    let account: BankAccount
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                if let url = account.qrURL(amount: total) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 260, height: 260)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 260, height: 260)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        case .failure:
                            VStack(spacing: 12) {
                                Image(systemName: "wifi.slash")
                                    .font(.largeTitle)
                                    .foregroundStyle(.secondary)
                                Text("Không tải được mã QR")
                                    .foregroundStyle(.secondary)
                            }
                            .frame(width: 260, height: 260)
                        @unknown default:
                            EmptyView()
                        }
                    }
                }

                VStack(spacing: 4) {
                    Text(account.label)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Text(account.accountName)
                        .font(.subheadline.weight(.medium))
                    Text(formatted)
                        .font(.title.bold().monospacedDigit())
                        .padding(.top, 4)
                }

                Spacer()
            }
            .padding(.top, 32)
            .navigationTitle("Mã QR thanh toán")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Đóng") { dismiss() }
                }
            }
        }
    }

    private var formatted: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.maximumFractionDigits = 0
        return (formatter.string(from: NSNumber(value: total)) ?? String(Int(total))) + " đ"
    }
}
