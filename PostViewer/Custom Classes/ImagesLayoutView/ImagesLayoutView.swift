//
//  ImagesLayoutView.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 21/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

import UIKit

/// Cost for images composition;
/// Cost between 2 and 0 for single image with single size class;
/// More cost means this composition is more suitable
private typealias Cost = Double

/// Default space between images
private let defaultSpaceBetweenImages = 2

/// Image object mapped with it's size class
private typealias ImageObjectWithSizeClass = (imageObject: ImageObject, sizeClass: SizeClass)

// MARK: - ImagesLayout

/// Layout object returned when layout is calculated
struct ImagesLayout {
    
    // MARK: Public
    
    /// Distance between images in layout;
    var spacesBetweenImages: Int = defaultSpaceBetweenImages
    
    /// Generating layout of images; available up to 10 images
    ///
    /// - Parameter images: images array, each image must conform to `ImagesLayoutViewImage` protocol
    /// - Parameter maxLines: maximum lines available
    /// - Returns: layout of images;
    init?(with images: [ImagesLayoutViewImage], maxLines: Int = 4) {
        
        let imagesCount = images.count
        let imagesForLines = Double(imagesCount) / Double(maxLines)
        
        guard imagesCount <= 10, maxLines > 0, ((imagesCount == 1) || (imagesForLines <= 3)) else {
            return nil
        }
        
        let images = images.map { return ImageObject($0) }
        
        var result: [[ImageObjectWithSizeClass]] = []
        
        // if 1 image, return just itself, coz there's no layout
        if images.count == 1 {
            let image = images[0]
            result = [[(image, image.bestSizeClass)]]
        }
        else {
            let calculationResult = ImagesLayout.getGroupsCost(withCurrentGroups: [], currentCost: 0, leftImages: images, depthsLeft: maxLines)
            
            result = calculationResult.groups
        }
        
        self.init(groups: result)
    }
    
    /// Height of layout with given width; Use this to process calculations
    ///
    /// - Parameters:
    ///   - width: width of view
    ///   - spacesBetweenImages: spaces between images
    /// - Returns: height in points
    func height(for width: Int) -> Int {
        
        // Return if no groups
        if groups.count == 0 {
            return 0
        }
        
        // Single element
        if groups.count == 1 && groups[0].count == 1 {
            
            let image = groups[0][0]
            let heightToWidth = CGFloat(image.imageObject.image.height) / CGFloat(image.imageObject.image.width)
            
            switch image.sizeClass {
            case .horizontal, .square:
                return Int(ceil(Double(heightToWidth) * Double(width)))
            case .vertical:
                return (width * 3) / 2
            }
        }
        
        // Not single element, we need width to be much wider than spaces
        if width <= 3 * spacesBetweenImages {
            return 0
        }
        
        var height = 0
        
        height += ((groups.count - 1) * spacesBetweenImages)
        
        // Calculate height for each group
        for group in groups {
            
            // Height basically depends on how many vertical spaces
            switch group.count {
            case 2:
                height += Int(ceil(Double(width - spacesBetweenImages) * 2 / 3))
            case 3:
                let item1 = group[0].sizeClass
                let item2 = group[1].sizeClass
                let item3 = group[2].sizeClass
                
                switch (item1, item2, item3) {
                case (.vertical, .vertical, .vertical):
                    height += Int(ceil(Double(width - 2 * spacesBetweenImages) * 2 / 3))
                case (.vertical, .horizontal, .horizontal), (.horizontal, .horizontal, .vertical):
                    height += Int(ceil(Double(width - spacesBetweenImages) * 2 / 3))
                default:
                    return 0
                }
            default:
                return 0
            }
        }
        
        return height
    }
    
    // MARK: Private
    
    fileprivate let groups: [[ImageObjectWithSizeClass]]
    
    fileprivate init(groups: [[ImageObjectWithSizeClass]]) {
        self.groups = groups
    }
    
    /// Groups with calculated cost and failure status
    private typealias GroupsWithCost = (groups: [[ImageObjectWithSizeClass]], cost: Cost, failure: Bool)
    
