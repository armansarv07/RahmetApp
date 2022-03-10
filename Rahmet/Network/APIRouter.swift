//
//  APIRouter.swift
//  Rahmet
//
//  Created by Elvina Shamoi on 28.02.2022.
//
import Alamofire
import SwiftKeychainWrapper
import Foundation
import SwiftyJSON

enum APIRouter: URLRequestConvertible {
    
    case restaurants
    case menu(id: Int)
    case orders
    case login(email: String, password: String)
    case register(email: String, password: String)
    case logout
    case createOrder(order: OrderInput)
    
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
            return "/orders"
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
        case .createOrder(let order):
            let products = order.products.map({ ["id": $0.id, "quantity": $0.quantity] })
            return ["restaurant_id": order.restaurantID, "products": products]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var url = URL(string: "")
        switch self {
        case .menu, .restaurants, .orders, .createOrder, .logout, .register, .login:
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
        guard var parameters = parameters else {
            return urlRequest
        }
        
        if parameters["restaurant_id"] != nil {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
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
