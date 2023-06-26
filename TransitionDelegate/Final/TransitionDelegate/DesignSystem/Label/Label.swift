import UIKit

private var styles: [Label.Style: LabelStyleProtocol.Type] = [
    .title: TitleLabel.self,
    .subtitle: SubTitleLabel.self,
    .body: BodyLabel.self,
    .caption: CaptionLabel.self
]

enum Label {
    static func build(with style: Label.Style, alignment: NSTextAlignment = .left) -> UILabel {
        let style = styles[style]
        
        let label = UILabel()
        label.font = style?.font
        label.textColor = style?.color
        label.numberOfLines = 0
        label.textAlignment = alignment
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
}

extension Label {
    enum Style {
        case title, subtitle, body, caption
    }
}
