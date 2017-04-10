//
//  ViewController.swift
//  SLWaterflowLayout
//
//  Created by zhangsl on 2017/4/10.
//  Copyright © 2017年 张树林. All rights reserved.
//

import UIKit


private let kColumensCount = 3
private let kColumMargin: CGFloat = 5
private let kRowMargin: CGFloat = 5
private let kCellId = "DemoCell"

class ViewController: UIViewController {
    
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = SLWaterflowLayout()
        layout.columnsCount = kColumensCount
        layout.columnMargin = kColumMargin
        layout.rowMargin = kRowMargin
        layout.delegate = self
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight];
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.register(DemoCell.self, forCellWithReuseIdentifier: kCellId)
        view.addSubview(collectionView)
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 41;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellId, for: indexPath) as! DemoCell
        let image = UIImage(named: "\(indexPath.item).jpg")
        cell.imageView.image = image
        
        return cell
    }
}

extension ViewController: SLWaterflowLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForItemAtIndexPath indexPath: IndexPath) -> CGFloat {
        let image = UIImage(named: "\(indexPath.item).jpg")!
        
        let width = (collectionView.frame.width - CGFloat(kColumensCount - 1) * kColumMargin) / 3
        let height = width * (image.size.height / image.size.width)
        
        return height
    }
}


