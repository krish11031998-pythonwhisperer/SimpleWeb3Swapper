//
//  ScaledModifier.swift
//  PopooApp
//
//  Created by Krishna Venkatramani on 16/02/2023.
//

import Foundation
import SwiftUI

enum ScaleType {
    case fit, fill
}

private struct ScaleModifier: ViewModifier {
    
    let scale: ScaleType
    
    init(scale: ScaleType) {
        self.scale = scale
    }
    
    func body(content: Content) -> some View {
        if scale == .fill {
            content
                .scaledToFill()
        } else {
            content
                .scaledToFit()
        }
    }
}


extension View {
    func scale(to: ScaleType) -> some View {
        self.modifier(ScaleModifier(scale: to))
    }
}
