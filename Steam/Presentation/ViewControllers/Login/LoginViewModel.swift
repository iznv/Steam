import Foundation

class LoginViewModel {
    
    // MARK: - Constants
    
    enum Constants {
        
        static let redirectUrl = "https://Steam/login"
        
        enum Parameter {
            
            static let claimedId = "openid.claimed_id"
            
            static let identity = "openid.identity"
            
            static let mode = "openid.mode"
            
            static let ns = "openid.ns"
            
            static let returnTo = "openid.return_to"
            
        }
        
    }
    
    // MARK: - Properties

    let loginRequest: URLRequest? = {
        let parameters = [
            Constants.Parameter.mode: "checkid_setup",
            Constants.Parameter.ns: "http://specs.openid.net/auth/2.0",
            Constants.Parameter.returnTo: Constants.redirectUrl,
            Constants.Parameter.identity: "http://specs.openid.net/auth/2.0/identifier_select",
            Constants.Parameter.claimedId: "http://specs.openid.net/auth/2.0/identifier_select"
        ]
        
        let queryItems = parameters.map { key, value -> URLQueryItem in
            URLQueryItem(name: key, value: String(describing: value))
        }

        let urlComponents = NSURLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "steamcommunity.com"
        urlComponents.path = "/openid/login"
        urlComponents.queryItems = queryItems

        guard let url = urlComponents.url else { return nil }

        return URLRequest(url: url)
    }()

    // MARK: - Services
    
    private let authService = AuthService()

}

// MARK: - Public

extension LoginViewModel {

    func onLoginSuccess(steamId: String) {
        authService.login(steamId: steamId)
    }

}
