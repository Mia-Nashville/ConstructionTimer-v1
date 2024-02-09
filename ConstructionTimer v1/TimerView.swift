//
//  TimerView.swift
//  ConstructionTimer v1
//
//  Created by Satoshi Mitsumori on 2/9/24.
//

import SwiftUI

struct TimerView: View {
    var buttonStyleConfig = ButtonStyleService()
    @StateObject private var viewModel = TimerViewModel()
    
    var body: some View {
        VStack(spacing: 10) {
            if viewModel.timeState == .cancelled {
                timePickerControl
            } else {
                progressView
            }
            timerControl
           Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .foregroundColor(.white)
    }

    
    @ViewBuilder
    var progressView: some View {
        ZStack {
            withAnimation {
                ProgressRing(progress: viewModel.progress)
                    .environmentObject(viewModel)
                    .padding()
            }
            
            VStack(spacing: 5) {
                
                Text(viewModel.secondsToCompletion.asTimestamp)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                HStack(spacing: 5) {
                    Image(systemName: "bell.fill")
                    Text(viewModel.completionDate, format: .dateTime.hour().minute())
                }
            }
        }
        .frame(width: 360, height: 250)
        .padding(.all, 32)
    }
    
    @ViewBuilder
    
    var timePickerControl: some View {
        VStack(spacing: 10) {
            HStack(spacing: 5) {
                TimePickerView(title: "hours", range: viewModel.hoursRange, binding: $viewModel.selectedHoursAmount)
                
                TimePickerView(title: "min", range: viewModel.minutesRange, binding: $viewModel.selectedMinutesAmount)
                
                TimePickerView(title: "sec", range: viewModel.secondsRange, binding: $viewModel.selectedSecoundsAmount)
           
            }
            .frame(width: 360, height: 255)
            .padding(.all, 32)
        }
    }
    
    @ViewBuilder
    var timerControl: some View {
        HStack {
            Button(action: {
                viewModel.timeState = .cancelled
                
            }, label: {
                buttonStyleConfig.cancelbutton()
            })
            Spacer()
            
            switch viewModel.timeState {
            case .active:
                Button(action: {
                    viewModel.timeState = .paused
                }, label: {
                    buttonStyleConfig.pausebutton()
                })
            case .paused:
                Button(action: {
                    viewModel.timeState = .resumed
                }, label: {
                    buttonStyleConfig.pausebutton()
                })
            case .resumed:
                Button(action: {
                    viewModel.timeState = .paused
                }, label: {
                    buttonStyleConfig.pausebutton()
                })
            case .cancelled:
                Button(action: {
                    viewModel.timeState = .active
                }, label: {
                    buttonStyleConfig.startbutton()
                })
            }
        }
            .padding(.horizontal, 30)
    }
}

struct TimerView_Preview: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}


