//
//  AuthService.swift
//  amistee_partner
//
//  Created by Apple on 19/12/20.
//
import Foundation
import Combine
import Alamofire

class AuthService: AuthAPI {
    
    private let api_url_base = "https://us-central1-amistee-72b71.cloudfunctions.net/webApi/"
    
    func loginWithFacebook() -> Future<User?, Never> {
        return Future<User?, Never> { promise in
            
            promise(.success(nil))
        }
    }
    
    func login(mobile: String, password: String) -> Future<User?, Never> {
        print("login creds = \(mobile) pass=\(password)")
        return Future<User?, Never> { promise in
            guard  let url = URL(string: "\(self.api_url_base)contractors/login") else { return }
            print("login api url =\(url)")
            AF.request(url,
                       method: .post,
                       parameters: ["mob_number" : mobile, "password" : password],
                       encoding: JSONEncoding.default)
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .responseDecodable(of: User.self) { response in
                    debugPrint(response)
                    if let user = response.value {
//                        let userData = User(id: user.id, email: user.email,contractor_name: user.contractor_name, company_name: user.company_name, business_name: user.business_name, mob_number: user.mob_number)
                        promise(.success(user))
                    }else {
                        promise(.success(nil))
                        return
                    }
                }
            
        }
    }
    
    func signUp(email: String, password: String) -> Future<User?, Never> {
        return Future<User?, Never> { promise in
            promise(.success(nil))
        }
    }
}
