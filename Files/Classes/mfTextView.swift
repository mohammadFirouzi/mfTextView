//
//  mfTextView.swift
//  mfTextView
//
//  Created by Mohammad Firouzi on 9/1/20.
//  Copyright © 2020 Mohammad Firouzi. All rights reserved.
//

import UIKit

@IBDesignable public class mfTextView: UIView {
    
    //MARK:- setup nib
    @IBOutlet var contentView: UIView!
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
        
        //MARK:- configurations(attributes didSet will call after this function(if value set in storyBoard) so we can set default attributes here if needed)
        txtContent.delegate = self
        
        lblTitle.text = titleText
        lblTitle.textColor = titleColor
        lblTitle.font = titleFont
        
        lblError.text = String()
        lblError.textColor = errorColor
        lblError.font = errorFont
        
        
        lblPlaceholder.text = placeholderText
        lblPlaceholder.textColor = placeholderColor
        lblPlaceholder.font = placeholderFont
        
        txtContent.text = contentText
        txtContent.textColor = contentColor
        txtContent.font = contentFont
        txtContent.textContainerInset = .zero
        txtContent.textContainer.lineFragmentPadding = 0.0
        
        vwBottomBorder.backgroundColor = bottomBorderColor
        
        cnsTxtContentHeight.constant = contentMaxHeight
        
    }
    
    //MARK:- outlets
    public weak var delegate: mfTextViewDelegate? = nil
    
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblError: UILabel!
    @IBOutlet private weak var lblPlaceholder: UILabel!
    @IBOutlet private weak var txtContent: UITextView!
    @IBOutlet private var cnsTxtContentHeight: NSLayoutConstraint!
    @IBOutlet private weak var vwBottomBorder: UIView!
    
    //MARK:- title attributes
    @IBInspectable public var titleText: String = String() {
        didSet {
            lblTitle.text = titleText
        }
    }
    
    @IBInspectable public var titleColor: UIColor = .black {
        didSet {
            lblTitle.textColor = titleColor
        }
    }
    
    public var titleFont: UIFont = .systemFont(ofSize: 15) {
        didSet {
            lblTitle.font = titleFont
        }
    }
    
    //MARK:- error attributes
    @IBInspectable public var errorColor: UIColor = .red {
        didSet {
            lblError.textColor = errorColor
        }
    }
    
    public var errorFont: UIFont = .systemFont(ofSize: 13) {
        didSet {
            lblError.font = errorFont
        }
    }
    
    //MARK:- placeholder attributes
    @IBInspectable public var placeholderText: String = String() {
        didSet {
            lblPlaceholder.text = placeholderText
        }
    }
    
    @IBInspectable public var placeholderColor: UIColor = .gray {
        didSet {
            lblPlaceholder.textColor = placeholderColor
        }
    }
    
    public var placeholderFont: UIFont = .systemFont(ofSize: 14) {
        didSet {
            lblPlaceholder.font = placeholderFont
        }
    }
    
    //MARK:- content attributes
    @IBInspectable public var contentText: String = String() {
        didSet {
            txtContent.text = contentText
            refreshPlaceholder()
            checkMaxHeight()
        }
    }
    
    @IBInspectable public var contentColor: UIColor = .black {
        didSet {
            txtContent.textColor = contentColor
        }
    }
    
    public var contentFont: UIFont = .systemFont(ofSize: 14) {
        didSet {
            txtContent.font = contentFont
        }
    }
    
    @IBInspectable public var contentMaxHeight: CGFloat = 0 {
        didSet {
            cnsTxtContentHeight.constant = contentMaxHeight
            checkMaxHeight()
        }
    }
    
    //MARK:- bottomBorder
    @IBInspectable public var bottomBorderColor: UIColor = .lightGray {
        didSet {
            vwBottomBorder.backgroundColor = bottomBorderColor
        }
    }
    @IBInspectable public var bottomBorderResponderColor: UIColor = .black
    
    
    //MARK:- functions
    private func refreshPlaceholder() {
        lblPlaceholder.isHidden = !txtContent.text.isEmpty
    }
    
    private func checkMaxHeight() {
        if contentMaxHeight == 0 || getTextHeight(text: txtContent.text) < contentMaxHeight {
            cnsTxtContentHeight.isActive = false
            txtContent.isScrollEnabled = false
        } else {
            cnsTxtContentHeight.isActive = true
            txtContent.isScrollEnabled = true
        }
    }
    
    private func getTextHeight(text: String) -> CGFloat {
        let constraintRect = CGSize(width: self.frame.width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = text.boundingRect(with: constraintRect , options: [.usesLineFragmentOrigin] , attributes: [NSAttributedString.Key.font : contentFont] , context: nil)
        return boundingBox.height
    }
    
    public func showError(error: String){
        lblError.alpha = 0.0
        UIView.animate(withDuration: 0.15, animations: {
            self.lblTitle.textColor = self.errorColor
            self.vwBottomBorder.backgroundColor = self.errorColor
            
            self.lblError.text = error
            self.superview?.layoutIfNeeded()
        }) { (success) in
            UIView.animate(withDuration: 0.15) {
                self.lblError.alpha = 1.0
            }
        }
    }
    
    public func hideError(){
        lblError.alpha = 1.0
        UIView.animate(withDuration: 0.15, animations: {
            self.lblError.alpha = 0.0
            
            self.lblTitle.textColor = self.titleColor
            self.vwBottomBorder.backgroundColor = self.txtContent.isFirstResponder ? self.bottomBorderResponderColor : self.bottomBorderColor
        }) { (success) in
            UIView.animate(withDuration: 0.15) {
                self.lblError.text = String()
                self.superview?.layoutIfNeeded()
            }
        }
    }
}

