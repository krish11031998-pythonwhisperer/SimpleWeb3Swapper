//
//  SwapInfoCard.swift
//  PopooApp
//
//  Created by Krishna Venkatramani on 16/02/2023.
//

import Foundation
import SwiftUI

fileprivate extension String {
    
    var logoURL: String {
        "https://signal.up.railway.app/tickers/image?query=\(self)"
    }
    
}

struct SwapInfoCard: View {
    
    let currency: String
    @State var value: String = .init("")
    let balance: Float
    let type: CardType
    @State var selectedMax: Bool = false
    
    init(currency: String, balance: Float, cardType: CardType) {
        self.currency = currency
        self.balance = balance
        self.type = cardType
    }
    
    //MARK: - HedaerView
    @ViewBuilder var selectedCurrencyBlob: some View {
        HStack(alignment: .center, spacing: 8) {
            ImageView(url: currency.logoURL)
                .frame(width: 30, height: 30, alignment: .center)
                .clipping(to: .circle)
            
            Text(currency)
                .font(.system(size: 16, weight: .semibold, design: .default))
                
            
            Image(systemName: "chevron.right")
                .resizable()
                .scaledToFit()
                .frame(width: 15, height: 15)
                .foregroundColor(.white)
                .padding(.leading, 2)
        }
        .padding(.init(vertical: 5, horizontal: 7.5))
        .background(Color.blue)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .buttonify()
    }
    
    var headerInfo: some View {
        HStack(alignment: .top, spacing: 10) {
            Text(type == .to ? "To" : "Swap From")
                .font(.system(size: 18, weight: .bold))
            Spacer()
            selectedCurrencyBlob
        }
    }
    
    //MARK: - BalanceView
    var balanceView: some View {
        
        HStack(alignment: .center, spacing: 10) {
            CustomTextField(placeHolder: "Enter Amount", config: .digits, text: $value)
                .keyboardType(.decimalPad)

            Spacer()
            if type == .from {
                Text("Max")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(selectedMax ? .white : .blue)
                    .padding(.init(top: 5, leading: 15, bottom: 5, trailing: 15))
                    .borderCard(borderColor: .blue, radius: 12, borderWidth: 1.5)
            }
        }
        
    }
    
    
    var balanceText: some View {
        Text("Balance: 0.232452352 \(currency)")
            .font(.system(size: 12, weight: .regular))
            .foregroundColor(.gray)
    }
    
    
    //MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            headerInfo
            balanceView.padding(.top, 10)
            balanceText
        }
        .padding(.init(by: 16))
        .borderCard(borderColor: .blue, radius: 16, borderWidth: 1.5)
    }
    
}


struct SwapInfoCard_Previews: PreviewProvider {
    static var previews: some View {
        SwapInfoCard(currency: "BTC", balance: 0.345345, cardType: .from)
            .padding(.all, 15)
    }
}
