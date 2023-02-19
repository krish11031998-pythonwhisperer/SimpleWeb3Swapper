//
//  SqapService.swift
//  PopooApp
//
//  Created by Krishna Venkatramani on 16/02/2023.
//

import Foundation
import web3swift
import Web3Core
import BigInt

protocol Web3ServiceInterface {
    func connect() async
    func connectWallet(privateKey: String, password: String) async -> Web3.Web3Wallet?
    func getBalance(for address: EthereumAddress) async -> BigUInt?
    func getConversion(amount: BigUInt, tokenA: String, tokenB: String) async -> BigUInt?
}



class Web3Service: Web3ServiceInterface {
    
    var web3: Web3? = nil
    
    func connect() async {

        guard let url = URL.binanceTestNetURL else { return }
        let provider = Web3HttpProvider(url: url, network: .Rinkeby)

        // Create a Web3 object using the provider
        let web3 = Web3(provider: provider)

        // Check if the connection is successful
        do {
            let blockNumber = try await web3.eth.blockNumber()
            print("Connected to the Binance Smart Chain Testnet! Current block number: \(blockNumber)")
            self.web3 =  web3
        } catch {
            return
        }
    }
    
//    func swap() async -> BigUInt? {
//
//        if web3 == nil {
//            await connect()
//        }
//
//        guard let factoryABI = String.readFromJSONFile("PancakeSwapABI") else { return nil }
//
//        //Setup Factory
//        let factoryAddress = "0xcA143Ce32Fe78f1f7019d7d551a6402fC5350c73"
//
//        guard let factory = web3?.contract(factoryABI, at: .init(from: factoryAddress)) else { return nil }
//
//        //Swap Token
//        let tokenA = Address("0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c") // Binance Coin (BNB)
//        let token1Address = Address("0xe9e7cea3dedca5984780bafc599bd69add087d56") // Binance USD (BUSD)
//
//        let amountIn = BigUInt("1000000000000000000")
//
//
//        return nil
//
//    }
    
    func getConversion(amount: BigUInt, tokenA: String = String.Token.bnb.rawValue, tokenB: String = String.Token.busd.rawValue) async -> BigUInt? {

        guard let web3 = web3 else {
            await connect()
            return await getConversion(amount: amount, tokenA: tokenA, tokenB: tokenB)
        }

        guard let pancakeContract = Web3.Contract.pancakeContract(web3: web3) else { return nil}
        
        let result = await pancakeContract.getAmountsOut(amount: amount, tokenA: tokenA, tokenB: tokenB)
        print("(DEBUG) result: ", result)
        
        return .zero
    }
    
    func connectWallet(privateKey: String, password: String) async -> Web3.Web3Wallet? {
        guard let web3 = web3 else {
            await connect()
            return await connectWallet(privateKey: privateKey, password: password)
        }
        
        web3.addKeystoreManager(KeystoreManager.defaultManager)
        
        guard let keyData = Data.fromHex(privateKey),
              let keyStore = try? EthereumKeystoreV3(privateKey: keyData, password: password) else {
           return  nil
        }
        
        let keystoreManager = KeystoreManager([keyStore])
        web3.addKeystoreManager(keystoreManager)
        
        return web3.wallet
    }
    
    func getBalance(for address: EthereumAddress) async -> BigUInt? {
        guard let web3 = web3 else {
            await connect()
            return await getBalance(for: address)
        }
        
        guard var balance = try? await web3.eth.getBalance(for: address) else { return nil }
        
        balance /= 1000000000
        
        return balance
    }
}

///Test Info
/// privateKey: f2ea933e2adf9d6192ac14dead4ae35f7eeea2e2368bd0a395eba1970ee54035
///
