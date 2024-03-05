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
    
//    @State var delayEncountered: String = ""
//    @State var actualDelay: String = ""
    @State private var isPlaying: Bool = false
 //   @State private var isRecording: Bool = false
    @StateObject var coreDataVM = CoreDataViewModel()
    
    var constructionDelay: Array = ["Utility Delay", "GC Site Preparation Delay", "Internal Equipment Delay", "Weather Delay", "Material Delay", "Design, Permit, Contract Delay", "Self Inflicted Delay", "None"]
    
    @State var delayEncountered: String = "2 hour GC Delay"
    @State var actualDelay: String = "None"
    var backgroundGradientlight =  Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
    @State var textfieldDescription: String = ""
    
    private func subheadlineText(withPlaceholder Placeholder: String) -> some View {
        Text(Placeholder)
            .foregroundStyle(Color.white)
            .font(.title3)
            .fontWeight(.bold)
    }
    
    
    var body: some View {
        ZStack {
            
            VStack(alignment: .leading, spacing: 5) {
                progressView
                    .padding(.top)
                    
               timerControl
           
                // MARK: - DropdownList
                VStack(alignment: .leading) {
                    subheadlineText(withPlaceholder: "Select Construction Delay")
                        .padding(.horizontal, 30)
                    
                    HStack {
                        GradientIconButton(icon: "exclamationmark.triangle.fill")
                            .padding(.horizontal, 5)
                        
                        Picker("Select Delay", selection: $actualDelay) {
                            ForEach(constructionDelay, id: \.self) { delays in
                                Text(delays)
                            }
                            .foregroundColor(.white)
                        }
                        .pickerStyle(.menu)
                        .font(.headline)
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom)
                    
                    HStack(spacing: 5) {
                        TextEditor(text: $delayEncountered)
                            .modifier(TextFieldClearButton(nextText: $delayEncountered))
                            .modifier(ChangeSmallerFrameSize())
                    }
                    .font(.headline)
                }
                .frame(width: 370, height: 220)
             //   .background(.ultraThickMaterial)
                .background(backgroundGradientlight)
                .cornerRadius(20)
                .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 4)
          
         //       DropDownList()
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
                isPlaying.toggle()
                
                let dateNow = Date()
                let dtFormatter = DateFormatter()
                dtFormatter.dateStyle = .full
                dtFormatter.timeStyle = .full
                
                let formattedDateTime = dtFormatter.string(from: dateNow)
                
                isPlaying ? coreDataVM.addDelayTime(topic: actualDelay, delay: delayEncountered,start: formattedDateTime) : coreDataVM.endDelayTime(endTime: formattedDateTime)
                
                viewModel.timeStates = isPlaying ? .active : .cancelled
            }, label: {
                buttonStyleConfig.recordButton2(color: isPlaying ? .red : .indigo, text: isPlaying ? "Stop Record": "Record")
            })
            .onTapGesture {
                withAnimation(Animation.spring()) {
                    self.isPlaying.toggle()
                  
                }
               
            }
            .padding(.horizontal, 20)
            Spacer()
            // Multi-state button in swiftui
            
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
            case .record:
                Button(action: {
                    viewModel.timeStates = .record
                }, label: {
                    buttonStyleConfig.recordbutton()
                })
            case .stoprecording:
                Button(action: {
                    viewModel.timeStates = .stoprecording
                }, label: {
                    buttonStyleConfig.stopRecording()
                })
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
