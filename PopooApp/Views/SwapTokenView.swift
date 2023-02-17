//
//  ContentView.swift
//  PopooApp
//
//  Created by Krishna Venkatramani on 16/02/2023.
//

import SwiftUI
import BigInt
import Web3Core

extension BigUInt {
    var floatValue: Float {
        let double = Double(self)/pow(10, 9)
        return Float(double)
    }
}

struct SwapTokenView: View {
    
    @EnvironmentObject var appState: AppState
    private let service: Web3ServiceInterface
    @State var balance: BigUInt = .zero
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
    
    var body: some View {
        VStack (alignment: .center, spacing: 24){
            Spacer()
            if appState.wallet != nil {
                // Convert the BigUInt value to a Double
                SwapInfoCard(currency: "BNB", balance: balance.floatValue, cardType: .from)
                Constants.img
                SwapInfoCard(currency: "ETH", balance: 2.23, cardType: .to)
                swapDetails
                Spacer()
                tradeButton
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
        
        static let testSwapDetail: [String: String] = [
            "Exchange Rate" : "1 USDT = 2.92 BNB",
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
