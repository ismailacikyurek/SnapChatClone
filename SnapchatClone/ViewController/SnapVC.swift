//
//  SnapVC.swift
//  SnapchatClone
//
//  Created by İSMAİL AÇIKYÜREK on 2.04.2022.
//

import UIKit
import ImageSlideshow
import ImageSlideshowKingfisher

class SnapVC: UIViewController {
    
    var selectedNSap : snap?
    var SelectedTime : Int?
    var inputArray = [KingfisherSource]()

    @IBOutlet weak var timeleftLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

       
        timeleftLabel.text = "Time Left :\(SelectedTime!)"
        
        
        if let snap = selectedNSap {
            for imageURl in snap.imageURlArray {
                inputArray.append(KingfisherSource(urlString: imageURl)!)
                
            }
            
            
            
            let imageSlideShow = ImageSlideshow(frame: CGRect(x: 10, y: 10, width: self.view.frame.width * 0.95, height: self.view.frame.height * 0.8))
            imageSlideShow.backgroundColor = .white
            
            let pageIndicator = UIPageControl()
            pageIndicator.currentPageIndicatorTintColor = UIColor.lightGray //Alttaki noktalar
            pageIndicator.pageIndicatorTintColor = UIColor.black
            imageSlideShow.pageIndicator = pageIndicator
            
            imageSlideShow.contentScaleMode = UIViewContentMode.scaleAspectFit
            imageSlideShow.setImageInputs(inputArray)
            self.view.addSubview(imageSlideShow)
            self.view.bringSubviewToFront(timeleftLabel)
        }
        
       
        
    }
    


}
