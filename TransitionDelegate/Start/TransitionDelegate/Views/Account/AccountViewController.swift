import UIKit

private struct Strings {
    static var title = "Account Sample",
               name = "Nome da Conta",
               button = "Fechar"
}

class AccountViewController: UIViewController, ViewProtocol {
    private lazy var labelTitle: UILabel = Label.build(with: .title, alignment: .center)
    private lazy var labelName: UILabel = Label.build(with: .body, alignment: .center)
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle(Strings.button, for: .normal)
        button.addTarget(self, action: #selector(actionButton), for: .touchUpInside)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: Actions
    @objc
    private func actionButton() {
        dismiss(animated: true)
    }
    
    // MARK: ViewProtocol
    func configViews() {
        view.backgroundColor = .white
        
        labelTitle.text = Strings.title
        labelName.text = Strings.name
    }
    
    func buildViews() {
        [labelTitle,
         labelName,
         button].forEach(view.addSubview)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            labelTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            labelTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            labelTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            labelName.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 24),
            labelName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            labelName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
