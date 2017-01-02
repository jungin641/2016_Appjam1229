//
//  ViewController.swift
//  DaumMapExample
//
//  Created by 이규진 on 2016. 11. 23..
//  Copyright © 2016년 이규진. All rights reserved.
//

import UIKit

class MapViewController: UIViewController, MTMapViewDelegate,UISearchBarDelegate{

    private let daumAPIKey = "989e84a4ef34f3f5247eab3c943f132d" // replace with your Daum API Key
    
    //mymapview생성
    lazy var myMapView: MTMapView = MTMapView(frame: CGRect(x: 0, y: 100, width: self.view.frame.size.width, height: self.view.frame.size.height-200))
    let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
    var currentLocationLongtitude : Double?
    var currentLocationLatitude : Double?
    var myPlace : MTMapPOIItem?
    
    var pvc : UIPageViewController?
    
    func tapAction(_ sender: UITapGestureRecognizer) {
        print("아아")
        print(pvc)
        pvc?.view.isUserInteractionEnabled = false
    }
    
    @IBAction func LocateSendBtn(_ sender: AnyObject) {
        print(myPlace?.mapPoint.mapPointGeo().latitude)
        print(myPlace?.mapPoint.mapPointGeo().longitude)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        myMapView.daumMapApiKey = daumAPIKey
        myMapView.delegate = self
        myMapView.baseMapType = .standard
        myMapView.currentLocationTrackingMode = .onWithoutHeading
        
        self.view.insertSubview(myMapView, at: 0)
    }
    
    //현위치 트래킹
    func mapView(_ mapView: MTMapView!, updateCurrentLocation location: MTMapPoint!, withAccuracy accuracy: MTMapLocationAccuracy) {
        mapView.currentLocationTrackingMode = .off
        
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//         self.navigationController?.navigationBar.topItem?.title = "어디"
//        
//        myMapView.daumMapApiKey = daumAPIKey
//        myMapView.delegate = self
//        myMapView.baseMapType = .standard
//        myMapView.currentLocationTrackingMode = .onWithoutHeading
//        pvc = parent?.parent as? UIPageViewController
//        myMapView.addGestureRecognizer(tap)
//        print(myMapView.gestureRecognizers)
//        self.view.insertSubview(myMapView, at: 0)
//    }
//
//    //현위치 트래킹
//    func mapView(_ mapView: MTMapView!, updateCurrentLocation location: MTMapPoint!, withAccuracy accuracy: MTMapLocationAccuracy) {
//        let currentLocationPointGeo = location.mapPointGeo
//        currentLocationLongtitude = currentLocationPointGeo().longitude
//        currentLocationLatitude = currentLocationPointGeo().longitude
//     
//         myPlace = poiItem(name: "둘", latitude: currentLocationLongtitude!, longitude: currentLocationLatitude!)
//           mapView.currentLocationTrackingMode = .off
//
//    }
        override func viewDidAppear(_ animated: Bool) {
            var items = [MTMapPOIItem]()
       
            if let myPlace = myPlace {
                items.append(myPlace)
            }
            
    //        items.append(poiItem(name: "셋", latitude: 37.5025612, longitude: 127.0415946))
    //        items.append(poiItem(name: "넷", latitude: 37.5037539, longitude: 127.0426469))
    //
            myMapView.addPOIItems(items)
            myMapView.fitAreaToShowAllPOIItems()
                    }
    
        func poiItem(name: String, latitude: Double, longitude: Double) -> MTMapPOIItem {
            let item = MTMapPOIItem()
            item.itemName = name
            item.markerType = .redPin
            item.markerSelectedType = .bluePin
            item.mapPoint = MTMapPoint(geoCoord: .init(latitude: latitude, longitude: longitude))
            item.showAnimationType = .noAnimation
            item.draggable = true
            item.customImageAnchorPointOffset = .init(offsetX: 30, offsetY: 0)
    
            return item
        }
    //    func poiItemMypin(name: String, latitude: Double, longitude: Double) -> MTMapPOIItem {
    //
    //        let item = MTMapPOIItem()
    //        item.itemName = name
    //
    //        item.markerType = .redPin
    //        item.markerSelectedType = .redPin
    //        item.draggable = true
    ////        item.mapPoint =
    //        item.showAnimationType = .noAnimation
    //        item.customImageAnchorPointOffset = .init(offsetX: 30, offsetY: 0)
    //        
    //        return item
    //    }
}
