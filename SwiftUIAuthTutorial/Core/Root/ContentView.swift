//
//  ContentView.swift
//  SwiftUIAuthTutorial
//
//  Created by Ejder Dağ on 25.03.2024.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
       
        Group {
            
            if viewModel.userSession != nil {
                ProfileView()
            } else {
                LoginView()
            }
        } 
        
    }
}

#Preview {
    ContentView()
}