    /// Recursive function to calculate groups compositions
    ///
    /// - Parameters:
    ///   - currentGroups: current grouped images
    ///   - currentCost: current cost of grouped images
    ///   - leftImages: images not yet calculated
    ///   - depthsLeft: how much deeper we can afford to dig; must not dig if less than 1; failure if less than zero
    /// - Returns: result of calculation
    private static func getGroupsCost(withCurrentGroups currentGroups: [[ImageObjectWithSizeClass]], currentCost: Cost, leftImages: [ImageObject], depthsLeft: Int) -> GroupsWithCost {
        
        switch leftImages.count {
        case 0, 1:
            // Can't lay out 0 or 1 image in this layout
            break
        case 2, 3:
            if depthsLeft < 0 {
                break
            }
            
            // Can't split 2 or 3 items, so return
            var currentGroups = currentGroups
            let bestCostGroup = getBestCostGroup(for: leftImages)
            currentGroups.append(bestCostGroup.group)
            return (currentGroups, currentCost + bestCostGroup.cost, false)
        case 4:
            if depthsLeft <= 0 {
                break
            }
            
            // 4 items can be divided only straightly to 2 groups of 2 items
            var currentGroups = currentGroups
            let groupOf2 = Array(leftImages[0...1])
            let bestCostGroup = getBestCostGroup(for: groupOf2)
            currentGroups.append(bestCostGroup.group)
            return getGroupsCost(withCurrentGroups: currentGroups, currentCost: currentCost + bestCostGroup.cost, leftImages: Array(leftImages[2...]), depthsLeft: depthsLeft - 1)
        default:
            if depthsLeft <= 0 {
                break
            }
            
            // 1) First calculate best costs of 2 and 3 items groups
            
            // Group of 2
            let groupOf2 = Array(leftImages[0...1])
            let groupOf2BestCost = getBestCostGroup(for: groupOf2)
            var groupOf2CurrentGroups = currentGroups
            groupOf2CurrentGroups.append(groupOf2BestCost.group)
            let groupOf2CostResult = getGroupsCost(withCurrentGroups: groupOf2CurrentGroups,
                                                   currentCost: currentCost + groupOf2BestCost.cost,
                                                   leftImages: Array(leftImages[2...]),
                                                   depthsLeft: depthsLeft - 1)
            
            // Group of 3
            let groupOf3 = Array(leftImages[0...2])
            let groupOf3BestCost = getBestCostGroup(for: groupOf3)
            var groupOf3CurrentGroups = currentGroups
            groupOf3CurrentGroups.append(groupOf3BestCost.group)
            let groupOf3CostResult = getGroupsCost(withCurrentGroups: groupOf3CurrentGroups,
                                                   currentCost: currentCost + groupOf3BestCost.cost,
                                                   leftImages: Array(leftImages[3...]),
                                                   depthsLeft: depthsLeft - 1)
            
            // 2) Select best offer and return
            
            switch (groupOf2CostResult.failure, groupOf3CostResult.failure) {
            case (false, false):
                if groupOf3CostResult.cost >= groupOf2CostResult.cost {
                    return groupOf3CostResult
                } else {
                    return groupOf2CostResult
                }
            case (false, true):
                return groupOf2CostResult
            case (true, false):
                return groupOf3CostResult
            case (true, true):
                break
            }
        }
        
        return ([], 0, true)
    }
    
    /// Group with it's calculated cost
    private typealias GroupWithCost = (group: [ImageObjectWithSizeClass], cost: Cost)
    
