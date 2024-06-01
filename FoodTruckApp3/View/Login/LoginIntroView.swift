//
//  LoginIntroView.swift
//  FoodTruckApp3
//
//  Created by 이종민 on 5/24/24.
//

import SwiftUI

struct LoginIntroView: View {
    @State private var isPresentedLoginView : Bool = false
    @State private var isPresentedRegisterView : Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                Text("환영합니다.")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundStyle(.bkText)
                
                Text("여러분이 원하시는 축제와 푸드트럭을 찾아보세요!")
                    .font(.system(size: 12))
                    .foregroundStyle(.grayDeep)
                Spacer()
                
                Button {
                    isPresentedLoginView.toggle()
                } label : {
                    Text("로그인")
                }.buttonStyle(FTAButtonStyle(textColor: Color.bkText))
                Button {
                    isPresentedRegisterView.toggle()
                } label : {
                    Text("회원가입")
                }.buttonStyle(FTAButtonStyle(textColor: Color.bkText))
            }
            .navigationDestination(isPresented: $isPresentedRegisterView) {
                RegisterEmailView()
            }
            .navigationDestination(isPresented: $isPresentedLoginView) {
                LoginView()
            }
        }
    }
}

#Preview {
    LoginIntroView()
}
