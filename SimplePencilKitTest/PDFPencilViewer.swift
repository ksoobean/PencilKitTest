//
//  PdfView.swift
//  SimplePencilKitTest
//
//  Created by 김수빈 on 2021/11/17.
//

import Foundation
import UIKit
import PencilKit
import SnapKit
import PDFKit

enum FileLocation {
    case LOCAL
    case WEB
}

struct FileInfo {
    var name: String = ""
    var fileUrl: URL
    var fileFrom: FileLocation = .LOCAL
}

@objcMembers class PDFPencilViewer: UIView {
    
    private var pdfView: PDFView?
    
    private var currentFile: FileInfo?
    
    //MARK:- 생성자
    public class func instance() -> PDFPencilViewer {
        let view = PDFPencilViewer()
        
        view.initView()
        
        return view
    }
    
    private func initView() {
        if nil == pdfView {
            self.pdfView = PDFView()
            self.addSubview(self.pdfView!)
        }
        
        pdfView?.snp.remakeConstraints({ make in
            make.leading.trailing.top.bottom.equalToSuperview()
        })
    }
    
    
    // 현재 파일 정보로 pdf 로드하기
    public func loadPDF(_ fileInfo: FileInfo) {
        self.currentFile = fileInfo
        print("PDF File Info: \(self.currentFile!)")
        
        if let fileUrl = self.currentFile?.fileUrl {
            if let pdfDocument = PDFDocument(url: fileUrl) {
                
                self.pdfView?.autoScales = true
                
                self.pdfView?.displayMode = .singlePageContinuous
                pdfView?.displayDirection = .horizontal
                
                // 축소 확대 최소 최대 비율
                self.pdfView?.minScaleFactor = self.pdfView?.scaleFactorForSizeToFit ?? 1.0
                self.pdfView?.maxScaleFactor = 10
                
                // pdf 보여주기
                self.pdfView?.document = pdfDocument
                
            }
        }
        
    }
    
}
