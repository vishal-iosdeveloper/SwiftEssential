//
//  UCUtil.swift
//  Doxbay
//
//  Created by Vishal Sharma on 03/07/19.
//  Copyright © 2019 Vishal Sharma. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ReqManager: NSObject {
    
    class func requestGETURL(_ strURL: String, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
        Alamofire.request(strURL).responseJSON { (responseObject) -> Void in
            
            print(responseObject)
            
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }
    
    
    class func requestPOSTURLWithFormData(_ strURL : String, params : [String : String]?, headers : [String : String]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void){
        
        let headers: HTTPHeaders = [
            //            "Content-type": "multipart/form-data"
            "Content-type": "application/x-www-form-urlencoded"
        ]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in params! {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                
            }
            
        }, usingThreshold: UInt64.init(), to: strURL, method: .post, headers: headers) { (result) in
            
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    
                    print("Succesfully uploaded")
                    print(response.result)
                    
                    if response.result.isSuccess {
                        let resJson = JSON(response.result.value!)
                        success(resJson)
                    }
                    if response.result.isFailure {
                        let error : Error = response.result.error!
                        failure(error)
                    }
                    
                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
                failure(error)
            }
        }
    }
    
    
    class func requestuploadImages(_ strURL : String, params : [String : Any]?, imageArray : [Any]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void){
        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data"
        ]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in params! {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            
            if(imageArray!.count > 0)
            {
                
                for img in imageArray!
                {
                    let data =  (img as? UIImage)?.jpegData(compressionQuality: 0.5)
                    if (data != nil)
                    {
                        multipartFormData.append(data!, withName:"avatar", fileName: "avatar.png", mimeType: "image/png")
                    }
                }
            }
            
        }, usingThreshold: UInt64.init(), to: strURL, method: .post, headers: headers) { (result) in
            
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    
                    print("Succesfully uploaded")
                    print(response.result)
                    
                    if response.result.isSuccess {
                        let resJson = JSON(response.result.value!)
                        success(resJson)
                    }
                    if response.result.isFailure {
                        let error : Error = response.result.error!
                        failure(error)
                    }
                    
                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
                failure(error)
            }
        }
    }
    
}


class TestController: UIViewController {
    
    func testPOSAPI(){
        
        let get_Que_parameters = ["api_token" : FtoManager.provideMe_Fto_UserToken()];
        SVProgressHUD.show()
        ReqManager.requestPOSTURLWithFormData(todayQue_URL, params: get_Que_parameters, headers: nil, success: {(response) -> Void in
            print("response is : \(response)")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.0001) {
                SVProgressHUD.dismiss()
            }
            
            switch response["status"].intValue{
            case 0:
                print("Status 0")
            case 1:
                print("Status 1")
            default:
                print("default")
            }
            
        }, failure:  {
            (error) -> Void in
            print("error===\(error)")
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.0001) {
                SVProgressHUD.dismiss()
            }
            
        })
    }
    
    func uploadUserImage(withImage userAvatarImage:UIImage){
        
        let upload_Image_parameters = ["api_token" : FtoManager.provideMe_Fto_UserToken()];
        
        print("========================= API CALlED =========================")
        print("Request URL- \(editUserImage_URL)\nParam --- \(upload_Image_parameters)")
        
        if(FtoManager.sharedManager.isInterNet_Available == false){
            self.view.makeToast(NSLocalizedString("no_Internet_msg", comment: ""))
            return;
        }
        
        SVProgressHUD.show()
        ReqManager.requestuploadImages(editUserImage_URL, params: upload_Image_parameters, imageArray: [userAvatarImage], success: {(response) -> Void in
            print("response is : \(response)")
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.0001) {
                SVProgressHUD.dismiss()
            }
            
            switch response["status"].intValue{
            case 0:
                print("Status 0")
            case 1:
                print("Status 1")
            default:
                print("default")
            }
            
        }, failure:  {
            (error) -> Void in
            print("error===\(error)")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.0001) {
                SVProgressHUD.dismiss()
            }
        })
    }
    
    
}


