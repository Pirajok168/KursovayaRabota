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
    
    
    
    @ObservedObject private var viewModel = ViewModel()
    
   
    @State private var showSheet = false
    
   
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
                        .onTapGesture {
                            viewModel.chooiseCake(cake: _cake)
                            showSheet.toggle()
                            
                        }
                }
                
                
                
            }
        
            .navigationTitle("Торты")
            
            .navigationBarBackButtonHidden(true)
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
	}
  
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
            
	}
}
