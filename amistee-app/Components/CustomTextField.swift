//
//  CustomTextField.swift
//  amistee_partner
//
//  Created by Apple on 19/12/20.
//

import SwiftUI

struct CustomTextField: View {
    
    @Binding var text: String
    private let isPasswordType: Bool
    private let placeHolderText: String
    
    init(placeHolderText: String, text: Binding<String>, isPasswordType: Bool = false) {
        _text = text
        self.isPasswordType = isPasswordType
        self.placeHolderText = placeHolderText
    }
    var body: some View {
        VStack {
            if isPasswordType {
                ZStack(alignment: .leading) {
                    if text.isEmpty {
                        Text(placeHolderText)
                            .foregroundColor(.gray)
                            .padding(.leading, 10)
                    }
                    SecureField(placeHolderText, text: $text)
                    .textFieldStyle(MyTextFieldStyle())
                }
                
            } else {
                ZStack(alignment: .leading) {
                    if text.isEmpty {
                        Text(placeHolderText)
                            .foregroundColor(.gray)
                            .padding(.leading, 10)
                    }
                    TextField("", text: $text)
                        .textFieldStyle(MyTextFieldStyle())
                }
            }
        }
    }
}
