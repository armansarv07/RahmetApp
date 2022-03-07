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
        case .orders, .login, .register, .logout, .createOrder:
            url = try Constants.oldURL.asURL()
        case .menu, .restaurants:
            url = try Constants.baseURL.asURL()
        }
//        let url = try Constants.baseURL.asURL()
        var urlRequest = URLRequest(url: url!.appendingPathComponent(path))
//        var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xNDIuOTMuMTA3LjIzOFwvYXBpXC9sb2dpbiIsImlhdCI6MTY0NjEyNTYxNCwiZXhwIjoxNjQ2MTI5MjE0LCJuYmYiOjE2NDYxMjU2MTQsImp0aSI6IkJiQ3BXOXZIbEVSak81UWQiLCJzdWIiOjUsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.zmNT8rVGjqLbBV0Uol7yzj-mhXzbznOzYPiWfcXQVSg"
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
//        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        urlRequest.addValue("Bearer \(String(describing: Constants.accessToken))", forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        // Parameters
        guard let parameters = parameters, let array = parameters["arrayParametersKey"] else {
            return urlRequest
        }
        do {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: array, options: [])
        } catch {
            throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
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
