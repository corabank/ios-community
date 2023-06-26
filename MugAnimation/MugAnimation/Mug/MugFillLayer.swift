import UIKit

final class MugFillLayer: CAShapeLayer {
    static var paddingLayer: CGFloat = 15
    static var widthLayer: CGFloat = 57
    static var heightLayer: CGFloat = 41
    
    private let timeToFill: CGFloat
    private let fillMugLayer = CAShapeLayer()
    
    private weak var animationDelegate: MugAnimationProtocol?
    
    init(timeToFill: CGFloat, delegate: MugAnimationProtocol) {
        self.timeToFill = timeToFill
        animationDelegate = delegate
        
        super.init()
        
        isHidden = true
        drawLayer()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    private func drawLayer() {
        let fillPath = UIBezierPath()
        fillPath.move(to: .init(x: 4, y: 0))
        fillPath.addLine(to: .init(x: MugFillLayer.widthLayer, y: 0))
        fillPath.addLine(to: .init(x: MugFillLayer.widthLayer, y: 20))
        fillPath.addQuadCurve(to: .init(x: 38, y: MugFillLayer.heightLayer),
                              controlPoint: .init(x: MugFillLayer.widthLayer, y: MugFillLayer.heightLayer))
        fillPath.addLine(to: .init(x: 25, y: MugFillLayer.heightLayer))
        fillPath.addQuadCurve(to: .init(x: 0, y: 20),
                              controlPoint: .init(x: 0, y: MugFillLayer.heightLayer))
        fillPath.addLine(to: .init(x: 0, y: 4))
        fillPath.addQuadCurve(to: .init(x: 4, y: 0),
                              controlPoint: .init(x: 0, y: 0))
        
        let mask = CAShapeLayer()
        mask.fillRule = .evenOdd
        mask.path = MugPathFactory
            .build()
            .cgPath
        
        fillMugLayer.path = fillPath.cgPath
        fillMugLayer.fillColor = UIColor(rgb: 0x36B5FF).withAlphaComponent(0.4).cgColor
        fillMugLayer.anchorPoint = .init(x: 0, y: 1)
        fillMugLayer.frame = .init(x: 0,
                                   y: 0,
                                   width: MugFillLayer.widthLayer,
                                   height: MugFillLayer.heightLayer)
        
        frame = .init(x: 0, y: 0, width: MugFillLayer.widthLayer,
                      height: MugFillLayer.heightLayer)
        addSublayer(fillMugLayer)
        self.mask = mask
    }
    
    func addAnimation() {
        isHidden = false
        
        let animation = CABasicAnimation(keyPath: "bounds.size.height")
        animation.fromValue = 0
        animation.toValue = MugFillLayer.heightLayer
        animation.duration = timeToFill
        animation.repeatCount = 0
        animation.delegate = self
        
        fillMugLayer.add(animation, forKey: "fill_cup_animation")
    }
}

extension MugFillLayer: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            animationDelegate?.didFinishMugFillAnimation()
        }
    }
}
