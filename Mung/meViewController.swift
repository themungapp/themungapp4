//
//  meViewController.swift
//  Mung
//
//  Created by Chike Chiejine on 30/09/2016.
//  Copyright © 2016 Color & Space. All rights reserved.
//

import UIKit


class meViewController: UIViewController, SimpleTabsDelegate, UITableViewDataSource, UITableViewDelegate  {
    
    //Author Information
    
    
    var goalImages = ["pic1.png", "pic3.png", "pic4.jpg", ]
    var goalTitles = ["Paris Summer Vacation", "Fashion Photography Equipment", "Summer 18 Gap Year Fund" ]
    var goalAuthorProfiles = ["pro1.jpg", "pro3.jpg", "pro4.jpg"]
    var goalAuthorNames = ["Amani Roy", "Jaslene Proctor", "Desmond Kramer"]
    var liked = false
    
    var header : StretchHeader!
    var vc:SimpleTabsViewController!
    let tabContainerView = UIView()

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    
//        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        setupHeaderView()
        //Tabs Confiigure
        
        let tab1 = SimpleTabItem(title:"LIKED", count: 3)
        let tab2 = SimpleTabItem(title:"INVESTED", count: 2)
        let tab3 = SimpleTabItem(title:"FOLLOWERS", count: 0)
        let tab4 = SimpleTabItem(title:"FOLLOWING", count: 0)
        vc = SimpleTabsViewController.create(self, baseView: tabContainerView, delegate: self, items: [tab1,tab2,tab3,tab4])
        vc.setTabTitleColor(UIColor(red:0.54, green:0.54, blue:0.54, alpha:1.0))
        vc.setNumberColor(UIColor(red:0.17, green:0.17, blue:0.17, alpha:1.0))
        vc.setNumberBackgroundColor(UIColor.clear)
        vc.setMarkerColor(UIColor(red:0.01, green:0.68, blue:0.88, alpha:1.0))
        vc.setTabTitleFont(UIFont(name: "Proxima Nova Soft", size: 12 )!)
        vc.setNumberFont(UIFont(name: "Proxima Nova Soft", size: 14 )!)
        
   
        
    
    }
    
    
    
    func setupHeaderView() {
        
    
        
        let options = StretchHeaderOptions()
        options.position = .fullScreenTop
        
        header = StretchHeader()
        header.stretchHeaderSize(headerSize: CGSize(width: view.frame.size.width, height: 230),
                                 imageSize: CGSize(width: view.frame.size.width, height: 200),
                                 controller: self,
                                 options: options)
        header.imageView.backgroundColor = UIColor.clear
//        header.imageView.image = UIImage(named: "profile.jpg")
        
        //Measurements 
        
        let headerWidth = header.imageView.frame.width
        let headerHeight = header.imageView.frame.height
        let headerWidthCenter = headerWidth / 2
        let headerHeightCenter = headerHeight / 2
        //  Add Profile Image
        let profileImage = UIImageView()
        profileImage.frame = CGRect(x: headerWidthCenter - 40, y: headerHeightCenter - 80, width: 80, height: 80)
        profileImage.image = UIImage(named: "profile.jpg")
        profileImage.layer.cornerRadius = 40
        profileImage.layer.borderColor = UIColor.white.cgColor
        profileImage.layer.borderWidth = 3.0
        profileImage.clipsToBounds = true
        profileImage.contentMode = .scaleAspectFill
        header.addSubview(profileImage)
        
        // Add Profile Name
        
        let labelHalfWayPoint = headerWidthCenter - (headerWidth / 2) + 10
        
        let userName = UILabel()
        let lineHeight = userName.font.lineHeight
        userName.frame = CGRect(x: labelHalfWayPoint , y: headerHeight - 80 , width: headerWidth - 20, height: 21)
        userName.font = UIFont(name: "Proxima Nova Soft", size: 20 )
        userName.textColor = UIColor(red:0.17, green:0.17, blue:0.17, alpha:1.0)
        userName.textAlignment = .center
        userName.text = "Name"
        userName.lineBreakMode = .byWordWrapping
        userName.numberOfLines = 0
        header.addSubview(userName)
        
        print("PRINT LINEHEIGHT")
        print(lineHeight)
        
  
        tabContainerView.frame = CGRect(x: 0, y: headerHeight - 40, width: headerWidth, height: 80)
        header.addSubview(tabContainerView)
    
        
  

        tableView.tableHeaderView = header
    }


    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    // MARK: - ScrollView Delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        header.updateScrollViewOffset(scrollView)
        
