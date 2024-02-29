//
//  TextFrameViewModifiers.swift
//  ConstructionTimer v1
//
//  Created by Satoshi Mitsumori on 2/29/24.
//

import Foundation
import SwiftUI

struct ChangeFrameSize: ViewModifier {
    func body(content: Content) -> some View {
        content
        
            .frame(width: 370, height: 80, alignment: .leading)
            .background(RoundedRectangle(cornerRadius: 20).stroke(Color(UIColor.systemGray2)))
            .background(.ultraThickMaterial).opacity(0.8)
            .foregroundColor(Color.black)
            .cornerRadius(20)
            .padding(.horizontal, 30)
            .shadow(radius: 5, x:5, y: 10)
    }
}

struct ChangeSmallerFrameSize: ViewModifier {
    func body(content: Content) -> some View {
        content
        
            .frame(width: 350, height: 80, alignment: .leading)
            .background(RoundedRectangle(cornerRadius: 20).stroke(Color(UIColor.systemGray2)))
            .background(.ultraThickMaterial).opacity(0.8)
            .foregroundColor(Color.black)
            .cornerRadius(20)
            .padding(.horizontal, 30)
            .shadow(radius: 5, x:5, y: 10)
    }
}

    struct fontModifier: ViewModifier {
        func body(content: Content) -> some View {
            content
                .padding(.vertical, 10)
                .padding(.horizontal, 5)
                .padding(.leading, 2)
                .foregroundColor(Color.white)
                .font(.headline)
            
        }
    }

struct TextFieldClearButton: ViewModifier {
    @Binding var nextText: String
    
    func body(content: Content) -> some View {
        HStack {
            content
            
            if !nextText.isEmpty {
                Button(action: {self.nextText = ""}, label: {
                    Image(systemName: "delete.left.fill")
                        .font(.system(size: 18))
                        .foregroundColor(Color.gray)
                })
            }
        }
    }
}



