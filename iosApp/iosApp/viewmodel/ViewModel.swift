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
    @Published var nameCake: String = ""
    @Published var registrationDate: String = ""
    @Published var cost: String = ""
    @Published var idModel: String = ""
    @Published var statusOrder: String = ""
    @Published var idOrder: String = ""
    @Published var prepayment: String = ""
    @Published var day: String = ""
       
    @Published var orders: [OrderForClient] = []
    
    @Published var slide: Float = 13000.0
    
    
    @Published var allOrders: [Orders_] = []
    
    @Published var masters: [Master_] = []
    
    @Published var masterOrder: [MasterOrders] = []
    
    @Published var id: String = ""
    
    @Published var idMaster = ""
    @Published var FIO = ""
    @Published var salary = ""
    @Published var idOrderAssigh = ""
    @Published var cakeAssign: Orders_? = nil
    @Published var FIOClient = ""
    @Published var presumptiveDate = ""
    @Published var numberClient = ""
    @Published var modelCake = ""
    
    func chooiseCake(cake: Cakes){
        self.selectedCake = cake
        self.nameCake = cake.name
        self.cost = cake.cost
        self.idModel = cake.idModel
        self.statusOrder = ""
        self.presumptiveDate = ""
        self.registrationDate = ""
        self.prepayment = ""
        self.idOrder = ""
        self.day = cake.productionTime
    }
    
    func getmasterOrder(){
        
        
        repo.getMasterOrders(completionHandler: {
            matserOrdes, _ in
            self.masterOrder = matserOrdes ?? []
        })
    }
    
    func assignmentMaster(idMaster: String, idOrders: String){
        repo.assignmentMaster(idMaster: idMaster, idOrder: idOrders, status: self.statusOrder, date: self.presumptiveDate, completionHandler: {
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
        id = String(ee)
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
        let cost = (self.selectedCake?.cost)!
        let a = Int(cost)!
        let b = Int(prepayment)!
        
        repo.createOrder(idModel: idModel!, idClient: "\(id)", cost: "\(a + b)", time: Int32(self.selectedCake!.productionTime)!, idOrder: self.idOrder, registrationDate: self.registrationDate, statusOrder: self.statusOrder, presumptiveDate: self.presumptiveDate,prepayment: self.prepayment, completionHandler: {
            _ in
        })
        
       

    }
    
    
    
    func showCake(){
        repo.getCake { cakes, _ in
            self.cakes = cakes ?? []
        }
    }
    
   
}
