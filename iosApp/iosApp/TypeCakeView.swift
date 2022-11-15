//
//  TypeCake.swift
//  iosApp
//
//  Created by Данила Еремин on 15.11.2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI
import shared

struct TypeCakeView: View{
    let title: String
    let isPressed: Bool
    
    var body: some View{
        HStack{
            Text(title)
                .foregroundColor(isPressed ? Color.white : Color.blue)
                .padding(.horizontal)
                .padding(.vertical, 10)
            
        }
        .background(isPressed ? Color.blue : Color.white)
        .cornerRadius(20)
        .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.blue, lineWidth: 1)
        )
    }
}

