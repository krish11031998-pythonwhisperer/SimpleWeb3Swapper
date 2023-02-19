//
//  ContentView.swift
//  PopooApp
//
//  Created by Krishna Venkatramani on 16/02/2023.
//

import SwiftUI
import BigInt
import Web3Core
import web3swift
import Combine

extension BigUInt {
    var floatValue: Float {
        let double = Double(self)/pow(10, 9)
        return Float(double)
    }
}

enum ConversionState {
    case idle, converting, converted
}

struct SwapTokenView: View {
    
    @EnvironmentObject var appState: AppState
    private let service: Web3ServiceInterface
    @State var balance: BigUInt = .zero
    @State var convert: ConversionState = .idle
    @State var amountToConvert: String = ""
    @State var tokenA: String.Token = .bnb
    @State var tokenB: String.Token = .busd
    
    init(service: Web3ServiceInterface = Web3Service()) {
        self.service = service
    }
    
    var swapDetails: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Swap Details")
                .font(.system(size: 16, weight: .bold))
            
            ForEach(Array(Constants.testSwapDetail.keys), id: \.self) { key in
                if let value = Constants.testSwapDetail[key] {
                    DualLabel(title: key, subTitle: value)
                }
            }
        }
    }
    
    var tradeButton: some View {
        Text("Trade Now")
            .padding(.init(by: 10))
            .frame(maxWidth: .infinity, alignment: .center)
            .background(Color.blue)
            .clipping(to: .capsule)
            .buttonify {
                print("(DEBUG) Clicked on Trade Now!")
            }
            
    }
    
    @ViewBuilder var convertNowButton: some View {
        switch convert {
        case .idle:
            "Convert".systemHeading2(color: .white).text
                .buttonifyAsync(callBack: convert)
                .padding(.init(vertical: 15, horizontal: 15))
                .background(Color.blue)
                .clipping(to: .capsule)
        case .converting:
            Constants.progressView
        case .converted:
            Constants.img
        }
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack (alignment: .center, spacing: 24){
                Spacer()
                if appState.wallet != nil {
                    SwapInfoCard(value: $amountToConvert, currency: tokenA.name, balance: balance.floatValue, cardType: .from)
                    convertNowButton
                    if convert == .converted {
                        SwapInfoCard(value: .constant(""), currency: tokenB.name, balance: 0, cardType: .to)
                        swapDetails
                        Spacer()
                        tradeButton
                    }
                }
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .task { await onAppear() }
        .padding()
    }
    
    private func onAppear() async {
        guard let web3 = appState.wallet,
                let addressStr = try? web3.getAccounts().first?.address,
                let address = EthereumAddress(addressStr)
        else { return }
        guard let balance = await service.getBalance(for: address) else { return }
        print("(DEBUG) address: \(addressStr) and balance: \(balance)")
        self.balance = balance
    }
    
    private func convert() async {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        withAnimation(.easeInOut) {
            self.convert = .converting
        }
        let convertedUnit = BigUInt("500000000000000000")
        print("(DEBUG) converted Unit: ", convertedUnit)
        
        //let converted = Web3.Utils.parseToBigUInt(amountToConvert, units: .wei)
        let val = await service.getConversion(amount: convertedUnit, tokenA: String.Token.bnb.rawValue, tokenB: String.Token.busd.rawValue)
        print("(DEBUG) Converted Value: ", val)
        withAnimation(.easeInOut) {
            self.convert = .converted
        }
    }

}

extension SwapTokenView {
    enum Constants {
        static let img: some View = {
            return Image(systemName: "arrow.down")
                .resizable()
                .foregroundColor(.white)
                .scale(to: .fit)
                .frame(width: 15, height: 15, alignment: .center)
                .padding(15)
                .background(Color.blue)
                .clipping(to: .circle)
        }()
        
        static let progressView: some View = {
            ProgressView()
                .frame(width: 15, height: 15, alignment: .center)
                .padding(15)
                .background(Color.blue)
                .clipping(to: .circle)
        }()
        
        static let testSwapDetail: [String: String] = [
            "Exchange Rate" : "1 BNB = 1 BUSDT",
            "Network Fees" : "0.00032 NEAR",
            "Price Impact" : "-0.005%",
            "Swapping with" : "Normal AMM",
            "Gas Refund" : "0% Refund"
        ]
    }
}

struct SwapTokenView_Previews: PreviewProvider {
    static var previews: some View {
        SwapTokenView()
    }
}
