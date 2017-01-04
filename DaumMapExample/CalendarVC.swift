//
//  CreateMeetingCalendarVC.swift
//  Appjam_1
//
//  Created by YuJungin on 2016. 12. 28..
//  Copyright © 2016년 jungining. All rights reserved.
//

import UIKit
import FSCalendar

class CalendarVC: UIViewController, FSCalendarDelegate, FSCalendarDataSource { //Delegate랑 Datasource프로토콜은 거의 필수로 구현한다고 보시면 됩니다.
    
    @IBOutlet  var calendar: FSCalendar!
    var selectedDates = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationController?.navigationBar.topItem?.title = "언제"
        self.calendar.appearance.caseOptions = [.weekdayUsesSingleUpperCase]
        
        calendar.delegate = self
        calendar.dataSource = self
        calendar.clipsToBounds = false
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        
        
    }
    
    // 각 날짜에 특정 문자열을 표시할 수 있습니다. 이미지를 표시하는 메소드도 있으니 API를 참조하세요.
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        return "1"
    }
//    // 특정 날짜를 선택했을 때, 발생하는 이벤트는 이 곳에서 처리할 수 있겠네요.
//    func calendar(_ calendar: FSCalendar, didSelect date: Date) {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyyMMdd"
//        
//        let dateString = formatter.string(from: date.xDays(+1))
//        selectedDates.append(dateString)
//        
//    }
    
    
    // 스와이프를 통해서 다른 달(month)의 달력으로 넘어갈 때 발생하는 이벤트를 이 곳에서 처리할 수 있겠네요.
    func calendarCurrentMonthDidChange(calendar: FSCalendar) {
        print(calendar)
    }
    //
    // 특정 날짜를 선택했을 때, 발생하는 이벤트는 이 곳에서 처리할 수 있겠네요.
    func calendar(_ calendar: FSCalendar, didSelect date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        
        let dateString = formatter.string(from: date.xDays(+1))
        selectedDates.append(dateString)
        //
        //        //GatheringVO객체에 추가
        //        if let parentVC = self.parent as? MakeGatheringVC {
        //            let newGathering = parentVC.newGathering
        //                newGathering.setDays(days: selectedDates)
        //        }
        //
    }
}


