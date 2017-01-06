//
//  ViewController.swift
//  DaumMapExample
//
//  Created by 이규진 on 2016. 11. 23..
//  Copyright © 2016년 이규진. All rights reserved.
//

import UIKit

class MapViewController: UIViewController, MTMapViewDelegate,UISearchBarDelegate,NetworkCallback {
    var searchedPosition  = [Position]()
    internal func networkResult(resultData: Any, code: Int) {
        searchedPosition = resultData as! [Position]
        
        
        mypoiItem.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(
            latitude: gdno(searchedPosition[0].latitude),
            longitude: gdno(searchedPosition[0].longtitude)))
        
        mypoiItem.itemName = gsno(searchedPosition[0].place)
        mypoiItem.draggable = true
        
        
        mapView.add(mypoiItem)
        
        mapView.currentLocationTrackingMode = .off
        mapView.fitAreaToShowAllPOIItems()

    }
    @IBOutlet var serachBar: UISearchBar!

    var selectedPosition : Position?
    let mypoiItem = MTMapPOIItem()
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBAction func ConfirmBtn(_ sender: AnyObject) {
        
        selectedPosition = Position(
            place: "임시값",
            longtitude: mypoiItem.mapPoint.mapPointGeo().latitude,
            latitude: mypoiItem.mapPoint.mapPointGeo().longitude)
        
    }
    private let daumAPIKey = "989e84a4ef34f3f5247eab3c943f132d" // replace with your Daum API Key
    
    lazy var mapView: MTMapView = MTMapView(frame: CGRect(x: 0, y: 100, width: self.view.frame.size.width, height: self.view.frame.size.height-200))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        serachBar.delegate = self

    
        mapView.daumMapApiKey = daumAPIKey
        mapView.delegate = self
        mapView.baseMapType = .standard
        mapView.showCurrentLocationMarker = false
        mapView.currentLocationTrackingMode = .onWithoutHeading
        
        searchBarSearchButtonClicked(serachBar)
        
       
        
        self.view.insertSubview(mapView, at: 0)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("위치검색하기 : 버튼 눌러짐")
         searchKeyword(searchKeyword: searchBar.text)
    }
    
    func searchKeyword(searchKeyword : String?) {
        print("위치검색하기 : 검색함수 호출됨, daumKeywordSearch호출")
        print("searchKeyword : \(searchKeyword)")
        let model = MapModel(self)
        
        model.daumKeywordSearch(query: searchKeyword)
    }
    //현위치 트래킹
    func mapView(_ mapView: MTMapView!, updateCurrentLocation location: MTMapPoint!, withAccuracy accuracy: MTMapLocationAccuracy) {
        mapView.showCurrentLocationMarker = false
        
        mypoiItem.mapPoint = location
        mypoiItem.itemName = "여기로 지정"
        mypoiItem.draggable = true
        
        
        mapView.add(mypoiItem)
        
        mapView.currentLocationTrackingMode = .off
        mapView.fitAreaToShowAllPOIItems()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
    }
    
    func poiItem(name: String, latitude: Double, longitude: Double) -> MTMapPOIItem {
        let item = MTMapPOIItem()
        item.itemName = name
        item.draggable = true
        item.markerType = .redPin
        item.markerSelectedType = .bluePin
        item.mapPoint = MTMapPoint(geoCoord: .init(latitude: latitude, longitude: longitude))
        item.showAnimationType = .springFromGround
        item.customImageAnchorPointOffset = .init(offsetX: 30, offsetY: 0)
        
        return item
    }
    
}
