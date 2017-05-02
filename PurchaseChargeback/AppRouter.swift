//
//  AppRouter.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/29/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import Foundation
import UIKit

enum RouterResult {
    case success(wireframe: AppPageWireframe.Type, rawPage: [String: AnyObject])
    case error(String?)
}

struct AppRouter {
    
    static let api = AppServerAPI()
    
    private static var routes: [AppPageType: AppPageWireframe.Type] = [
        AppPageType.notice : NoticeWireframe.self,
        AppPageType.chargeback: ChargebackWireframe.self
    ]
    
    static func routePage(ofType pageType: AppPageType, fromURL url: URL, fromViewController: UIViewController, completion: @escaping (_ result: RouterResult) -> Void) {
        self.api.get(url: url) { (result: AppServerAPIResponse) in
            switch result {
            case .failed(_):
                let message = "appapi.error.unknown".localized(comment:  "Ocorreu um erro desconhecido. Por favor, tente novamente.")
                completion(.error(message))
                
            case .success(let object):
                guard let wireframe = self.routes[pageType] else {
                    let message = "appapi.error.pagenotsupported".localized(comment: "A página requisitada não é suportada.")
                    completion(.error(message))
                    return
                }
                completion(RouterResult.success(wireframe: wireframe, rawPage: object))
            }
        }
    }
}
