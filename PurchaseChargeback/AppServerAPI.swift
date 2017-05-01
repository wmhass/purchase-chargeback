//
//  AppServerAPI.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/29/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import Foundation
import Alamofire

struct AppServerAPI {
    
    
    
    static let domain = "https://nu-mobile-hiring.herokuapp.com"
    
    typealias RequestCompletion = (AppServerAPI.Result) -> Void
    
    static func url(forResource resource: AppServerAPI.Resource) -> URL? {
        return URL(string: AppServerAPI.domain + "/" + resource.rawValue)
    }
    
    static func get(url: URL, completion: RequestCompletion?) {
        AppServerAPI.request(url: url, completion: completion)
    }
    
    static func get(resource: AppServerAPI.Resource, completion: RequestCompletion?) {
        AppServerAPI.request(resource, method: .get, parameters: nil, completion: completion)
    }
    
    static func request(_ resource: AppServerAPI.Resource, method: HTTPMethod = .get, parameters: Parameters? = nil, completion: RequestCompletion?) {
        guard let url = self.url(forResource: resource) else {
            let message = "appapi.error.unknown".localized(comment: "Ocorreu um erro desconhecido. Por favor, tente novamente.")
            completion?(Result.failed(message))
            return
        }
        AppServerAPI.request(url: url, completion: completion)
    }
    
    static func request(url: URL, method: HTTPMethod = .get, parameters: Parameters? = nil, completion: RequestCompletion?) {
        Alamofire.request(url, method: method, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response: DataResponse<Any>) in
            guard let json = response.result.value as? [String: AnyObject] else {
                let message = "appapi.error.decode".localized(comment: "Ocorreu um erro ao ler a resposta do serivdor. Por favor, tente novamente.")
                completion?(AppServerAPI.Result.failed(message))
                return
            }
            completion?(AppServerAPI.Result.success(json))
        }
    }
}

extension AppServerAPI {
    enum Resource: String {
        case notice
    }
    
    enum Result {
        case success([String: AnyObject])
        case failed(String?)
    }
}
