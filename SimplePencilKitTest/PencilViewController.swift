//
//  PencilViewController.swift
//  SimplePencilKitTest
//
//  Created by 김수빈 on 2021/11/17.
//

import Foundation
import UIKit

import SnapKit


import UniformTypeIdentifiers

@objcMembers class PencilViewController: UIViewController {
    
    private var pdfPencilView: PDFPencilViewer?
    
    
    private var fileList: [FileInfo] = []
    
    private var currentFile: FileInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .white
        
        if nil == self.pdfPencilView {
            self.pdfPencilView = PDFPencilViewer.instance()
            
            self.view.addSubview(self.pdfPencilView!)
        }
        
        self.pdfPencilView?.snp.remakeConstraints({ make in
            make.leading.trailing.top.bottom.equalToSuperview()
        })
        
        
        
        let loadPDFButton = UIButton()
        loadPDFButton.setTitle("LOAD", for: .normal)
        loadPDFButton.addTarget(self, action: #selector(loadPDF), for: .touchUpInside)
        loadPDFButton.backgroundColor = .black
        loadPDFButton.setTitleColor(.white, for: .normal)
        
        self.view.addSubview(loadPDFButton)
        
        self.view.bringSubviewToFront(loadPDFButton)
        
        loadPDFButton.snp.remakeConstraints { make in
            make.width.height.equalTo(80)
            make.bottom.equalToSuperview().inset(50)
            make.trailing.equalToSuperview().inset(50)
        }
        
        // add file button
        let addButton = UIButton()
        addButton.setTitle("ADD", for: .normal)
        addButton.addTarget(self, action: #selector(addFile), for: .touchUpInside)
        addButton.backgroundColor = .black
        addButton.setTitleColor(.white, for: .normal)
        
        self.view.addSubview(addButton)
        
        self.view.bringSubviewToFront(addButton)
        
        addButton.snp.remakeConstraints { make in
            make.width.height.equalTo(80)
            make.bottom.equalToSuperview().inset(50)
            make.trailing.equalTo(loadPDFButton.snp.leading).inset(20)
        }
    }
    
    /// import file
    func addFile() {
        let docPicker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.pdf], asCopy: true)
        docPicker.delegate = self
        docPicker.modalPresentationStyle = .formSheet
        self.present(docPicker, animated: true, completion: nil)
    }
    
    func loadPDF() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let pdfURL = UIAlertAction(title: "WEB URL", style: .default) { action in
            // 샘플 pdf url 오픈
            let sampleURL: String = "http://www.africau.edu/images/default/sample.pdf"
            self.currentFile = FileInfo(name: "", fileUrl: URL(string: sampleURL)!, fileFrom: .WEB)
            self.pdfPencilView?.loadPDF(self.currentFile!)
            return
        }
        
        let localPDF = UIAlertAction(title: "LOCAL", style: .default) { action in
            // 문서 디렉토리에 있는 pdf 열기
            let fileManager = FileManager.default
            let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
            do {
                let fileURLs = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
                
                
                guard !fileURLs.isEmpty else {
                    let sampleURL: String = "http://www.africau.edu/images/default/sample.pdf"
                    self.currentFile = FileInfo(name: "", fileUrl: URL(string: sampleURL)!, fileFrom: .WEB)
                    self.pdfPencilView?.loadPDF(self.currentFile!)
                    return
                }
                
                // process files
                for file in fileURLs {
                    let vm = FileInfo(name: file.lastPathComponent, fileUrl: file, fileFrom: .LOCAL)
                    
                    self.fileList.append(vm)
                }
                
                self.currentFile = self.fileList.first
                self.pdfPencilView?.loadPDF(self.currentFile!)
                
                print(fileURLs)
                
            } catch {
                print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
                
            }
        }
        
        let cancelAction = UIAlertAction(title: "CANCEL", style: .cancel) { action in
            //
        }
        
        actionSheet.addAction(pdfURL)
        actionSheet.addAction(localPDF)
        actionSheet.addAction(cancelAction)
        
        if let popoverController = actionSheet.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.maxY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
}

// MARK:- UIDocumentPickerDelegate
extension PencilViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileURL = urls.first else {
            return
        }
        
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let sandboxFileURL = dir.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            print("Already Exists!")
        } else {
            do {
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                print("Copy Complete")
            } catch {
                print("Error: \(error)")
            }
        }
    }
}
