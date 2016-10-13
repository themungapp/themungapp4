//
//  SimpleTabItem.swift
//  SimpleTabsViewController
//
//  Created by David Collado Sela on 19/5/15.
//  Copyright (c) 2015 David Collado Sela. All rights reserved.
//

import UIKit

open class SimpleTabItem:NSObject{
    var title = ""
    var forceShowCount = false
    var count = 0
    var index = 0
    
    internal var tabView:UIView!
    internal var label:UILabel!
    internal var countView:UIView!
    internal var countLabel:UILabel!
    internal var button:UIButton!
    
    internal var titleColor:UIColor!
    internal var titleFont:UIFont!
    internal var numberBackgroundColor:UIColor!
    internal var numberFont:UIFont!
    internal var numberColor:UIColor!
    
    fileprivate var tabContainer:SimpleTabsViewController!
    
    fileprivate var previousTab:SimpleTabItem?
    fileprivate var nextTab:SimpleTabItem?
    
    fileprivate var labelConstraints = [NSLayoutConstraint]()
    
    public init(title:String,forceShowCount:Bool = true,count:Int=0){
        self.title = title
        self.forceShowCount = forceShowCount
        self.count = count
    }
    
    open func createTabView(_ textFont:UIFont,textColor:UIColor,numberFont:UIFont,numberColor:UIColor,numberBackgroundColor:UIColor,tabContainer:SimpleTabsViewController,previousTab:SimpleTabItem?,nextTab:SimpleTabItem?)->UIView{
        
        self.titleColor = textColor
        self.titleFont = textFont
        self.numberBackgroundColor = numberBackgroundColor
        self.numberFont = numberFont
        self.numberColor = numberColor
        
        self.tabContainer = tabContainer
        tabView = UIView(frame: CGRect(x: 100, y: 0, width: 100, height: 43))
        tabView.translatesAutoresizingMaskIntoConstraints = false
        label = UILabel()
        label.setContentHuggingPriority(251, for: UILayoutConstraintAxis.horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = self.title
        tabView.addSubview(label)
        if(self.forceShowCount || self.count > 0){
            showCountView()
        }else{
            setLabelConstraints(label,container: tabView)
        }
        
        button = UIButton()
        button.addTarget(self, action: #selector(SimpleTabItem.tabPressed), for: UIControlEvents.touchUpInside)
        button.setContentHuggingPriority(250, for: UILayoutConstraintAxis.horizontal)
        button.translatesAutoresizingMaskIntoConstraints = false
        tabView.addSubview(button)
        setButtonConstraints(button,container: tabView)
        
        self.previousTab = previousTab
        self.nextTab = nextTab
        updateStyle()
        return tabView
    }
    
    internal func updateStyle(){
        if let countLabel = countLabel{
            countLabel.font = numberFont
            countLabel.textColor = numberColor
        }
        if let countView = countView{
            countView.backgroundColor = numberBackgroundColor
        }
        label.font = titleFont
        label.textColor = titleColor
        
        

    }
    
    internal func updateCount(_ count:Int){
        self.count = count
        if(self.forceShowCount || self.count > 0){
            showCountView()
        }else{
            hideCountView()
        }
    }
    
    fileprivate func showCountView(){
        if(countView == nil){
            countView = UIView()
            countView.translatesAutoresizingMaskIntoConstraints = false
            countView.layer.cornerRadius = 10
            countLabel = UILabel()
            countLabel.translatesAutoresizingMaskIntoConstraints = false
            countView.addSubview(countLabel)

            tabView.addSubview(countView)
            tabView.removeConstraints(labelConstraints)
            label.removeConstraints(labelConstraints)
            setCountLabelConstraints(countLabel, container:tabView, countView:countView)
            setLabelWithCountConstraints(label,countView:countView,container: tabView)
            


            updateStyle()
        }
        countLabel.text = String(self.count)
    }
    
    fileprivate func hideCountView(){
        if(countView != nil){
            countView.removeFromSuperview()
            countView = nil
            setLabelConstraints(label,container: tabView)
        }
    }
    
    internal func tabPressed(){
        tabContainer.tabSelected(self.index)
    }
    
    //MARK: - Constraints
    
    internal func setConstraints(){
        setTabCommonConstraints()
        
        if let previousTab = previousTab{
            if(nextTab != nil){
                //Middle
                setMiddleTabConstraints(previousTab)
            }else{
                //Last
                setLastTabConstraints(previousTab)
            }
        }else{
            //First
            setFirstTabConstraints()
        }
    }
    
    

    
    fileprivate func setCountLabelConstraints(_ countLabel:UILabel,container:UIView, countView:UIView){
        
        
        
        let tabHeight = container.frame.size.height
        let tabWidth = container.frame.size.width
        let tabY = container.frame.origin.y - tabHeight
        let tabX = container.frame.origin.x + tabWidth
        
        
        
        let widthConstraint = NSLayoutConstraint(item: countLabel, attribute: .width, relatedBy: .equal,
                                                 toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: tabWidth)
        
//        let heightConstraint = NSLayoutConstraint(item: countLabel, attribute: .height, relatedBy: .equal,
//                                                  toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 5)
        
        let xConstraint = NSLayoutConstraint(item: countLabel, attribute: .centerX, relatedBy: .equal, toItem: container, attribute: .centerX, multiplier: 1, constant: 0)
        
        label.backgroundColor = UIColor.yellow
        countLabel.textAlignment = .center
        
 
        
        let bottomSpace = NSLayoutConstraint(item: container, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: countLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 2)
        
        let topSpace = NSLayoutConstraint(item: countLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: container, attribute: NSLayoutAttribute.top, multiplier: 1, constant: -35)
        
        container.addConstraints([widthConstraint, bottomSpace,topSpace, xConstraint])
        
        
        
//        container.addConstraints([trailingSpace,leadingSpace,bottomSpace,topSpace, trailingSpaceTwo])
        
    }
    
    
    fileprivate func setLabelWithCountConstraints(_ label:UILabel,countView:UIView,container:UIView){
        let alignYCenter = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: container, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 4)
        
        let trailingSpace = NSLayoutConstraint(item: countView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: label, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 11)
        
        let trailingSpaceFromCount = NSLayoutConstraint(item: container, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: countView, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        let leadingSpace = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: container, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 11)
        let centerY = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: countView, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: -10)
        
        
        
  
        labelConstraints = [alignYCenter,trailingSpace,trailingSpaceFromCount,leadingSpace,centerY]
        
        
        
        
        
        
        
        container.addConstraints(labelConstraints)
    }
    
