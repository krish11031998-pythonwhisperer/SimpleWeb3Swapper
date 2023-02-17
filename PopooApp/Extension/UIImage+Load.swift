//
//  LoadImage.swift
//  PopooApp
//
//  Created by Krishna Venkatramani on 16/02/2023.
//

import Foundation
import Combine
import UIKit

enum ImageLoadError: String, Error {
    case invalidUrl, noData, invalidDataForImage
}

//MARK: - UIView+GraphicRenderer
extension UIImage {
    static let placeHolder: UIImage = { .init(named: "placeHolder") ?? .init() }()
    
    static func loadImageForUrl(_ urlStr: String) -> AnyPublisher<UIImage, Error> {
        guard let url = URL(string: urlStr) else { return Fail(outputType: UIImage.self, failure: ImageLoadError.invalidUrl).eraseToAnyPublisher() }
        let result: AnyPublisher<UIImage, Error> = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .map { (data, _) -> UIImage in
                guard let img = UIImage(data: data) else { return .placeHolder}
                return img
            }
            .mapError { _ in
                return ImageLoadError.noData
            }
            .eraseToAnyPublisher()
        return result
    }
    
}
