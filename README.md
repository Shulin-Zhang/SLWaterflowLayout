# SLWaterflowLayout
UICollectionView waterflow layout, written with swift

用UICollectionViewLayout子类实现瀑布流布局


![Alt text](https://github.com/CoderSLZhang/SLWaterflowLayout/blob/master/waterflow.gif)

# How to use SLWaterflowLayout
```swift
let layout = SLWaterflowLayout()
layout.columnsCount = kColumensCount
layout.columnMargin = kColumMargin
layout.rowMargin = kRowMargin
layout.delegate = self       
collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
```

```swift
extension ViewController: SLWaterflowLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForItemAtIndexPath indexPath: IndexPath) -> CGFloat {
        let image = UIImage(named: "\(indexPath.item).jpg")!
        
        let width = (collectionView.frame.width - CGFloat(kColumensCount - 1) * kColumMargin) / 3
        let height = width * (image.size.height / image.size.width)
        
        return height
    }
}
```
        
