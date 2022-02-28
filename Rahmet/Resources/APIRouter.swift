//
//  APIRouter.swift
//  Rahmet
//
//  Created by Elvina Shamoi on 28.02.2022.
//
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    case restaurants
    case menu(id: Int)
    case order(id: Int)
    case orders
    case login(email: String, password: String)
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .restaurants, .menu, .order:
            return .get
        case .orders, .login:
            return .post
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .restaurants:
            return "/restaurants"
        case .menu(let id):
            return "/menu/\(id)"
        case .order(let id):
            return "/order/\(id)"
        case .orders:
            return "/orders"
        case .login:
            return "/login"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .restaurants, .menu, .order, .orders:
            return nil
        case .login(let email, let password):
            return ["something": email, "smth": password]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.baseURL.asURL()
                
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
//        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
//        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
 
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
}
