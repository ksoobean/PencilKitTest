//
//  ListVM.swift
//  PencilKit
//
//  Created by 김수빈 on 2021/11/16.
//

import Foundation
import UIKit

enum Type {
    case FOLDER
    case DOCUMENT
}

struct ListVM {
    var type: Type
    
    var fileName: String
    var fileExtension: String
    var filePath: String
    
    var thumnailImage: UIImage?
    
    
    
//    // 확장자별 이미지랑 배경색 셋팅
//    if .FOLDER == self.fileType {
//        // 1. 폴더인 경우 확장자, 이미지 배경색, 썸네일 이미지 없음
//        // 폴더이름
//        self.folderName = self.dzAttachFile.originalFileName
//        self.fileExtension = ""
//        self.thumnailImage = UIImage(named: "icAttatchFolder")
//    } else {
//        // 2. 파일인 경우
//        // 파일 이름
//        self.fileName = self.dzAttachFile.originalFileName
//        // 확장자로 기본 썸네일 이미지 셋팅
//        self.defaultImageWithExtn = UIImage(named: Util.sharedInstance()!.setImageWithExtension(returnSmallImage: false, extsn: self.fileExtension.lowercased())) ?? UIImage()
//        // 작은 이미지도 셋팅
//        self.extSmallImage = UIImage(named: Util.sharedInstance()!.setImageWithExtension(returnSmallImage: true, extsn: self.fileExtension.lowercased())) ?? UIImage()
//        // 확장자별 배경 색 셋팅
//        self.extBackgroundColor = Util.sharedInstance()!.setColorWithExtension(extsn: self.fileExtension.lowercased())
//
//        if true == Util.sharedInstance()!.isImage(self.fileExtension.lowercased()) {
//            // 이미지인 경우
//            self.thumnailImage = UIImage(contentsOfFile: self.dzAttachFile.fileDLPath) ?? UIImage()
//            self.hasThumnail = true
//        } else if "pdf" == self.fileExtension {
//            self.thumnailImage = self.pdfThumbnail(url: URL(fileURLWithPath: self.dzAttachFile.fileDLPath))
//            self.hasThumnail = true
//        } else {
//            self.thumnailImage = self.defaultImageWithExtn
//            self.hasThumnail = false
//        }
        
//    }
}
