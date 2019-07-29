//  Created by Vishal Sharma on 18/12/18.
//  Copyright © 2018 Vishal Sharma. All rights reserved.

import Foundation
import UIKit
import SwiftyJSON

//MARK:🍏🍏🍏🍏🍏 Label With Inset.
@IBDesignable class PaddingLabel: UILabel {
    
    @IBInspectable var topInset: CGFloat = 5.0
    @IBInspectable var bottomInset: CGFloat = 5.0
    @IBInspectable var leftInset: CGFloat = 7.0
    @IBInspectable var rightInset: CGFloat = 7.0
    
    override func drawText(in rect: CGRect) {
        super.layer.cornerRadius = 5.0
        super.layer.masksToBounds = true
        super.clipsToBounds = true;
        
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
}

//MARK:🍏🍏🍏🍏🍏 View with Theme Color
class FTO_Theme_View: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView();
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView();
    }
    
    func configureView() {
        self.backgroundColor = UIColor.fto_Theme_Color
    }
}

//MARK:🍏🍏🍏🍏🍏 Google & Manual SignIn Button
class FTO_LogIn_Btn: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton();
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureButton();
    }
    
    func configureButton() {
        self.layer.borderColor = UIColor.fto_Theme_Color.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 27.5
        self.layer.masksToBounds = true
        self.clipsToBounds = true
        
        self.titleLabel?.font = UIFont.fto_Medium_Font
        self.titleLabel?.textColor = UIColor.fto_Theme_Color
    }
}


//MARK:🍏🍏🍏🍏🍏 Manage Labels with Font-Size
class FTO_Large_Label: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLargeLabel();
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureLargeLabel();
    }
    
    func configureLargeLabel() {
        self.font = UIFont.fto_Large_Font;
        self.textColor = UIColor.fto_GrayText_Color
        self.adjustsFontSizeToFitWidth = true
    }
}

class FTO_Medium_Label: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureMediumLabel();
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureMediumLabel();
    }
    
    func configureMediumLabel() {
        self.font = UIFont.fto_Cell_Title_Font;
        self.textColor = UIColor.fto_GrayText_Color
        self.adjustsFontSizeToFitWidth = true
    }
}

class FTO_Small_Light_Label: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSmall_Label();
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureSmall_Label();
    }
    
    func configureSmall_Label() {
        self.font = UIFont.fto_Small_Light_Font
        self.textColor = UIColor.fto_GrayText_Color
        self.adjustsFontSizeToFitWidth = true
    }
}

class FTO_Small_Label: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSmall_Label();
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureSmall_Label();
    }
    
    func configureSmall_Label() {
        self.font = UIFont.fto_Small_Font;
        self.textColor = UIColor.fto_GrayText_Color
        self.adjustsFontSizeToFitWidth = true
    }
}

class FTO_Header_Label: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure_Header_Label();
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure_Header_Label();
    }
    
    func configure_Header_Label() {
        self.font = UIFont.fto_Header_Font;
        self.textColor = UIColor.fto_Header_Color
        self.adjustsFontSizeToFitWidth = true
    }
}
class FTO_Cell_Title_Label: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure_Header_Label();
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure_Header_Label();
    }
    
    func configure_Header_Label() {
        self.font = UIFont.fto_Cell_Title_Font;
        self.textColor = UIColor.fto_GrayText_Color
        self.adjustsFontSizeToFitWidth = true
    }
}


class FTO_LineLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure_LineView();
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure_LineView();
    }
    
    func configure_LineView() {
        self.backgroundColor = UIColor(red: 216.0/255.0, green: 216.0/255.0, blue: 216.0/255.0, alpha: 1.0)
    }
}
class FTO_TextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure_TextF();
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure_TextF();
    }
    
    func configure_TextF() {
        self.font = UIFont.fto_Medium_Font
    }
}



struct FTO_AppLinks_Modal {
    var about_us: JSON
    var the_Plastic_Issue: JSON
    var terms_Conditions: JSON
    var privacy_Policy: JSON
    var how_it_Works: JSON
    var shop: JSON
    var contact_Us: JSON
    var facebook: JSON
    var twitter: JSON
    var instagram: JSON
    
    
    init(about_us:JSON,
         the_Plastic_Issue: JSON,
         terms_Conditions :JSON,
         privacy_Policy :JSON,
         how_it_Works: JSON,
         shop: JSON,
         contact_Us: JSON,
         facebook: JSON,
         twitter: JSON,
         instagram: JSON
        ) {
        self.about_us = about_us;
        self.the_Plastic_Issue = the_Plastic_Issue;
        self.terms_Conditions = terms_Conditions;
        self.privacy_Policy = privacy_Policy;
        self.how_it_Works = how_it_Works;
        self.shop = shop;
        self.contact_Us = contact_Us;
        self.facebook = facebook;
        self.twitter = twitter;
        self.instagram = instagram;
    }
}
