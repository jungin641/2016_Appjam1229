//
//  ViewController.swift
//  pageSample
//
//  Created by woong on 2016. 3. 28..
//  Copyright © 2016년 handstudio. All rights reserved.
//

import UIKit

class MakeGatheringVC: UIViewController , UIPageViewControllerDataSource {
    
    var pageViewController : UIPageViewController!
    var newGathering = GatheringVO()
    var vcs:Array<UIViewController>=[]
    var contentVC: ContentViewController?
    
    var index = 0
    @IBAction func CancelBtn(_ sender: AnyObject) {
        // 저장안하고 끄면 데이터 날라가야겠지?
        dismiss(animated: true)
        
    }
    @IBAction func CompleteBtn(_ sender: AnyObject) {
        //확인창으로 넘어가기
        let viewControllers = pageViewController.viewControllers! as [UIViewController]
        
        for vc in vcs{
            if let ContactsVC = vc as? ContactsViewController{
                let friendList = ContactsVC.selectedArray
                if let swiftArray = friendList as NSArray as? [Int] {
                    newGathering.setParticipant(participant: swiftArray)
                }
            }
            if let CalendarVC = vc as? CalendarVC{
                let days = CalendarVC.selectedDates
                newGathering.setDays(days: days)
            }
            if let mapViewController = vc as? MapViewController{
                let position = mapViewController.selectedPosition
                newGathering.setPosision(position: position)
            }
            
        }
        
        
        //다 옵셔널로 프린트됨
        print(newGathering.participant)
        print(newGathering.days)
        print(newGathering.position?.latitude)
        
        dismiss(animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vcs.append(storyboard!.instantiateViewController(withIdentifier: "ContactsViewController"))
        vcs.append(storyboard!.instantiateViewController(withIdentifier: "CalendarVC"))
        vcs.append(storyboard!.instantiateViewController(withIdentifier: "MapViewController"))
        self.pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageViewController") as! UIPageViewController
        self.pageViewController.dataSource = self
        
        let startVC = self.viewControllerAtIndex(0)
        let viewControllers = NSArray(object: startVC)
        
        
        self.pageViewController.setViewControllers(viewControllers as? [UIViewController] , direction: .forward, animated: true, completion: nil)
        self.pageViewController.view.frame = CGRect(x: 0,y: 30,width: self.view.frame.width, height: self.view.frame.height - 80)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        
    }
    
    
    /**
     * viewPageController 구성 함수
     */
    func viewControllerAtIndex (_ index : Int) -> UIViewController {
        
        return vcs[index]
    }
    
    
    
    /**
     * 이전 ViewPageController 구성
     */
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var index = 0
        print("이전 : \(viewController)")
        if viewController === vcs[0] {
            return nil
        } else if viewController === vcs[1] {
            index = 0
        } else if viewController === vcs[2] {
            index = 1
        } else {
            return nil
        }
        
        return self.viewControllerAtIndex(index)
    }
    
    
    /**
     * 이후 ViewPageController 구성
     */
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        
        var index = 0
        print("이후 : \(viewController)")
        if viewController === vcs[0] {
            index = 1
        } else if viewController === vcs[1] {
            index = 2
        } else if viewController === vcs[2] {
            return nil
        } else {
            return nil
        }
        
        return self.viewControllerAtIndex(index)
    }
    
    
    /**
     * 인디케이터의 총 갯수
     */
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 3
    }
    
    
    /**
     * 인디케이터의 시작 포지션
     */
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}
