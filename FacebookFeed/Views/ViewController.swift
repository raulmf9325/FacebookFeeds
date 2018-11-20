//
//  ViewController.swift
//  FacebookFeed
//
//  Created by Raul Mena on 11/16/18.
//  Copyright © 2018 Raul Mena. All rights reserved.
//

import UIKit

class FeedController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var posts: [Post] = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        collectionView.alwaysBounceVertical = true
        navigationItem.title = "Facebook Feed"
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: "FeedCellId")
        
        
        let postMark = Post()
        postMark.name = "Mark Zuckerberg"
        postMark.statusText = "Meanwhile, the beast turned to the dark side"
        postMark.imageName = "zuckprofile"
        postMark.statusImageName = "zuckdog"
        postMark.numLikes = "488"
        postMark.numComments = "10.7K"
        
        let postJobs = Post()
        postJobs.name = "Steve Jobs"
        postJobs.imageName = "steve_profile"
        postJobs.statusImageName = "steve_status"
        postJobs.statusText = "My favorite things in life don’t cost any money. It’s really clear that the most precious resource we all have is time.\n Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven’t found it yet, keep looking. Don’t settle. As with all matters of the heart, you’ll know when you find it."
        postJobs.numLikes = "5K"
        postJobs.numComments = "1.2K"
        
        
        let postGandhi = Post()
        postGandhi.name = "Mahatma Gandhi"
        postGandhi.imageName = "gandhi"
        postGandhi.statusText = "Where there is love there is life.\n Happiness is when what you think, what you say, and what you do are in harmony. \n The weak can never forgive. Forgiveness is the attribute of the strong. \n Strength does not come from physical capacity. It comes from an indomitable will. \n In a gentle way, you can shake the world."
        postGandhi.statusImageName = "gandhi_status"
        postGandhi.numLikes = "1K"
        postGandhi.numComments = "457"
        
        posts = [postMark, postJobs, postGandhi]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCellId", for: indexPath) as! FeedCell
        cell.post = posts[indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let height = posts[indexPath.item].statusText?.height(withConstrainedWidth: view.frame.width, font: UIFont.systemFont(ofSize: 14)){
            let knownHeight: CGFloat = 8 + 44 + 4 + 4 + 200 + 8 + 24 + 8 + 0.5 + 40
            return CGSize(width: view.frame.width, height: height + knownHeight + 16)
        }
        
        return CGSize(width: view.frame.width, height: 400)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.invalidateLayout()
    }
    
}

extension UIView{
    func addConstraintsWithFormat(format: String, views: UIView...){
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated(){
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}


/*  Extending String object to include height function
 */

extension String {
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.height
    }
    
}

extension UIView{
    
    func fillSuperView(){
        anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor)
    }
    
    func anchorSize(to view: UIView){
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize? = nil){
        
        translatesAutoresizingMaskIntoConstraints = false                                               // Activate auto layout
        
        if let top = top{
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading{
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom{
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true         // bottom and trailing constants must be negative
        }
        
        if let trailing = trailing{
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true      // bottom and trailing constants must be negative
        }
        
        if let size = size{
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        
    }
    
}
