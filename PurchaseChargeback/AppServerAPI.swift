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
    
    typealias RequestCompletion = (AppServerAPI.Result) -> Void
    
    static func get(url: URL, completion: RequestCompletion?) {
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
