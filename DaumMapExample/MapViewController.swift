//
//  ViewController.swift
//  DaumMapExample
//
//  Created by 이규진 on 2016. 11. 23..
//  Copyright © 2016년 이규진. All rights reserved.
//

import UIKit

class MapViewController: UIViewController, MTMapViewDelegate,UISearchBarDelegate {
    var selectedPosition = Position(place: "", longtitude: "37.4981688", latitude: "127.0484572")
    @IBAction func ConfirmBtn(_ sender: AnyObject) {
        
        //GatheringVO객체에 추가
//        if let parentVC = self.parent as? MakeGatheringVC {
//            let newGathering = parentVC.newGathering
//            newGathering.setPosision(position: Position(place: "", longtitude: "37.4981688", latitude: "127.0484572"))
//        }
        
    }
    private let daumAPIKey = "989e84a4ef34f3f5247eab3c943f132d" // replace with your Daum API Key
    
    lazy var mapView: MTMapView = MTMapView(frame: CGRect(x: 0, y: 100, width: self.view.frame.size.width, height: self.view.frame.size.height-200))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.daumMapApiKey = daumAPIKey
        mapView.delegate = self
        mapView.baseMapType = .standard
        mapView.showCurrentLocationMarker = false
        mapView.currentLocationTrackingMode = .onWithoutHeading
        self.view.insertSubview(mapView, at: 0)
    }
    
    //현위치 트래킹
    func mapView(_ mapView: MTMapView!, updateCurrentLocation location: MTMapPoint!, withAccuracy accuracy: MTMapLocationAccuracy) {
        mapView.showCurrentLocationMarker = false
        let poiItem = MTMapPOIItem()
        poiItem.mapPoint = location
        mapView.add(poiItem)
                mapView.currentLocationTrackingMode = .off
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //        var items = [MTMapPOIItem]()
        //        items.append(poiItem(name: "하나", latitude: 37.4981688, longitude: 127.0484572))
        //
        //        mapView.addPOIItems(items)
        //        mapView.fitAreaToShowAllPOIItems()
    }
    
    func poiItem(name: String, latitude: Double, longitude: Double) -> MTMapPOIItem {
        let item = MTMapPOIItem()
        item.itemName = name
        item.draggable = true
        item.markerType = .redPin
        item.markerSelectedType = .bluePin
        item.mapPoint = MTMapPoint(geoCoord: .init(latitude: latitude, longitude: longitude))
        item.showAnimationType = .noAnimation
        item.customImageAnchorPointOffset = .init(offsetX: 30, offsetY: 0)
        
        return item
    }
    
}
