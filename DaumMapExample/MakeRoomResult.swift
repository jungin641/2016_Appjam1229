//
//  makeRoomResult.swift
//  Huddle
//
//  Created by pro on 2017. 1. 3..
//  Copyright © 2017년 JunginYu. All rights reserved.
//

import UIKit
import FSCalendar

class MakeRoomResult : UIViewController, MTMapViewDelegate, FSCalendarDelegate, FSCalendarDataSource{
    private let daumAPIKey = "989e84a4ef34f3f5247eab3c943f132d" // replace with your Daum API Key
    var selectedDates = [Dates]()
    var selectedDatesDate = [String]()
    var selectedPosition : [Position]?
    
    @IBOutlet var btn1 : UIButton?
    @IBOutlet var btn2 : UIButton?
    @IBOutlet var titleTxt : UITextField?
    @IBOutlet var contentsTxt : UITextView?
    @IBOutlet var when : FSCalendar!
    @IBOutlet var manCount : UILabel?
    @IBOutlet var mapView : MTMapView!
    
    var gatheringVC = GatheringVO()
    var ischeck1 = 0
    var ischeck2 = 0
    override func viewDidLoad() {
        super.viewDidLoad()
    
        mapView.daumMapApiKey = daumAPIKey
        mapView.delegate = self
        
        manCount?.text = "\(gino(gatheringVC.participant?.count))"
        //   when?.select(gatheringVC.days)
        when?.allowsSelection = false
        
        
        
        when.delegate = self
        when.dataSource = self
        when.clipsToBounds = false
        when.allowsMultipleSelection = true
        when.appearance.headerMinimumDissolvedAlpha = 0.0
        
        when.appearance.selectionColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        when.appearance.borderSelectionColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        
        
        when.appearance.caseOptions = [.weekdayUsesSingleUpperCase]
        // calendar.appearance.today // 오늘 색 변경

        
    }
    //달력표시
    func selectView(){
        
        for i in selectedDates {
            selectedDatesDate.append(gsno(i.date))
        }
        
        // 표시하기
        for date in selectedDatesDate{
            let myDate = self.formatter.date(from : date)!.xDays(0)
          //  dateList.append(myDate)
            when.select(self.formatter.date(from : date)?.xDays(0))
        }
        
        //사용자 선택 막기, 꼭 맨 밑에 있어야 함
        when.allowsSelection = false
    }
    // 지도 표시
    func putPoiItem(){
        print("PublicMapVCPublicMapVCPublicMapVCPublicMapVCPublicMapVCPublicMapVC")
        mapView.baseMapType = .standard
        // items.append(poiItem(name: "넷", latitude: 126, longitude: 38))
        // items.append(poiItem(name: "넷", latitude: 127.1722, longitude: 37.5665))
        // items.append(poiItem(name: "넷", latitude: 126.920757, longitude: 37.623885))
        // items.append(poiItem(name: "넷", latitude: 126.927032, longitude: 37.4873488))
        
        
        //        //샘플 데이터
        //        selectedPosition = Position(place: "여기", longtitude: "127.0426469", latitude: "37.5037539")
        
        
        var items = [MTMapPOIItem]()
        
        
        if let mySelectedPosition = selectedPosition{
            for sp in mySelectedPosition{
                print("latitude \(sp.latitude) longtitude \(sp.longtitude)")
                items.append(
                    poiItem(
                        //gdno extensionControl에 추가!
                        name: gsno(sp.place),
                        latitude:  gdno(Double(gsno(sp.latitude))),
                        longitude:  gdno(Double(gsno(sp.longtitude)))
                ))
            }
            
        }
        
        mapView.addPOIItems(items)
        mapView.fitAreaToShowAllPOIItems()
        self.view.insertSubview(mapView, at: 0)
        
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

    
    
    
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return formatter
    }()
    
}
