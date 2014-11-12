//
//  UISearchDisplayController+RAC.swift
//  RACSwift-SearchBar
//
//  Created by Azri Jamil on 11/12/14.
//  Copyright (c) 2014 Nematix System. All rights reserved.
//

import Foundation


extension UISearchDisplayController: UISearchDisplayDelegate {
    
    func rac_ActiveSignal() -> RACSignal {
        self.delegate = self
        
        let didBeginEditing: RACSignal = self
            .rac_signalForSelector(Selector("searchDisplayControllerDidBeginSearch:"), fromProtocol:UISearchDisplayDelegate.self)
            .map{ _ in true }
        
        let didEndEditing: RACSignal = self
            .rac_signalForSelector(Selector("searchDisplayControllerDidEndSearch:"), fromProtocol:UISearchDisplayDelegate.self)
            .map{ _ in false }
        
        return RACSignal.merge([didBeginEditing,didEndEditing])
    }
    
}