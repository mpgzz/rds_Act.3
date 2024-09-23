//
//  app03_productsApp.swift
//  app03-products
//
//  Created by Μιτχελλ on 28/08/24.
//

import SwiftUI

@main
struct app03_productsApp: App {
    
    @State var productsModel = ProductsModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(productsModel)
        }
    }
}
