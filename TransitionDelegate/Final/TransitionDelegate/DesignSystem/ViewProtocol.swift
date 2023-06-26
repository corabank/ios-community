import Foundation

protocol ViewProtocol {
    func configViews()
    func buildViews()
    func setupConstraints()
    
    func setupViews()
}

extension ViewProtocol {
    func setupViews() {
        configViews()
        buildViews()
        setupConstraints()
    }
    
    func setupConstraints() {}
}
