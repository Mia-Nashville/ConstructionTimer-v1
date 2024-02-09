//
//  CircularRing.swift
//  ConstructionTimer v1
//
//  Created by Satoshi Mitsumori on 2/12/24.
//

import Foundation
import SwiftUI

struct CircularRing: View {
    @EnvironmentObject var timeVM: TimerViewModel
    @State var progress: CGFloat = 0.0
    
    func rotationalCircle() -> some View {
        Circle()
            .stroke(lineWidth: 20)
            .foregroundColor(.gray)
    }
    
    let timer = Timer.publish(every: 1, on: .main, in: .common)
                .autoconnect()
    
    var body: some View {
        ZStack {
            rotationalCircle()
            
            Circle()
                .trim(from: 0.0, to: min(timeVM.progress, 1.0))
                .stroke(AngularGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.4470588235, blue: 0.7137254902, alpha: 1)), Color(#colorLiteral(red: 0.8509803922, green: 0.6862745098, blue: 0.8509803922, alpha: 1)), Color(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)), Color(#colorLiteral(red: 0.5921568627, green: 0.8509803922, blue: 0.8823529412, alpha: 1)), Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))]), center: .center), style: StrokeStyle(lineWidth: 15.0, lineCap: .round, lineJoin: .round))
                .rotationEffect(Angle(degrees: 360))
                .rotationEffect(Angle(degrees: 240))
                .animation(.easeInOut(duration: 1.0), value: timeVM.progress)
            
            Spacer()
            
            VStack(spacing: 10) {
                Text("Elapsed Time")
                    .foregroundStyle(Color.white)
                    .fontWeight(.semibold)
                
             //   Text("0:00")
                Text(timeVM.startTime, style: .timer)
                    .foregroundStyle(Color.white)
                    .font(.title)
                
                Text("Current Time")
                    .foregroundStyle(Color.white)
                    .font(.title3)
                    .fontWeight(.semibold)
                
                HStack(spacing: 5) {
                    Image(systemName: "bell.fill")
                    Text(Date.now, format: .dateTime.hour().minute())
                }
                .foregroundColor(Color.white)
            }
            Spacer()
        }
        .frame(width: 300, height: 300)
        .padding()
    }
}

struct CircularRing_Preview: PreviewProvider {
    static var previews: some View {
        CircularRing().environmentObject(TimerViewModel())
    }
}
