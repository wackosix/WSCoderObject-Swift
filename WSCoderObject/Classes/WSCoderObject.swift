//
//  WSCoderObject.swift
//  WSCoderObject
//
//  Created by OneZens on 16/1/25.
//  Copyright © 2016年 www.onezen.cc. All rights reserved.
//

import UIKit

class WSCoderObject: NSObject, NSCoding {
 
    //归档
    func encode(with aCoder: NSCoder) {
        
        var count: UInt32 = 0
        
        let ivars = class_copyIvarList(self.classForCoder, &count)
        
        for i in 0..<count {
            
            let ivar = ivars?[Int(i)]
            let name = String.init(cString: ivar_getName(ivar), encoding: .utf8)
            if let varName = name {
                aCoder.encode(value(forKey: varName), forKey: varName)
            }
        }
        
        free(ivars)
        
    }
    
    //解档
    required init?(coder aDecoder: NSCoder) {
     
        super.init()
        
        var count: UInt32 = 0
        
        let ivars = class_copyIvarList(self.classForCoder, &count)
        
        for i in 0..<count {
            
            let ivar = ivars?[Int(i)]
            let name = String.init(cString: ivar_getName(ivar), encoding: .utf8)
            if let varName = name {
                setValue(aDecoder.decodeObject(forKey: varName), forKey: varName)
            }
        }
        
        free(ivars)
    }
    
    override init() {
        super.init()
    }

}
