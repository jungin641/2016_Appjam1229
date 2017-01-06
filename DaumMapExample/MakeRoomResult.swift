//
//  makeRoomResult.swift
//  Huddle
//
//  Created by pro on 2017. 1. 3..
//  Copyright © 2017년 JunginYu. All rights reserved.
//

import UIKit
import FSCalendar

class MakeRoomResult : UIViewController, MTMapViewDelegate, FSCalendarDelegate, FSCalendarDataSource, NetworkCallback{
    let userDefault = UserDefaults.standard
    var codeResult = 0
    internal func networkResult(resultData: Any, code: Int) {
        codeResult = code
        if(code == 1){
            let noldamTransitionDelegate = NoldamTrasitionDelegate()
            transitioningDelegate = noldamTransitionDelegate
            let pvc = storyboard!.instantiateViewController(withIdentifier: "RoomMakedPopUp") as! RoomMakedPopUp
            pvc.modalPresentationStyle = .custom
            
            pvc.transitioningDelegate = noldamTransitionDelegate
            present(pvc, animated: true)
        }
        //        if codeResult == 1{
        //            dismiss(animated: true, completion: nil)
        //
        //        }
        
    }
    
    private let daumAPIKey = "989e84a4ef34f3f5247eab3c943f132d" // replace with your Daum API Key
    
    var selectedDatesDate = [String]()
    var selectedPosition = [Position]()
    
    @IBOutlet var btn1 : UIButton?
    @IBOutlet var btn2 : UIButton?
    @IBOutlet var titleTxt : UITextField?
    @IBOutlet var contentsTxt : UITextField?
    var count = 0
    var count2 = 0
    @IBOutlet var when : FSCalendar!
    @IBOutlet var manCount : UILabel?
    @IBOutlet var mapView : MTMapView!
    var when_fix = 0
    var where_fix = 0
    
    var gatheringVC = GatheringVO()
    var thisRoomInfo = RoomInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btn1?.setImage(UIImage(named : "checkcheckoff"), for: UIControlState.normal)
        btn2?.setImage(UIImage(named : "checkcheckoff"), for: UIControlState.normal)
        mapView.daumMapApiKey = daumAPIKey
        mapView.delegate = self
        
        manCount?.text = "\(gino(gatheringVC.participant?.count))"
        
        when.delegate = self
        when.dataSource = self
        when.clipsToBounds = false
        when.allowsMultipleSelection = true
        when.appearance.headerMinimumDissolvedAlpha = 0.0
        
        when.appearance.selectionColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        when.appearance.borderSelectionColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        
        
        when.appearance.caseOptions = [.weekdayUsesSingleUpperCase]
        // calendar.appearance.today // 오늘 색 변경
        if let hostSelectedDays = gatheringVC.days{
            selectedDatesDate = hostSelectedDays
        }
        if let hostSelectedPosition = gatheringVC.position{
            selectedPosition.append(hostSelectedPosition)
        }
        putPoiItem()
        selectView()
        
        //self.view.insertSubview(mapView, at: 0)
    }
    //달력표시
    func selectView(){
        
        
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
        mapView.baseMapType = .standard
        // items.append(poiItem(name: "넷", latitude: 126, longitude: 38))
        // items.append(poiItem(name: "넷", latitude: 127.1722, longitude: 37.5665))
        // items.append(poiItem(name: "넷", latitude: 126.920757, longitude: 37.623885))
        // items.append(poiItem(name: "넷", latitude: 126.927032, longitude: 37.4873488))
        
        
        //        //샘플 데이터
        //        selectedPosition = Position(place: "여기", longtitude: "127.0426469", latitude: "37.5037539")
        
        
        var items = [MTMapPOIItem]()
        
        
        for sp in selectedPosition{
            items.append(
                poiItem(
                    //gdno extensionControl에 추가!
                    name: gsno(sp.place),
                    latitude:  gdno(sp.latitude),
                    longitude: gdno(sp.longtitude)
            ))
        }
        
        
        
        mapView.addPOIItems(items)
        mapView.fitAreaToShowAllPOIItems()
        
        
    }
    @IBAction func Btn1Click(_ sender: Any) {
        if count%2 == 0{
            btn1?.setImage(UIImage(named : "checkcheck-1"), for: UIControlState.normal)
            when_fix = 1
        }
        else{
            btn1?.setImage(UIImage(named : "checkcheckoff"), for: UIControlState.normal)
            when_fix = 0
        }
        count += 1
    }
    
    @IBAction func Btn2Click(_ sender: Any) {
        if count2%2 == 0{
            btn2?.setImage(UIImage(named : "checkcheck-1"), for: UIControlState.normal)
            where_fix = 1
        }
        else{
            btn2?.setImage(UIImage(named : "checkcheckoff"), for: UIControlState.normal)
            where_fix = 0
        }
        count2 += 1
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
    @IBAction func BtnCancel(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func BtnComplete(_ sender: AnyObject) {
        
        if titleTxt?.text?.isEmpty == true{
            
            
            let noldamTransitionDelegate = NoldamTrasitionDelegate()
            transitioningDelegate = noldamTransitionDelegate
            let pvc = storyboard!.instantiateViewController(withIdentifier: "NoSelectPopUp") as! NoSelectPopUp
            pvc.modalPresentationStyle = .custom
            
            pvc.transitioningDelegate = noldamTransitionDelegate
            present(pvc, animated: true)
            
        }
        
        
        
        thisRoomInfo.host_id = userDefault.integer(forKey: "id")
        thisRoomInfo.title = titleTxt?.text
        thisRoomInfo.text = contentsTxt?.text
        thisRoomInfo.is_open = 0
        thisRoomInfo.when_fix = when_fix //날짜 확정 1 날짜 미정 0
        thisRoomInfo.where_fix = where_fix // 0: 장소 미정, 1: 장소 확정)
        
        gatheringVC.roomInfo = thisRoomInfo
        let model = MakeGatheringModel(self)
        model.roomCreate(gatheringVO: gatheringVC)
        
    }
    
}
