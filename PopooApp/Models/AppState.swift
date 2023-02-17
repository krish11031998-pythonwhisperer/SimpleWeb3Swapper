//
//  AppStorage.swift
//  PopooApp
//
//  Created by Krishna Venkatramani on 17/02/2023.
//

import Foundation
import web3swift

class AppState: ObservableObject {
    @Published var wallet: Web3.Web3Wallet? = nil
}
