//
//  Service.swift
//  WeatherTrends
//
//  Created by Dima Komar  on 11/30/17.
//  Copyright © 2017 Dima Komar . All rights reserved.
//

import Foundation

protocol Service: class {
    
    var name: String { get }
    
    var isRunning: Bool { get set }
    
    func start()
    
    func resume()
    
    func pause()
    
    func stop()
}

extension Service {
    var name: String {
        return App.getName(self) ?? "Undefined"
    }
    
    func start() {
        self.isRunning = true
    }
    
    func resume() {
        self.isRunning = true
    }
    
    func pause() {
        self.isRunning = false
    }
    
    func stop() {
        self.isRunning = false
    }
}
