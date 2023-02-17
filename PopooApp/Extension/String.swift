//
//  String.swift
//  PopooApp
//
//  Created by Krishna Venkatramani on 17/02/2023.
//

import Foundation

extension String {
    
    static func readFromJSONFile(_ filename: String) -> String? {
        guard let file = Bundle.main.path(forResource: filename, ofType: "json") else { return nil }
        
        guard let string = try? String(contentsOfFile: file) else { return  nil }
        
        return string
    }
    
}
