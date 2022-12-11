import SwiftUI
import shared



struct Cake: Hashable{
    let path: String
    let name: String
    let cost: Double
}


struct ContentView: View {
	
    let cakes: [String] = [
        "Фруктовые", "С молоком", "Шоколадные"
    ]
    @State private var pressed = "Фруктовые"
    
    
    
    @StateObject private var viewModel = ViewModel()
    
   
    @State private var showSheet = false
    
    @State private var profile = false
    
    @State private var manage = false
    
    @State private var master = false
    let id: Int
   
    @State private var idOrder = 0
    
    @State private var idModel = 0
    @State private var showSS = false
	var body: some View {
        
            
            ScrollView(.vertical){
                
                Text("0 .. \(viewModel.slide)")
                
                
                Slider(
                    value: $viewModel.slide,
                        in: 0...13000,
                        step: 5
                    ) {
                        Text("Speed")
                    } minimumValueLabel: {
                        Text("0")
                    } maximumValueLabel: {
                        Text("13000")
                    } onEditingChanged: { editing in
                        viewModel.showByCost()
                    }
                .padding()
                .onAppear{
                    viewModel.showCake()
                }
                
               
                
                ForEach(viewModel.cakes, id: \.self){
                    _cake in
                    ElemCake(cake: _cake)
                        .padding()
                        .transition(.scale)
                        .simultaneousGesture(
                            TapGesture()
                                .onEnded { _ in
                                    viewModel.chooiseCake(cake: _cake)
                                    showSheet.toggle()
                                })
                }
                
                
                
            }
            .onAppear{
                viewModel.wq(ee: id)
            }
        
            .navigationTitle("Торты")
            
            .navigationBarBackButtonHidden(true)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button(action: {
                        profile.toggle()
                    }, label: {
                        Image(systemName: "person")
                    })
                   
                })
                
                ToolbarItem(placement: .navigationBarLeading, content: {
                    Button(action: {
                        manage.toggle()
                    }, label: {
                        Image(systemName: "person.fill")
                    })
                })
            }
            .sheet(isPresented: $manage, content: {
                ScrollView(content: {
                    LazyVStack{
                        ForEach(viewModel.allOrders, id: \.self){
                            order in
                            HStack{
                                
                                AsyncImage(url: URL(string: order.patch), content: {
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
                                Button(action: {
                                    viewModel.idOrderAssigh = order.idOrder
                                    viewModel.cakeAssign = order
                                    viewModel.statusOrder = order.statusOrder
                                    viewModel.FIOClient = "\(order.surname) \(order.name_) \(order.lastname)"
                                    viewModel.numberClient = "\(order.phoneNumber)"
                                    viewModel.statusOrder = order.statusOrder
                                    viewModel.modelCake = order.name
                                    viewModel.cost = order.cost
                                    viewModel.prepayment = order.prepayment
                                    viewModel.presumptiveDate = order.presumptiveDate
                                    idOrder = Int(order.idOrder)!
                                    idModel = Int(order.idModel_)!
                                    master.toggle()
                                }, label: {
                                    VStack{
                                        Text("Id Заказа \(order.idOrder)")
                                            .frame(maxWidth: .infinity,  alignment: .leading)
                                        Text("Клиент: \(order.surname) \(order.name_) \(order.lastname)")
                                            .frame(maxWidth: .infinity,  alignment: .leading)
                                        Text("Модель торта: \(order.name)")
                                            .frame(maxWidth: .infinity,  alignment: .leading)
                                        Text("Номер телефона клиента \(order.phoneNumber)")
                                            .frame(maxWidth: .infinity,  alignment: .leading)
                                        Text("Статус \(order.statusOrder)")
                                            .frame(maxWidth: .infinity,  alignment: .leading)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                })
                                
                                
                                
                                
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .cornerRadius(20)
                            
                            
                        }
                    }
                    .sheet(isPresented: $master, content: {
                        if(!showSS){
                            ScrollView(content: {
                                LazyVStack(content: {
                                    ForEach(viewModel.masters ,id: \.self, content: {
                                        master in
                                        VStack{
                                            Text("ФИО \(master.surname) \(master.name) \(master.lastname)")
                                                .frame(maxWidth: .infinity,  alignment: .leading)
                                            Text("Зп \(master.salary)")
                                                .frame(maxWidth: .infinity,  alignment: .leading)
                                            
                                            
                                        }
                                        .onTapGesture {
                                            viewModel.idMaster = master.idMaster
                                            viewModel.FIO = "\(master.surname) \(master.name) \(master.lastname)"
                                            viewModel.salary = "\(master.salary)"
                                            showSS.toggle()
                                            //viewModel.assignmentMaster(idMaster: "\(master.idMaster)", idOrders: "\(self.idOrder)")
                                        }
                                        .padding()
                                        
                                        Divider()
                                    })
                                })
                                
                                Divider()
                                    .foregroundColor(.red)
                                
                                
                            })
                            .onAppear{
                                viewModel.getAllMaster()
                            }
                        
                        }else{
                            ScrollView{
                                LazyVStack(content: {
                                    Section(content: {
                                        Text("Id Мастера")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        TextField("", text: $viewModel.idMaster)
                                        
                                        Text("Фио Мастера")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        TextField("", text: $viewModel.FIO)
                                        
                                        Text("Зарплата  Мастера")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        TextField("", text: $viewModel.salary)
                                    }, header: {
                                        Text("Информация о мастере")
                                            .bold()
                                    })
                                    Spacer(minLength: 30)
                                    Section(content: {
                                        
                                        Text("Id заказа")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        TextField("", text: $viewModel.idOrderAssigh)
                                        
                                        Text("Статус заказа")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        TextField("", text: $viewModel.statusOrder)
                                        
                                        Text("Примерная дата готовности заказа")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        TextField("", text: $viewModel.presumptiveDate)
                                        
                                        Text("Модель торта - \(viewModel.modelCake)\nПредоплата - \(viewModel.prepayment)\nОбщая стоимость - \(viewModel.cost)")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                      
                                        
                                        
                                        
                                       
                                    }, header: {
                                        Text("Информация о заказе")
                                            .bold()
                                    })
                                    Spacer(minLength: 30)
                                    Section(content: {
                                        TextField("", text: $viewModel.FIOClient)
                                            
                                       
                                        TextField("", text: $viewModel.numberClient)
                                           
                                        
                                            
                                    }, header: {
                                        Text("Информация о клиенте")
                                            .bold()
                                    })
                                    Spacer(minLength: 30)
                                })
                               
                                
                                Button(action: {
                                    viewModel.assignmentMaster(idMaster: viewModel.idMaster, idOrders: viewModel.idOrderAssigh)
                                    showSS.toggle()
                                    
                                }, label: {
                                    Text("Назначить мастера")
                                        .frame(maxWidth: .infinity)
                                })
                                
                            }
                            .textFieldStyle(.roundedBorder)
                            .padding()
                        }
                    })
                
                    Divider()
                    Divider()
                    Divider()
                    
                   
                    
                    LazyVStack(content: {
                      Section(content: {
                          ForEach(viewModel.masterOrder, id: \.self, content: {
                              master in
                              
                              VStack{
                                  Text("ФИО мастера \(master.surname) \(master.name) \(master.lastname)")
                                      .frame(maxWidth: .infinity,  alignment: .leading)
                                  
                                  Text("Id client \(master.idClient)")
                                      .frame(maxWidth: .infinity,  alignment: .leading)
                                  
                                  Text("Торт \(master.name_)")
                                      .frame(maxWidth: .infinity,  alignment: .leading)
                                  
                                  Text("Статус \(master.statusOrder)")
                                      .frame(maxWidth: .infinity,  alignment: .leading)

                              }
                              .padding()
                          })
                      }, header: {
                          Text("Заказы, который выполняются")
                              .font(.title3)
                              .frame(maxWidth: .infinity,  alignment: .leading)
                              .padding()

                      })
                        
                    })
                })
                .onAppear{
                    viewModel.getAllOrders()
                    viewModel.getmasterOrder()
                }
            })
            
            
            .sheet(isPresented: $showSheet, content: {
                ScrollView(.vertical, showsIndicators: false){
                    
                    
                    Section(content: {
                      
                        TextField("ID заказа", text: $viewModel.idOrder)
                        
                        Text("ID Клиента")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        TextField("ID заказа", text: $viewModel.id)
                        
                        TextField("Предоплата", text: $viewModel.prepayment)
                        
                        TextField("", text: $viewModel.nameCake)
                        
                        TextField("", text: $viewModel.cost)
                        
                        TextField("дата заказа", text: $viewModel.registrationDate)
                        
                        TextField("Примерная дата готовности", text: $viewModel.presumptiveDate)
                    
                        Text("Время готовки торта - \(viewModel.day) дня")
                            .frame(maxWidth: .infinity, alignment: .leading)
                       
                        
                        TextField("Статус заказа", text: $viewModel.statusOrder)
                            
                        
                        
                    }, header: {
                        Text("Корзина")
                            .font(.title.bold())
                    })
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    
                    
                   
                }
                .overlay(alignment: .bottom, content: {
                    Button(action: {
                        viewModel.createOrder()
                    }, label: {
                        Text("Сделать заказ")
                            .frame(maxWidth: .infinity)
                    })
                    .buttonStyle(.bordered)
                    .cornerRadius(30)
                    
                    .padding()
                })
            })
            .sheet(isPresented: $profile, content: {
                ScrollView(.vertical){
                    LazyVStack{
                        ForEach(viewModel.orders, id: \.self){
                            order in
                            
                            HStack{
                                AsyncImage(url: URL(string: order.patch), content: {
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
                                    Text("Торт: \(order.name)")
                                    
                                    Text("Статус заказа: \(order.statusOrder)")
                                   
                                    Text("Можно забрать: \(order.presumptiveDate)")
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .cornerRadius(20)
                        }
                        .padding()
                        
                        
                    }
                }
                .onAppear{
                    viewModel.getOrders()
                }
            })
            
	}
    
    func tezt(londf: Int64) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let dateVar = Date.init(timeIntervalSinceNow: TimeInterval(londf / 1000))
        return dateFormatter.string(from: dateVar)
    }
  
}

