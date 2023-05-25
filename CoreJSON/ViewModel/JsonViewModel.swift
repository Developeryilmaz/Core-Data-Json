//
//  JsonViewModel.swift
//  CoreJSON
//
//  Created by YILMAZ ER on 25.05.2023.
//

import Foundation
import CoreData

class JsonViewModel: ObservableObject {
    @Published var products : [ProductModel] = []
    
    // saving JSON TO Core Data...
    
    func saveData(context: NSManagedObjectContext) {
        products.forEach { (data) in
            let entity = Product(context: context)
            entity.title = data.title
            entity.category = data.category
            entity.id = Int64(data.id)
            entity.brand = data.brand
            entity.discountPercentage = Float(data.discountPercentage)
            entity.rating = Float(data.rating)
            entity.price = Int16(data.price)
            entity.stock = Int16(data.stock)
            entity.thumbnail = data.thumbnail
        }
        // saving all pending data at once ....
        do {
            try context.save()
            print("success")
        }catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchData(context: NSManagedObjectContext) {
        
        guard let url = URL(string: "https://dummyjson.com/products") else { fatalError("Missing URL") }
        
        let request = URLRequest(url: url)
//        request.addValue("swiftuio4.0", forHTTPHeaderField: "field")
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: request) { (data, res, _ ) in
            
            guard let jsonData = data else { return }
            
            // checking for any internal api error ....
            
            let response = res as! HTTPURLResponse
            // checking by status code ...
            
            if response.statusCode == 404 {
                print("error API Error")
                return
            }
            
            // fetching JSON Data ...
            
            do {
                
                let result = try JSONDecoder().decode(Result.self, from: jsonData)
                
                DispatchQueue.main.async {
                    self.products = result.products
                    self.saveData(context: context)
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
