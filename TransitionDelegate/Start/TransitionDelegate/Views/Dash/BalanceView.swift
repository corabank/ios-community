import UIKit

private struct Strings {
    static var title = "💰 Saldo da Conta",
               subtitle = "R$ 13.000.000,00"
}

final class BalanceView: UIView, ViewProtocol {
    private lazy var labelTitle: UILabel = Label.build(with: .title)
    private lazy var labelSubtitle: UILabel = Label.build(with: .subtitle)
    
    private lazy var content: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    // MARK: Initialization
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    // MARK: ViewProtocol
    func configViews() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        
        labelTitle.text = Strings.title
        labelSubtitle.text = Strings.subtitle
    }
    
    func buildViews() {
        addSubview(content)
        
        [labelTitle,
         labelSubtitle].forEach(content.addArrangedSubview)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: topAnchor,constant: 16),
            content.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -16),
            content.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 24),
            content.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -24)
        ])
    }
}
