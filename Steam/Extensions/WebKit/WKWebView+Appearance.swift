//
//  WKWebView+Appearance.swift
//  Steam
//
//  Created by Ivan Zinovyev on 01/12/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import WebKit

private enum Constants {
    
    static let verticalSpacing = "8"
    
}

extension WKWebView {

    static func themeable() -> WKWebView {
        guard var css = "WebViewStyles.css".content,
              var javaScript = "WebViewSetupScript.js".content else {
            return WKWebView()
        }

        let theme = ThemeManager.theme

        css = css
            .replacingOccurrences(of: "#TEXT_COLOR#", with: theme.primaryTextColor.hex)
            .replacingOccurrences(of: "#LINK_COLOR#", with: theme.accentColor.hex)
            .replacingOccurrences(of: "#BACKGROUND_COLOR#", with: theme.primaryBackgroundColor.hex)
            .replacingOccurrences(of: "#HORIZONTAL_MARGIN#", with: String(Int(CGFloat.horizontalMargin)))
            .replacingOccurrences(of: "#VERTICAL_SPACING#", with: Constants.verticalSpacing)
        
        javaScript = javaScript
            .replacingOccurrences(of: "#CSS#", with: css)

        let userScript = WKUserScript(source: javaScript, injectionTime: .atDocumentEnd, forMainFrameOnly: true)

        let userContentController = WKUserContentController()
        userContentController.addUserScript(userScript)

        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentController

        let webView = WKWebView(frame: .zero, configuration: configuration)
        return webView
    }

}

// MARK: - Private

private extension String {

    var content: String? {
        let components = self.components(separatedBy: String.dot)

        guard components.count == 2 else {
            return nil
        }

        let filename = components[0]
        let type = components[1]

        guard let path = Bundle.main.path(forResource: filename, ofType: type),
              let content = try? String(contentsOfFile: path).components(separatedBy: .newlines).joined() else {
            return nil
        }

        return content
    }
}
