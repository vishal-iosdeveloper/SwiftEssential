//  Created by Vishal Sharma on 18/12/18.
//  Copyright © 2018 Vishal Sharma. All rights reserved.


import Foundation
import UIKit

extension Notification.Name {
    static let changeActiveVC = Notification.Name(
        rawValue: "changeActiveVC")
}

extension UserDefaults {
    enum Keys {
        static let isUserLoggedIn = "isUserLoggedIn"
        static let loginType = "loginType"
        static let user_details = "user_details"
        static let user_reminder_settings = "user_reminder_settings"
        static let available_Links = "available_Links"
        
    }
}

extension UIFont{
    static let fto_Small_Font = UIFont.init(name: "OpenSans", size: 14)
}

extension UITextView {
    
    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }
    
}

extension UIViewController{
    
    class func giveMeTopMostVC() -> UIViewController? {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController;
        }
        return nil
    }
}