    /// Gets best cost of group and returns group with size classes
    ///
    /// - Parameter group: group to calculate
    /// - Returns: image objects matched with size classes with best cost
    private static func getBestCostGroup(for group: [ImageObject]) -> GroupWithCost {
        
        if group.count == 2 {
            // Group of 2 images
            
            let item1 = group[0]
            let item2 = group[1]
            
            // There can be only 2 types: Square + Vertical or Vertical + Square
            let costSV = item1.cost(for: .square) + item2.cost(for: .vertical)
            let costVS = item1.cost(for: .vertical) + item2.cost(for: .square)
            
            // Return best offer
            if costSV >= costVS {
                return ([(item1, .square),
                         (item2, .vertical)],
                        costSV)
            }
            else {
                return ([(item1, .vertical),
                         (item2, .square)],
                        costVS)
            }
        }
        else if group.count == 3 {
            // Group of 3 images
            
            let item1 = group[0]
            let item2 = group[1]
            let item3 = group[2]
            
            // There can be only 3 types: 2 Horizontal + Vertical, Vertical + 2 Horizontal, 3 Vertical
            let costHHV = item1.cost(for: .horizontal) + item2.cost(for: .horizontal) + item3.cost(for: .vertical)
            let costVHH = item1.cost(for: .vertical) + item2.cost(for: .horizontal) + item3.cost(for: .horizontal)
            let costVVV = item1.cost(for: .vertical) + item2.cost(for: .vertical) + item3.cost(for: .vertical)
            
            // Return best offer
            if costVHH >= costHHV && costVHH >= costVVV {
                return ([(item1, .vertical),
                         (item2, .horizontal),
                         (item3, .horizontal)],
                        costVHH)
            }
            else if costHHV >= costVVV {
                return ([(item1, .horizontal),
                         (item2, .horizontal),
                         (item3, .vertical)],
                        costHHV)
            }
            else {
                return ([(item1, .vertical),
                         (item2, .vertical),
                         (item3, .vertical)],
                        costVVV)
            }
        }
        
        // Unsuitable group
        fatalError("Wrong usage of method")
    }
}

// MARK: - ImagesLayoutView

/// Provides image arrangement with custom layout;
/// Layouts images in 2x2 squares, 2x1 horizontal images and 1x2 vertical images;
/// Layouts single image in best fitting case;
class ImagesLayoutView: UIView {
    
    /// Background color of image when loading
    var imageBackgroundColor: UIColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    
    /// Layouted images
    var imageViews: [UIImageView] = []
    
    /// Default image view content mode
    var defaultImageViewContentMode = UIViewContentMode.scaleAspectFill
    
    // MARK: - Lay out
    
    /// Use this method to display layout of images; Loads images in layout
    ///
    /// - Parameter layout: ImagesLayout object got from `calculateLayout(with:)` method
    func setLayout(_ layout: ImagesLayout) {
    
        for subview in imageViews {
            subview.removeFromSuperview()
        }
        imageViews = []
        
        let groups = layout.groups
        
        if groups.count == 0 {
            return
        }
        
        if groups.count == 1 && groups[0].count == 1 {
            
            let image = groups[0][0]
            setSingleImage(image)
            return
        }
        
        for groupIndex in 0 ..< groups.count {
            
            let group = groups[groupIndex]
            let isLast = (groupIndex == (groups.count - 1))
            layoutGroup(group, layout: layout, isLast: isLast)
        }
    }
    
    /// Loads image for image view with given image object
    ///
    /// - Parameters:
    ///   - imageView: image view to load image in
    ///   - imageObject: image object to get image from
    private func loadImageForImageView(_ imageView: UIImageView, from imageObject: ImageObject) {
        imageView.contentMode = defaultImageViewContentMode
        
        if let image = imageObject.image.image {
            // If image already exists
            imageView.setImageOnMainQueue(image)
        } else {
            // Load from URL
            
            let maxSize = bounds.width
            let url = URL(string: imageObject.image.imageUrlString(withMaximumSideSize: Int(maxSize)))
            if let url = url {
                imageView.loadImage(with: url)
            }
        }
    }
    
    /// Lays out single image
    ///
    /// - Parameter image: image to lay out
    private func setSingleImage(_ image: ImageObjectWithSizeClass) {
        
        let imageView = UIImageView()
        imageView.backgroundColor = imageBackgroundColor
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)
        
        // Top and bottom
        NSLayoutConstraint(item: imageView, attribute: .top,
                           relatedBy: .equal,
                           toItem: self, attribute: .top,
                           multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: imageView, attribute: .bottom,
                           relatedBy: .equal,
                           toItem: self, attribute: .bottom,
                           multiplier: 1, constant: 0).isActive = true
        
