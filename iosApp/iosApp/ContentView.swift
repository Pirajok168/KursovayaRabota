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
    
    
    
    @State private var viewModel = ViewModel()
    
   
    @State private var showSheet = false
    
    @State private var profile = false
    
    let id: Int
   
	var body: some View {
        
            
            ScrollView(.vertical){
                Button(action: {
                    viewModel.createCake()
                }, label: {
                    Text("1")
                })
                ScrollView(.horizontal, showsIndicators: false){
                    LazyHStack{
                        ForEach(cakes, id: \.self){ cake in
                            TypeCakeView(title: cake, isPressed: pressed == cake)
                                .padding()
                                .onTapGesture {
                                    withAnimation{
                                        pressed = cake
                                        switch cake {
                                        case "Фруктовые": viewModel.showCake(typeCake: TypeCake.fruits )
                                        case "С молоком": viewModel.showCake(typeCake: TypeCake.milk )
                                        case "Шоколадные": viewModel.showCake(typeCake: TypeCake.chocolate )
                                        default:
                                            print("Error")
                                        }
                                        
                                    }
                                }
                            
                        }
                    }
                    .padding(.horizontal)
                    
                }
                
                ForEach(viewModel.previewCakes, id: \.self){
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
            }
            .sheet(isPresented: $showSheet, content: {
                ScrollView(.vertical, showsIndicators: false){
                    
                    Section(content: {
                      
                         
                            
                        BasketElem(cake: viewModel.selectedCake!)
                        
                    }, header: {
                        Text("Корзина")
                            .font(.title.bold())
                    })
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
                                AsyncImage(url: URL(string: order.patch!), content: {
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
                                    Text("Торт: \(order.name!)")
                                    
                                    Text("Статус заказа: \(order.statusOrder)")
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding()
                        
                        
                    }
                }
                .onAppear{
                    viewModel.getOrders()
                }
            })
            
	}
  
}

