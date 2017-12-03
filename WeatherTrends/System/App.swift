//
//  App.swift
//  WeatherTrends
//
//  Created by Dima Komar  on 11/30/17.
//  Copyright © 2017 Dima Komar . All rights reserved.
//

import Foundation

class App {
    fileprivate static var services: [String: Service] = [:]
    
    class func add(_ service: Service, named name: String) {
        self.services[name] = service
    }
    
    class func remove(_ name: String) {
        if let service = self.get(name) {
            service.stop()
        }
        self.services[name] = nil
    }
    
    class func get(_ name: String) -> Service? {
        return self.services[name]
    }
    
    class func getName(_ service: Service) -> String? {
        for (name, svc) in self.services {
            if Mirror(reflecting: svc).subjectType == Mirror(reflecting: service).subjectType {
                return name
            }
        }
        return nil
    }
    
    class func start() {
        for (_, service) in self.services {
            if !service.isRunning {
                service.start()
            }
        }
    }
    
    class func resume() {
        for (_, service) in self.services {
            if !service.isRunning {
                service.resume()
            }
        }
    }
    
    class func pause() {
        for (_, service) in self.services {
            if !service.isRunning {
                service.pause()
            }
        }
    }
    
    class func stop() {
        for (_, service) in self.services {
            if !service.isRunning {
                service.stop()
            }
        }
    }
    
    class func shutdown() {
        self.stop()
        self.services.removeAll()
    }
}
