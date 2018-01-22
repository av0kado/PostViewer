//
//  SearchField.swift
//  Portable
//

import UIKit

/// Search field with image to use as UISearchBar. Benefits are that you can set it's alignment.
extension UITextField {
    
    func setAttributedPlaceholderWithSearchImage(_ placeholderText: NSAttributedString) {
        let searchImageAttachment = TextAttachmentWithOffset(CGPoint(x: 0, y: -2), image: #imageLiteral(resourceName: "SearchIcon"))
        let searchImageString = NSAttributedString(attachment: searchImageAttachment)
        
        let resultString = NSMutableAttributedString(attributedString: searchImageString)
        let spaceString = NSAttributedString(string: "  ")
        resultString.append(spaceString)
        resultString.append(placeholderText)
        self.attributedPlaceholder = resultString
    }
    
    func setPlaceholderWithSearchImage(_ placeholder: String) {
        setAttributedPlaceholderWithSearchImage(NSAttributedString(string: placeholder))
    }
}

fileprivate class TextAttachmentWithOffset: NSTextAttachment {
    
    private var offset: CGPoint
    
    init(_ offset: CGPoint, image: UIImage) {
        self.offset = offset
        super.init(data: nil, ofType: nil)
        self.image = image
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func attachmentBounds(for textContainer: NSTextContainer?, proposedLineFragment lineFrag: CGRect, glyphPosition position: CGPoint, characterIndex charIndex: Int) -> CGRect {
        
        var bounds = CGRect()
        bounds.origin = offset
        bounds.size = image!.size
        return bounds
    }
}
