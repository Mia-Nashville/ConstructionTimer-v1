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
    @Environment(\.scenePhase) var scenePhase
    
    var backgroundGradient =  Color(#colorLiteral(red: 0.05786960235, green: 0.03020962386, blue: 0.09482574627, alpha: 1))
    let notification = NotificationCenter()
    
    var body: some View {
        ZStack {
            
            VStack(alignment: .leading, spacing: 5) {
                progressView
                    .padding(.top)
                    
               timerControl
                
                DropDownList()
                    .padding(.horizontal, 12)
                Spacer()
            }
         
            .onChange(of: scenePhase) { newPhase in
                viewModel.onChangeofScenePhase(newPhase)
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
            }
            VStack(spacing: 5) {
                
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
        .padding()
    }
    
    @ViewBuilder
    var timerControl: some View {
        HStack {
            Button(action: {
                viewModel.timeStates = .cancelled
                
            }, label: {
                buttonStyleConfig.cancelbutton()
            })
            
            Button(action: {
                // add viewModel here
          
            }, label: {
                buttonStyleConfig.recordbutton()
            })
            .padding(.horizontal, 20)
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
                    
                    notification.sendNotification(date: Date(), type: "time", timeInterval: 30, title: "Time Interval", body: "This is a reminder that your time has passed the requested time")
                }, label: {
                    buttonStyleConfig.startbutton()
                })
//            case .record:
//                Button(action: {
//                    viewModel.timeStates = .paused
//                }, label: {
//                    buttonStyleConfig.recordbutton()
//                })
            }
        }
        .padding()
         
    }
    
}

struct JikanView_Preview: PreviewProvider {
    static var previews: some View {
        JikanView()
    }
}
