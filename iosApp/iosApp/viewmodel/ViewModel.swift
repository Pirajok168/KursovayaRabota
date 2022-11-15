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
        repo.showAllCake(typeCake: typeCake, completionHandler: {
            (model, error) in
            self.cakes = model ?? []
        })
    }
    
   
}
