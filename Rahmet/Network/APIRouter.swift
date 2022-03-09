//
//  APIRouter.swift
//  Rahmet
//
//  Created by Elvina Shamoi on 28.02.2022.
//
import Alamofire
import SwiftKeychainWrapper
import Foundation

enum APIRouter: URLRequestConvertible {
    
    case restaurants
    case menu(id: Int)
    case orders
    case login(email: String, password: String)
    case register(email: String, password: String)
    case logout
    case createOrder(restaurantID: Int, products: [OrderCreateProduct])
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .restaurants, .menu, .orders:
            return .get
        case .login, .register, .logout, .createOrder:
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
        case .orders:
            return "/orders"
        case .login:
            return "/login"
        case .register:
            return "/register"
        case .logout:
            return "/logout"
        case .createOrder:
            return "/orders/create"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .restaurants, .menu, .orders, .logout:
            return nil
        case .login(let email, let password), .register(let email, let password):
            print(["email": email, "password": password])
            return ["email": email, "password": password]
        case .createOrder(let restaurantID, let products):
            return ["restaurant_id": restaurantID, "products": products]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var url = URL(string: "")
        switch self {
        case .orders, .createOrder, .logout, .register, .login:
            url = try Constants.oldURL.asURL()
        case .menu, .restaurants:
            url = try Constants.baseURL.asURL()
        }
        var urlRequest = URLRequest(url: url!.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        if let token = Constants.accessToken {
            urlRequest.addValue("Bearer " + token, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        }
        // Parameters
        guard let parameters = parameters else {
            return urlRequest
        }

        if let array = parameters["arrayParametersKey"] {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: array, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        } else {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        return urlRequest
    }
}

extension Array {
    /// Convert the receiver array to a `Parameters` object.
    func asParameters() -> Parameters {
        return ["arrayParametersKey": self]
    }
}
