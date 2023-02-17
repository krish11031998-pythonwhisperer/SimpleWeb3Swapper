//
//  CustomTextFieldStyle.swift
//  PopooApp
//
//  Created by Krishna Venkatramani on 17/02/2023.
//

import Foundation
import SwiftUI

//MARK: - CustomTextFieldStyle
struct CustomTextFieldStyle: TextFieldStyle {

    let config: CustomTextFieldConfig
    
    var placeHolder: some View {
        config.placeHolder.text
            .padding(.leading,config.insets.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
          .textFieldStyle(PlainTextFieldStyle())
          .multilineTextAlignment(.leading)
          .accentColor(config.accentColor)
          .foregroundColor(config.foregroundColor)
          .font(config.font)
          .padding(config.insets)
          .borderCard(borderColor: config.borderColor, radius: config.cornerRadius, borderWidth: config.borderWidth)
    }
}
