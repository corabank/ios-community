import UIKit

final class MugHandleLayer: CAShapeLayer {
    static var widthLayer: CGFloat = MugLayer.widthLayer
    static var heightLayer: CGFloat = 16
    
    override init() {
        super.init()
        drawLayer()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    private func drawLayer() {
        let handlePath = UIBezierPath()
        handlePath.addArc(withCenter: .init(x: MugHandleLayer.widthLayer,
                                            y: MugHandleLayer.heightLayer),
                          radius: MugHandleLayer.heightLayer,
                          startAngle: (3 * .pi) / 2,
                          endAngle: (.pi / 2) - 0.01,
                          clockwise: true)
        
        
        path = handlePath.cgPath
        lineWidth = 5
        fillColor = UIColor.clear.cgColor
        strokeColor = UIColor(rgb: 0x1A93DA).cgColor
    }
}
