//
//  DropDownList.swift
//  ConstructionTimer v1
//
//  Created by Satoshi Mitsumori on 2/27/24.
//

import SwiftUI

struct DropDownList: View {
    var constructionDelay: Array = ["Utility Delay", "GC Site Preparation Delay", "Internal Equipment Delay", "Weather Delay", "Material Delay", "Design, Permit, Contract Delay", "Self Inflicted Delay", "None"]
    
    @State var actualDelay: String = "None"
    var backgroundGradient =  Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
    
    private func subheadlineText(withPlaceholder Placeholder: String) -> some View {
        Text(Placeholder)
            .foregroundStyle(Color.white)
            .font(.title3)
            .fontWeight(.bold)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            subheadlineText(withPlaceholder: "Select Construction Delay")
            
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
        }
        .frame(width: 320, height: 100)
     //   .background(.ultraThickMaterial)
        .background(backgroundGradient)
        .cornerRadius(20)
        Spacer()
    }
}

#Preview {
    DropDownList()
}

struct GradientIconButton: View {
    var icon: String
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)), Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .mask(Image(systemName: icon).font(.system(size: 17)))
            .background(Color(#colorLiteral(red: 0.1019607843, green: 0.07058823529, blue: 0.2431372549, alpha: 0.6004759934)))
            .frame(width: 40, height: 40)
            .mask(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: 12, style: .continuous)
                .stroke(lineWidth: 2)
                .foregroundColor(Color.white)
                .blendMode(.overlay))
    }
}
