//
//  ContentView.swift
//  ConstructionTimer v1
//
//  Created by Satoshi Mitsumori on 2/9/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedDate = Date()
    let notification = NotificationCenter()
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Button(action: {
                notification.sendNotification(date: Date(), type: "time", timeInterval: 30, title: "Here There", body: "This is a reminder that it works")
            }, label: {
                Text("Send a notification in 5 sec")
            })
            
            DatePicker("Pick a Date", selection: $selectedDate, in: Date()...)
            
            Button(action: {
                notification.sendNotification(date: selectedDate, type: "date", title: "Hello", body: "This is a reminder you set the date")
            }, label: {
                Text("Schedule Notification")
            })
            
            Spacer()
            
            Text("Not Working?")
                .foregroundStyle(.secondary)
                .fontWeight(.semibold)
                .font(.caption)
            
            Button(action: {
                notification.askUserPermission()
            }, label: {
                Text("Request Permissions")
            })
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
