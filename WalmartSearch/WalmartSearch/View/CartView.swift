import SwiftUI

struct CartView: View {
    @ObservedObject var viewModel: ProductViewModel

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.cart, id: \.id) { product in
                        NavigationLink(destination: ProductDetailView(vm: ProductViewModel(), product: product)) {
                            HStack {
                                AsyncImage(url: URL(string: product.thumbnail)) { image in
                                    image.resizable()
                                } placeholder: {
                                    Color.gray.opacity(0.3)
                                }
                                .frame(width: 50, height: 50)
                                .cornerRadius(5)
                                
                                VStack(alignment: .leading) {
                                    Text(product.title)
                                        .fontWeight(.bold)
                                    Text("$\(product.price).00")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                            }
                            .padding()
                        }
                    }
                    .onDelete(perform: deleteItems)
                }

                // Total amount section
                HStack {
                    Text("Total:")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    // Calculate total price
                    Text("$\(viewModel.cart.reduce(0) { $0 + $1.price }).00")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 16 / 255, green: 120 / 255, blue: 12 / 255, opacity: 1))
                }
                .padding()
                
                // Fake checkout button
                Button("Checkout") {
                    // Placeholder for checkout action
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding()
            }
            .navigationTitle("Cart")
        }
    }

    private func deleteItems(at offsets: IndexSet) {
        viewModel.cart.remove(atOffsets: offsets)
    }
}

// Preview provider if needed for SwiftUI Previews
struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(viewModel: ProductViewModel())
    }
}
