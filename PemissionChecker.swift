//
//  PemissionChecker.swift
//  GoogleMap
//
//  Created by Vishal Sharma on 24/12/19.
//  Copyright © 2019 Vishal Sharma All rights reserved.
//

import UIKit
import AVKit
import Photos

public func checkCameraPermission()   {
  
  let status = AVCaptureDevice.authorizationStatus(for: .video)
  switch status {
  case .notDetermined:
    print("AVCaptureDevice notDetermined")
    
  case .restricted:
    print("AVCaptureDevice restricted")
    
  case .denied:
    print("AVCaptureDevice denied")
    
  case .authorized:
    print("AVCaptureDevice authorized")
    
  @unknown default:
    print("AVCaptureDevice unknown default")
  }
  
}

public func checkPhotoPermission()   {
  /*
   PHPhotoLibrary.requestAuthorization { (statusCode) in
   print("statusCode is : \(statusCode)")
   }
   */
  
  let status = PHPhotoLibrary.authorizationStatus()
  switch status {
  case .notDetermined:
    print("PHPhoto notDetermined")
    
  case .restricted:
    print("PHPhoto restricted")
    
  case .denied:
    print("PHPhoto denied")
    
  case .authorized:
    print("PHPhoto authorized")
    
  @unknown default:
    print("unknown default")
  }
  
}

public func checkLocationPermission() {
  
  let status = CLLocationManager.authorizationStatus()
  switch status {
  case .notDetermined:
    print("CLLocationManager notDetermined")
    
  case .restricted:
    print("CLLocationManager restricted")
    
  case .denied:
    print("CLLocationManager denied")
    
  case .authorizedAlways:
    print("CLLocationManager authorized")
    
  case .authorizedWhenInUse:
    print("CLLocationManager authorized")
    
  @unknown default:
    print("CLLocationManager unknown default")
  }
}

public func checkNotificationPermission() {
  let current = UNUserNotificationCenter.current()
  current.getNotificationSettings(completionHandler: { (settings) in
    if settings.authorizationStatus == .notDetermined {
      print("UserNotification notDetermined")
    } else if settings.authorizationStatus == .denied {
      print("UserNotification denied")
    } else if settings.authorizationStatus == .authorized {
      print("UserNotification aauthorized")
    }
  })
}
