//
//  PublicResultCalendarVC.swift
//  Huddle
//
//  Created by YuJungin on 2017. 1. 3..
//  Copyright © 2017년 JunginYu. All rights reserved.
//

import UIKit
import FSCalendar

class PublicResultCalendarVC: UIViewController , FSCalendarDelegate, FSCalendarDataSource{
    @IBOutlet var calendar : FSCalendar!
    var selectedDates = [String]()
//    dates : [{
//    date: string
//    count: int //해당date에 투표한 사람수
//    }]
//    
    var testDate : Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendar.delegate = self
        calendar.dataSource = self
        calendar.clipsToBounds = false
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.allowsSelection = false
        
        calendar.appearance.caseOptions = [.weekdayUsesSingleUpperCase]
       // calendar.appearance.today // 오늘 색 변경

    }

    // 각 날짜에 특정 문자열을 표시할 수 있습니다. 이미지를 표시하는 메소드도 있으니 API를 참조하세요.
    func calendar(calendar: FSCalendar, subtitleForDate date: NSDate) -> String? {
        return "1"
    }
    
    
    
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
    
    }

}
extension Date {
    func xDays(_ x: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: x, to: self)!
    }
}
