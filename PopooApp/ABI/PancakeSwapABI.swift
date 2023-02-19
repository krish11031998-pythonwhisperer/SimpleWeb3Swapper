//
//  PancakeSwapABI.swift
//  PopooApp
//
//  Created by Krishna Venkatramani on 19/02/2023.
//

import Foundation
import web3swift
import Web3Core
import BigInt

//MARK: - PancakeSwapContract
typealias PancakeSwapContract = Web3.Contract & PancakeSwapContractInterface

//MARK: - PancakeABI
enum PancakeSwapABI {
    case getAmountsOut(amountIn: BigUInt, tokenA: EthereumAddress, tokenB: EthereumAddress)
}

extension PancakeSwapABI: GenericABI {
    
    var address: String { "0x10ED43C718714eb63d5aA57B78B54704E256024E" }
    
    var abi: String? { String.readFromJSONFile("PancakeSwapABI") }
    
    var methodName: String {
        switch self {
        case .getAmountsOut:
            return "getAmountsOut"
        }
    }
    
    var params: [Any] {
        switch self {
        case .getAmountsOut(let amountIn, let tokenA, let tokenB):
            return [amountIn, [tokenA, tokenB]]
        }
    }
    
}

//MARK: - String+ABIDefaults
fileprivate extension String {
    static var pancakeSwapABI: String {
        String.readFromJSONFile("PancakeSwapABI") ?? ""
    }
    static let factoryAddress = "0x10ED43C718714eb63d5aA57B78B54704E256024E"
}



//MARK: - PancakeSwapContract + Web3.Contract
extension Web3.Contract {
    static func pancakeContract(web3: Web3) -> PancakeSwapContract? {
        
        guard let contract = web3.contract(.pancakeSwapABI, at: .init(.factoryAddress)) else { return nil }
        return contract
    }
}

//MARK: - PancakeSwapContract
protocol PancakeSwapContractInterface {
    func getAmountsOut(amount: BigUInt, tokenA: String, tokenB: String) async -> [String: Any]?
}


//MARK: - Web3.Contract + PancakeSwapContract
extension Web3.Contract: PancakeSwapContractInterface {
    
    func getAmountsOut(amount: BigUInt, tokenA: String, tokenB: String) async -> [String: Any]? {
        guard let tokenA = EthereumAddress(tokenA), let tokenB = EthereumAddress(tokenB) else { return nil }
        return await PancakeSwapABI.getAmountsOut(amountIn: amount, tokenA: tokenA, tokenB: tokenB).call(web3: self)
    }
    
}



