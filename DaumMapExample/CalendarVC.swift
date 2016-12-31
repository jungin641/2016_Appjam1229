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
    
    @IBOutlet weak var calendar: FSCalendar!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        self.navigationController?.navigationBar.topItem?.title = "언제"
         self.calendar.appearance.caseOptions = [.weekdayUsesSingleUpperCase]
     
        calendar.delegate = self
        calendar.dataSource = self
        calendar.clipsToBounds = false
    
        
        
    }
//    
//    // 각 날짜에 특정 문자열을 표시할 수 있습니다. 이미지를 표시하는 메소드도 있으니 API를 참조하세요.
//    func calendar(calendar: FSCalendar, subtitleForDate date: NSDate) -> String? {
//        return "W"
//    }
//    

    
    // 스와이프를 통해서 다른 달(month)의 달력으로 넘어갈 때 발생하는 이벤트를 이 곳에서 처리할 수 있겠네요.
    func calendarCurrentMonthDidChange(calendar: FSCalendar) {
        print(calendar)
    }
    //
    // 특정 날짜를 선택했을 때, 발생하는 이벤트는 이 곳에서 처리할 수 있겠네요.
    func calendar(_ calendar: FSCalendar, didSelect date: Date) {
        print("선택 날짜\(date.xDays(+1))")
        
        
    }
}
extension Date {
    func xDays(_ x: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: x, to: self)!
    }
}