        let heightToWidth = CGFloat(image.imageObject.image.height) / CGFloat(image.imageObject.image.width)
        
        // Horizontal position
        switch image.sizeClass {
        case .horizontal, .square:
            // Bind leading and trailing
            NSLayoutConstraint(item: imageView, attribute: .leading,
                               relatedBy: .equal,
                               toItem: self, attribute: .leading,
                               multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: imageView, attribute: .trailing,
                               relatedBy: .equal,
                               toItem: self, attribute: .trailing,
                               multiplier: 1, constant: 0).isActive = true
            
            // Proportions
            NSLayoutConstraint(item: imageView, attribute: .height,
                               relatedBy: .equal,
                               toItem: imageView, attribute: .width,
                               multiplier: heightToWidth, constant: 0).isActive = true
        case .vertical:
            // Center horizontally
            NSLayoutConstraint(item: imageView, attribute: .centerX,
                               relatedBy: .equal,
                               toItem: self, attribute: .centerX,
                               multiplier: 1, constant: 0).isActive = true
            
            // Width relative to layout view
            NSLayoutConstraint(item: imageView, attribute: .width,
                               relatedBy: .lessThanOrEqual,
                               toItem: self, attribute: .width,
                               multiplier: 1, constant: 0).isActive = true
            
            // Height relative to width
            NSLayoutConstraint(item: imageView, attribute: .height,
                               relatedBy: .equal,
                               toItem: self, attribute: .width,
                               multiplier: 1.5, constant: 0).isActive = true
            NSLayoutConstraint(item: imageView, attribute: .height,
                               relatedBy: .equal,
                               toItem: imageView, attribute: .width,
                               multiplier: heightToWidth, constant: 0).isActive = true
        }
        
        loadImageForImageView(imageView, from: image.imageObject)
        
