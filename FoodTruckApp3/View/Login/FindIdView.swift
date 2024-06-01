//
//  FindIdView.swift
//  FoodTruckApp3
//
//  Created by 이종민 on 5/25/24.
//

import SwiftUI

struct FindIdView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Text("FindId View")
        NavigationStack {
            
        }.navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label : {
                        Image(systemName: "chevron.backward")
                            .bold()
                            .foregroundColor(Color.bkText)
                    }
                }
            }
    }
}

#Preview {
    FindIdView()
}
