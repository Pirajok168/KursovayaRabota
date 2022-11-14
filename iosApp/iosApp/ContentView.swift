import SwiftUI



struct TypeCake: View{
    let title: String
    let isPressed: Bool
    
    var body: some View{
        HStack{
            Text(title)
                .foregroundColor(isPressed ? Color.white : Color.blue)
                .padding(.horizontal)
                .padding(.vertical, 10)
            
        }
        .background(isPressed ? Color.blue : Color.white)
        .cornerRadius(20)
        .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.blue, lineWidth: 1)
        )
    }
}

struct Cake: Hashable{
    let path: String
    let name: String
    let cost: Double
}

struct ElemCake: View{
    
    let cake: Cake
    let count: Int?
    var onPlus: (Cake) -> Void
    var onMinus: (Cake) -> Void
    
    var body: some View{
        ZStack{
            Color.clear.background(.ultraThinMaterial)
            
            HStack {
                AsyncImage(url: URL(string: cake.path), content: {
                    image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        
                        
                }, placeholder: {

                })
                .frame(width: 160, height: 180)
                
                VStack(alignment: .leading){
                    Text(cake.name)
                        .bold()
                        .font(.system(size: 20))
                        .padding(.horizontal)
                        .padding(.bottom, 5)
                    
                    Text("\(String(format: "%.2f", cake.cost)) ₽")
                        .padding(.horizontal)
                    
                    HStack{
                        Circle()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.blue)
                            .overlay{
                                Image(systemName: "minus")
                                

                            }
                            .padding(.leading)
                            .padding(.trailing, 10)
                            .onTapGesture {
                                onMinus(cake)
                            }
                        
                        Text("\(count ?? 0)")
                            .frame(width: 30)
                        
                        Circle()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.blue)
                            .overlay{
                                Image(systemName: "plus")
                                

                            }
                            .padding(.trailing)
                            .padding(.leading, 10)
                            .onTapGesture {
                                onPlus(cake)
                            }
                    }
                }
                
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            
            
           
        }
        .frame(maxWidth: .infinity, minHeight: 180)
        .cornerRadius(50)
    }
}

struct ContentView: View {
	
    let cakes: [String] = [
        "Фруктовые", "С молоком", "Шоколадные"
    ]
    @State private var pressed = "Фруктовые"
    
    @State private var basket: Dictionary<Cake, Int> = [:]
   
    let _cake =  Cake( path: "https://static.1000.menu/img/content/24746/tort-molochnaya-devochka_1515476392_15_max.jpg", name: "Молочный торт", cost: 1300)
	var body: some View {
        NavigationStack{
            
            ScrollView(.vertical){
                ScrollView(.horizontal, showsIndicators: false){
                    LazyHStack{
                        ForEach(cakes, id: \.self){ cake in
                            TypeCake(title: cake, isPressed: pressed == cake)
                                .padding()
                                .onTapGesture {
                                    withAnimation{
                                        pressed = cake
                                    }
                                    
                                }
                        }
                    }
                    .padding(.horizontal)
                    
                }
                ElemCake(cake: _cake, count: basket[_cake], onPlus: { (value: Cake) in
                    var _cake = basket[value]
                    if (_cake != nil){
                        basket[value] = _cake! + 1
                    }else{
                        basket[value] = 1
                    }
                }, onMinus: {
                    (value: Cake) in
                        var _cake = basket[value]
                        if (_cake != nil ){
                            guard _cake! - 1 >= 0 else{
                                return
                            }
                            basket[value] = _cake! - 1
                        }else{
                            basket[value] = 0
                        }
                } )
                    .padding()
                
            }
           
            
            .navigationTitle("Торты")
        }
	}
  
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
            
	}
}
