//
//  AddWallet.swift
//  PopooApp
//
//  Created by Krishna Venkatramani on 17/02/2023.
//

import Foundation
import SwiftUI

struct AddWalletView: View {
    @EnvironmentObject var appState: AppState
    @State private var password: String = .init("PerivaThunai23$")
    @State private var privateKey: String = .init("f2ea933e2adf9d6192ac14dead4ae35f7eeea2e2368bd0a395eba1970ee54035")
    private let service: Web3ServiceInterface
    @Binding private var showSwapPage: Bool
    
    init(showSwapPage: Binding<Bool>,
         service: Web3ServiceInterface = Web3Service()) {
        self._showSwapPage = showSwapPage
        self.service = service
    }
    
    
    private func textField(text: String, for binding: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(text)
                .font(.caption)
            CustomTextField(placeHolder: text, isSecure: true, text: binding)
        }
    }
    
    private var connectButton: some View {
        Text("Connect")
            .font(.system(.body, weight: .semibold))
            .foregroundColor(.white)
            .padding(.init(vertical: 15, horizontal: 10))
            .frame(maxWidth: .infinity, alignment: .center)
            .background(Color.blue)
            .clipping(to: .capsule)
            .buttonifyAsync {
                appState.wallet = await service.connectWallet(privateKey: privateKey, password: password)
                if appState.wallet != nil {
                    showSwapPage = true
                }
            }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("Enter your wallet details")
                .font(.system(.largeTitle, design: .default, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
            textField(text: "Private Key", for: $privateKey)
            textField(text: "Password", for: $password)
            connectButton
            Spacer()
        }
        .task { await service.connect() }
        .padding(15)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        
    }
    
}


struct AddWalletView_Previews: PreviewProvider {
    static var previews: some View {
        AddWalletView(showSwapPage: .constant(false))
    }
}
