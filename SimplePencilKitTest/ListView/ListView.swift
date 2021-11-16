//
//  File.swift
//  PencilKit
//
//  Created by 김수빈 on 2021/11/15.
//

import Foundation
import UIKit

protocol ListViewProtocol {
    func showDetailView(vm: ListVM)
}

@objcMembers class ListView: UIView {
    
    public var delegate: ListViewProtocol?
    
    // collectionView
    private var listCollectionView: UICollectionView?
    
    let cellId: String = "ListCell"
    
    // 문서 리스트
    private var dataList: [ListVM] = []
    
    public class func instance() -> ListView {
        let view = ListView()
        
        view.initView()
        
//        view.loadFileList(folderName: "")
        view.getDocumentList()
        
        return view
    }
    
    private func initView() {
        self.backgroundColor = .white
        
        // collectionView
        if nil == listCollectionView {
            
            listCollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout())
            
            listCollectionView?.dataSource = self
            listCollectionView?.delegate = self
            
            listCollectionView?.register(ListCell.self, forCellWithReuseIdentifier: cellId)
            
            
            self.addSubview(listCollectionView!)
        }
        
        listCollectionView?.snp.remakeConstraints({ make in
            make.leading.trailing.top.bottom.equalToSuperview()
        })
        
    }
    
    
    
}

//MARK:- CollectionView 관련
extension ListView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ListCell
        
        cell.vm = self.dataList[indexPath.row]
        
        return  cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.delegate?.showDetailView(vm: self.dataList[indexPath.row])
        
    }
    
    /// create Compositional Layout
    private func createLayout() -> UICollectionViewCompositionalLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout

    }
}

//MARK:- 파일 리스트
extension ListView {
    // 문서 리스트 가져오기
    private func getDocumentList() {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .downloadsDirectory, in: .userDomainMask)[0]
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
            // process files
            
            print(fileURLs)
            
        } catch {
            print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
        }
    }
    
//    /// 폴더 이름으로 경로 만들어주기
//    /// - Returns: 조회할 폴더 경로
//    private func setFolderPath(folderNameToLoadList: String) -> String {
//
//        var folderPath: String = ""
//
//        // 현재 리스트 경로
//        let array = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
//        let rootPath = String(format: "%@/download", array.first!)
//
//        if "" != folderNameToLoadList {
//            folderPath = String(format: "%@/%@", rootPath, folderNameToLoadList)
//        } else {
//            folderPath = rootPath
//        }
//
//        return folderPath
//    }
//
//    /// 폴더 하위의 리스트 조회하기
//    /// - Parameter folderName: 조회할 폴더 이름
//    func loadFileList(folderName: String) {
//        self.dataList.removeAll()
//
//        let folderPath = self.setFolderPath(folderNameToLoadList: folderName)
//        let fileManager = FileManager.default
//        let downloadFolderURL: URL = URL(string: folderPath.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)!
//        do {
//            let contentsInFolder = try fileManager.contentsOfDirectory(at: downloadFolderURL, includingPropertiesForKeys: [.contentModificationDateKey, .localizedNameKey], options: .skipsHiddenFiles)
//
//            guard contentsInFolder.count != 0 else {
//                // 폴더가 비어있을 때 아래 로직 필요 없음.
//                return
//            }
//
//            // process files
//            for file in contentsInFolder {
//                var interval: TimeInterval = 0.0
//                var strDate: String = ""
////                if false == Util.sharedInstance()!.isImage(file.pathExtension.lowercased()) && "SKETCH" == self.menuNameType {
////                    continue
////                }
//
//                if fileManager.fileExists(atPath: file.path) {
//                    let attributesDic = try fileManager.attributesOfItem(atPath: file.path)
//                    let createDate: Date = attributesDic[.modificationDate] as! Date
//                    let formatter = DateFormatter.init()
//                    formatter.dateFormat = "yyyy-MM-dd a hh:mm:ss"
//                    interval = createDate.timeIntervalSince1970
//                    strDate = formatter.string(from: createDate)
//
//                }
//
//                var objcIsDir: ObjCBool = false
//                if fileManager.fileExists(atPath: file.path, isDirectory: &objcIsDir) {
//                    let vm: ListVM?
//                    if true == objcIsDir.boolValue {
//                        // 폴더인 경우
//                        vm = ListVM(type: .FOLDER,
//                                    fileName: file.lastPathComponent,
//                                    fileExtension: "",
//                                    filePath: file.path)
//
//                    } else {
//                        // 파일인 경우
////                        let attributesDic = try fileManager.attributesOfItem(atPath: file.path)
////                        let size = String(format: "%zd", attributesDic[.size] as! CVarArg)
//
//                        vm = ListVM(type: .DOCUMENT,
//                                    fileName: file.deletingPathExtension().lastPathComponent,
//                                    fileExtension: file.pathExtension,
//                                    filePath: file.path)
//
//                    }
//
//                    if "" != vm?.fileName {
//                        self.dataList.append(vm!)
//                    }
//
//                } else {
//                    print("Oops, \(file.path) does not exist?")
//                }
//            }
//        } catch {
//            print("Error while enumerating files \(downloadFolderURL.path): \(error.localizedDescription)")
//        }
//
//        // 소팅 해야된다면 해주기
//        // 리로드
//        self.listCollectionView?.reloadData()
//    }
}
