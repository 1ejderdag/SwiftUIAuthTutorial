//
//  ProfileView.swift
//  SwiftUIAuthTutorial
//
//  Created by Ejder Dağ on 26.03.2024.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        
        if let user = viewModel.currentUser {
            
            List {
                Section {
                    HStack {
                        Text(user.initals)
                            .fontWeight(.semibold)
                            .font(.title)
                            .frame(width: 72,height: 72)
                            .background(Color(.systemGray3))
                            .clipShape(Circle())
                            .foregroundStyle(Color(.white))
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(user.fullname)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                              
                            // @gmail.com kullanıldığında otomatik olarak mavi renk görünür.
                            // Bu default mavi rengi değiştirmek için Assests'taki accent color'ı değiştir.
                            Text(user.email)
                                .font(.footnote)
                                .foregroundStyle(Color(.gray))
                            
                        }
                        
                        
                    }
                }
                
                
                Section("General") {
                    HStack {
                        SettingsRowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray))
                        Spacer()
                        Text("1.0.0")
                            .foregroundStyle(Color(.systemGray))
                            .font(.subheadline)
                    }
                }
                
                Section("Account") {
                    Button {
                        viewModel.signOut()
                    } label: {
                        SettingsRowView(imageName: "arrow.left.circle.fill", title: "Sign Out", tintColor: Color(.red))
                    }
                    Button {
                        print("Delete Account")
                    } label: {
                        SettingsRowView(imageName: "x.circle.fill", title: "Delete Account", tintColor: Color(.red))
                    }
                }
                
            }
        }
    }
}

#Preview {
    ProfileView()
}
