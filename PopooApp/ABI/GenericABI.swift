//
//  GenericABI.swift
//  PopooApp
//
//  Created by Krishna Venkatramani on 19/02/2023.
//

import Foundation
import web3swift
import Web3Core
import BigInt

protocol GenericABI {
    var address: String { get }
    var abi: String? { get }
    var methodName: String { get }
    var params: [Any] { get }
    func call(web3: Web3.Contract) async -> [String : Any]?
}

extension GenericABI {
    func call(web3: Web3.Contract) async -> [String: Any]? {
        guard let method = web3.contract.method(methodName, parameters: params, extraData: nil) else { return nil }
        
        web3.transaction.data = method
        
        if let chainID = web3.web3.provider.network?.chainID {
            web3.transaction.chainID = chainID
        }
        
        do {
            let result = try await web3.web3.eth.callTransaction(web3.transaction)
            print("(DEBUG) callTransactionResult : ", result)
            let data = web3.contract.decodeReturnData(methodName, data: result)
            print("(DEBUG) data: ", data)
            return data
        } catch {
            print("(ERROR) err: ", error.localizedDescription)
            return nil
        }
    }
}

