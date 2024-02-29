//
//  CustomTextFieldButton.swift
//  ConstructionTimer v1
//
//  Created by Satoshi Mitsumori on 2/29/24.
//

import Foundation
import SwiftUI


struct CustomTextFieldButton: View {
    @State var nameofText: String
    @State var emailOf: String
    @State var imageofButton: String
    
    var body: some View {
        VStack {
            TextField("Enter Project Name", text: $nameofText)
                .textFieldStyle(GradientTextFieldBackground(systemImageString: imageofButton))
        }
    }
}

#Preview {
    CustomTextFieldButton(nameofText: "Enter Project Name", emailOf: "email", imageofButton: "target")
}

struct GradientTextFieldBackground: TextFieldStyle {
    
    let systemImageString: String
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)
                .stroke(
                    LinearGradient(
                        colors: [.gray,.gray],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(width: 350, height: 60)
                .background(.ultraThickMaterial)
                .cornerRadius(10)
                .shadow(radius: 2)
            
            HStack {
                Image(systemName: systemImageString)
                    .font(.headline)
                // Reference the TextField here
                configuration
            }
            .padding(.leading)
            .padding(.horizontal, 10)
            .foregroundColor(Color.blue).opacity(0.9)
        }
    }
}

struct GradientTextFieldBackgroundDark: TextFieldStyle {
    let systemImageString: String
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)
                .stroke(
                    LinearGradient(
                        colors: [
                            .gray,
                            .gray
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(width: 340, height: 55)
                .background(.ultraThickMaterial).opacity(0.7)
                .cornerRadius(10)
                .shadow(radius: 0)
            
            
            HStack {
                Image(systemName: systemImageString)
                    .font(.headline)
                // Reference the TextField here
                configuration
            }
            .padding(.leading)
            .padding(.horizontal, 20)
            .foregroundColor(Color.indigo)
        }
    }
}