        imageViews = [imageView]
    }
    
    /// Lays out groups of images
    ///
    /// - Parameters:
    ///   - group: group to lay out
    ///   - isLast: this is last group
    private func layoutGroup(_ group: [ImageObjectWithSizeClass], layout: ImagesLayout, isLast: Bool) {
        switch group.count {
        case 2:
            layoutGroupOf2(group, layout: layout, isLast: isLast)
        case 3:
            layoutGroupOf3(group, layout: layout, isLast: isLast)
        default:
            break
        }
    }
    
    // MARK: - Lay out group of 2
    
    /// Lays out group of 2 images
    ///
    /// - Parameters:
    ///   - group: group to lay out
    ///   - isLast: this is last group
    private func layoutGroupOf2(_ group: [ImageObjectWithSizeClass], layout: ImagesLayout, isLast: Bool) {
        
        struct Size {
            var width: CGFloat = 1
            var height: CGFloat = 1
        }
        
        let image1 = group[0], image2 = group[1]
        
        // Multiplier sizes, not real
        var item1Size = Size(), item2Size = Size()
        
        switch (image1.sizeClass, image2.sizeClass) {
        case (.square, .vertical):
            item1Size = Size(width: 2, height: 2)
            item2Size = Size(width: 1, height: 2)
        case (.vertical, .square):
            item1Size = Size(width: 1, height: 2)
            item2Size = Size(width: 2, height: 2)
        default:
            return
        }
        
        let views = [UIImageView(), UIImageView()]
        for view in views {
            view.clipsToBounds = true
            view.backgroundColor = imageBackgroundColor
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
        
        // Set top constraints
        var item: Any, attribute: NSLayoutAttribute, space: CGFloat
        if let lastImageView = imageViews.last {
            item = lastImageView
            attribute = .bottom
            space = CGFloat(layout.spacesBetweenImages)
        } else {
            item = self
            attribute = .top
            space = 0
        }
        
        for view in views {
            NSLayoutConstraint(item: view, attribute: .top,
                               relatedBy: .equal,
                               toItem: item, attribute: attribute,
                               multiplier: 1.0, constant: space).isActive = true
        }
        
        // Set horizontal constraints
        var horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "|[view1]-\(layout.spacesBetweenImages)-[view2]|",
            metrics: nil,
            views: ["view1" : views[0], "view2" : views[1]])
        
        horizontalConstraints.append(NSLayoutConstraint(item: views[0], attribute: .width,
                                                        relatedBy: .equal,
                                                        toItem: views[1], attribute: .width,
                                                        multiplier: item1Size.width / item2Size.width, constant: 0))
        
        NSLayoutConstraint.activate(horizontalConstraints)
        
        // Set heights via multipliers
        let viewsWithSizes = [(views[0], item1Size), (views[1], item2Size)]
        for viewWithSize in viewsWithSizes {
            let view = viewWithSize.0
            let size = viewWithSize.1
            NSLayoutConstraint(item: view, attribute: .height,
                               relatedBy: .equal,
                               toItem: view, attribute: .width,
                               multiplier: size.height / size.width, constant: 0).isActive = true
        }
        
        // Bind to bottom if needed
        if isLast {
            NSLayoutConstraint(item: views[0], attribute: .bottom,
                               relatedBy: .equal,
                               toItem: self, attribute: .bottom,
                               multiplier: 1.0, constant: 0).isActive = true
        }
        
        loadImageForImageView(views[0], from: image1.imageObject)
        loadImageForImageView(views[1], from: image2.imageObject)
        
        imageViews.append(contentsOf: views)
    }
    
    // MARK: - Lay out group of 3
    
    /// Lays out group of 3 images
    ///
    /// - Parameters:
    ///   - group: group to lay out
    ///   - isLast: this is last group
    private func layoutGroupOf3(_ group: [ImageObjectWithSizeClass], layout: ImagesLayout, isLast: Bool) {
        
        struct LayoutBinding {
            var item: Any?
            var attribute: NSLayoutAttribute
            var constant: CGFloat
            var multiplier: CGFloat
            
            init(item: Any?, attribute: NSLayoutAttribute, constant: CGFloat, multiplier: CGFloat = 1.0) {
                self.item = item
                self.attribute = attribute
                self.constant = constant
                self.multiplier = multiplier
            }
        }
        
        class ItemWithLayoutConfiguration {
            
            var imageObject: ImageObject
            var view: UIImageView = UIImageView()
            
            var topBinding: LayoutBinding? = nil
            var bottomBinding: LayoutBinding? = nil
            var leadingBinding: LayoutBinding? = nil
            var trailingBinding: LayoutBinding? = nil
            var widthBinding: LayoutBinding? = nil
            var heightBinding: LayoutBinding? = nil
            
            init(_ imageObject: ImageObject) {
                self.imageObject = imageObject
            }
        }
        
        // Create configs
        let items = group.map { return ItemWithLayoutConfiguration($0.imageObject) }
        
        let defaultSpace = CGFloat(layout.spacesBetweenImages)
        
        // Default top binding
        var topBinding: LayoutBinding
        
        if let view = imageViews.last {
            topBinding = LayoutBinding(item: view, attribute: .bottom, constant: defaultSpace)
        } else {
            topBinding = LayoutBinding(item: self, attribute: .top, constant: 0)
        }
        
        // Default bottom binding
        var bottomBinding: LayoutBinding?
        if isLast {
            bottomBinding = LayoutBinding(item: self, attribute: .bottom, constant: 0)
        }
        
        // Configure bindings
        switch (group[0].sizeClass, group[1].sizeClass, group[2].sizeClass) {
            
        // MARK: 3 vertical views
        case (.vertical, .vertical, .vertical):
            
            for item in items.enumerated() {
                
                let offset = item.offset
                let item = item.element
                
                // Default top
                item.topBinding = topBinding
                
                // Leading
                if offset == 0 {
                    item.leadingBinding = LayoutBinding(item: self, attribute: .leading, constant: 0)
                } else {
                    item.leadingBinding = LayoutBinding(item: items[offset - 1].view, attribute: .trailing, constant: defaultSpace)
                }
                
                // Height
                if offset == 0 {
                    item.heightBinding = LayoutBinding(item: item.view, attribute: .width, constant: 0, multiplier: 2.0)
                } else {
                    item.heightBinding = LayoutBinding(item: items[0].view, attribute: .height, constant: 0)
                }
                
                // Width
                if offset > 0 {
                    item.widthBinding = LayoutBinding(item: items[0].view, attribute: .width, constant: 0)
                }
            }
            
            // Trailing separately
            items[2].trailingBinding = LayoutBinding(item: self, attribute: .trailing, constant: 0)
            
            // Bottom separately
            items[2].bottomBinding = bottomBinding
            
        // MARK: Vertical and 2 horizontal views
        case (.vertical, .horizontal, .horizontal):
            
            // Top bindings
            items[0].topBinding = topBinding
            items[1].topBinding = topBinding
            items[2].topBinding = LayoutBinding(item: items[1].view, attribute: .bottom, constant: defaultSpace)
            
            // Vertical item bottom binding to second horizontal item
            items[0].bottomBinding = LayoutBinding(item: items[2].view, attribute: .bottom, constant: 0)
            
            // Horizontal bindings
            items[0].leadingBinding = LayoutBinding(item: self, attribute: .leading, constant: 0)
            items[1].leadingBinding = LayoutBinding(item: items[0].view, attribute: .trailing, constant: defaultSpace)
            items[2].leadingBinding = items[1].leadingBinding
            items[1].trailingBinding = LayoutBinding(item: self, attribute: .trailing, constant: 0)
            items[2].trailingBinding = items[1].trailingBinding
            items[1].widthBinding = LayoutBinding(item: items[0].view, attribute: .width, constant: 0, multiplier: 2.0)
            
            // Height bindings for items 2 and 3
            items[1].heightBinding = LayoutBinding(item: items[1].view, attribute: .width, constant: 0, multiplier: 0.5)
            items[2].heightBinding = LayoutBinding(item: items[1].view, attribute: .height, constant: 0)
            
            // Bottom binding
            items[2].bottomBinding = bottomBinding
            
        // MARK: 2 horizontal and vertical view
        case (.horizontal, .horizontal, .vertical):
            
            // Top bindings
            items[0].topBinding = topBinding
            items[1].topBinding = LayoutBinding(item: items[0].view, attribute: .bottom, constant: defaultSpace)
            items[2].topBinding = topBinding
            
            // Second horizontal item bottom binding to vertical item
            items[1].bottomBinding = LayoutBinding(item: items[2].view, attribute: .bottom, constant: 0)
            
            // Horizontal bindings
            items[0].leadingBinding = LayoutBinding(item: self, attribute: .leading, constant: 0)
            items[1].leadingBinding = items[0].leadingBinding
            items[0].trailingBinding = LayoutBinding(item: items[2].view, attribute: .leading, constant: -defaultSpace)
            items[1].trailingBinding = items[0].trailingBinding
            items[2].trailingBinding = LayoutBinding(item: self, attribute: .trailing, constant: 0)
            items[0].widthBinding = LayoutBinding(item: items[2].view, attribute: .width, constant: 0, multiplier: 2.0)
            
            // Height bindings for items 1 and 2
            items[0].heightBinding = LayoutBinding(item: items[0].view, attribute: .width, constant: 0, multiplier: 0.5)
            items[1].heightBinding = LayoutBinding(item: items[0].view, attribute: .height, constant: 0)
            
            // Bottom binding
            items[2].bottomBinding = bottomBinding
            
        default:
            return
        }
        
        // Configure views
        for item in items {
            item.view.clipsToBounds = true
            item.view.backgroundColor = imageBackgroundColor
            item.view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(item.view)
        }
        
        // Set all constraints
        for item in items {
            
            let view = item.view
            
            if let top = item.topBinding {
                NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal,
                                   toItem: top.item, attribute: top.attribute,
                                   multiplier: top.multiplier, constant: top.constant).isActive = true
            }
            if let bottom = item.bottomBinding {
                NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal,
                                   toItem: bottom.item, attribute: bottom.attribute,
                                   multiplier: bottom.multiplier, constant: bottom.constant).isActive = true
            }
            if let leading = item.leadingBinding {
                NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal,
                                   toItem: leading.item, attribute: leading.attribute,
                                   multiplier: leading.multiplier, constant: leading.constant).isActive = true
            }
            if let trailing = item.trailingBinding {
                NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal,
                                   toItem: trailing.item, attribute: trailing.attribute,
                                   multiplier: trailing.multiplier, constant: trailing.constant).isActive = true
            }
            if let width = item.widthBinding {
                NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal,
                                   toItem: width.item, attribute: width.attribute,
                                   multiplier: width.multiplier, constant: width.constant).isActive = true
            }
            if let height = item.heightBinding {
                NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal,
                                   toItem: height.item, attribute: height.attribute,
                                   multiplier: height.multiplier, constant: height.constant).isActive = true
            }
        }
        
        // Load images
        for item in items {
            loadImageForImageView(item.view, from: item.imageObject)
            imageViews.append(item.view)
        }
    }
    
    // MARK: -
}

