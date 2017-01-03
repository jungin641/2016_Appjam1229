//
//  PublicMapVC.swift
//  Huddle
//
//  Created by YuJungin on 2017. 1. 3..
//  Copyright © 2017년 JunginYu. All rights reserved.
//

import UIKit

class PublicMapVC: UIViewController, MTMapViewDelegate {
    private let daumAPIKey = "989e84a4ef34f3f5247eab3c943f132d" // replace with your Daum API Key
    
    var selectedPosition : Position?
    
    @IBOutlet var mapView : MTMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.daumMapApiKey = daumAPIKey
        mapView.delegate = self
        mapView.baseMapType = .standard
     
        self.view.insertSubview(mapView, at: 0)
    }
   

    override func viewDidAppear(_ animated: Bool) {
                var items = [MTMapPOIItem]()
//        
//        let selectedPositionLatitude = selectedPosition?.latitude{
//            selectedPositionLatitude
//        }
//                items.append(poiItem(name: "하나", latitude:  Double(selectedPosition?.latitude), longitude:  Double(selectedPosition?.longtitude)))
//       
                mapView.addPOIItems(items)
                mapView.fitAreaToShowAllPOIItems()
    }
    
    func poiItem(name: String, latitude: Double, longitude: Double) -> MTMapPOIItem {
        let item = MTMapPOIItem()
        item.itemName = name
        item.draggable = false
        item.markerType = .redPin
        item.markerSelectedType = .bluePin
        item.mapPoint = MTMapPoint(geoCoord: .init(latitude: latitude, longitude: longitude))
        item.showAnimationType = .springFromGround
        item.customImageAnchorPointOffset = .init(offsetX: 30, offsetY: 0)
        
        return item
    }
}
