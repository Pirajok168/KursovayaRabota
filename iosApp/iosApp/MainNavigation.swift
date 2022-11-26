//
//  MainNavigation.swift
//  iosApp
//
//  Created by Данила Еремин on 26.11.2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI

enum PathNav: Hashable{
    case Auth
    case HomeScreen
}

class Navigation: ObservableObject{
    @Published var path: [PathNav] = [.Auth]
    
    func toHomeScreen(){
        path.append(PathNav.HomeScreen)
    }
}

struct MainNavigation: View {
    @ObservedObject var nav = Navigation()
    var body: some View {
        NavigationStack(path: $nav.path){
            EmptyView()
                .navigationDestination(for: PathNav.self, destination: {
                    dest in
                    
                    if dest == .Auth {
                        Auth()
                            .environmentObject(nav)
                    }else if dest == .HomeScreen{
                        ContentView()
                    }
                })
        }
    }
}

struct MainNavigation_Previews: PreviewProvider {
    static var previews: some View {
        MainNavigation()
    }
}
