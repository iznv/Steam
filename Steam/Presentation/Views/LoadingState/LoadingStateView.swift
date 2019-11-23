import Utils

class LoadingStateView: BaseView {

    // MARK: - Constants

    private struct Constants {
    

    
    }
    
    // MARK: - Views

    private let activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .gray)
        view.startAnimating()
        return view
    }()
    
    // MARK: - Subviews
    
    override func addViews() {
        addSubview(activityIndicatorView)
    }
    
    // MARK: - Constraints
    
    override func configureConstraints() {
        configureActivityIndicatorConstraints()
    }
    
    // MARK: - Appearance
    
    override func configureAppearance() {
        backgroundColor = .white
    }
    
}

// MARK: - Constraints

private extension LoadingStateView {
    
    func configureActivityIndicatorConstraints() {
        activityIndicatorView.snp.remakeConstraints { make in
            make.center.equalToSuperview()
        }
    }

}
