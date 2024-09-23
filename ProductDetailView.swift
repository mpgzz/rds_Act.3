//
//  ProductDetailView.swift
//  app03-products
//
//  Created by Μιτχελλ on 03/09/24.
//

import SwiftUI

struct ProductDetailView: View {
    
    @Environment(ProductsModel.self) var productsModel
    @Environment(\.dismiss) var dismiss
    
    var mode: Mode = .add
    @State var product: Product = Product.defaultProduct
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text(mode == .add ? "Agregar Producto" : "Actualizar Producto")
                        .font(.headline)
                        .foregroundColor(.blue)) {
                        Text("Id del producto")
                            .font(.caption)
                        TextField("Product Id", text: $product.productId)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(8)
                        
                        Text("Nombre del producto")
                            .font(.caption)
                        TextField("Product Name", text: $product.productName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(8)
                    }
                }
                .padding()

                Button(action: {
                    if mode == .add {
                        print("Agrega")
                        Task {
                            await productsModel.addProduct(product: product)
                            alertMessage = "Producto agregado exitosamente."
                            showAlert = true
                        }
                    } else {
                        print("Actualiza")
                        Task {
                            await productsModel.updateProduct(product: product)
                            alertMessage = "Producto actualizado exitosamente."
                            showAlert = true
                        }
                    }
                }) {
                    Text(mode == .add ? "Agregar" : "Actualizar")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .navigationTitle(mode == .add ? "Agregar Producto" : "Actualizar Producto")
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Éxito"), message: Text(alertMessage), dismissButton: .default(Text("OK"), action: {
                    dismiss()
                }))
            }
        }
    }
}

#Preview {
    ProductDetailView()
        .environment(ProductsModel())
}
