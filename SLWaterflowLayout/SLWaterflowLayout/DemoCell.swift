//
//  MyCollectionViewCell.swift
//  CollectionViewLayout
//
//  Created by zhangsl on 2017/4/6.
//  Copyright © 2017年 zhangsl. All rights reserved.
//

import UIKit

class DemoCell: UICollectionViewCell {
    
    let imageView = UIImageView();
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
}
