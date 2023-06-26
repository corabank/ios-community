import UIKit

class ViewController: UIViewController {
    
    private lazy var bgIcon: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 80
        view.backgroundColor = UIColor(rgb: 0xEAF7FF)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        
        return view
    }()
    
    private lazy var mugView = MugView(timeToFill: 1) {
        print("finish")
    }
    
    // MARK: Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        bgIcon.addSubview(mugView)
        view.addSubview(bgIcon)
        
        NSLayoutConstraint.activate([
            bgIcon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            bgIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bgIcon.widthAnchor.constraint(equalToConstant: 160),
            bgIcon.heightAnchor.constraint(equalToConstant: 160),
            
            mugView.centerXAnchor.constraint(equalTo: bgIcon.centerXAnchor),
            mugView.centerYAnchor.constraint(equalTo: bgIcon.centerYAnchor)
        ])
    }
}
