//
//  Buttonify.swift
//  PopooApp
//
//  Created by Krishna Venkatramani on 16/02/2023.
//

import Foundation
import SwiftUI

typealias Callback = () -> Void
typealias AsyncCallback = () async -> Void
private struct BouncyButtonModifier: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        let scale = configuration.isPressed ? 0.95 : 1
        let opacity = configuration.isPressed ? 0.95 : 1
        return configuration.label
            .scaleEffect(scale)
            .opacity(opacity)
    }
}


private struct ButtonifyModifier: ViewModifier {
    
    let callback: Callback?
    let asyncCallback: AsyncCallback?
    
    init(callback: Callback? = nil, asyncCallback: AsyncCallback? = nil) {
        self.callback = callback
        self.asyncCallback = asyncCallback
    }
    
    
    func body(content: Content) -> some View {
        Button {
            if let callback {
                callback()
            } else if let asyncCallback = asyncCallback{
                Task {
                    await asyncCallback()
                }
            }
        } label: {
            content
        }
        .buttonStyle(BouncyButtonModifier())
    }
}


extension View {
    
    func buttonify(callBack: Callback? = nil)  -> some View{
        self.modifier(ButtonifyModifier(callback: callBack))
    }
    
    func buttonifyAsync(callBack: AsyncCallback? = nil)  -> some View{
        self.modifier(ButtonifyModifier(asyncCallback: callBack))
    }
}
