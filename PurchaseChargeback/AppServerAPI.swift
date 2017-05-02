//
//  AppServerAPI.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/29/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import Foundation
import Alamofire


enum AppServerAPIResponse {
    case success([String: AnyObject])
    case failed(String?)
}

protocol AppServerAPIProtocol {
    typealias RequestCompletion = (AppServerAPIResponse) -> Void
    func get(url: URL, completion: RequestCompletion?)
    func post(url: URL, object: [String: AnyObject]?, completion: RequestCompletion?)
}

struct AppServerAPI {
    
    func request(url: URL, method: HTTPMethod, parameters: [String: AnyObject]?, completion: AppServerAPIProtocol.RequestCompletion?) {
        Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response: DataResponse<Any>) in
            guard let json = response.result.value as? [String: AnyObject] else {
                let message = "appapi.error.decode".localized(comment: "Ocorreu um erro ao ler a resposta do serivdor. Por favor, tente novamente.")
                completion?(AppServerAPIResponse.failed(message))
                return
            }
            completion?(AppServerAPIResponse.success(json))
        }
    }
}

// MARK: - AppServerAPIProtocol
extension AppServerAPI: AppServerAPIProtocol {
    func post(url: URL, object: [String: AnyObject]?, completion: AppServerAPIProtocol.RequestCompletion?) {
        self.request(url: url, method: .post, parameters: object, completion: completion)
    }

    func get(url: URL, completion: AppServerAPIProtocol.RequestCompletion?) {
        self.request(url: url, method: .get, parameters: nil, completion: completion)
    }
}
