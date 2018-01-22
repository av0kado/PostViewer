//
//  PostsListPostCell.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 21/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

import UIKit

class PostsListPostCell: UITableViewCell, ConfigurableView {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var noContentView: UIView!
    @IBOutlet weak var imagesLayoutView: ImagesLayoutView!
    @IBOutlet weak var likesButton: UIButton!
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        imageView?.image = nil
        ownerNameLabel.text = nil
        dateLabel.text = nil
        likesButton.setTitle(nil, for: .normal)
    }

    // MARK: - ConfigurableView

    func configure(with object: Any) {

        guard let cellObject = object as? PostsListPostCellObject else {
            return
        }

        // Configure with cellObject
        
        let urlString = cellObject.avatar.urlString
        
        if let url = URL(string: urlString) {
            avatarImageView.loadImage(with: url)
        }
        
        ownerNameLabel.text = cellObject.ownerName
        
        dateLabel.text = dateFormatter.string(from: cellObject.date)
        
        if let imagesLayout = cellObject.imagesLayout {
            noContentView.isHidden = true
            imagesLayoutView.isHidden = false
            imagesLayoutView.setLayout(imagesLayout)
        }
        else {
            noContentView.isHidden = false
            imagesLayoutView.isHidden = true
        }
        
        likesButton.setTitle(String(cellObject.likesCount), for: .normal)
        likesButton.setImage(cellObject.isLiked ? #imageLiteral(resourceName: "LikesSelected") : #imageLiteral(resourceName: "Likes"), for: .normal)
    }
}
