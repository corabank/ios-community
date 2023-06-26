import UIKit

private struct Strings {
    static var title = "Últimos lançamentos",
               marketTitle = "🛒 Mercado",
               marketValue = "R$ 200,00",
               moveTitle = "🎥 Cinema",
               moveValue = "R$ 80,00",
               mallTitle = "🏬 Shopping",
               mallValue = "R$ 250,00",
               travelTitle = "✈️ Viagem",
               travelValue = "R$ 550,00"
}

final class SummaryView: UIView, ViewProtocol {
    private lazy var labelTitle: UILabel = Label.build(with: .subtitle)
    
    private lazy var content: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var items: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
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
    }
    
    func buildViews() {
        addSubview(content)
        
        [labelTitle,
         items].forEach(content.addArrangedSubview)
        
        [Item(title: Strings.marketTitle, value: Strings.marketValue),
         Item(title: Strings.moveTitle, value: Strings.moveValue),
         Item(title: Strings.mallTitle, value: Strings.mallValue),
         Item(title: Strings.travelTitle, value: Strings.travelValue)].forEach(items.addArrangedSubview)
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

private final class Item: UIStackView, ViewProtocol {
    private lazy var labelTitle: UILabel = Label.build(with: .body)
    private lazy var labelSubtitle: UILabel = Label.build(with: .body, alignment: .right)
    
    private let title: String,
                value: String
    
    // MARK: Initialization
    init(title: String, value: String) {
        self.title = title
        self.value = value
        
        super.init(frame: .zero)
        
        setupViews()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) { fatalError() }
    
    // MARK: ViewProtocol
    func configViews() {
        axis = .horizontal
        spacing = 16
        translatesAutoresizingMaskIntoConstraints = false
        
        labelTitle.text = title
        labelSubtitle.text = value
        
        labelSubtitle.textColor = .gray
    }
    
    func buildViews() {
        [labelTitle, labelSubtitle].forEach(addArrangedSubview)
    }
}
