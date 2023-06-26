import UIKit

protocol MugAnimationProtocol: AnyObject {
    func didFinishMugFillAnimation()
    func didFinishSmokeAnimation()
}

final class MugView: UIView {
    private lazy var smokeLayers = [SmokeLayer(delegate: self),
                                    SmokeLayer(delegate: self),
                                    SmokeLayer(delegate: self)]
    private lazy var mugLayer = MugLayer()
    private lazy var mugFillLayer = MugFillLayer(timeToFill: timeToFill, delegate: self)
    private lazy var mugHandleLayer = MugHandleLayer()
    
    private let timeToFill: CGFloat
    private var smokeFinishAnimatinsCount = 0
    
    private let hasFinishTransition: () -> Void
    
    init(timeToFill: CGFloat, hasFinishTransition: @escaping () -> Void) {
        self.timeToFill = timeToFill
        self.hasFinishTransition = hasFinishTransition
        
        super.init(frame: .zero)
        
        configViews()
        buildViews()
        setupConstraints()
        startIntroAnimation()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    func startIntroAnimation() {
        transform = CGAffineTransform(rotationAngle: -.pi)
        frame = frame.offsetBy(dx: -180, dy: 9)
            
        UIView.animate(withDuration: 0.8,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 2,
                       animations: { [unowned self] in
            self.transform = .identity
            self.frame = self.frame.offsetBy(dx: 180, dy: 0)
        }) { [weak self] _ in
            self?.startFillAnimation()
        }
    }
    
    func configViews() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func buildViews() {
        smokeLayers.enumerated().forEach { [unowned self] (index, layer) in
            let positionX =  SmokeLayer.paddingLayer * CGFloat(index) + SmokeLayer.widthLayer
            layer.frame = layer.frame.offsetBy(dx: positionX,
                                               dy: 0)
            
            self.layer.addSublayer(layer)
        }
        
        mugLayer.frame = mugLayer.frame.offsetBy(dx: 2.5,
                                                 dy: SmokeLayer.heightLayer + MugLayer.paddingLayer)
        mugFillLayer.frame = mugFillLayer.frame.offsetBy(dx: 2.5,
                                                         dy: SmokeLayer.heightLayer + MugLayer.paddingLayer)
        mugHandleLayer.frame = mugHandleLayer.frame.offsetBy(dx: 2.5,
                                                             dy: SmokeLayer.heightLayer + MugLayer.paddingLayer)
        
        layer.addSublayer(mugFillLayer)
        layer.addSublayer(mugHandleLayer)
        layer.addSublayer(mugLayer)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 75),
            heightAnchor.constraint(equalToConstant: 75)
        ])
    }
    
    private func startFillAnimation() {
        mugFillLayer.addAnimation()
    }
    
    private func startSmokeAnimation() {
        smokeLayers[0].addAnimation(after: 0.5)
        smokeLayers[1].addAnimation(after: 0)
        smokeLayers[2].addAnimation(after: 1)
    }
}

extension MugView: MugAnimationProtocol {
    func didFinishMugFillAnimation() {
        startSmokeAnimation()
    }
    
    func didFinishSmokeAnimation() {
        smokeFinishAnimatinsCount += 1
        
        if smokeFinishAnimatinsCount == 3 {
            smokeLayers.forEach {
                $0.removeAllAnimations()
            }
            
            hasFinishTransition()
        }
    }
}
