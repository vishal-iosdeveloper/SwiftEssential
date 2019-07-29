//
//  Constant.swift
//  TestObjC
//
//  Created by Vishal Sharma on 29/07/19.
//  Copyright © 2019 Vishal Sharma. All rights reserved.
//

import Foundation

// API(s)
let base_URL =  "192.168.0.1"
let register_URL = base_URL + "register"

// List of Error code
struct ServerCode {
    static let invalidToken = 106
    static let success = 1
    static let error = 0
}

// Useful con
let SCREEN_Width :CGFloat  = UIScreen.main.bounds.width
let SCREEN_Height :CGFloat = UIScreen.main.bounds.height

// Manage Theme Of app here.
extension UIColor{
    static let fto_Theme_Color = UIColor(red: 49.0/255.0, green: 124.0/255.0, blue: 167.0/255.0, alpha: 1.0)
    static let fto_GrayText_Color = UIColor(red: 110.0/255.0, green: 127.0/255.0, blue: 136.0/255.0, alpha: 1.0)
    static let fto_Header_Color = UIColor(red: 182.0/255.0, green: 190.0/255.0, blue: 194.0/255.0, alpha: 1.0)
}
