//
//  ViewController.swift
//  DaumMapExample
//
//  Created by 이규진 on 2016. 11. 23..
//  Copyright © 2016년 이규진. All rights reserved.
//

import UIKit

class MapViewController: UIViewController, MTMapViewDelegate {

    private let daumAPIKey = "989e84a4ef34f3f5247eab3c943f132d" // replace with your Daum API Key
    //mymapview생성
    lazy var myMapView: MTMapView = MTMapView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height-100))
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = "어디"
        myMapView.daumMapApiKey = daumAPIKey
        myMapView.delegate = self
        myMapView.baseMapType = .standard
        //현위치 트래킹 함수 호출
       
      self.view.insertSubview(myMapView, at: 0)
    }
    
    //현위치 트래킹
    func mapView(_ mapView: MTMapView!, updateCurrentLocation location: MTMapPoint!, withAccuracy accuracy: MTMapLocationAccuracy) {
        var currentLocationPointGeo = location.mapPointGeo
        print("efe\(currentLocationPointGeo().latitude)fef")
        print("efe\(currentLocationPointGeo().longitude)fef")
        
    }
    //    override func viewDidAppear(_ animated: Bool) {
    //        var items = [MTMapPOIItem]()
    ////        items.append(poiItem(name: "하나", latitude: 37.4981688, longitude: 127.0484572))
    ////        items.append(poiItem(name: "둘", latitude: 37.4987963, longitude: 127.0415946))
    ////        items.append(poiItem(name: "셋", latitude: 37.5025612, longitude: 127.0415946))
    ////        items.append(poiItem(name: "넷", latitude: 37.5037539, longitude: 127.0426469))
    ////
    //
    //        mapView.addPOIItems(items)
    //        mapView.fitAreaToShowAllPOIItems()
    //    }
    //
    //    func poiItem(name: String, latitude: Double, longitude: Double) -> MTMapPOIItem {
    //        let item = MTMapPOIItem()
    //        item.itemName = name
    //        item.markerType = .bluePin
    //        item.markerSelectedType = .bluePin
    //        item.mapPoint = MTMapPoint(geoCoord: .init(latitude: latitude, longitude: longitude))
    //        item.showAnimationType = .noAnimation
    //        item.customImageAnchorPointOffset = .init(offsetX: 30, offsetY: 0)
    //
    //        return item
    //    }
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
