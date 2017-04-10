# SLWaterflowLayout
UICollectionView waterflow layout, written with swift

用UICollectionViewLayout子类实现瀑布流布局


![Alt text](https://github.com/CoderSLZhang/SLWaterflowLayout/blob/master/waterflow.gif)


 let layout = SLWaterflowLayout()
 layout.columnsCount = kColumensCount
 layout.columnMargin = kColumMargin
 layout.rowMargin = kRowMargin
 layout.delegate = self        
 collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        
