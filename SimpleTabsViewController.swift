//
//  SimpleTabberViewController.swift
//  SimpleTabberViewController
//
//  Created by David Collado Sela on 19/5/15.
//  Copyright (c) 2015 David Collado Sela. All rights reserved.
//

import UIKit

open class SimpleTabsViewController: UIViewController {
    
    open class func create(_ parentVC:UIViewController?,baseView:UIView?,delegate:SimpleTabsDelegate?,items:[SimpleTabItem]) -> SimpleTabsViewController{
        let newVC = SimpleTabsViewController(items: items)
        newVC.delegate = delegate
        if let parentVC = parentVC{
            newVC.willMove(toParentViewController: parentVC)
        }
        if let baseView = baseView{
            baseView.addSubview(newVC.view)
        }else{
            parentVC?.view.addSubview(newVC.view)
        }
        newVC.didMove(toParentViewController: parentVC)
        if let baseView = baseView{
            newVC.view.frame = CGRect(origin: CGPoint(x: 0,y: 0), size: baseView.frame.size)
        }else{
            if let parentVC = parentVC{
                newVC.view.frame = CGRect(origin: CGPoint(x: 0,y: 0), size: parentVC.view.frame.size)
            }else{
                newVC.view.frame = CGRect(origin: CGPoint(x: 0,y: 0), size: CGSize(width: UIScreen.main.bounds.width, height: 50))
            }
        }
        return newVC
    }
    
    var items:[SimpleTabItem] = [SimpleTabItem]()
    var currentTab = 0
    weak var delegate:SimpleTabsDelegate?
    
    var tabsContainer: UIView!
    
    var activeMarker: UIView!
    
    var bottomReference: UIView!
    
