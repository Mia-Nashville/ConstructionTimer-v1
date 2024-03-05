//
//  ConstructionTimer_v1App.swift
//  ConstructionTimer v1
//
//  Created by Satoshi Mitsumori on 2/9/24.
//

import SwiftUI

@main
struct ConstructionTimer_v1App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
         //   ContentView()
        
        //    TimerView()
           JikanView()
             //   .environmentObject(JikanViewModel())
        }
    }
}
