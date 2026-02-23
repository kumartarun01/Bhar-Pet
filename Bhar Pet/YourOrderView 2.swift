import SwiftUI

struct YourOrderView2: View {
    var body: some View {
        NavigationStack {
            HStack{
                Image(systemName: "chevron.left")
                    .padding(15)
                Spacer()
                Text("Orders")
                Spacer()
            }
                Spacer()
            VStack{
                Text("Your Orders")
                    .font(.title)
                Text("Track and manage your current orders.")
                    .foregroundColor(.secondary)
            }
            Spacer()
//            VStack(alignment: .leading){
//                VStack{
//                    HStack(alignment: .top, spacing: 20){
//                        Image(systemName: "chevron.left")
//                        Text("Orders")
//                          
//                    }
//                }
//                    VStack {
//                        Text("Your Orders")
//                            .font(.title)
//                        Text("Track and manage your current orders.")
//                            .foregroundColor(.secondary)
//                    }
//                    .padding()
//
//                }
                           
//            .navigationTitle("\(Image(systemName: "chevron.left"))Orders")
        }.toolbar(.hidden)
    }
}

#Preview {
        YourOrderView2()
    
}
