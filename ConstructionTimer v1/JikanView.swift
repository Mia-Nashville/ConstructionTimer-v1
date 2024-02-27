//
//  JikanView.swift
//  ConstructionTimer v1
//
//  Created by Satoshi Mitsumori on 2/27/24.
//

import SwiftUI

struct JikanView: View {
    var buttonStyleConfig = ButtonStyleService()
    @StateObject private var viewModel = JikanViewModel()
    var backgroundGradient =  Color(#colorLiteral(red: 0.05786960235, green: 0.03020962386, blue: 0.09482574627, alpha: 1))
    
    
    var body: some View {
        ZStack {
            
            VStack(alignment: .leading, spacing: 5) {
                progressView
                
               timerControl
                
                DropDownList()
                    .padding(.horizontal, 60)
            }
        }
        
    }
    
    @ViewBuilder
    var progressView: some View {
        ZStack {
            withAnimation {
                JikanRing(progress: viewModel.progress)
//                ProgressRing(progress: viewModel.progress)
                    .environmentObject(viewModel)
                    .padding()
            }
            VStack(spacing: 10) {
                
                Text(viewModel.secondsToCompletion.asTimestamps)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                HStack(spacing: 5) {
                    Image(systemName: "bell.fill")
                    Text(viewModel.completionDate, format: .dateTime.hour().minute())
                }
            }
        }
        .frame(width: 360, height: 260)
        .padding(.all, 32)
    }
    
    @ViewBuilder
    var timerControl: some View {
        HStack {
            Button(action: {
                viewModel.timeStates = .cancelled
                
            }, label: {
                buttonStyleConfig.cancelbutton()
            })
            Spacer()
            
            switch viewModel.timeStates {
            case .active:
                Button(action: {
                    viewModel.timeStates = .paused
                }, label: {
                    buttonStyleConfig.pausebutton()
                })
            case .paused:
                Button(action: {
                    viewModel.timeStates = .resumed
                }, label: {
                    buttonStyleConfig.pausebutton()
                })
            case .resumed:
                Button(action: {
                    viewModel.timeStates = .paused
                }, label: {
                    buttonStyleConfig.pausebutton()
                })
            case .cancelled:
                Button(action: {
                    viewModel.timeStates = .active
                }, label: {
                    buttonStyleConfig.startbutton()
                })
            }
        }
        .padding(.leading, 40)
         Spacer()
    }
    
}

struct JikanView_Preview: PreviewProvider {
    static var previews: some View {
        JikanView()
    }
}
