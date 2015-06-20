//
//  mapViewViewController.swift
//  appleWatcher
//
//  Created by 加藤健一 on 2015/06/20.
//  Copyright (c) 2015年 加藤健一. All rights reserved.
//

import UIKit
import MapKit
class mapViewViewController: UIViewController,MKMapViewDelegate {
    @IBOutlet var mapView : MKMapView!
    var parseNumber = 0
    var lat : CLLocationDegrees = 0
    var lon : CLLocationDegrees = 0
    var info = [PFObject]()
    var timer : NSTimer!
    var junban = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        junban == 0
        self.loadData { (objects, error) -> () in
            for object in objects {
                self.info.append(object as PFObject)
                
            }
            self.parseNumber = self.info.first?.objectForKey("number") as Int
            
            
            
            
            self.timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "timer:", userInfo: nil, repeats: true)
            
            
            
            
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
    
    func timer(timer : NSTimer){
        var parseLastNumber = self.info.last?.objectForKey("number") as Int
        if (junban == parseNumber){
            timer.invalidate()
        }
        junban = self.parseNumber - 1
                    self.lat = self.info[junban].objectForKey("lat") as CLLocationDegrees
                    self.lon = self.info[junban].objectForKey("lon") as CLLocationDegrees
      //------------------------------------------------------------------------
        // 経度、緯度.
        
        var myLatitude: CLLocationDegrees = lat
        var myLongitude: CLLocationDegrees = lon
        
        // 中心点.
        let center: CLLocationCoordinate2D = CLLocationCoordinate2DMake(myLatitude, myLongitude)
     
        

        
        // ピンを生成.
        var myPin: MKPointAnnotation = MKPointAnnotation()
        
        // 座標を設定.
        myPin.coordinate = center
        
        var num = junban + 1
        
        // タイトルを設定.
        myPin.title = String(format: "%d人目の登録者です",num)

        
        // MapViewにピンを追加.
        mapView.addAnnotation(myPin)
        //------------------------------------------------------------------------

    }
    
    
    
        @IBAction func  small(){
            // 経度、緯度.
            let myLatitude: CLLocationDegrees = 35.681382
            let myLongitude: CLLocationDegrees = 139.766084
            
            // 中心点.
            let center: CLLocationCoordinate2D = CLLocationCoordinate2DMake(myLatitude, myLongitude)
            
            // MapViewに中心点を設定.
            mapView.setCenterCoordinate(center, animated: true)
            
            // 縮尺.
            // 表示領域.
            let mySpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 3, longitudeDelta: 3)
            let myRegion: MKCoordinateRegion = MKCoordinateRegionMake(center, mySpan)
            
            // MapViewにregionを追加.
            mapView.region = myRegion
        }
        
        @IBAction func big(){
            // 経度、緯度.
            let myLatitude: CLLocationDegrees = 35.681382
            let myLongitude: CLLocationDegrees = 139.766084
            
            // 中心点.
            let center: CLLocationCoordinate2D = CLLocationCoordinate2DMake(myLatitude, myLongitude)
            
            // MapViewに中心点を設定.
            mapView.setCenterCoordinate(center, animated: true)
            
            // 縮尺.
            // 表示領域.
            let mySpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 20, longitudeDelta: 20)
            let myRegion: MKCoordinateRegion = MKCoordinateRegionMake(center, mySpan)
            
            // MapViewにregionを追加.
            mapView.region = myRegion
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        
        /*
        // MARK: - Navigation
        
        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        }
        */
        
}
