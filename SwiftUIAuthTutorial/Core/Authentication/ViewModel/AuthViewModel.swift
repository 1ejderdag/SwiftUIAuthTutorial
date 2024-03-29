//
//  AuthViewModel.swift
//  SwiftUIAuthTutorial
//
//  Created by Ejder Dağ on 26.03.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
//import FirebaseFirestoreSwift

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}
@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            
            userSession = result.user
            await fetchUser()
            
        } catch {
            print("DEBUG: Failed to sing in. Error: \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            
            self.userSession = result.user
            
            let user = User(id: result.user.uid, fullname: fullname, email: email)
            
            let encodedUser = try Firestore.Encoder().encode(user) // 
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            
            await fetchUser()
        } catch {
            print("Kullanıcı oluşturulurken bir hata oluştu. Hata: \(error.localizedDescription)")
        }
        
    }
    
    func signOut() {
        
        do {
            try Auth.auth().signOut()
            self.userSession = nil
        } catch {
            print("DEBUG: Failed to sign out with error - \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() {
        print("delete account")
    }
    
    func fetchUser() async {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
    
        self.currentUser = try? snapshot.data(as: User.self)
        
    }
}