//        // NavigationHeader alpha update
//        let offset : CGFloat = scrollView.contentOffset.y
//        if (offset > 50) {
//            let alpha : CGFloat = min(CGFloat(1), CGFloat(1) - (CGFloat(50) + (navigationView.frame.height) - offset) / (navigationView.frame.height))
//            navigationView.alpha = CGFloat(alpha)
//            
//        } else {
//            navigationView.alpha = 0.0;
//        }
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return goalImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

       
        //Get Cell and Index
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "goal", for: indexPath) as! goalViewCell
        let indexRow = (indexPath as NSIndexPath).row
        
        //Measurements
        
        let width = self.tableView.frame.width
        let height = cell.frame.height
        
        //Gradient Overlay
        
        cell.overlayGradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        cell.overlayGradient.locations = [0.0, 0.9]
        cell.overlayGradient.frame = CGRect(x: 0, y: 0, width: width, height: 300)
        cell.goalImage.layer.insertSublayer(cell.overlayGradient, at: 0)
        
        //Configure outlets
        
        cell.goalAuthorName.setTitle(goalAuthorNames[indexRow], for: .normal)
        cell.goalAuthorProfile.setImage(UIImage(named: goalAuthorProfiles[indexRow]), for: .normal)
        cell.goalTitle.text = goalTitles[indexRow]
        cell.goalImage.image = UIImage(named: goalImages[indexRow])
        
        // Set button targets
        
        cell.likeGoal.addTarget(self, action:#selector(likeButton), for: UIControlEvents.touchUpInside)
        cell.goalAuthorName.addTarget(self, action:#selector(authorProfile), for: UIControlEvents.touchUpInside)
        cell.goalAuthorProfile.addTarget(self, action:#selector(authorProfile), for: UIControlEvents.touchUpInside)
        cell.shareGoal.addTarget(self, action:#selector(shareGoal), for: UIControlEvents.touchUpInside)
        
        // Set Up button tags
        
        cell.goalAuthorName.tag = indexRow
        cell.goalAuthorProfile.tag = indexRow
        cell.shareGoal.tag = indexRow
        
        
        
        return cell

    
    }
    
    
    
    
    
    //Like button target function
    
    
    func likeButton(sender: UIButton){
        
        
        // Get index from sender
        
        let indexRow = sender.tag
        
        
        // Liked Status
        
        if liked == true {
            
            //  Current user is unliking
            
            liked = false
            
            //Set up normal button state
            
            let likedButton = UIImage(named: "linedHeart-icon.png")
            sender.setImage(likedButton, for: UIControlState.normal)
            
            
        } else {
            
            //  Current user is liking
            
            liked = true
            
            //Set up liked button state
            
            let likedButton = UIImage(named: "filledHeart-icon.png")?.withRenderingMode(.alwaysTemplate)
            sender.tintColor = UIColor(red:0.90, green:0.04, blue:0.20, alpha:1)
            sender.setImage(likedButton, for: UIControlState.normal)
            
            
        }
        
        
    }
    
    //Author profile target function
    
    
    func authorProfile(sender: UIButton){
        
        // Get index from sender
        
        let indexRow = sender.tag
    }
    
    // Share goal target function
    
    
    func shareGoal(sender: UIButton){
        
        // Get index from sender
        
        let indexRow = sender.tag
        
        
        let textToShare = "Swift is awesome!  Check out this website about it!"
        if let myWebsite = NSURL(string: "http://www.codingexplorer.com/")
        {
            let objectsToShare = [textToShare, myWebsite] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            //            //New Excluded Activities Code
            //            activityVC.excludedActivityTypes = [UIActivityTypeAirDrop, UIActivityTypeAddToReadingList]
            //            //
            
            self.present(activityVC, animated: true, completion: nil)
            
        }
        
        
    }
    
    
    
    
    // MARK : - SimpleTabsDelegate
    
    func tabSelected(_ tabIndex:Int){
        
        
    if tabIndex == 0 {
            
            
        
        
    }  else if tabIndex  == 1 {
    
    
    let vC = self.storyboard?.instantiateViewController(withIdentifier: "investViewNav")
    self.navigationController?.present(vC!, animated: true)

    }
        
    }
    
//            UIView.animate(withDuration: 0.5, animations: {
//                
// 
//
//  
//                
//            })
//        } else if tabIndex  == 1 {
//            
//            UIView.animate(withDuration: 0.5, animations: {
//                
//                self.discoverFeed.alpha = 0
//                self.newFeed.alpha = 1
//                self.anotherFeed.alpha = 0
//                
//            })
//            
//        } else {
//            
//            UIView.animate(withDuration: 0.5, animations: {
//                
//                self.discoverFeed.alpha = 0
//                self.newFeed.alpha = 0
//                self.anotherFeed.alpha = 1
//                
//            })
//            
//        }




}

