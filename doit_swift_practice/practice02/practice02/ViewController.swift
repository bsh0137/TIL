//
//  ViewController.swift
//  practice02
//
//  Created by 백성현 on 2021/07/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var lblPage: UILabel!
    @IBOutlet var pageControl: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pageControl.numberOfPages = 10
        pageControl.pageIndicatorTintColor = UIColor.green
        pageControl.currentPageIndicatorTintColor = UIColor.red
        lblPage.text = "1"
    }

    @IBAction func pageChange(_ sender: UIPageControl) {
        lblPage.text = String(pageControl.currentPage + 1)
    }
    
}

