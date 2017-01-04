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
       // items.append(poiItem(name: "넷", latitude: 37.5037539, longitude: 127.0426469))
        
        //샘플 데이터
        selectedPosition = Position(place: "여기", longtitude: "127.0426469", latitude: "37.5037539")
        self.view.insertSubview(mapView, at: 0)
    }
   

    override func viewDidAppear(_ animated: Bool) {
        var items = [MTMapPOIItem]()
        items.append(poiItem(name: "넷", latitude: 37.5027529, longitude: 127.0436479))
        print(items[0].mapPoint.mapPointGeo().longitude)
        print(items[0].mapPoint.mapPointGeo().latitude)
        if let mySelectedPosition = selectedPosition{
            items.append(
                poiItem(
                    //gdno extensionControl에 추가!
                    name: gsno(mySelectedPosition.place),
                    latitude:  gdno(Double(gsno(mySelectedPosition.latitude))),
                    longitude:  gdno(Double(gsno(mySelectedPosition.longtitude)))
            ))
            print(items[1].mapPoint.mapPointGeo().longitude)
            print(items[1].mapPoint.mapPointGeo().latitude)
            var doubledata = gdno(Double(gsno(mySelectedPosition.latitude)))
            print("gdnodoubledata : \(doubledata)")
        }
        
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
        item.showAnimationType = .noAnimation
        item.customImageAnchorPointOffset = .init(offsetX: 30, offsetY: 0)
        
        return item
    }
}