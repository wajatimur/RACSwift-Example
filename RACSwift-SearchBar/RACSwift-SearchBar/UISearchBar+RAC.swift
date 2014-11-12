//
//  UISearchBar+RAC.swift
//  RACSwift-SearchBar
//
//  Created by Azri Jamil on 11/12/14.
//  Copyright (c) 2014 Nematix System. All rights reserved.
//

import Foundation



extension UISearchBar: UISearchBarDelegate {
    
    func rac_textSignal() -> RACSignal {
        self.delegate = self
        
        return self.rac_signalForSelector(Selector("searchBar:textDidChange:"), fromProtocol:UISearchBarDelegate.self)
            .map{ (any:AnyObject!) -> AnyObject! in
                let tuple: RACTuple = any as RACTuple
                return tuple.second
            }
    }
}