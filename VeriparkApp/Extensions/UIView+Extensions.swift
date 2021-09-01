//
//  UIView+Extensions.swift
//  VeriparkApp
//
//  Created by Samet Bugra Oktay on 10.08.2021.
//

import UIKit

extension UIView {
    
    public var width : CGFloat {
        return self.frame.size.width
    }
    
    public var height : CGFloat {
        return self.frame.size.height
    }
    
    public var top : CGFloat {
        return self.frame.origin.y
    }
    
    public var bottom : CGFloat {
        return self.frame.height + self.frame.origin.y
    }
    
    public var left : CGFloat {
        return self.frame.origin.x
    }
    
    public var right : CGFloat {
        return self.frame.width + self.frame.origin.x
    }
}
