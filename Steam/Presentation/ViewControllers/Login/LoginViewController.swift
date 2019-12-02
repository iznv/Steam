import StatefulViewController
import Utils
import WebKit

class LoginViewController: BaseViewController<LoginViewModel> {

    // MARK: - Views

    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.isOpaque = false
        webView.navigationDelegate = self
        return webView
    }()
    
    // MARK: - Properties
    
    private lazy var stateMachine = ViewStateMachine(view: view, defaultStatesDelegate: nil)
    
    private let redirectUrl = LoginViewModel.Constants.redirectUrl.lowercased()
    
    // MARK: - Output
    
    var didLogin: (() -> Void)?

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enableTheme(for: view)
        
        navigationItem.title = R.string.localizable.login()

        load()
    }
    
    // MARK: - Subviews
    
    override func addViews() {
        view.addSubview(webView)
    }
    
    // MARK: - Constraints
    
    override func configureConstraints() {
        configureWebViewConstraints()
    }

}

// MARK: - Themeable

extension LoginViewController: Themeable {
    
    func apply(theme: Theme) {
        view.backgroundColor = theme.primaryBackgroundColor
        webView.backgroundColor = theme.primaryBackgroundColor
        webView.scrollView.backgroundColor = theme.primaryBackgroundColor
    }
    
}

// MARK: - WKNavigationDelegate

extension LoginViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        guard let url = navigationAction.request.url else {
            decisionHandler(.allow)
            return
        }

        if url.absoluteString.starts(with: redirectUrl) {
            handleLoginRedirect(url: url)
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
    
    func webView(_ webView: WKWebView,
                 didFinish navigation: WKNavigation) {
        
        stateMachine.transition(to: .none)
    }
    
}

// MARK: - Constraints

private extension LoginViewController {

    func configureWebViewConstraints() {
        webView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}

// MARK: - Private

private extension LoginViewController {
    
    func load() {
        stateMachine.transition(to: ViewState.loading) { [weak self] in
            guard let self = self else { return }
            if let request = self.viewModel.loginRequest {
                self.webView.load(request)
            }
        }
    }
    
    func handleLoginRedirect(url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return }
        
        guard let claimedId = components
            .queryItems?
            .first(where: { $0.name == LoginViewModel.Constants.Parameter.claimedId })?
            .value else { return }
        
        guard let steamId = URL(string: claimedId)?.lastPathComponent else { return }
        
        viewModel.onLoginSuccess(steamId: steamId)
        
        didLogin?()
    }

}
