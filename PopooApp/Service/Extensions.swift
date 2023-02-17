//
//  Extensions.swift
//  PopooApp
//
//  Created by Krishna Venkatramani on 16/02/2023.
//

import Foundation
import web3swift
import Web3Core

extension EthereumAddress {
    static let pancakeSwapAddress = EthereumAddress("0x73feaa1eE314F8c655E354234017bE2193C9E24E")
}

extension URL {
    static let binanceTestNetURL: URL? = {
        .init(string: "https://data-seed-prebsc-1-s1.binance.org:8545")
    }()
}

extension Web3HttpProvider {
    static let binanceTestNet: Web3HttpProvider? = {
        guard let url = URL.binanceTestNetURL else { return nil }
        return Web3HttpProvider(url: url, network: .Kovan)
    }()
}
