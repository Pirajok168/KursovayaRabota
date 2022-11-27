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
       
    @Published var orders: [ShowOrdersByIndividualClient] = []
    
    @Published var slide: Float = 13000.0
    
    @Published var typeCake: TypeCake = .fruits
    
    @Published var allOrders: [AllOrders] = []
    
    @Published var masters: [Master] = []
    
    @Published var masterOrder: [GetMasterOrders] = []
    
    var id: Int = 0
    
    func getmasterOrder(){
        repo.getMasterOrders(completionHandler: {
            matserOrdes, _ in
            self.masterOrder = matserOrdes ?? []
        })
    }
    
    func assignmentMaster(idMaster: Int64, idOrders: Int, idModel: Int){
        repo.assignmentMaster(idMaster: Int32(idMaster), idOrder: Int64(idOrders),idModel: Int64(idModel), completionHandler: {
            error in
        })
    }
    
    func getAllMaster(){
        repo.showAllMaster(completionHandler: {
            master, error in
            self.masters = master ?? []
        })
    }
    
    func getAllOrders(){
        repo.showAllOrders(completionHandler: {
            allOrders, error in
            self.allOrders = allOrders ?? []
        })
    }
    
    func wq(ee: Int){
        id = ee
    }
    
    func showByCost(){
        repo.showCakeByCost(cost: Int32(Int(slide)), completionHandler: {
            model, error in
            self.cakes = model ?? []
            self.previewCakes = self.cakes.filter({
                model in
                model.type == self.typeCake.name
            })
        })
    }
    
    func getOrders(){
        repo.showOrdersByIndividualClient(idClient: Int64(id), completionHandler: {
            orders, error in
        
            self.orders = orders ?? []
           
        })
    }
    
    func createOrder(){
        repo.createOrder(id:  Int64(id), cakes: self.selectedCake!, idClient: Int64(id), completionHandler: {
            error in
            
        })
    }
    
    func chooiseCake(cake: Model){
        self.selectedCake = cake
    }
   
    func createCake(){
        repo.createCake(completionHandler: {_ in
            
        })
        
        repo.createMaster(completionHandler: {
            _ in
        })
        
        repo.showAllCake(typeCake: TypeCake.fruits, completionHandler: {
            (model, error) in
            self.cakes = model ?? []
        }
        )
    }
    
    func showCake(typeCake: TypeCake){
        self.typeCake = typeCake
        previewCakes = cakes.filter({
            model in
            model.type == typeCake.name
        })
    }
    
   
}
