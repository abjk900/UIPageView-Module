//
//  ViewController.swift
//  PageViewController
//
//  Created by NIA on 2018. 10. 4..
//  Copyright © 2018년 NIA. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    //1. ScrollView and PageControl 선언
    let scrollView = UIScrollView()
    let pageController: UIPageControl = {
       let paegeNation = UIPageControl()
        paegeNation.pageIndicatorTintColor = .lightGray
        return paegeNation
    }()
    
    //2. slide nib 제작 및 array 화
    var slides: [Slide] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        view.backgroundColor = .white
        
        slides = createSlides()
        setupSlideOnScrollView(slides: slides)
        setupScrollView()
    }
    
    //2. slide nib 제작 및 array 화
    func createSlides() -> [Slide]{
        let slide1: Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide1.imgeView.image = UIImage(named: "Unknown.jpeg")
        slide1.labelTitle.text = "햄버그"
        
        let slide2: Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide2.imgeView.image = UIImage(named: "Unknown-1.jpeg")
        slide2.labelTitle.text = "떡볶이"
        
        let slide3: Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide3.imgeView.image = UIImage(named: "Unknown-2.jpeg")
        slide3.labelTitle.text = "연어"
        
        let slide4: Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide4.imgeView.image = UIImage(named: "Unknown-3.jpeg")
        slide4.labelTitle.text = "김치전"
        
        return [slide1, slide2, slide3, slide4]
    }
    
    //3. scrollView에 slides 삽입.
    func setupSlideOnScrollView(slides: [Slide]){
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0..<slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
    
    //4. scroll 이 돌아갈때 pagenation 이 패스되며 돌아가게
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pageController.currentPage = Int(pageIndex)
    }
    
    //5. 마지막으로 페이지네이션 된 스크롤뷰를 뷰에 얹기
    func setupScrollView() {
        self.view.addSubview(scrollView)
        self.view.addSubview(pageController)
        
        scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        scrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        pageController.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 60, paddingRight: 0, width: 70, height: 0)
        pageController.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        pageController.numberOfPages = slides.count
        pageController.currentPage = 0
        view.bringSubviewToFront(pageController)
    }


}

