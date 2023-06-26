import UIKit

private struct Strings {
    static var navTitle = "Sample",
               title = "Sample App"
}

final class DashViewController: UIViewController, ViewProtocol {
    private lazy var labelTitle: UILabel = Label.build(with: .title, alignment: .center)
    private lazy var cardBalance: UIView = BalanceView()
    private lazy var cardFinanceSummary: UIView = SummaryView()
    
    private lazy var headerView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var contentView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Strings.navTitle
        
        setupViews()
        configNavigationAction()
    }
    
    // MARK: Actions
    @objc
    private func actionAccount() {
        present(AccountViewController(), animated: true)
    }
    
    private func configNavigationAction() {
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "person"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(actionAccount))
        rightBarButton.tintColor = .white
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    // MARK: ViewProtocol
    func configViews() {
        labelTitle.text = Strings.title
        labelTitle.textColor = .white
        
        view.backgroundColor = .darkGray
    }
    
    func buildViews() {
        headerView.addArrangedSubview(labelTitle)
        
        [headerView,
         contentView].forEach(view.addSubview)
        
        [cardBalance,
         cardFinanceSummary].forEach(contentView.addArrangedSubview)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            headerView.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: -24),
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
        ])
    }
}
