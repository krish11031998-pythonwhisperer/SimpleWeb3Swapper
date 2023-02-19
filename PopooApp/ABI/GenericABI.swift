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

enum OperationType { case write, read }

protocol GenericABI {
    var address: String { get }
    var abi: String? { get }
    var methodName: String { get }
    var params: [Any] { get }
    var operation: OperationType { get }
    func call(web3: Web3.Contract) async -> [String : Any]?
}

extension GenericABI {
    func call(web3: Web3.Contract) async -> [String: Any]? {
        guard let method = web3.contract.method(methodName, parameters: params, extraData: nil) else { return nil }
        
        web3.transaction.data = method
        
        if let chainID = web3.web3.provider.network?.chainID {
            web3.transaction.chainID = chainID
        }
        
        if operation == .read {
            guard let intermediate = web3.createReadOperation(methodName, parameters: params) else { return nil }
            do {
                let result = try await intermediate.callContractMethod()
                print("(DEBUG) data: ", result)
                return result
            } catch {
                print("(ERROR) err: ", error.localizedDescription)
                return nil
            }
        } else {
            guard let intermediate = web3.createWriteOperation(methodName, parameters: params) else { return nil }
            do {
                let result = try await intermediate.callContractMethod()
                print("(DEBUG) data: ", result)
                return result
            } catch {
                print("(ERROR) err: ", error.localizedDescription)
                return nil
            }
        }
       
    }
}

