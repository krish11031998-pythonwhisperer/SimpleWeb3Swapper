//
//  CardType.swift
//  PopooApp
//
//  Created by Krishna Venkatramani on 16/02/2023.
//

import Foundation

enum CardType {
    case from, to
}

extension CardType {
    
    var text: String {
        switch self {
        case .from:
            return "Swap from"
        case .to:
            return "To"
        }
    }
    
}
