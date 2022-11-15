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
    
    @State private var basket: Dictionary<Model, Int> = [:]
    
    @ObservedObject private var viewModel = ViewModel()
    
    @State private var countOnBasket = 0
   
    let _cake =  Cake( path: "https://static.1000.menu/img/content/24746/tort-molochnaya-devochka_1515476392_15_max.jpg", name: "Молочный торт", cost: 1300)
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
                ForEach(viewModel.cakes, id: \.self){
                    _cake in
                    ElemCake(cake: _cake, count: basket[_cake], onPlus: { (value: Model) in
                        let _cake = basket[value]
                        if (_cake != nil){
                            basket[value] = _cake! + 1
                            countOnBasket += 1
                        }else{
                            basket[value] = 1
                            countOnBasket = 1
                        }
                    },  onMinus: {
                        (value: Model) in
                        let _cake = basket[value]
                            if (_cake != nil ){
                                guard _cake! - 1 >= 0 else{
                                    return
                                }
                                basket[value] = _cake! - 1
                                countOnBasket -= 1
                            }else{
                                basket[value] = 0
                                countOnBasket = 0
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
	}
  
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
            
	}
}
