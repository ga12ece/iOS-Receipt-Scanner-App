//
//  InsightController.swift
//  simpleApp
//
//  Created by Son Dinh on 9/13/19.
//  Copyright © 2019 Son Dinh. All rights reserved.
//

import UIKit

class InsightController: UIViewController {

    
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    var insightArr = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        mainScrollView.frame = view.frame
        
        insightArr = [ UIImage(named: "dining")!, UIImage(named: "category")!, UIImage(named: "monthly")!, UIImage(named: "saving")!]
        
        // Do any additional setup after loading the view.
        for i in 0..<insightArr.count {
            let imageView = UIImageView()
            imageView.image = insightArr[i]
            imageView.contentMode = .scaleAspectFit
            let yPos = self.view.frame.height * CGFloat(i)
            imageView.frame = CGRect(x: 0, y: yPos, width: self.mainScrollView.frame.width, height: self.mainScrollView.frame.height)
            self.mainScrollView.contentSize.height = self.mainScrollView.frame.height * CGFloat(i + 1)
            
            self.mainScrollView.addSubview(imageView)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showNavigationBar()
    }
}
