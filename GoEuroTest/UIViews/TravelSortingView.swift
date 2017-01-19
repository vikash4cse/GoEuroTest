//
//  TravelSortingView.swift
//  GoEuroTest
//
//  Created by Nagarro on 19/01/17.
//  Copyright © 2017 KV. All rights reserved.
//

import UIKit

@objc public protocol TravelSortingViewDelegate {
    
    func didSelecteSortingButton()
}

class TravelSortingView: UIView {
    
    @IBOutlet weak var delegate:TravelSortingViewDelegate?
    
    @IBOutlet weak var sortingButton: UIButton!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView()
    {
        let nibArray = Bundle.main.loadNibNamed("TravelSortingView", owner: self, options: nil);
        let mainView : UIView = nibArray?[0] as! UIView
        mainView.translatesAutoresizingMaskIntoConstraints = false;
        self.addSubview(mainView)
        
        let viewsDictionary = ["mainView":mainView];
        var constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[mainView]-0-|", options: NSLayoutFormatOptions(rawValue: UInt(0)), metrics: nil, views: viewsDictionary);
        self.addConstraints(constraints)
        
        constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[mainView]-0-|", options: NSLayoutFormatOptions(rawValue: UInt(0)), metrics: nil, views: viewsDictionary);
        self.addConstraints(constraints);
    }
    
    @IBAction func sortingButtonAction(_ sender: Any) {
        
        if let delegate = self.delegate {
            
            delegate.didSelecteSortingButton();
        }
    }
}
