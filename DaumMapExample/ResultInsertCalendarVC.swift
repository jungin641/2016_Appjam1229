//
//  ResultInsertCalendarVC.swift
//  Huddle
//
//  Created by YuJungin on 2017. 1. 6..
//  Copyright © 2017년 JunginYu. All rights reserved.
//

import UIKit
import FSCalendar

class ResultInsertCalendarVC: UIViewController , FSCalendarDelegate, FSCalendarDataSource{
    @IBOutlet var calendar : FSCalendar!
    var selectedDates = [Dates]()
    var dateList = [Date]()
    var selectedDatesDate = [String]()
    //    dates : [{
    //    date: string
    //    count: int //해당date에 투표한 사람수
    //    }]
    //
    
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return formatter
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        calendar.delegate = self
        calendar.dataSource = self
        calendar.clipsToBounds = false
        calendar.allowsMultipleSelection = true
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        
        calendar.appearance.selectionColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        calendar.appearance.borderSelectionColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        
        
        calendar.appearance.caseOptions = [.weekdayUsesSingleUpperCase]
        // calendar.appearance.today // 오늘 색 변경
        
        
    }
    
    //숫자 표시하기
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        var count : String?
        for myDate in dateList {
            let result = myDate.compare(date)
            switch result {
            case .orderedSame:
                count =  "11"
            default:
                count =  nil
            }
        }
        return count
    }
    
    func selectView(){
        
        for i in selectedDates {
            selectedDatesDate.append(gsno(i.date))
        }
        
        // 표시하기
        for date in selectedDatesDate{
            let myDate = self.formatter.date(from : date)!.xDays(0)
            dateList.append(myDate)
            calendar.select(self.formatter.date(from : date)?.xDays(0))
        }
        
        //사용자 선택 막기, 꼭 맨 밑에 있어야 함
        calendar.allowsSelection = false
    }
    
}
