//
//  StopWatchView.swift
//  ConstructionTimer v1
//
//  Created by Satoshi Mitsumori on 2/12/24.
//

import Foundation
import SwiftUI


struct StopWatchView: View {
    var backgroundGradient =  Color(#colorLiteral(red: 0.05786960235, green: 0.03020962386, blue: 0.09482574627, alpha: 1))
    var buttonStyle = ButtonStyleService()
    
    @StateObject var viewModel = TimerViewModel()
    
    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                withAnimation {
                    CircularRing(progress: viewModel.progress)
                        .environmentObject(viewModel)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(backgroundGradient)
        .foregroundColor(Color.white)
    }
    
    
//    var body: some View {
//        ZStack {
//            backgroundGradient
//                .ignoresSafeArea()
//                withAnimation {
//                    CircularRing(progress: viewModel.progress)
//                        .environmentObject(viewModel)
//                        .padding()
//                    
//                }
//            
//            VStack(spacing: 10) {
//                Text("Elapsed Time")
//                    .foregroundStyle(Color.white)
//                    .fontWeight(.semibold)
//                
//                Text("0:00")
//                    .foregroundStyle(Color.white)
//                    .font(.title)
//                
//                Text("Current Time")
//                    .foregroundStyle(Color.white)
//                    .font(.title3)
//                    .fontWeight(.semibold)
//                
//                HStack(spacing: 5) {
//                    Image(systemName: "bell.fill")
//                    Text(Date.now, format: .dateTime.hour().minute())
//                }
//                .foregroundColor(Color.white)
//            }
//            
//            Button(action: {
//                
//            }, label: {
//                buttonStyle.startbutton()
//            })
//            .offset(x: 100, y: 250)
//           
//            Button(action: {
//                
//            }, label: {
//                buttonStyle.cancelbutton()
//            })
//            .offset(x: -100, y: 250)
//    
//            
//        }
//        
//        
//        
//    }
}

struct StopWatchView_Preview: PreviewProvider {
    static var previews: some View {
        StopWatchView()
    }
}
