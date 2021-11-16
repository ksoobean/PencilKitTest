//
//  ListCell.swift
//  PencilKit
//
//  Created by 김수빈 on 2021/11/15.
//

import UIKit

class ListCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        return iv
    }()
    
    
    
    public var vm: ListVM? {
        didSet {
            guard let vm = vm else {
                return
            }
            
            self.imageView.image = vm.thumnailImage
        }
    }
    
    
}
