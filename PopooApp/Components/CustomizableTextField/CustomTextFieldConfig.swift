//
//  CustomTextFieldConfig.swift
//  PopooApp
//
//  Created by Krishna Venkatramani on 17/02/2023.
//

import Foundation
import SwiftUI

//MARK: - CustomTextFieldConfig
public struct CustomTextFieldConfig {
    let accentColor: Color
    let foregroundColor: Color
    let font: Font
    let insets: EdgeInsets
    let placeHolder: RenderableText
    let borderColor: Color
    let borderWidth: CGFloat
    let cornerRadius: CGFloat
    
    public init(
        accentColor: Color,
        foregroundColor: Color,
        font: Font,
        insets: EdgeInsets,
        placeHolder: RenderableText,
        borderColor: Color,
        borderWidth: CGFloat,
        cornerRadius: CGFloat = 20
    ) {
        self.accentColor = accentColor
        self.foregroundColor = foregroundColor
        self.font = font
        self.insets = insets
        self.placeHolder = placeHolder
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.cornerRadius = cornerRadius
    }
}
 
extension CustomTextFieldConfig {
    
    static var `default`: CustomTextFieldConfig = .init(accentColor: .blue,
                                                        foregroundColor: .blue,
                                                        font: .system(size: 15, weight: .regular, design: .default),
                                                        insets: .init(vertical: 12, horizontal: 16),
                                                        placeHolder: "Placeholder".systemBody(),
                                                        borderColor: .blue,
                                                        borderWidth: 2,
                                                        cornerRadius: 12)
    static var plain: CustomTextFieldConfig = .init(accentColor: .clear,
                                                        foregroundColor: .blue,
                                                        font: .system(size: 15, weight: .semibold, design: .default),
                                                        insets: .init(vertical: 12, horizontal: 16),
                                                        placeHolder: "".systemBody(),
                                                        borderColor: .clear,
                                                        borderWidth: 2,
                                                        cornerRadius: 12)
    
    static var digits: CustomTextFieldConfig = .init(accentColor: .clear,
                                                        foregroundColor: .blue,
                                                        font: .system(size: 20, weight: .semibold, design: .default),
                                                        insets: .init(vertical: 0, horizontal: 0),
                                                        placeHolder: "".systemBody(),
                                                        borderColor: .clear,
                                                        borderWidth: 2,
                                                        cornerRadius: 12)
}
