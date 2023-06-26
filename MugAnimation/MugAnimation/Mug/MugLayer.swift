import UIKit

enum MugPathFactory {
    static func build() -> UIBezierPath {
        let mugPath = UIBezierPath()
        mugPath.move(to: .init(x: 4, y: 0))
        mugPath.addLine(to: .init(x: MugLayer.widthLayer, y: 0))
        mugPath.addLine(to: .init(x: MugLayer.widthLayer, y: 20))
        mugPath.addQuadCurve(to: .init(x: 38, y: MugLayer.heightLayer),
                             controlPoint: .init(x: MugLayer.widthLayer, y: MugLayer.heightLayer))
        mugPath.addLine(to: .init(x: 25, y: MugLayer.heightLayer))
        mugPath.addQuadCurve(to: .init(x: 0, y: 20),
                             controlPoint: .init(x: 0, y: MugLayer.heightLayer))
        mugPath.addLine(to: .init(x: 0, y: 4))
        mugPath.addQuadCurve(to: .init(x: 4, y: 0),
                             controlPoint: .init(x: 0, y: 0))
        
        return mugPath
    }
}

final class MugLayer: CAShapeLayer {
    static var paddingLayer: CGFloat = 17.5
    static var widthLayer: CGFloat = 56
    static var heightLayer: CGFloat = 41
    
    override init() {
        super.init()
        drawLayer()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    private func drawLayer() {
        path = MugPathFactory
            .build()
            .cgPath
        lineWidth = 5
        fillColor = UIColor.clear.cgColor
        strokeColor = UIColor(rgb: 0x1A93DA).cgColor
    }
}
