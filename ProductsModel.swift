//
//  ProductsModel.swift
//  app03-products
//
//  Created by Μιτχελλ on 28/08/24.
//

import SwiftUI

@Observable
class ProductsModel {
    
    var products: [Product] = []
    
    func fetchProducts() async {
        
        products.removeAll()
        let url = URL(string: "http://10.14.255.53:4000/products")!
        let components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        
        //        let (data) = try await URLSession.shared.data(for: request)
        //        print(String(decoding: data, as: UTF8.self))
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            print(String(decoding: data, as: UTF8.self))
            if let decodedResponse = try? JSONDecoder().decode([Product].self, from: data) {
                products = decodedResponse
            }
            
            
        } catch {
            print("Invalid data")
        }
    }
    
    func deleteProduct(product: Product) async {
        
        let url = URL(string: "http://10.14.255.50:4000/delete-product/\(product.productId)")!
        
        let components = URLComponents(url: url, resolvingAgainstBaseURL: true)!

        var request = URLRequest(url: components.url!)
        request.httpMethod = "DELETE"
        request.timeoutInterval = 10

        do {
            let (_, _) = try await URLSession.shared.data(for: request)
            // Handle success
        } catch {
            print("Failed to delete product: \(error)")
        }
        
    }

    func addProduct(product: Product) async {
        
        let url = URL(string: "http://10.14.255.50:4000/add-product")!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = 10
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(product) {
            request.httpBody = encoded
        }

        do {
            let (_, _) = try await URLSession.shared.data(for: request)
            // Handle success
        } catch {
            print("Failed to add product: \(error)")
        }
    }

    func updateProduct(product: Product) async {
    
        let url = URL(string: "http://10.14.255.50:4000/update-product/\(product.productId)")!

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.timeoutInterval = 10
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(product) {
            request.httpBody = encoded
        }

        do {
            let (_, _) = try await URLSession.shared.data(for: request)
            // Handle success
        } catch {
            print("Failed to add product: \(error)")
        }

    }
        

}