    fileprivate func setLabelConstraints(_ label:UILabel,container:UIView){
        let alignYCenter = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: container, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 4)
        let trailingSpace = NSLayoutConstraint(item: container, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: label, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 11)
        let leadingSpace = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: container, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 11)
        labelConstraints = [alignYCenter,trailingSpace,leadingSpace]
        container.addConstraints(labelConstraints)
    }
    
    
    
    fileprivate func setButtonConstraints(_ button:UIButton,container:UIView){
        let trailingSpace = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: container, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        let leadingSpace = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: container, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        let bottonSpace = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: container, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        let topSpace = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: container, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        container.addConstraints([trailingSpace,leadingSpace,bottonSpace,topSpace])
    }
    
    // MARK : - Tab constraints
    
    fileprivate func setTabCommonConstraints(){
        let bottonSpace = NSLayoutConstraint(item: tabView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: tabContainer.tabsContainer, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: -1)
        let topSpace = NSLayoutConstraint(item: tabView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: tabContainer.tabsContainer, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        tabContainer.tabsContainer.addConstraints([bottonSpace,topSpace])
    }
    
    fileprivate func setFirstTabConstraints(){
        let leadingSpace = NSLayoutConstraint(item: tabView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: tabContainer.tabsContainer, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        tabContainer.tabsContainer.addConstraints([leadingSpace])
    }
    
    fileprivate func setMiddleTabConstraints(_ previousTab:SimpleTabItem){
        let leadingSpace = NSLayoutConstraint(item: tabView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: previousTab.tabView, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        tabContainer.tabsContainer.addConstraints([leadingSpace])
    }
    
    fileprivate func setLastTabConstraints(_ previousTab:SimpleTabItem){
        let trailingSpace = NSLayoutConstraint(item: tabView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: tabContainer.tabsContainer, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        
        let leadingSpace = NSLayoutConstraint(item: tabView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: previousTab.tabView, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        tabContainer.tabsContainer.addConstraints([trailingSpace,leadingSpace])
    }
}
