import StatefulViewController
import Utils
import WebKit

class WebViewViewController: BaseViewController<WebViewViewModel> {
    
    // MARK: - Views

    private lazy var webView: WKWebView = {
        let webView = WKWebView.themeable()
        webView.isOpaque = false
        webView.scrollView.delegate = self
        webView.navigationDelegate = self
        return webView
    }()

    // MARK: - Properties
    
    private lazy var stateMachine = ViewStateMachine(view: view, defaultStatesDelegate: self)

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enableTheme(for: view)
        
        navigationItem.title = viewModel.title
        
        loadContents()
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

// MARK: - DefaultStatesDelegate

extension WebViewViewController: DefaultStatesDelegate {
    
    func didTapRetry(view: CustomStateView) {
        loadContents()
    }
    
}

// MARK: - Themeable

extension WebViewViewController: Themeable {
    
    func apply(theme: Theme) {
        view.backgroundColor = theme.primaryBackgroundColor
        webView.backgroundColor = theme.primaryBackgroundColor
        webView.scrollView.backgroundColor = theme.primaryBackgroundColor
        webView.evaluateAppearanceScript()
    }
    
}

// MARK: - UIScrollViewDelegate

extension WebViewViewController: UIScrollViewDelegate {

    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        scrollView.pinchGestureRecognizer?.isEnabled = false
    }
}

// MARK: - WKNavigationDelegate

extension WebViewViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void) {

        if navigationAction.navigationType == .linkActivated {
            if let url = navigationAction.request.url, UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }

            decisionHandler(.cancel)
            return
        }

        guard navigationAction.navigationType == .other else {
            decisionHandler(.cancel)
            return
        }

        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView,
                 didFailProvisionalNavigation navigation: WKNavigation!,
                 withError error: Error) {
        
        stateMachine.transition(to: ViewState.somethingWrong)
    }

    func webView(_ webView: WKWebView,
                 didFinish navigation: WKNavigation) {
        
        webView.evaluateAppearanceScript()
        stateMachine.transition(to: .none)
    }

}

// MARK: - Constraints

private extension WebViewViewController {

    func configureWebViewConstraints() {
        webView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}

// MARK: - Private

private extension WebViewViewController {

    func loadContents() {
        stateMachine.transition(to: ViewState.loading) { [weak self] in
            guard let self = self else { return }
            self.webView.loadHTMLString(self.viewModel.contents, baseURL: Bundle.main.bundleURL)
        }
    }

}
