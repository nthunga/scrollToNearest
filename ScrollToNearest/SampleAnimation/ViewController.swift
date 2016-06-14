//
//  ViewController.swift
//  SampleAnimation
//
//  Created by Naveen Thunga on 09/03/16.
//  Copyright © 2016 YMedia Labs. All rights reserved.
//

import UIKit

let count = 100
class ViewController: UIViewController {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var transtionView: UIView!
    @IBOutlet weak var sliderView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    let cellIdentifier = "cellIdentifier"
    var timer : NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollToNearestIndex(indexPath:NSIndexPath)  {
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(NSEC_PER_SEC) * 0.2))
        dispatch_after(time, dispatch_get_main_queue()) {
            self.collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.Right, animated: true)
        }
    }

}

extension ViewController: UICollectionViewDataSource{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell : TestCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! TestCell
        cell.textLabel.text = String(stringInterpolationSegment: indexPath.row)
        return cell
    }
    
}

extension ViewController : UICollectionViewDelegate{
    func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool{
        return true
    }
    func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath){
        if let cell = collectionView.cellForItemAtIndexPath(indexPath){
            cell.layer.borderWidth = 3.0
            cell.layer.borderColor = UIColor.blueColor().CGColor
        }
    }
    func collectionView(collectionView: UICollectionView, didUnhighlightItemAtIndexPath indexPath: NSIndexPath){
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        cell!.layer.borderWidth = 0.0
        cell!.layer.borderColor = UIColor.clearColor().CGColor
    }
}

extension ViewController : UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        var page = (scrollView.contentOffset.x / scrollView.frame.size.width)
        page = round(page)

        let index : Int = Int(page)
        let indexPath = NSIndexPath(forRow: index, inSection: 0)
        scrollToNearestIndex(indexPath)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView){
        
    }
}

extension ViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        return CGSizeMake(collectionView.frame.size.width, collectionView.frame.size.height)
    }

}





