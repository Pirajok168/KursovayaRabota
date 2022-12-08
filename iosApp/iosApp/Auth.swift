//
//  Auth.swift
//  iosApp
//
//  Created by Данила Еремин on 26.11.2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI
import shared

class AuthViewModel: ObservableObject{
    private let repo: IApi = KursovayaSDK().dialogChatModule.update
    
    @Published var name: String = ""
    
    @Published var surname: String = ""
    @Published var lastname: String = ""
    @Published var phoneNumber: String = ""
    @Published var emain: String = ""
    
    @Published var isClietExists: Bool? = nil
    @Published var errrr: Bool? = nil
    
    @Published var id: Int = 0
    
    func auth(){
        repo.auth(number: phoneNumber, email: emain, completionHandler: {
            (client, error) in
            if client == nil {
                withAnimation{
                    self.errrr = true
                }
            }else{
                self.id = Int(client!.idClient)!
                self.isClietExists = true
            }
        })
        
    
    }
    
    func client(  f: @escaping () -> Void ){
//        id = Int.random(in: 0...100)
//        repo.createClient(id: Int64(id), surname: surname, name: name, lastname: lastname, phoneNumber: phoneNumber, mail: emain, completionHandler: {
//            _ in
//        })
//        f()
    }
}

struct Auth: View {
    @ObservedObject var viewModel = AuthViewModel()
    @EnvironmentObject  var nav: Navigation
    var fun: (Int) -> Void
    
    var body: some View {
        if viewModel.errrr == nil {
            VStack{
                TextField("Введите номер телефона", text: $viewModel.phoneNumber)
                    .padding()
                    
                
                
                TextField("Введите e-mail", text: $viewModel.emain)
                    .padding()
                
                Button(action: {
                    viewModel.auth()
                
                }, label: {
                    Text("Войти")
                        .frame(maxWidth: .infinity)
                })
                .buttonStyle(.bordered)
                .padding()
            }
            .autocorrectionDisabled(true)
            .autocapitalization(.none)
            .navigationBarBackButtonHidden(true)
            .textFieldStyle(.roundedBorder)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .ignoresSafeArea(.keyboard)
            .onChange(of: viewModel.isClietExists, perform: {
                newVal in
                if newVal == true{
                    fun(viewModel.id)
                    nav.toHomeScreen()
                }
               
            })
        }else{
            VStack{
                TextField("Введите имя", text: $viewModel.name)
                    .padding()
                
                
                TextField("Введите фамилию", text: $viewModel.surname)
                    .padding()
                    
                
                TextField("Введите отчество", text: $viewModel.lastname)
                    .padding()
                    
                
                TextField("Введите номер телефона", text: $viewModel.phoneNumber)
                    .padding()
                    
                
                TextField("Введите Email", text: $viewModel.emain)
                    .padding()
                    .transition(.push(from: .leading))
                
                Button(action: {
                    viewModel.client(){
                        fun(viewModel.id)
                        nav.toHomeScreen()
                    }
                    
                }, label: {
                    Text("Авторизироваться")
                        .frame(maxWidth: .infinity)
                })
                .buttonStyle(.bordered)
                .padding()
            }
            .autocapitalization(.none)
            .autocorrectionDisabled(true)
            .navigationBarBackButtonHidden(true)
            .textFieldStyle(.roundedBorder)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .ignoresSafeArea(.keyboard)
        }
    }
}

struct Auth_Previews: PreviewProvider {
    static var previews: some View {
        Auth(){
            _ in
        }
    }
}
