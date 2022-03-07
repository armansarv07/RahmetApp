//
//  APIClient.swift
//  Rahmet
//
//  Created by Elvina Shamoi on 28.02.2022.
//

import Alamofire

class APIClient {
    
    @discardableResult
        private static func performRequest<T:Decodable>(route:APIRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (AFResult<T>)->Void) -> DataRequest {
            return AF.request(route)
                            .responseDecodable (decoder: decoder){ (response: AFDataResponse<T>) in
                                completion(response.result)
            }
        }

    static func login(email: String, password: String, completion:@escaping (AFResult<LoginResponse>)->Void) {
        performRequest(route: APIRouter.login(email: email, password: password), completion: completion)
    }
    
    static func register(email: String, password: String, completion:@escaping (AFResult<Response>)->Void) {
        performRequest(route: APIRouter.register(email: email, password: password), completion: completion)
    }
    
    static func logout(completion:@escaping (AFResult<Response>) -> Void) {
        performRequest(route: APIRouter.logout, completion: completion)
    }
    
    static func getOrders(completion: @escaping (AFResult<OrderByID>) -> Void) {
        performRequest(route: APIRouter.orders, completion: completion)
    }

    static func postOrder(order: OrderInput, completion:@escaping (AFResult<Response>) -> Void) {
        guard let id = order.restaurantID, let products = order.products else { return }
        
        performRequest(route: APIRouter.createOrder(restaurantID: id, products: products), completion: completion)
    }
    
}
