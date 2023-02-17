//
//  ContentView.swift
//  PopooApp
//
//  Created by Krishna Venkatramani on 17/02/2023.
//

import Foundation
import SwiftUI
import Combine


struct ContentView: View {
    
    @EnvironmentObject var appState: AppState
    @State var showSwapPage: Bool = false
    
    var body: some View {
        NavigationStack {
            AddWalletView(showSwapPage: $showSwapPage)
                .navigationDestination(isPresented: $showSwapPage) {
                    SwapTokenView()
                }
        }
    }
    
}
