//
//  QMPLineCollectionViewFlowLayout.m
//  QiMengProject
//
//  Created by mac on 2021/3/10.
//

#import "QMPLineCollectionViewFlowLayout.h"

@implementation QMPLineCollectionViewFlowLayout

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

/**
 * 用来做布局的初始化操作（不建议在init方法中进行布局的初始化操作）
 */
- (void)prepareLayout {
    [super prepareLayout];
    
    // 水平滚动
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    self.minimumInteritemSpacing = 200;
    CGFloat margin = (self.collectionView.frame.size.width - self.itemSize.width) / 2;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, margin, 0, margin);
}

/**
 * 当collectionView的显示范围发生改变的时候，是否需要重新刷新布局
 * 一旦重新刷新布局，就会重新调用下面的方法：
 * 1.prepareLayout
 * 2.layoutAttributesForElementsInRect:方法
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}


/**
 * 这个方法的返回值是一个数组（数组里面存放着rect范围内所有元素的布局属性）
 * 这个方法的返回值决定了rect范围内所有元素的排布（frame）
 */
//需要在viewController中使用上ZWLineLayout这个类后才能重写这个方法！！

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    //让父类布局好样式
    NSArray *attributesArray = [super layoutAttributesForElementsInRect:rect];
    
    //计算出collectionView的中心的位置
    CGFloat ceterX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    /**
     * 1.一个cell对应一个UICollectionViewLayoutAttributes对象
     * 2.UICollectionViewLayoutAttributes对象决定了cell的frame
     */
    for (UICollectionViewLayoutAttributes *attributes in attributesArray) {
        NSLog(@"attributes:%@",attributes);
        //cell的中心点距离collectionView的中心点的距离，注意ABS()表示绝对值
        CGFloat delta = ABS(attributes.center.x - ceterX);
        //设置缩放比例
        CGFloat scale = 1.3 - delta / self.collectionView.frame.size.width;
        if(scale <= 1.0)scale = 1.0;
//        NSLog(@"scale:%lf",scale);
        //设置cell滚动时候缩放的比例
        attributes.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return attributesArray;
}

/**
 * 这个方法的返回值，就决定了collectionView停止滚动时的偏移量
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    // 计算出最终显示的矩形框
    CGRect rect;
    rect.origin.y = 0;
    rect.origin.x = proposedContentOffset.x;
    rect.size = self.collectionView.frame.size;
    
    //获得super已经计算好的布局的属性
    NSArray *arr = [super layoutAttributesForElementsInRect:rect];
    
    //计算collectionView最中心点的x值
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in arr) {
        NSLog(@"attrs:%@",attrs);
        if (ABS(minDelta) > ABS(attrs.center.x - centerX)) {
            minDelta = attrs.center.x - centerX;
        }
    }
    proposedContentOffset.x += minDelta;
    return proposedContentOffset;
}


@end
