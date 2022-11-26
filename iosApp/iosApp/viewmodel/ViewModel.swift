//
//  ViewModel.swift
//  iosApp
//
//  Created by Данила Еремин on 15.11.2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import Foundation
import shared


class ViewModel: ObservableObject{
    private let repo: IRepository = KursovayaSDK().dialogChatModule.repo
    @Published var cakes: [Model] = []
    
    @Published var previewCakes: [Model] = []
    
    @Published var selectedCake: Model? = nil
    
    
    func createOrder(){
        repo.createOrder(cakes: self.selectedCake!, idClient: 1, completionHandler: {
            error in
            
        })
    }
    
    func chooiseCake(cake: Model){
        self.selectedCake = cake
    }
   
    func createCake(){
        repo.createCake(completionHandler: {_ in
            
        })
        
        repo.showAllCake(typeCake: TypeCake.fruits, completionHandler: {
            (model, error) in
            self.cakes = model ?? []
        }
        )
    }
    
    func showCake(typeCake: TypeCake){
        previewCakes = cakes.filter({
            model in
            model.type == typeCake.name
        })
    }
    
   
}
