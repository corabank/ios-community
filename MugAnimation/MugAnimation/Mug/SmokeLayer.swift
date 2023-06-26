import UIKit

final class SmokeLayer: CAShapeLayer {
    static var paddingLayer: CGFloat = 15
    static var widthLayer: CGFloat = 10
    static var heightLayer: CGFloat = 16
    static var lineWidthLayer: CGFloat = 5
    
    private weak var animationDelegate: MugAnimationProtocol?
    
    init(delegate: MugAnimationProtocol? = nil) {
        animationDelegate = delegate
        
        super.init()
        
        isHidden = true
        drawLayer()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    private func drawLayer() {
        let rect = CGRect(x: SmokeLayer.lineWidthLayer / 2,
                          y: 0,
                          width: SmokeLayer.widthLayer,
                          height: SmokeLayer.heightLayer)
        
        let path = UIBezierPath()
        let center: CGPoint = CGPoint(x: rect.midX,
                                      y: rect.maxY - SmokeLayer.widthLayer)
        path.move(to: CGPoint(x: center.x, y: center.y))
        path.addCurve(to: CGPoint(x: rect.midX, y: rect.maxY + SmokeLayer.widthLayer),
                      controlPoint1: CGPoint(x: rect.midX + SmokeLayer.widthLayer, y: rect.maxY),
                      controlPoint2: CGPoint(x: rect.midX - SmokeLayer.widthLayer, y: rect.maxY))
        
        self.path = path.cgPath
        lineWidth = SmokeLayer.lineWidthLayer
        lineCap = .round
        fillColor = UIColor.clear.cgColor
        strokeColor = UIColor(rgb: 0x1A93DA).cgColor
    }
    
    func addAnimation(after time: Double) {
        isHidden = false
        
        let startAnimation = CABasicAnimation(keyPath: "strokeStart")
        startAnimation.fromValue = 1
        startAnimation.toValue = 0
        startAnimation.duration = 1
        startAnimation.fillMode = .backwards
        startAnimation.beginTime = TimeInterval(time)
        
        let endAnimation = CABasicAnimation(keyPath: "strokeEnd")
        endAnimation.fromValue = 1
        endAnimation.toValue = -1
        endAnimation.fillMode = .forwards
        endAnimation.beginTime = 1 + TimeInterval(time)
        
        let smokeAnimation = CAAnimationGroup()
        smokeAnimation.animations = [startAnimation, endAnimation]
        smokeAnimation.duration = 3
        smokeAnimation.repeatCount = 0
        smokeAnimation.delegate = self
        smokeAnimation.isRemovedOnCompletion = true
        
        add(smokeAnimation, forKey: "smoke_animation")
    }
}

extension SmokeLayer: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            isHidden = true
            animationDelegate?.didFinishSmokeAnimation()
        }
    }
}
