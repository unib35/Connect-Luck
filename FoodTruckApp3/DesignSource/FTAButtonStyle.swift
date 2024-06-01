//
//  FTAButtonStyle.swift
//  FoodTruckApp3
//
//  Created by 이종민 on 5/28/24.
//

import SwiftUI

struct FTAButtonStyle : ButtonStyle {
    let textColor: Color
        let borderColor: Color
        
        init(textColor: Color, borderColor: Color? = nil) {
            self.textColor = textColor
            self.borderColor = borderColor ?? textColor
        }
        
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .font(.system(size: 14))
                .foregroundColor(textColor)
                .frame(maxWidth: .infinity, maxHeight: 40)
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(borderColor, lineWidth: 0.8)
                }
                .padding(.horizontal, 15)
                .opacity(configuration.isPressed ? 0.5 : 1)
        }
}
