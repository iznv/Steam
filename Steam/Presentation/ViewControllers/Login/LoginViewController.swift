import Utils
import WebKit

class LoginViewController: BaseViewController<LoginViewModel> {

    // MARK: - Views

    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.navigationDelegate = self
        return webView
    }()
    
    // MARK: - Properties
    
    private let redirectUrl = LoginViewModel.Constants.redirectUrl.lowercased()
    
    // MARK: - Output
    
    var didLogin: (() -> Void)?

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = R.string.localizable.login()

        if let request = viewModel.loginRequest {
            webView.load(request)
        }
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
