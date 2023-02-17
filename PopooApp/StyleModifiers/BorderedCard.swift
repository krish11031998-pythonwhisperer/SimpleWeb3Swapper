//
//  BorderedCard.swift
//  PopooApp
//
//  Created by Krishna Venkatramani on 16/02/2023.
//

import Foundation
import SwiftUI

private struct BorderedCard: ViewModifier {
    
    var borderColor: Color
    var radius: CGFloat
    var borderWidth: CGFloat
    
    public init(borderColor: Color, radius: CGFloat = 8, borderWidth: CGFloat = 1) {
        self.borderColor = borderColor
        self.radius = radius
        self.borderWidth = borderWidth
    }
    
    
    public func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: radius)
                    .strokeBorder(borderColor, lineWidth: borderWidth)
            )
    }
}

public extension View {
    
    func borderCard(borderColor: Color, radius: CGFloat = 8, borderWidth: CGFloat = 1) -> some View {
        modifier(BorderedCard(borderColor: borderColor, radius: radius, borderWidth: borderWidth))
    }
}
