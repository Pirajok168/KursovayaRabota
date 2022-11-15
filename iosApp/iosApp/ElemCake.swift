//
//  ElemCake.swift
//  iosApp
//
//  Created by Данила Еремин on 15.11.2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI
import shared

struct ElemCake: View{
    
    
    let cake: Model
    let count: Int?
    let onPlus: (Model) -> Void
    let onMinus: (Model) -> Void
    
    init(cake: Model, count: Int?, onPlus: @escaping (Model) -> Void, onMinus: @escaping (Model) -> Void) {
        self.cake = cake
        self.count = count
        self.onPlus = onPlus
        self.onMinus = onMinus
    }
    
    var body: some View{
        ZStack{
            Color.clear.background(.ultraThinMaterial)
            
            HStack {
               
                
                AsyncImage(url: URL(string: cake.patch), content: {
                    image in
                    
                        image
                            .resizable()
                            .frame(width: 160, height: 180)
                            .aspectRatio(contentMode: .fill)
                            .transition(.scale)
                            
                    
                   
                    
                }, placeholder: {
                    ProgressView()
                })
                .frame(width: 160, height: 180)
                    
                
                
                
                
                VStack(alignment: .leading){
                    Text(cake.name)
                        .bold()
                        .font(.system(size: 20))
                        .padding(.horizontal)
                        .padding(.bottom, 5)
                    
                    Text("\(String(format: "%.2f", cake.cost)) ₽")
                        .padding(.horizontal)
                        .padding(.bottom)
                    
                    HStack{
                        Circle()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.blue)
                            .overlay{
                                Image(systemName: "minus")
                                

                            }
                            .padding(.leading)
                            .padding(.trailing, 10)
                            
                            .simultaneousGesture(
                                DragGesture(minimumDistance: 0)
                                    .onChanged({
                                        _ in
                                       
                                    })
                                    .onEnded({
                                        _ in
                                        onMinus(cake)
                                    })
                            )
                        
                        Text("\(count ?? 0)")
                            .frame(width: 30)
                        
                        Circle()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.blue)
                            .overlay{
                                Image(systemName: "plus")
                                

                            }
                            .padding(.trailing)
                            .padding(.leading, 10)
                            
                            .simultaneousGesture(
                                DragGesture(minimumDistance: 0)
                                    .onChanged({
                                        _ in
                                       
                                    })
                                    .onEnded({
                                        _ in
                                        onPlus(cake)
                                    })
                            )
                    }
                }
                
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            
            
           
        }
        .frame(maxWidth: .infinity, minHeight: 180)
        .cornerRadius(50)
    }
}

