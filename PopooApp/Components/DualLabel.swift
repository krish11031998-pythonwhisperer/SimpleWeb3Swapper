//
//  DualLabel.swift
//  PopooApp
//
//  Created by Krishna Venkatramani on 16/02/2023.
//

import Foundation
import SwiftUI

struct DualLabel: View {
    
    let title: String
    let subTitle: String
    
    init(title: String, subTitle: String) {
        self.title = title
        self.subTitle = subTitle
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Text(title)
                .foregroundColor(.gray)
                .font(.system(size: 14, weight: .light))
            Spacer()
            Text(subTitle)
                .font(.system(size: 14, weight: .bold))
        }
    }
    
}
