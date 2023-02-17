//
//  ImageView.swift
//  PopooApp
//
//  Created by Krishna Venkatramani on 16/02/2023.
//

import Foundation
import SwiftUI
import Combine

struct ImageView: View {
    
    let url: String?
    let scaleType: ScaleType
    let tint: Color
    @State var img: UIImage
    @State private var cancellable: AnyCancellable? = nil
    
    init(url: String? = nil,
         img: UIImage = .placeHolder,
         scaleType: ScaleType = .fill,
         tintColor: Color = .white) {
        self.url = url
        self._img = .init(initialValue: img)
        self.scaleType = scaleType
        self.tint = tintColor
    }
    
    var body: some View {
        Image(uiImage: img)
            .resizable()
            .foregroundColor(tint)
            .scale(to: scaleType)
            .onAppear(perform: onAppearBlock)
            .onDisappear {
                cancellable?.cancel()
            }
    }
    
}

extension ImageView {
    //MARK: - onAppear
    private func onAppearBlock() {
        guard let url = url else { return }
        cancellable = UIImage.loadImageForUrl(url)
            .sink { completion in
                print("(COMPLETION) : ", completion)
            } receiveValue: { image in
                DispatchQueue.main.async {
                    withAnimation{
                        img = image
                    }
                }
            }
    }
    
}

