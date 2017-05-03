//
//  AppServerAPI.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/29/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import Foundation
import Alamofire


enum RouterResult {
    case success(wireframeType: AppPageWireframe.Type, rawPage: [String: AnyObject])
    case error(String?)
}


enum AppServerAPIResponse {
    case success([String: AnyObject])
    case failed(String?)
}

protocol AppServerAPIProtocol {
    typealias RequestCompletion = (AppServerAPIResponse) -> Void
    func get(url: URL, completion: RequestCompletion?)
    func post(url: URL, object: [String: AnyObject]?, completion: RequestCompletion?)
    func routeLink(appLink: AppApiLink, completion: @escaping (_ result: RouterResult) -> Void)
}

struct AppServerAPI {
    
    static var routes: [AppPageType: AppPageWireframe.Type] = [
        AppPageType.notice : NoticeWireframe.self,
        AppPageType.chargeback: ChargebackWireframe.self
    ]
    
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
    
    func routeLink(appLink: AppApiLink, completion: @escaping (_ result: RouterResult) -> Void) {
        guard let pageType = AppPageType(rawValue: appLink.name), let wireframe = AppServerAPI.routes[pageType] else {
            let message = "appapi.error.pagenotsupported".localized(comment: "A página requisitada não é suportada.")
            completion(.error(message))
            return
        }
        
        self.get(url: appLink.url) { (result: AppServerAPIResponse) in
            switch result {
            case .failed(_):
                let message = "appapi.error.unknown".localized(comment:  "Ocorreu um erro desconhecido. Por favor, tente novamente.")
                completion(.error(message))
                
            case .success(let object):
                completion(RouterResult.success(wireframeType: wireframe, rawPage: object))
            }
        }
    }
}
