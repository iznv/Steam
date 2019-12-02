import NotificationCenter
import UIKit
import Utils

@objc(TodayViewController)
class TodayViewController: UIViewController {

    private enum Constants {
        
        static let levelViewTop: CGFloat = 15
        
    }
    
    // MARK: - Views

    private let levelView: LevelView = {
        let view = LevelView()
        
        if #available(iOSApplicationExtension 11.0, *) {
            view.textColor = UIColor(named: "Text")
            view.progressForegroundColor = UIColor(named: "Accent")
            view.progressBackgroundColor = UIColor(named: "Background")
        } else {
            view.textColor = UIColor(hex: 0x000000)
            view.progressForegroundColor = UIColor(hex: 0xFFB700)
            view.progressBackgroundColor = UIColor(hex: 0x000000).withAlphaComponent(0.2)
        }
        
        view.isHidden = true
        
        return view
    }()

    // MARK: - Properties

    private let viewModel = TodayViewModel()

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        configureConstraints()

        bind()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.loadLevel()
    }
    
    // MARK: - Subviews
    
    func addViews() {
        view.addSubview(levelView)
    }
    
    // MARK: - Constraints
    
    func configureConstraints() {
        levelView.snp.remakeConstraints { make in
            make.top.equalToSuperview().inset(Constants.levelViewTop)
            make.leading.trailing.equalToSuperview()
        }
    }

}

// MARK: - NCWidgetProviding

extension TodayViewController: NCWidgetProviding {
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        viewModel.loadLevel(completionHandler: completionHandler)
    }
    
}

// MARK: - Binding

private extension TodayViewController {

    func bind() {
        viewModel.didLoadLevel = { [weak self] level in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.levelView.level = level.title
                self.levelView.progressString = level.progressString
                self.levelView.progress = level.progress
                self.levelView.isHidden = false
            }
        }
        
        viewModel.onNoSteamId = { [weak self] in
            self?.levelView.isHidden = true
        }
    }

}
