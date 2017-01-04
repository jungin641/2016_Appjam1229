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
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return formatter
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //sample data
        selectedDates = ["20170118","20170122","20170126","20170103"]
        
        calendar.delegate = self
        calendar.dataSource = self
        calendar.clipsToBounds = false
        calendar.allowsMultipleSelection = true
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        
        calendar.appearance.selectionColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        calendar.appearance.borderSelectionColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
   
        
        calendar.appearance.caseOptions = [.weekdayUsesSingleUpperCase]
       // calendar.appearance.today // 오늘 색 변경
        
        // 이미지 표시하기
        for date in selectedDates{
            
            calendar.select(self.formatter.date(from : date)?.xDays(+1))
            print(self.formatter.date(from : date)!)
        }
      
        //사용자 선택 막기, 꼭 맨 밑에 있어야 함
        calendar.allowsSelection = false
    }

    // 각 날짜에 특정 문자열을 표시할 수 있습니다.
    func calendar(calendar: FSCalendar, subtitleForDate date: NSDate) -> String? {
        return "1"
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
