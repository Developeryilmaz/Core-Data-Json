//
//  CardView.swift
//  CoreJSON
//
//  Created by YILMAZ ER on 25.05.2023.
//

import SwiftUI

struct CardView: View {
    
    var product: ProductModel?
    var fetchData: Product?
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(product == nil ? (fetchData?.title ?? "") : (product?.title ?? ""))
                .font(.subheadline)
                .fontWeight(.heavy)
                .foregroundColor(.black)
            Text(product?.category == nil ? (fetchData?.category ?? "") : (product?.category ?? ""))
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.gray)
            
            HStack {
                if product?.price == nil {
                    Text("price: \(fetchData?.price ?? 0)")
                        .foregroundColor(.green)
                        .font(.caption)
                }else {
                    Text("price: \(product?.price ?? 0)")
                        .foregroundColor(.green)
                        .font(.caption)
                }
                
                Divider().frame(width: 0.5, height: 20)
                Text("rating: "+String(format: "%.2f", product?.rating == nil ? (fetchData?.rating ?? 0.0) : (product?.rating ?? "")))
                    .foregroundColor(.blue)
                    .font(.caption)
                Divider().frame(width: 0.5, height: 20)
                Text("disc: "+String(format: "%.2f", product?.discountPercentage == nil ? (fetchData?.discountPercentage ?? 0.0) : (product?.discountPercentage ?? "")))
                    .foregroundColor(.indigo)
                    .font(.caption)
                Divider().frame(width: 0.5, height: 20)
                
                if product?.stock == nil {
                    Text("stock: \(fetchData?.stock ?? 0)")
                        .foregroundColor(.green)
                        .font(.caption)
                }else {
                    Text("stock: \(product?.stock ?? 0)")
                        .foregroundColor(.green)
                        .font(.caption)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

