//
//  EdgeInsets.swift
//  PopooApp
//
//  Created by Krishna Venkatramani on 16/02/2023.
//

import Foundation
import SwiftUI

extension EdgeInsets {
    
    init(vertical: CGFloat, horizontal: CGFloat) {
        self.init(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }
    
    init(by: CGFloat) {
        self.init(top: by, leading: by, bottom: by, trailing: by)
    }
    
}
