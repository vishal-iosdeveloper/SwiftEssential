//  Created by Vishal Sharma on 03/07/19.
//  Copyright © 2019 Vishal Sharma. All rights reserved.

/*
 pod 'ReachabilitySwift'
 pod 'SVProgressHUD'
 */


import Foundation
import UIKit
import Reachability
import SVProgressHUD

enum Leftmenu: Int {
    // Left menu
    case Leftmenu_Home = 0,
    Leftmenu_Shop
}

class FtoManager: NSObject {
    
    static let sharedManager = FtoManager()
    
    let app_StoryBoard: UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
    
    // Rechability.
    var isInterNet_Available = true;
    var reachability : Reachability!
    
    
    //MARK: Custom properties.
    private override init() {
        super.init()
        
        self.reachability = Reachability()!
        checkInternetConnection();
        configure_ProgressHud();
    }
    
    func checkInternetConnection(){
        
        self.reachability.whenReachable = { reachability in
            self.isInterNet_Available = true
            
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
        }
        self.reachability.whenUnreachable = { _ in
            self.isInterNet_Available = false
            print("Not reachable")
        }
        
        do {
            try self.reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    func configure_ProgressHud(){
        SVProgressHUD.setForegroundColor(.white)
        SVProgressHUD.setBackgroundColor(UIColor.fto_Theme_Color)
        SVProgressHUD.setDefaultMaskType(.clear)
    }
}
