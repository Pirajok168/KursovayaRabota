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
    private let repo: IRepository = KursovayaSDK().dialogChatModule.repo
    
    @Published var name: String = ""
    
    @Published var surname: String = ""
    @Published var lastname: String = ""
    @Published var phoneNumber: String = ""
    @Published var emain: String = ""
    
    @Published var isClietExists: Bool? = nil
    @Published var errrr: Bool? = nil
    
    func auth(){
        repo.auth(phoneNumber: phoneNumber, email: emain, completionHandler: {
            (client, error) in
            if client == nil {
                self.errrr = true
            }else{
                self.isClietExists = true
            }
        })
    }
    
    func client(  f: @escaping () -> Void ){
        repo.createClient(surname: surname, name: name, lastname: lastname, phoneNumber: phoneNumber, mail: emain, completionHandler: {
            _ in
        })
        f()
    }
}

struct Auth: View {
    @ObservedObject var viewModel = AuthViewModel()
    @EnvironmentObject  var nav: Navigation
    
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
                
                Button(action: {
                    viewModel.client(){
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
        Auth()
    }
}
