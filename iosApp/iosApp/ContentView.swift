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
    
    @State private var basket: Dictionary<Int, Int> = [:]
    
    @ObservedObject private var viewModel = ViewModel()
    
    @State private var countOnBasket = 0
   
    @State private var showSheet = false
	var body: some View {
        NavigationStack{
            
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
                    ElemCake(cake: _cake, count: basket[Int(_cake.idModel)], onPlus: { (value: Model) in
                        let _cake = basket[Int(value.idModel)]
                        if (_cake != nil){
                            basket[Int(value.idModel)] = _cake! + 1
                            
                        }else{
                            basket[Int(value.idModel)] = 1
                           
                        }
                        countOnBasket += 1
                        
                    },  onMinus: {
                        (value: Model) in
                        let _cake = basket[Int(value.idModel)]
                            if (_cake != nil ){
                                guard _cake! - 1 >= 0 else{
                                    return
                                }
                                basket[Int(value.idModel)] = _cake! - 1
                               
                            }else{
                                basket[Int(value.idModel)] = 0
                                
                            }
                        if countOnBasket != 0 {
                            countOnBasket -= 1
                        }
                    } )
                        .padding()
                        .transition(.scale)
                }
                
                
                
            }
            
            
           
            
            .navigationTitle("Торты")
            .toolbar {
                ToolbarItem{
                    ZStack{
                        Button(action: {
                            showSheet.toggle()
                        }, label: {
                            Image(systemName: "basket")
                            
                        })
                        
                        
                        Text("\(countOnBasket)")
                            .frame(width: 20, height: 20)
                            .background(.red)
                            .clipShape(Circle())
                            .offset(x: 24, y: -12)
                    }
                    
                }
                
            }
        }
        .sheet(isPresented: $showSheet, content: {
            ScrollView(.vertical, showsIndicators: false){
                LazyVStack(alignment: .leading, spacing: 15, pinnedViews: .sectionHeaders, content: {
                    Section(content: {
                        ForEach(basket.keys.sorted(), id: \.self){
                            idModel in
                            
                            let cake: Model? = viewModel.cakes.first(where: { model in
                                model.idModel == idModel
                            })
                         
                            
                            BasketElem(cake: cake!, count: basket[idModel]!)
                        }
                    }, header: {
                        Text("Корзина")
                            .font(.title.bold())
                    })
                    .padding()
                })
                
               
            }
        })
	}
  
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
            
	}
}
