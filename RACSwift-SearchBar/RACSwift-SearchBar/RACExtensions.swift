//
//  RACExtensions.swift
//  RACSwift-SearchBar
//
//  Created by Azri Jamil on 11/12/14.
//  Copyright (c) 2014 Nematix System. All rights reserved.
//

import Foundation


struct RAC  {
    var target : NSObject!
    var keyPath : String!
    var nilValue : AnyObject!
    
    init(_ target: NSObject!, _ keyPath: String, nilValue: AnyObject? = nil) {
        self.target = target
        self.keyPath = keyPath
        self.nilValue = nilValue
    }
    
    func assignSignal(signal : RACSignal) {
        signal.setKeyPath(self.keyPath, onObject: self.target, nilValue: self.nilValue)
    }
}

extension NSObject {
    func RACObserve(target: NSObject!,_ keyPath: String) -> RACSignal{
        return target.rac_valuesForKeyPath(keyPath, observer: self)
    }
}


infix operator <~ {}
infix operator ~> {}

func <~ (rac: RAC, signal: RACSignal) {
    rac.assignSignal(signal)
}

func ~> (signal: RACSignal, rac: RAC) {
    rac.assignSignal(signal)
}