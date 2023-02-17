//
//  PopooAppApp.swift
//  PopooApp
//
//  Created by Krishna Venkatramani on 16/02/2023.
//

import SwiftUI

@main
struct PopooAppApp: App {
    
    @StateObject var appState: AppState = .init()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .ignoresSafeArea(.keyboard)
        }
    }
}
