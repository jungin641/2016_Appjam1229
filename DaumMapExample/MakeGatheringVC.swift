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
    
    @IBAction func CancelBtn(_ sender: AnyObject) {
        // 저장안하고 끄면 데이터 날라가야겠지?
        dismiss(animated: true)
        
    }
    @IBAction func CompleteBtn(_ sender: AnyObject) {
        //확인창으로 넘어가기
        dismiss(animated: true)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageViewController") as! UIPageViewController
        self.pageViewController.dataSource = self
        
        let startVC = self.viewControllerAtIndex(0) as ContentViewController
        let viewControllers = NSArray(object: startVC)
        
        self.pageViewController.setViewControllers(viewControllers as? [UIViewController] , direction: .forward, animated: true, completion: nil)
        self.pageViewController.view.frame = CGRect(x: 0,y: 30,width: self.view.frame.width, height: self.view.frame.height - 100)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        
    }
    
    
    /**
    * viewPageController 구성 함수
    */
    func viewControllerAtIndex (_ index : Int) -> ContentViewController {
        
        let vc : ContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
        
        vc.pageIndex = index
        
//        print(">>> : " ,vc.titleText)
//        
        return vc
    }
    
    
    
    /**
    * 이전 ViewPageController 구성
    */
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! ContentViewController
        var index = vc.pageIndex as Int

        if( index == 0 ) {
            return nil
        }
//        
//        if( index == 0 || index == NSNotFound) {
//            return nil
//        }
//        
        index -= 1
        
        return self.viewControllerAtIndex(index)
    }
    
    
    /**
    * 이후 ViewPageController 구성
    */
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! ContentViewController
        
        var index = vc.pageIndex as Int
        
        if( index == 3) {
            return nil
        }
        
        index += 1
        
        if (index == 3) {
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

