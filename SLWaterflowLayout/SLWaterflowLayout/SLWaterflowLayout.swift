//
//  MyLayout.swift
//  CollectionViewLayout
//
//  Created by zhangsl on 2017/4/6.
//  Copyright © 2017年 张树林. All rights reserved.
//

import UIKit


protocol SLWaterflowLayoutDelegate: class {
    func collectionView(_ collectionView: UICollectionView, heightForItemAtIndexPath indexPath:IndexPath) -> CGFloat
}


class SLWaterflowLayout: UICollectionViewLayout {
    
    var edgeIndets: UIEdgeInsets = UIEdgeInsets.zero
    
    var columnsCount = 1
    
    var rowMargin: CGFloat = 0
    
    var columnMargin: CGFloat = 0
    
    weak var delegate: SLWaterflowLayoutDelegate?
    
    private var contentHeight: CGFloat = 0
    
    private var heights = [CGFloat]()
    
    private var attributes = [UICollectionViewLayoutAttributes]()
    
    
    
    override func prepare() {
        guard columnsCount > 0, let collectionView = collectionView else {
            return
        }
        
        contentHeight = edgeIndets.top
        heights.removeAll()
        attributes.removeAll()
        
        heights = Array(repeating: edgeIndets.top, count: columnsCount)
        
        let total = collectionView.numberOfItems(inSection: 0);
        
        for i in 0..<total {
            let indexPath = IndexPath(item: i, section: 0)
            let attr = layoutAttributesForItem(at: indexPath)
            
            if attr != nil {
                attributes.append(attr!)
            }
        }
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let delegate = delegate, columnsCount > 0 else {
            return nil;
        }

        let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        
        let minHeight = heights.min()!
        let minCol = heights.index(of: minHeight)!
        
        let itemHeight = delegate.collectionView(collectionView!, heightForItemAtIndexPath: indexPath);
        let itemWidth = (collectionView!.frame.width - edgeIndets.left - edgeIndets.right - (CGFloat(columnsCount) - 1) * columnMargin) / CGFloat(columnsCount)
        let itemX = edgeIndets.left + itemWidth * CGFloat(minCol) + columnMargin * CGFloat(minCol)
        var itemY = minHeight
        
        if indexPath.item >= columnsCount {
            itemY += rowMargin
        }
        
        heights[minCol] = itemY + itemHeight
        
        let maxHeight = heights.max()!
        if contentHeight < maxHeight {
            contentHeight = maxHeight
        }
        
        attr.frame = CGRect(x: itemX, y: itemY, width: itemWidth, height: itemHeight)
        
        return attr
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard columnsCount > 0 else {
            return nil;
        }
        
        var resultAttrs = [UICollectionViewLayoutAttributes]()
        
        for attr in attributes {
            if attr.frame.intersects(rect) {
                resultAttrs.append(attr)
            }
        }
        
        return resultAttrs;
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: collectionView!.frame.width, height: contentHeight + edgeIndets.bottom)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard let collectionView = collectionView else {
            return false
        }
        
        let oldBounds = collectionView.bounds;
        
        if oldBounds.width == newBounds.width {
            return false
        } else {
            return true
        }
    }
}
