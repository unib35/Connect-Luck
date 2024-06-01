//
//  LoginButtonStyle.swift
//  FoodTruckApp3
//
//  Created by 이종민 on 5/25/24.
//

import SwiftUI


struct FTAToggleButtonStyle: ButtonStyle {
    
    private var isEnabled : Bool = false
    
    init(_ isEnabled: Bool) {
        self.isEnabled = isEnabled
    }
    
    func makeBody(configuration: Configuration) -> some View {
        
        switch isEnabled {
        case true: //활성화
            return AnyView(configuration.label
                .font(.system(size: 14))
                .foregroundColor(Color.wh)
                .frame(maxWidth: .infinity, maxHeight: 40)
                .background(Color.bkText)
                .cornerRadius(5.0)
//                .overlay {
//                    RoundedRectangle(cornerRadius: 5)
//                        .stroke(lineWidth: 1)
//                }
                
            ).opacity(configuration.isPressed ? 0.5 : 1)
            
        case false: //비활성화
            return AnyView(configuration.label
                .font(.system(size: 14))
                .foregroundColor(Color.wh)
                .frame(maxWidth: .infinity, maxHeight: 40)
                .background(Color.gray2)
                .cornerRadius(5.0)

                
                
            ).opacity(configuration.isPressed ? 0.5 : 1)
            
        }
    }
}
