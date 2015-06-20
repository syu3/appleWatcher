//
//  registerViewController.swift
//  appleWatcher
//
//  Created by 加藤健一 on 2015/06/20.
//  Copyright (c) 2015年 加藤健一. All rights reserved.
//

import UIKit

class registerViewController: UIViewController , CLLocationManagerDelegate{
    var parseNumber = 0
    var myLocationManager:CLLocationManager!
    var number = 0
    var info = [PFObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 現在地の取得.
        myLocationManager = CLLocationManager()
        
        NSLog("前")
        
        myLocationManager.delegate = self
        // セキュリティ認証のステータスを取得.
        let status = CLLocationManager.authorizationStatus()
        
        
        // 取得精度の設定.
        myLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        // 取得頻度の設定.
        myLocationManager.distanceFilter = 100
        NSLog("後")
        self.loadData { (objects, error) -> () in
            for object in objects {
                self.info.append(object as PFObject)
                
            }
            self.parseNumber = self.info.last?.objectForKey("number") as Int
        }
        
    }
    
    
    func loadData(callback:([PFObject]!, NSError!) -> ())  {
        var query: PFQuery = PFQuery(className: "Address")
        
        query.orderByAscending("createdAt")
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
            if (error != nil){
                // エラー処理
                //alertを出す。
                
            }
            callback(objects as [PFObject], error)
        }
    }
    
    
    
    @IBAction func have(){
        
        
        
        
        number = 0
        number++
        
        myLocationManager.startUpdatingLocation()
        
    }
    
    
    
    
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        
        println("didChangeAuthorizationStatus");
        
        // 認証のステータスをログで表示.
        var statusStr = "";
        switch (status) {
        case .NotDetermined:
            statusStr = "NotDetermined"
        case .Restricted:
            statusStr = "Restricted"
        case .Denied:
            statusStr = "Denied"
        case .AuthorizedAlways:
            statusStr = "AuthorizedAlways"
        case .AuthorizedWhenInUse:
            statusStr = "AuthorizedWhenInUse"
        }
        println(" CLAuthorizationStatus: \(statusStr)")
    }
    
    
    // 位置情報取得に成功したときに呼び出されるデリゲート.
    func locationManager(manager: CLLocationManager!,didUpdateLocations locations: [AnyObject]!){
        if(number == 1){
            parseNumber = parseNumber + 1
            NSLog("hello")
            
            var object: PFObject = PFObject(className: "Address")
            object["lat"] = (manager.location.coordinate.latitude)
            object["lon"] = (manager.location.coordinate.longitude)
            object["number"] = parseNumber
            
            object.saveInBackgroundWithBlock { (succeeded, error) -> Void in
                
            }
            
        }else{
            
        }
        
        //        // 緯度・経度の表示.
        //        myLatitudeLabel.text = "緯度：\(manager.location.coordinate.latitude)"
        //        myLatitudeLabel.textAlignment = NSTextAlignment.Center
        //
        //        myLongitudeLabel.text = "経度：\(manager.location.coordinate.longitude)"
        //        myLongitudeLabel.textAlignment = NSTextAlignment.Center
        //
        //
        //        self.view.addSubview(myLatitudeLabel)
        //        self.view.addSubview(myLongitudeLabel)
        
    }
    
    // 位置情報取得に失敗した時に呼び出されるデリゲート.
    func locationManager(manager: CLLocationManager!,didFailWithError error: NSError!){
        print("error")
    }
    
    
}
