//
//  ElemCake.swift
//  iosApp
//
//  Created by Данила Еремин on 15.11.2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI
import shared

struct BasketElem: View{
    let cake: Cakes
  
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
                    
                    Text("Стоимость: \(cake.cost) ₽")
                        .padding(.horizontal)
                        
                    
                    Text("Вес: \(String(format: "%.2f", cake.weight)) грамм")
                        .padding(.horizontal)
                        .padding(.bottom)
                    
                   
                }
                
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            
            
           
        }
        .frame(maxWidth: .infinity, minHeight: 180)
        .cornerRadius(50)
    }
}

struct ElemCake: View{
    
    
    let cake: Cakes
   
    init(cake: Cakes) {
        self.cake = cake
        print(cake)
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
                    
                    Text("Стоимость: \(cake.cost) ₽")
                        .padding(.horizontal)
                    
                    Text("Тип: \(cake.type)")
                        .padding(.horizontal)
                        
                    
                    Text("Вес: \(cake.weight) грамм")
                        .padding(.horizontal)
                        .padding(.bottom)
                    
                    
                    
                }
                
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            
            
           
        }
        .frame(maxWidth: .infinity, minHeight: 180)
        .cornerRadius(50)
    }
}

