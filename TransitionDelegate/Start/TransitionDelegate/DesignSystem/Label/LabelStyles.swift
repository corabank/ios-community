import UIKit

protocol LabelStyleProtocol {
    static var font: UIFont { get }
    static var color: UIColor { get }
}

extension LabelStyleProtocol {
    static var color: UIColor {
        .gray
    }
}

struct TitleLabel: LabelStyleProtocol {
    static var font: UIFont {
        .systemFont(ofSize: 24, weight: .bold)
    }
    
    static var color: UIColor {
        .black
    }
}

struct SubTitleLabel: LabelStyleProtocol {
    static var font: UIFont {
        .systemFont(ofSize: 18, weight: .bold)
    }
    
    static var color: UIColor {
        .darkGray
    }
}

struct BodyLabel: LabelStyleProtocol {
    static var font: UIFont {
        .systemFont(ofSize: 14, weight: .regular)
    }
    
    static var color: UIColor {
        .black
    }
}

struct CaptionLabel: LabelStyleProtocol {
    static var font: UIFont {
        .systemFont(ofSize: 12, weight: .regular)
    }
}
