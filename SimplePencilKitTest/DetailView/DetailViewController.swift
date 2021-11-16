//
//  ViewController.swift
//  PencilKit
//
//  Created by 김수빈 on 2021/11/15.
//

import UIKit
import SnapKit
import PencilKit


class DetailViewController: UIViewController {
    
    private var listView: UIView?

    
    public class func instance() -> DetailViewController {
        let vc = DetailViewController()
        
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 네비게이션 셋팅
        self.setNavigation()
        
        // 리스트 영역 셋팅
    }


    
    
}


//MARK:- 네비게이션 관련
extension DetailViewController {
    
    func setNavigation() {
        // 타이틀
        self.setNavigationTitle()
    }
    
    /// 네비게이션 타이틀 셋팅
    func setNavigationTitle() {
        self.navigationItem.title = "Title!"
    }
    
    /// 네비게이션 왼쪽 버튼 셋팅
    func setNavigationLeftButtons() {
        // backButton
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    /// 네비게이션 오른쪽 버튼 셋팅
    func setNavigationRightButtons() {
        
    }
}
