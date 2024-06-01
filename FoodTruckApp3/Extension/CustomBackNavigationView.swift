import SwiftUI

struct CustomBackNavigationView: ViewModifier {
    @Environment(\.dismiss) var dismiss
    var backButtonColor: Color
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.backward")
                            .bold()
                            .foregroundColor(backButtonColor)
                    }
                }
            }
    }
}

extension View {
    func customNavigation(backButtonColor: Color = .primary) -> some View {
        self.modifier(CustomBackNavigationView(backButtonColor: backButtonColor))
    }
}
