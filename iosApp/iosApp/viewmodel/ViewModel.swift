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
    private let repo: IApi = KursovayaSDK().dialogChatModule.update
    @Published var cakes: [Cakes] = []
    
    
    
    @Published var selectedCake: Cakes? = nil
       
    @Published var orders: [OrderForClient] = []
    
    @Published var slide: Float = 13000.0
    
    
    @Published var allOrders: [Orders_] = []
    
    @Published var masters: [Master_] = []
    
    @Published var masterOrder: [MasterOrders] = []
    
    var id: Int = 0
    
    func chooiseCake(cake: Cakes){
        self.selectedCake = cake
    }
    
    func getmasterOrder(){
        
        
        repo.getMasterOrders(completionHandler: {
            matserOrdes, _ in
            self.masterOrder = matserOrdes ?? []
        })
    }
    
    func assignmentMaster(idMaster: String, idOrders: String){
        repo.assignmentMaster(idMaster: idMaster, idOrder: idOrders, completionHandler: {
            _ in
        })
       
    }
    
    func getAllMaster(){
        repo.showMaster(completionHandler: {
            master, error in
            self.masters = master ?? []
        })
    }
    
    func getAllOrders(){
        repo.showOrder { orders, error in
            self.allOrders = orders ?? []
        }
    }
    
    func wq(ee: Int){
        id = ee
    }
    
    func showByCost(){
        repo.showCakeByCost(cost: "\(Int(slide))", completionHandler: {
            model, error in
            self.cakes = model ?? []
        })
        
        
        
    }
    
    func getOrders(){
        repo.showOrderByIndividualClient(idClient: "\(id)") {orders, error in
            
            self.orders = orders ?? []
        }
        
    }
    
    func createOrder(){
        let idModel = self.selectedCake?.idModel
        let cost = self.selectedCake?.cost
        
        repo.createOrder(idModel: idModel!, idClient: "\(id)", cost: cost!, completionHandler: {
            _ in
        })

    }
    
    
    
    func showCake(){
        repo.getCake { cakes, _ in
            self.cakes = cakes ?? []
        }
    }
    
   
}
