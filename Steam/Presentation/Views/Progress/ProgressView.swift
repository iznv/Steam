import Utils

class ProgressView: BaseView {

    // MARK: - Constants

    private struct Constants {
    
        static let cornerRadius: CGFloat = 4
    
    }
    
    // MARK: - Views
    
    private let progressView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Constants.cornerRadius
        return view
    }()
    
    // MARK: - Properties

    var progress: CGFloat = 0 {
        didSet {
            if progress < 0 {
                progress = 0
            }
            
            if progress > 1 {
                progress = 1
            }
            
            updateProgress()
        }
    }
    
    // MARK: - Init
    
    override func commonInit() {
        super.commonInit()
        
        enableTheme(for: self)
    }
    
    // MARK: - Subviews
    
    override func addViews() {
        addSubview(progressView)
    }
    
    // MARK: - Appearance
    
    override func configureAppearance() {
        layer.cornerRadius = Constants.cornerRadius
    }
    
    // MARK: - Overrides
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateProgress()
    }

}

// MARK: - Themeable

extension ProgressView: Themeable {
    
    func apply(theme: Theme) {
        progressView.backgroundColor = theme.accentColor
        backgroundColor = theme.primaryTextColor.withAlphaComponent(0.2)
    }
    
}

// MARK: - Private

private extension ProgressView {
    
    func updateProgress() {
        progressView.frame = CGRect(x: 0,
                                    y: 0,
                                    width: progress * bounds.width,
                                    height: bounds.height)
    }
    
}
