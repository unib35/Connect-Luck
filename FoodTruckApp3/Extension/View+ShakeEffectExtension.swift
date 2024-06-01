import SwiftUI

extension View {
    func shakeEffect(_ shakes: Int) -> some View {
        self.modifier(ShakeEffect(shakes: shakes))
    }
}

struct ShakeEffect: GeometryEffect {
    var animatableData: CGFloat
    init(shakes: Int) {
        animatableData = CGFloat(shakes)
    }

    func effectValue(size: CGSize) -> ProjectionTransform {
        let translation = sin(animatableData * .pi * 2) * 10
        return ProjectionTransform(CGAffineTransform(translationX: translation, y: 0))
    }
}
