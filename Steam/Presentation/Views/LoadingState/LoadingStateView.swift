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
    
    // MARK: - Init
    
    override func commonInit() {
        super.commonInit()
        
        enableTheme(for: self)
    }
    
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

// MARK: - Themeable

extension LoadingStateView: Themeable {
    
    func apply(theme: Theme) {
        backgroundColor = theme.primaryBackgroundColor
        activityIndicatorView.style = theme.activityIndicatorStyle
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
