import SwiftUI

struct YourOrderView2: View {
    var body: some View {
        VStack {
            Text("Your Orders")
                .font(.title)
            Text("Track and manage your current orders.")
                .foregroundColor(.secondary)
        }
        .padding()
        .navigationTitle("Orders")
    }
}

#Preview {
    NavigationStack {
        YourOrderView2()
    }
}
