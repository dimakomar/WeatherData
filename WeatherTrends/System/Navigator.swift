//
//  Navigator.swift
//  WeatherTrends
//
//  Created by Dima Komar  on 11/30/17.
//  Copyright © 2017 Dima Komar . All rights reserved.
//

import Foundation

protocol Navigator {
    var viewController:UIViewController { get }
    
    func push<VC:UIViewController>(_ viewController:VC)
    func pop<VC:UIViewController>(_ viewController:VC)
    func present<VC:UIViewController>(_ viewController:VC)
}

extension Navigator {
    func push<VC:UIViewController>(_ v:VC) {
        viewController.navigationController?.pushViewController(v, animated: true)
    }
    
    func pop<VC:UIViewController>(_ v:VC) {
        _ = viewController.navigationController?.popToRootViewController(animated: true)
    }
    
    func present<VC:UIViewController>(_ v:VC) {
        DispatchQueue.main.async { self.viewController.navigationController?.present(v, animated: true, completion: nil) }
    }
}
