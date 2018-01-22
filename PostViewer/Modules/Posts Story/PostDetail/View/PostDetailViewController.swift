//
//  PostDetailViewController.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 22/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

import UIKit

class PostDetailViewController: UIViewController, PostDetailViewInput, ConfigurableModuleController {
    
    var output: PostDetailViewOutput!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var noFunctionalityView: UIView!
    @IBOutlet weak var deletedView: UIView!
    @IBOutlet weak var imagesStackView: UIStackView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.viewWillPresent()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    // MARK: - Actions
    
    @objc func likePressed() {
        output.like()
    }
    
    @objc func refresh(_ refreshControl: UIRefreshControl) {
        output.didUpdate()
        refreshControl.endRefreshing()
    }

    // MARK: - PostDetailViewInput

    func setupInitialState() {
        textLabel.superview?.isHidden = true
        noFunctionalityView.isHidden = true
        deletedView.isHidden = true
        
        ownerNameLabel.text = ""
        dateLabel.text = ""
        
        likeButton.addTarget(self, action: #selector(likePressed), for: .touchUpInside)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        scrollView.refreshControl = refreshControl
    }
    
    func setPostOwner(_ user: User) {
        
        setAvatar(user.avatar)
        
        ownerNameLabel.text = "\(user.firstName) \(user.lastName)"
    }
    
    func setPostOwner(_ group: Group) {
        
        setAvatar(group.avatar)
        
        ownerNameLabel.text = group.name
    }
    
    func set(postDate: Date, text: String?, images: [AttachmentImage]?) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        
        dateLabel.text = dateFormatter.string(from: postDate)
        
        var noData = true
        
        if text != nil && text!.count > 0 {
            noData = false
            textLabel.text = text
            textLabel.superview?.isHidden = false
        }
        
        if let images = images {
            noData = false
            setImages(images)
            imagesStackView.isHidden = false
        }
        
        if noData {
            noFunctionalityView.isHidden = false
        }
    }
    
    func setLikes(_ likesCount: Int, isLiked: Bool) {
        likeButton.setImage(isLiked ? #imageLiteral(resourceName: "LikesSelected") : #imageLiteral(resourceName: "Likes"), for: .normal)
        likeButton.setTitle(String(likesCount), for: .normal)
    }
    
    func setPostDeleted() {
        
        deletedView.isHidden = false
        imagesStackView.isHidden = true
        textLabel.superview?.isHidden = true
        noFunctionalityView.isHidden = true
        
        avatarImageView.image = nil
        ownerNameLabel.text = StringsHelper.string(for: .deleted)
        dateLabel.text = nil
    }
    
    // MARK: - ConfigurableModuleController
    
    func configureModule(with object: Any) {
        
        if let post = object as? Post {
            output.configure(with: post)
        }
    }
    
    // MARK: - Helpers
    
    /// Sets avatar
    func setAvatar(_ avatar: Avatar) {
        let urlString = avatar.urlString
        
        if let url = URL(string: urlString) {
            avatarImageView.loadImage(with: url)
        }
    }
    
    /// Sets images and loads them
    func setImages(_ images: [AttachmentImage]) {
        
        for subview in imagesStackView.subviews {
            subview.removeFromSuperview()
        }
        
        let boundsWidth = view.bounds.width
        
        for image in images {
            
            var size = CGSize.zero
            
            size.width = view.bounds.width
            size.height = CGFloat(image.height) / CGFloat(image.width) * size.width
            
            let heightToBoundsWidth = size.height / boundsWidth
            if (heightToBoundsWidth) > 2 {
                size.height = 2 * boundsWidth
                size.width = (2 / heightToBoundsWidth) * size.width
            }
            
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            let maximumSize = Int(view.contentScaleFactor) * Int(max(size.width, size.height))
            
            if let url = URL(string: image.imageUrlString(withMaximumSideSize: maximumSize)) {
                
                imageView.loadImage(with: url)
            }
            
            imagesStackView.addArrangedSubview(imageView)
            
            NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal,
                               toItem: nil, attribute: .notAnAttribute,
                               multiplier: 1, constant: size.width).isActive = true
            NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal,
                               toItem: nil, attribute: .notAnAttribute,
                               multiplier: 1, constant: size.height).isActive = true
        }
    }
}
