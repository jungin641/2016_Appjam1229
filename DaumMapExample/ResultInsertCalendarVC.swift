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

    var selectedDatesDate = [String]()
 
    
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
        calendar.allowsSelection = true
        
        calendar.appearance.caseOptions = [.weekdayUsesSingleUpperCase]
        // calendar.appearance.today // 오늘 색 변경
        
        
    }
    
  
    
    func selectView(){
       
        
        // 표시하기
        for date in selectedDatesDate{
            let myDate = self.formatter.date(from : date)!.xDays(0)

            calendar.select(myDate)
        }
        
        
    }
    
}
