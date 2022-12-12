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
    @State private var showOrderByDate = false
    @State private var showPopilation = false
    @State private var date = ""
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
                
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button(action: {
                        showPopilation.toggle()
                    }, label: {
                        Image(systemName: "square")
                    })
                   
                })
                
                ToolbarItem(placement: .navigationBarLeading, content: {
                    Button(action: {
                        manage.toggle()
                    }, label: {
                        Image(systemName: "person.fill")
                    })
                })
                
                ToolbarItem(placement: .navigationBarLeading, content: {
                    Button(action: {
                        showOrderByDate.toggle()
                    }, label: {
                        Image(systemName: "square.fill")
                    })
                })
            }
            .sheet(isPresented: $showPopilation, content: {
                ScrollView(content: {
                    Button(action: {
                        viewModel.showPopulationCake()
                    }, label: {
                        Text("Показать популярные торты")
                    })
                    .padding()
                    
                    ForEach(viewModel.populationModel, id: \.self){
                        model in
                        
                        ZStack{
                            Color.clear.background(.ultraThinMaterial)
                            
                            HStack {
                               
                                
                                AsyncImage(url: URL(string: model.patch), content: {
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
                                    Text("Количество раз заказывали: \(model.count)")
                                        .padding(.horizontal)
                                    
                                    Text("Модель торта \(model.name)")
                                        .bold()
                                        .font(.system(size: 20))
                                        .padding(.horizontal)
                                        .padding(.bottom, 5)
                                    
                                   
                                    
                                    Text("Тип: \(model.type)")
                                        .padding(.horizontal)
                                        
                                    
                                    
                                    
                                    
                                }
                                
                                
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            
                            
                            
                           
                        }
                        .padding()
                        .frame(maxWidth: .infinity, minHeight: 180)
                        .cornerRadius(50)
                    }
                })
            })
            .sheet(isPresented: $showOrderByDate, content: {
                ScrollView{
                    HStack{
                        TextField("Введите дату", text: $date)
                            .textFieldStyle(.roundedBorder)
                        
                        Button(action: {
                            viewModel.showOrderByDate(date: date)
                        }, label: {
                            Text("Поиск")
                        })
                        
                    }
                    .padding()
                    
                    Text("Общая стоимость заказов - \(viewModel.sumOrder)")
                        .bold()
                        .padding()
                    
                    ForEach(viewModel.orderDay, id: \.self){
                        order in
                        VStack{
                            Text("Стоимость заказа - \(order.cost)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text("ФИО клиента - \(order.surnameClient) \(order.nameClient) \(order.lastnameClient)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text("Телефон клиента - \(order.phone)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text("Модель торта - \(order.nameCake)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text("Предоплата - \(order.prepayment)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text("Дата регистрации заказа - \(order.registrationOrder)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text("Предположительная дата выдачи - \(order.presumptiveDate)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            if order.idMaster != "None"{
                                Text("ФИО Мастера, выполняющего заказ - \(order.surnameMaster) \(order.nameMaster) \(order.lastnameMaster)")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            
                        }
                        .padding()
                        Divider()
                    }
                }
            })
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
                                NavigationView{
                                    ScrollView{
                                        LazyVStack(content: {
                                            Section(content: {
                                                VStack{
                                                    Text("Id Мастера")
                                                        .frame(maxWidth: .infinity, alignment: .leading)
                                                    
                                                    NavigationLink(destination: {
                                                        
                                                        ScrollView(content: {
                                                            LazyVStack(content: {
                                                                ForEach(viewModel.masters ,id: \.self, content: {
                                                                    master in
                                                                    Button(action: {
                                                                        viewModel.idMaster = master.idMaster
                                                                        viewModel.FIO = "\(master.surname) \(master.name) \(master.lastname)"
                                                                        viewModel.salary = "\(master.salary)"
                                                                        
                                                                    }, label: {
                                                                        VStack{
                                                                            Text("ФИО \(master.surname) \(master.name) \(master.lastname)")
                                                                                .frame(maxWidth: .infinity,  alignment: .leading)
                                                                            Text("Зп \(master.salary)")
                                                                                .frame(maxWidth: .infinity,  alignment: .leading)
                                                                            
                                                                            
                                                                        }
                                                                    })
                                                                    
                                                                    .onTapGesture {
                                                                        
                                                                        
                                                                    }
                                                                    .padding()
                                                                    
                                                                    Divider()
                                                                })
                                                            })
                                                        })
                                                        
                                                    }, label: {
                                                        Text("выбрать мастера")
                                                    })
                                                }
                                                
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
                                  Text("ФИО мастера \(master.surnameMaster) \(master.nameMaster) \(master.lastnameMaster)")
                                      .frame(maxWidth: .infinity,  alignment: .leading)
                                  
                                  Text("Id client \(master.idClient)")
                                      .frame(maxWidth: .infinity,  alignment: .leading)
                                  
                                  Text("ФИО КЛИЕНТА \(master.surnameClient) \(master.nameClient) \(master.lastnameClient)")
                                      .frame(maxWidth: .infinity,  alignment: .leading)
                                  
                                  Text("Стоимость заказа \(master.cost)")
                                      .frame(maxWidth: .infinity,  alignment: .leading)
                                  
                                  Text("Дата заказа \(master.registrationOrder)")
                                      .frame(maxWidth: .infinity,  alignment: .leading)
                                  
                                  Text("Примерная дата выдачи заказа \(master.presumptiveDate)")
                                      .frame(maxWidth: .infinity,  alignment: .leading)
                                  
                                  Text("Номер телефона и почта клиента \(master.phone) \(master.mail)")
                                      .frame(maxWidth: .infinity,  alignment: .leading)
                                  
                                  Text("Торт \(master.nameCake)")
                                      .frame(maxWidth: .infinity,  alignment: .leading)
                                  
                                  Text("Статус \(master.statusOrder)")
                                      .frame(maxWidth: .infinity,  alignment: .leading)

                              }
                              .padding()
                              Divider()
                          })
                      }, header: {
                          Text("Заказы, которые выполняются")
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
                NavigationView{
                    ScrollView(.vertical, showsIndicators: false){
                        
                        
                        Section(content: {
                            
                            TextField("ID заказа", text: $viewModel.idOrder)
                            
                            HStack{
                                Text("ID Клиента")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                NavigationLink(destination: {
                                    ScrollView{
                                        LazyVStack{
                                            ForEach(viewModel.clients, id: \.self){
                                                client in
                                                Button(action: {
                                                    viewModel.id = client.idClient
                                                    viewModel.basketClient = client
                                                }, label: {
                                                    VStack{
                                                        Text("Id клиента - \(client.idClient)")
                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                        Text("FIO клиента - \(client.surname) \(client.name) \(client.lastname)")
                                                            .frame(maxWidth: .infinity, alignment: .leading)

                                                        Text("Телефон клиента - \(client.phone)")
                                                            .frame(maxWidth: .infinity, alignment: .leading)

                                                        Text("Почта клиента - \(client.mail)")
                                                            .frame(maxWidth: .infinity, alignment: .leading)

                                                    }
                                                })
                                                
                                                Divider()
                                            }
                                        }
                                    }
                                    .onAppear{
                                        viewModel.showAllClient()
                                    }
                                }, label: {
                                    Text("Выбрать клиента")
                                })
                                
                                
                                
                            }
                            
                            Text("ID клиента - \(viewModel.id)\nФИО - \(viewModel.basketClient?.surname ?? "") \(viewModel.basketClient?.name ?? "") \(viewModel.basketClient?.lastname ?? "")\nНомер телефона - \(viewModel.basketClient?.phone ?? "")")
                          
                            
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
                }
            })
            .sheet(isPresented: $profile, content: {
                NavigationView{
                    ScrollView(.vertical){
                        VStack{
                            Text("Показаны заказы для клиента - \(viewModel.idClientShow). ФИО - \(viewModel.clientShor?.surname ?? "") \(viewModel.clientShor?.name ?? "") \(viewModel.clientShor?.lastname ?? "")")
                            NavigationLink(destination: {
                                ScrollView{
                                    LazyVStack{
                                        ForEach(viewModel.clients, id: \.self){
                                            client in
                                            Button(action: {
                                                viewModel.idClientShow = client.idClient
                                                viewModel.clientShor = client
                                                viewModel.getOrders()
                                            }, label: {
                                                VStack{
                                                    Text("Id клиента - \(client.idClient)")
                                                        .frame(maxWidth: .infinity, alignment: .leading)
                                                    Text("FIO клиента - \(client.surname) \(client.name) \(client.lastname)")
                                                        .frame(maxWidth: .infinity, alignment: .leading)

                                                    Text("Телефон клиента - \(client.phone)")
                                                        .frame(maxWidth: .infinity, alignment: .leading)

                                                    Text("Почта клиента - \(client.mail)")
                                                        .frame(maxWidth: .infinity, alignment: .leading)

                                                }
                                            })
                                            
                                            Divider()
                                        }
                                    }
                                }
                                .onAppear{
                                    viewModel.showAllClient()
                                }
                            }, label: {
                                Text("Показать заказы для клиента")
                            })
                        }
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

