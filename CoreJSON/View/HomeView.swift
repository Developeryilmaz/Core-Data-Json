//
//  HomeView.swift
//  CoreJSON
//
//  Created by YILMAZ ER on 25.05.2023.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var jsonModel = JsonViewModel()
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: Product.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Product.price, ascending: true)]) var results : FetchedResults<Product>
    
    var body: some View {
        VStack {
            
            // checking if core data exists...
            if results.isEmpty {
                if jsonModel.products.isEmpty {
                        ProgressView()
                       // fetching Data
                            .onAppear {
                                jsonModel.fetchData(context: context)
                            }
                    } else {
                        List(jsonModel.products, id: \.self) { product in
                            // display fetched JSON Data....
                            
                            CardView(product: product)
                        }
                        .listStyle(InsetGroupedListStyle())
                    }
                //display fethed JSON Data....
            }
            else {
                List(results) { product in
                    // display fetched JSON Data...
                    CardView(fetchData: product)
                }
                .listStyle(InsetGroupedListStyle())
            }
        }
        .navigationTitle(!results.isEmpty ? "Fetched Core Data" : "Fetch JSON")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                
                Button {
                    
                    do {
                        results.forEach({ (product) in
                            context.delete(product)
                        })
                        try context.save()
                    } catch {
                        debugPrint(error.localizedDescription)
                    }
                    
                    // when array is clear indicator appears
                    // as a result data is fetched again ....
//                    jsonModel.products.removeAll()
                    
                    
                } label: {
                    Image(systemName: "arrow.clockwise.circle")
                        .font(.title)
                }

            }
        }
    }
}
