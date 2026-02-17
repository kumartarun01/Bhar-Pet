import SwiftUI

struct HistoryView: View {
    var body: some View {
        VStack(spacing: 8) {
            Text("Order History")
                .font(.title)
                .fontWeight(.bold)
            Text("Here you can see the history of your past orders.")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .navigationTitle("History")
    }
}

#Preview {
    NavigationStack {
        HistoryView()
    }
}