//MARK:- textView delegate
extension mfTextView: UITextViewDelegate {
    public func textViewDidChange(_ textView: UITextView) {
        contentText = textView.text
        delegate?.mfTextViewContentDidChange(textView: textView)
    }
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        delegate?.mfTextViewContentDidBeginEditing(textView: textView)
        
        let tempAnimatingView = UIView(frame: vwBottomBorder.bounds)
        tempAnimatingView.frame.origin.x = tempAnimatingView.frame.size.width/2
        tempAnimatingView.frame.size.width = 0
        tempAnimatingView.backgroundColor = bottomBorderResponderColor
        vwBottomBorder.addSubview(tempAnimatingView)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            tempAnimatingView.frame.origin.x = 0
            tempAnimatingView.frame.size.width = self.vwBottomBorder.frame.width
            self.layoutIfNeeded()
        }) { (success) in
            self.vwBottomBorder.backgroundColor = self.bottomBorderResponderColor
            tempAnimatingView.removeFromSuperview()
        }
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        delegate?.mfTextViewContentDidEndEditing(textView: textView)
        
        vwBottomBorder.backgroundColor = bottomBorderColor
        
        let tempAnimatingView = UIView(frame: vwBottomBorder.bounds)
        tempAnimatingView.backgroundColor = bottomBorderResponderColor
        vwBottomBorder.addSubview(tempAnimatingView)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            tempAnimatingView.frame.origin.x = tempAnimatingView.frame.size.width/2
            tempAnimatingView.frame.size.width = 0
            self.layoutIfNeeded()
        }) { (success) in
           tempAnimatingView.removeFromSuperview()
        }
    }
}


//MARK:- delegate
public protocol mfTextViewDelegate: class {
    func mfTextViewContentDidBeginEditing(textView: UITextView)
    func mfTextViewContentDidChange(textView: UITextView)
    func mfTextViewContentDidEndEditing(textView: UITextView)
}

public extension mfTextViewDelegate {
    func mfTextViewContentDidBeginEditing(textView: UITextView) {}
    func mfTextViewContentDidChange(textView: UITextView) {}
    func mfTextViewContentDidEndEditing(textView: UITextView) {}
}
