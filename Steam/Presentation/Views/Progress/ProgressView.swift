import Utils

class ProgressView: BaseView {

    // MARK: - Constants

    private struct Constants {
    

    
    }
    
    // MARK: - Views
    
    private let progressView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    // MARK: - Properties

    var progress: CGFloat = 0 {
        didSet {
            updateProgress()
        }
    }
    
    // MARK: - Init
    
    override func commonInit() {
        super.commonInit()
        
        backgroundColor = .darkGray
    }
    
    // MARK: - Subviews
    
    override func addViews() {
        addSubview(progressView)
    }
    
    // MARK: - Overrides
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateProgress()
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
