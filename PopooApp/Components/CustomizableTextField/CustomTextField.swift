//
//  CustomTextField.swift
//  PopooApp
//
//  Created by Krishna Venkatramani on 17/02/2023.
//

import Foundation
import SwiftUI


//MARK: - CustomTextField
struct CustomTextField: View {
    
    let isSecure: Bool
    let placeHolder: String
    let config: CustomTextFieldConfig
    @Binding var text: String
    
    public init(placeHolder: String = "Placeholder",
                isSecure: Bool = false,
                config: CustomTextFieldConfig = .default,
                text: Binding<String>) {
        self.placeHolder = placeHolder
        self.config = config
        self.isSecure = isSecure
        self._text = text
    }
    
    
    public var body: some View {
        if isSecure {
            SecureField(placeHolder, text: $text)
                .textFieldStyle(CustomTextFieldStyle(config: config))
        } else {
            TextField(placeHolder, text: $text)
                .textFieldStyle(CustomTextFieldStyle(config: config))
        }
    }
}