/// Size classes for layout
///
/// - square: 2x2 square
/// - horizontal: 2x1 horizontal item
/// - vertical: 1x2 vertical item
fileprivate enum SizeClass {
    case square
    case horizontal
    case vertical
}

/// Wrap over ImagesLayoutViewImage
fileprivate class ImageObject {
    
    /// Width of original image
    private var width: Int {
        return image.width
    }
    /// Height of original image
    private var height: Int {
        return image.height
    }
    
    /// Original view image
    let image: ImagesLayoutViewImage
    
    /// Calculated costs for size classes of image
    private var sizeClassesCosts: [SizeClass : Cost] = [.square : 0,
                                                        .horizontal : 0,
                                                        .vertical : 0]
    
    /// Inits `ImageObject` with given `ImagesLayoutViewImage`
    ///
    /// - Parameter image: object conforming to `ImagesLayoutViewImage`
    init(_ image: ImagesLayoutViewImage) {
        self.image = image
        
        calculatePreferredSizeClasses()
    }
    
    /// `Cost` of given `SizeClass` for this object;
    ///
    /// - Parameter sizeClass: size class for object to get `Cost` from
    /// - Returns: cost of size class; from 0 to 2
    func cost(for sizeClass: SizeClass) -> Cost {
        let result = sizeClassesCosts[sizeClass]!
        return result
    }
    
    /// Best suitable `SizeClass` for this `ImageObject`
    var bestSizeClass: SizeClass {
        
        let squareCost = cost(for: .square)
        let horizontalCost = cost(for: .horizontal)
        let verticalCost = cost(for: .vertical)
        
        if squareCost >= horizontalCost && squareCost >= verticalCost {
            return .square
        } else if horizontalCost >= verticalCost {
            return .horizontal
        } else {
            return .vertical
        }
    }
    
    /// Calculates values of costs for all size classes
    func calculatePreferredSizeClasses() {
        
        let dWidth = Double(width)
        let dHeight = Double(height)
        
        if (dWidth / dHeight) >= 1.5 {
            // Image is more horizontal
            
            let verticalCost = pow((dHeight / dWidth), 3)
            let squareCost = 1 - verticalCost
            
            sizeClassesCosts[.horizontal] = 2
            sizeClassesCosts[.square] = squareCost
            sizeClassesCosts[.vertical] = verticalCost
        }
        else if (dHeight / dWidth) >= 1.5 {
            // Image is more vertical
            
            let horizontalCost = pow((dWidth / dHeight), 3)
            let squareCost = 1 - horizontalCost
            
            sizeClassesCosts[.vertical] = 2
            sizeClassesCosts[.square] = squareCost
            sizeClassesCosts[.horizontal] = horizontalCost
        }
        else {
            // Image is more square
            
            sizeClassesCosts[.square] = 2
            
            var horizontalCost: Cost
            var verticalCost: Cost
            
            if dWidth > dHeight {
                horizontalCost = pow((dHeight / dWidth), 2)
                verticalCost = 1 - horizontalCost
            }
            else {
                verticalCost = pow((dWidth / dHeight), 2)
                horizontalCost = 1 - verticalCost
            }
            
            sizeClassesCosts[.horizontal] = horizontalCost
            sizeClassesCosts[.vertical] = verticalCost
        }
    }
}
