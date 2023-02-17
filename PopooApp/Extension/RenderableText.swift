//
//  RenderableText.swift
//  PopooApp
//
//  Created by Krishna Venkatramani on 17/02/2023.
//

import Foundation
import SwiftUI

public protocol RenderableText {
    var text: Text { get }
}

extension AttributedString: RenderableText {
    
    public var text: Text { .init(self) }
    
    public func styled(font: UIFont, color: Color) -> RenderableText {
        var attributedString = self
        attributedString.font = font
        attributedString.foregroundColor = color
        
        return attributedString
    }
}

extension String: RenderableText {
    
    public var text: Text {
        .init(self)
    }
    
    public func styled(font: UIFont, color: Color) -> RenderableText {
        var attributedString = AttributedString(self)
        attributedString.font = font
        attributedString.foregroundColor = color
        
        return attributedString
    }
}

public extension String {
    
    func systemHeading1(color: Color = .black) -> RenderableText {
        styled(font: .systemFont(ofSize: 15, weight: .semibold), color: color)
    }
    
    func systemHeading2(color: Color = .black) -> RenderableText {
        styled(font: .systemFont(ofSize: 13, weight: .semibold), color: color)
    }
    
    func systemSubHeading(color: Color = .black) -> RenderableText {
        styled(font: .systemFont(ofSize: 12, weight: .regular),color: color)
    }
    
    func systemBody(color: Color = .black) -> RenderableText {
        styled(font: .systemFont(ofSize: 12, weight: .regular),color: color)
    }
    
    func sectionHeader(color: Color = .black) -> RenderableText {
        styled(font: .systemFont(ofSize: 25, weight: .semibold), color: color)
    }
    
    func sectionSubHeading(color: Color = .black) -> RenderableText {
        styled(font: .systemFont(ofSize: 17.5, weight: .regular), color: color)
    }
}
