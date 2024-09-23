//
//  ContentView.swift
//  app03-products
//
//  Created by Μιτχελλ on 28/08/24.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(ProductsModel.self) var productsModel
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(productsModel.products) { product in
                        NavigationLink {
                            ProductDetailView(mode: .edit, product: product)
                        } label: {
                            HStack {
                                Image(systemName: "box.fill")
                                    .foregroundColor(.blue)
                                Text(product.productName)
                                    .fontWeight(.semibold)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                        }
                    }
                    .onDelete(perform: deleteProducts)
                }
                .listStyle(.insetGrouped)
                .padding(.top)
                
                Spacer()
                Text("Michelle González, A00837313")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.bottom)
                    .navigationTitle("Productos")
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            NavigationLink {
                                ProductDetailView(mode: .add)
                            } label: {
                                Image(systemName: "plus")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .background(Color.red)
                                    .clipShape(Circle())
                                    .shadow(color: Color.black.opacity(0.2), radius: 0.5, x: 0, y: 2)
                            }
                        }
                    }
            }
                    .background(Color(UIColor.systemGray6))
                    .onAppear {
                        Task {
                            await productsModel.fetchProducts()
                        }
                    }
            }
            .padding()
        }
    
    private func deleteProducts(offsets: IndexSet) {
        Task {
            for index in offsets {
                await productsModel.deleteProduct(product: productsModel.products[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(ProductsModel())
}