    var centerMarkerConstraint:NSLayoutConstraint?
    var widthMarkerConstraint:NSLayoutConstraint?
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        createBaseView()
        createMenu()
        setCurrentTab(0, animated: false)
    }
    
    convenience init(items:[SimpleTabItem]) {
        self.init(nibName: nil, bundle: nil)
        self.items = items
    }
    
    open func setTabCount(_ tabIndex:Int,count:Int){
        if(self.items[tabIndex].tabView != nil){
            self.items[tabIndex].updateCount(count)
        }
    }
    
    //MARK: - Base View
    
    fileprivate func createBaseView(){
        self.view.backgroundColor = fillColor
        self.view.clipsToBounds = true
        createBottomView()
        createTabsContainer()
        createMarker()
    }
    
    fileprivate func createBottomView(){
        bottomReference = UIView(frame: CGRect(x: -10, y: 48, width: self.view.bounds.width, height: 3))
        bottomReference.backgroundColor = bottomFillColor
        bottomReference.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(bottomReference)
        let trailingConstraint = NSLayoutConstraint(item: self.view, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: bottomReference, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: -10)
        let leadingConstraint = NSLayoutConstraint(item: bottomReference, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: -10)
        let bottomSpaceConstraint = NSLayoutConstraint(item: self.view, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: bottomReference, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: bottomReference, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 2)
        bottomReference.addConstraint(heightConstraint)
        self.view.addConstraints([trailingConstraint,leadingConstraint,bottomSpaceConstraint])
    }
    
    fileprivate func createTabsContainer(){
        tabsContainer = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 50))
        tabsContainer.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tabsContainer)
        let centerXConstraint = NSLayoutConstraint(item: self.view, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: tabsContainer, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let centerYConstraint = NSLayoutConstraint(item: self.view, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: tabsContainer, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: -4)
        let topConstraint = NSLayoutConstraint(item: tabsContainer, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        self.view.addConstraints([centerXConstraint,centerYConstraint,topConstraint])
    }
    
    fileprivate func createMarker(){
        activeMarker = UIView(frame: CGRect(x: 50, y: 50, width: 200, height: 4))
        activeMarker.backgroundColor = markerFillColor
        activeMarker.translatesAutoresizingMaskIntoConstraints = false
        tabsContainer.addSubview(activeMarker)
        let bottomSpaceConstraint = NSLayoutConstraint(item: tabsContainer, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: activeMarker, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 8)
        let heightConstraint = NSLayoutConstraint(item: activeMarker, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 2)
        activeMarker.addConstraint(heightConstraint)
        tabsContainer.addConstraints([bottomSpaceConstraint])
    }
    
    //MARK: - Tabs
    
    internal func tabSelected(_ tab:Int){
        setCurrentTab(tab,animated:true)
        delegate?.tabSelected(tab)
    }
    
    open func setCurrentTab(_ tab:Int,animated:Bool){
        currentTab = tab
        if(centerMarkerConstraint != nil && widthMarkerConstraint != nil){
            self.tabsContainer.removeConstraints([centerMarkerConstraint!,widthMarkerConstraint!])
        }
        centerMarkerConstraint = NSLayoutConstraint(item: activeMarker, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.items[currentTab].tabView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        widthMarkerConstraint = NSLayoutConstraint(item: activeMarker, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self.items[currentTab].tabView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        if(animated){
            self.tabsContainer.addConstraints([self.widthMarkerConstraint!,self.centerMarkerConstraint!])
            self.tabsContainer.setNeedsUpdateConstraints()
            UIView.animate(withDuration: 0.1, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                self.view.layoutIfNeeded()
                
                }, completion: { finished in
            })
        }else{
            tabsContainer.addConstraints([widthMarkerConstraint!,centerMarkerConstraint!])
        }
    }
    
    //MARK: - Menu Creation
    
    fileprivate func createMenu(){
        for i in 0 ..< items.count {
            items[i].index = i
            let tab = createTab(items[i])
            self.tabsContainer.addSubview(tab)
            items[i].setConstraints()
            

            
            
            
            
        }
    }
    
    fileprivate func createTab(_ item:SimpleTabItem) -> UIView{
        var previousItem:SimpleTabItem?
        if((item.index - 1) >= 0){
            previousItem = self.items[item.index - 1]
        }
        var nextItem:SimpleTabItem?
        if((item.index + 1) < self.items.count){
            nextItem = self.items[item.index + 1]
        }
        return item.createTabView(tabsFont, textColor: textColor, numberFont: numbersFont, numberColor: numbersColor, numberBackgroundColor: numbersBackgroundColor, tabContainer: self,previousTab:previousItem,nextTab:nextItem)
    }
    
    // MARK: - Style
    
    var textColor:UIColor = UIColor.black
    var numbersColor:UIColor = UIColor.black
    var numbersBackgroundColor:UIColor = UIColor.yellow
    var markerFillColor:UIColor = UIColor.red
    var tabsFont = UIFont.systemFont(ofSize: 10)
    var numbersFont = UIFont.systemFont(ofSize: 14)
    var bottomFillColor = UIColor(red:0.01, green:0.68, blue:0.88, alpha:0)
    var fillColor = UIColor.white
    
    open func setTabTitleColor(_ color:UIColor){
        self.textColor = color
        updateTabsStyle()
    }
    
    open func setNumberColor(_ color:UIColor){
        numbersColor = color
        


        updateTabsStyle()
    }
    
    open func setNumberBackgroundColor(_ color:UIColor){
        numbersBackgroundColor = color
        updateTabsStyle()
    }
    
    open func setMarkerColor(_ color:UIColor){
        markerFillColor = color
        activeMarker.backgroundColor = markerFillColor
    }
    
    open func setTabTitleFont(_ font:UIFont){
        tabsFont = font
        updateTabsStyle()
    }
    
    open func setNumberFont(_ font:UIFont){
        numbersFont = font
        updateTabsStyle()
    }
    
    open func setBottomBackgroundColor(_ color:UIColor){
        bottomFillColor = color
        bottomReference.backgroundColor = bottomFillColor
    }
    
    open func setBackgroundColor(_ color:UIColor){
        fillColor = color
        self.view.backgroundColor = fillColor
    }
    
    fileprivate func updateTabsStyle(){
        for tab in self.items{
            tab.titleColor = self.textColor
            tab.titleFont = self.tabsFont
            tab.numberFont = self.numbersFont
            tab.numberColor = self.numbersColor
            tab.numberBackgroundColor = self.numbersBackgroundColor
    
            tab.updateStyle()
        }
    }
    
    deinit{
        delegate = nil
        tabsContainer = nil
        activeMarker = nil
        bottomReference = nil
        centerMarkerConstraint = nil
        widthMarkerConstraint = nil
    }

}
