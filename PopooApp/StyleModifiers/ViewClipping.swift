//
//  ViewClipping.swift
//  PopooApp
//
//  Created by Krishna Venkatramani on 16/02/2023.
//

import Foundation
import SwiftUI

//MARK: - ViewClipping View Modifier

enum ViewClipping {
    case roundedRect(cornerRadius: CGFloat)
    case circle
    case capsule
}

private extension ViewClipping {
    var shape: AnyShape {
        switch self {
        case .roundedRect(let cornerRadius):
            return AnyShape(RoundedRectangle(cornerRadius: cornerRadius))
        case .circle:
            return AnyShape(Circle())
        case .capsule:
            return AnyShape(Capsule())
        }
    }
}

private struct ViewClippingModifier: ViewModifier {

    let clipping: ViewClipping
    
    init(clipping: ViewClipping) {
        self.clipping = clipping
    }
    
    func body(content: Content) -> some View {
        content
            .clipShape(clipping.shape)
    }
}


extension View {
    
    func clipping(to: ViewClipping) -> some View {
        self.modifier(ViewClippingModifier(clipping: to))
    }
}
