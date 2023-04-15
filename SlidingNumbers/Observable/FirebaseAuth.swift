//
//  FirebaseAuth.swift
//  SlidingNumbers
//
//  Created by fredrik sundström on 2023-04-15.
//

import Foundation
import Firebase

class FirebaseAuth: ObservableObject{
    let auth = Auth.auth()
    @Published var isLoggedIn: Bool = false
    
    
    /*func isLoggedIn() -> Bool{
        return auth.currentUser != nil
    }*/
    
    func login(email:String,password:String){
        auth.signIn(withEmail: email, password: password){ [weak self] (result,error) in
            guard let strongSelf = self else { return }
                guard let error = error else {
                    printAny("success")
                    return
                }
            printAny(error.localizedDescription)
            strongSelf.isLoggedIn = true
        }
    }
    
    func signup(email:String,password:String){
        auth.createUser(withEmail: email, password: password){ (result,error) in
            guard let error = error else {
                printAny("success")
                return
            }
            printAny(error.localizedDescription)
            
          }
    }
}
