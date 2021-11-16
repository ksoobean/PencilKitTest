//
//  ViewController.swift
//  PencilKit
//
//  Created by 김수빈 on 2021/11/15.
//

import UIKit
import SnapKit

@objcMembers class ListViewController: UIViewController {
    
    // 리스트 영역 뷰
    private var listView: ListView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.initView()
    }


    private func initView() {
        self.view.backgroundColor = .white
        
        // 네비게이션 셋팅
        self.setNavigation()
        
        // 리스트 영역 셋팅
        self.setListView()
    }
    
    
    private func setListView() {
        if nil == listView {
            listView = ListView.instance()
            
            self.listView?.delegate = self
            
            self.view.addSubview(listView!)
        }
        
        listView?.snp.remakeConstraints({ make in
            make.leading.trailing.top.bottom.equalToSuperview()
        })
    }
    
}


//MARK:- 네비게이션 관련
extension ListViewController {
    
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
        
    }
    
    /// 네비게이션 오른쪽 버튼 셋팅
    func setNavigationRightButtons() {
        
    }
}

//MARK:- ListViewProtocol
extension ListViewController: ListViewProtocol {
    func showDetailView(vm: ListVM) {
        let detailVC = DetailViewController.instance()
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
}
