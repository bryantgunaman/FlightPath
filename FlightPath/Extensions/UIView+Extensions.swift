//
//  UIView+Extensions.swift
//  FlightPath
//
//  Created by Bryant Gunaman on 10/11/19.
//  Copyright © 2019 Bryant Gunaman. All rights reserved.
//

import UIKit


struct Padding {
    var top    : CGFloat
    var left   : CGFloat
    var right  : CGFloat
    var bottom : CGFloat
    
    
    init(top: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0, bottom: CGFloat = 0) {
        self.top    = top
        self.left   = left
        self.right  = right
        self.bottom = bottom
    }
}


enum Proximity {
    case greaterThanOrEqualTo
    case lessThanOrEqualTo
}


extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    
    func setColorLayer(tintColor : UIColor?, backgroundColor : UIColor?, alpha : CGFloat = 1.0, opacity : CFloat = 1.0) {
        if let tintColor = tintColor {
            self.tintColor = tintColor
        }
        
        if let backgroundColor = backgroundColor {
            self.backgroundColor = backgroundColor
        }
        
        self.alpha = alpha
        self.layer.opacity = opacity
    }
    
    
    func setShadowLayer(shadowColor: UIColor?, shadowRadius: CGFloat?, shadowOpacity: Float?, shadowOffset: CGSize?) {
        if let shadowColor = shadowColor {
            layer.shadowColor = shadowColor.cgColor
        }
        
        if let shadowRadius = shadowRadius {
            layer.shadowRadius = shadowRadius
        }
        
        if let shadowOpacity = shadowOpacity {
            layer.shadowOpacity = shadowOpacity
        }
        
        if let shadowOffset = shadowOffset {
            layer.shadowOffset = shadowOffset
        }
    }
    
    
    func setBorderLayer(cornerRadius : CGFloat?, borderColor: UIColor? = nil, borderWidth : CGFloat? = nil, clipsToBounds : Bool? = nil, masksToBounds : Bool? = nil) {
        if let cornerRadius = cornerRadius {
            self.layer.cornerRadius = cornerRadius
        }
        
        if let borderColor = borderColor {
            self.layer.borderColor = borderColor.cgColor
        }
        
        if let borderWidth = borderWidth {
            self.layer.borderWidth = borderWidth
        }
        
        if let clipsToBounds = clipsToBounds {
            self.clipsToBounds = clipsToBounds
        }
        
        if let masksToBounds = masksToBounds {
            self.layer.masksToBounds = masksToBounds
        }
    }
    
    
    func anchorAlignment(centerX : NSLayoutXAxisAnchor?, centerXProximity : Proximity? = nil, centerY : NSLayoutYAxisAnchor?, centerYProximity : Proximity? = nil, offsetX : CGFloat = 0.0, offsetY : CGFloat = 0.0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let centerX = centerX {
            if let centerXProximity = centerXProximity {
                switch centerXProximity {
                case .greaterThanOrEqualTo:
                    self.centerXAnchor.constraint(greaterThanOrEqualTo: centerX, constant: offsetX).isActive = true
                case .lessThanOrEqualTo:
                    self.centerXAnchor.constraint(lessThanOrEqualTo:    centerX, constant: offsetX).isActive = true
                }
            }
            else {
                self.centerXAnchor.constraint(equalTo: centerX, constant: offsetX).isActive = true
            }
        }
        
        if let centerY = centerY {
            if let centerYProximity = centerYProximity {
                switch centerYProximity {
                case .greaterThanOrEqualTo:
                    self.centerYAnchor.constraint(greaterThanOrEqualTo: centerY, constant: offsetY).isActive = true
                case .lessThanOrEqualTo:
                    self.centerYAnchor.constraint(lessThanOrEqualTo:    centerY, constant: offsetY).isActive = true
                }
            }
            else {
                self.centerYAnchor.constraint(equalTo: centerY, constant: offsetY).isActive = true
            }
        }
    }
    
    
    func anchorSizeWithConstant(width : CGFloat?, widthProximity : Proximity? = nil, height: CGFloat?, heightProximity : Proximity? = nil) {
        if let width = width {
            if let widthProximity = widthProximity {
                switch widthProximity {
                case .greaterThanOrEqualTo :
                    self.widthAnchor.constraint(greaterThanOrEqualToConstant: width).isActive = true
                case .lessThanOrEqualTo :
                    self.widthAnchor.constraint(lessThanOrEqualToConstant: width).isActive = true
                }
            }
            else {
                self.widthAnchor.constraint(equalToConstant: width).isActive = true
            }
        }
        
        if let height = height {
            if let heightProximity = heightProximity {
                switch heightProximity {
                case .greaterThanOrEqualTo :
                    self.heightAnchor.constraint(greaterThanOrEqualToConstant: height).isActive = true
                case .lessThanOrEqualTo :
                    self.heightAnchor.constraint(lessThanOrEqualToConstant: height).isActive = true
                }
            }
            else {
                self.heightAnchor.constraint(equalToConstant: height).isActive = true
            }
        }
    }
    
    
    func anchorSize(widthAnchor  : NSLayoutDimension?, widthMultiplier  : CGFloat = 1.0, widthConstant  : CGFloat = 0.0, widthProximity  : Proximity? = nil,
                    heightAnchor : NSLayoutDimension?, heightMultiplier : CGFloat = 1.0, heightConstant : CGFloat = 0.0, heightProximity : Proximity? = nil)
    {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let widthAnchor = widthAnchor {
            if let widthProximity = widthProximity {
                switch widthProximity {
                case .greaterThanOrEqualTo :
                    self.widthAnchor.constraint(greaterThanOrEqualTo: widthAnchor, multiplier: widthMultiplier, constant: widthConstant).isActive = true
                case .lessThanOrEqualTo :
                    self.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: widthMultiplier, constant: widthConstant).isActive = true
                }
            }
            else {
                self.widthAnchor.constraint(equalTo: widthAnchor, multiplier: widthMultiplier, constant: widthConstant).isActive = true
            }
        }
        
        if let heightAnchor = heightAnchor {
            if let heightProximity = heightProximity {
                switch heightProximity {
                case .greaterThanOrEqualTo :
                    self.heightAnchor.constraint(greaterThanOrEqualTo: heightAnchor, multiplier: heightMultiplier, constant: heightConstant).isActive = true
                case .lessThanOrEqualTo :
                    self.heightAnchor.constraint(lessThanOrEqualTo: heightAnchor, multiplier: heightMultiplier, constant: heightConstant).isActive = true
                }
            }
            else {
                self.heightAnchor.constraint(equalTo: heightAnchor, multiplier: heightMultiplier, constant: heightConstant).isActive = true
            }
        }
    }
    
    
    func anchorBounds(top      : NSLayoutYAxisAnchor?, topProximity      : Proximity? = nil,
                      leading  : NSLayoutXAxisAnchor?, leadingProximity  : Proximity? = nil,
                      trailing : NSLayoutXAxisAnchor?, trailingProximity : Proximity? = nil,
                      bottom   : NSLayoutYAxisAnchor?, bottomProximity   : Proximity? = nil,
                      padding  : Padding = Padding())
    {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            if let topProximity = topProximity {
                switch topProximity {
                case .greaterThanOrEqualTo :
                    self.topAnchor.constraint(greaterThanOrEqualTo: top, constant: padding.top).isActive = true
                case .lessThanOrEqualTo    :
                    self.topAnchor.constraint(lessThanOrEqualTo:    top, constant: padding.top).isActive = true
                }
            }
            else {
                self.topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
            }
        }
        
        if let leading = leading {
            if let leadingProximity = leadingProximity {
                switch leadingProximity {
                case .greaterThanOrEqualTo :
                    self.leadingAnchor.constraint(greaterThanOrEqualTo: leading, constant: padding.left).isActive = true
                case .lessThanOrEqualTo    :
                    self.leadingAnchor.constraint(lessThanOrEqualTo:    leading, constant: padding.left).isActive = true
                }
            }
            else {
                self.leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
            }
        }
        
        if let trailing = trailing {
            if let trailingProximity = trailingProximity {
                switch trailingProximity {
                case .greaterThanOrEqualTo :
                    self.trailingAnchor.constraint(greaterThanOrEqualTo: trailing, constant: -padding.right).isActive = true
                case .lessThanOrEqualTo    :
                    self.trailingAnchor.constraint(lessThanOrEqualTo:    trailing, constant: -padding.right).isActive = true
                }
            }
            else {
                self.trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
            }
        }
        
        if let bottom = bottom {
            if let bottomProximity = bottomProximity {
                switch bottomProximity {
                case .greaterThanOrEqualTo :
                    self.bottomAnchor.constraint(greaterThanOrEqualTo: bottom, constant: -padding.bottom).isActive = true
                case .lessThanOrEqualTo    :
                    self.bottomAnchor.constraint(lessThanOrEqualTo:    bottom, constant: -padding.bottom).isActive = true
                }
            }
            else {
                self.bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
            }
        }
    }
    
    
    func align(originX: CGFloat?, originY: CGFloat?, centerX: CGFloat?, centerY: CGFloat?, center: CGPoint?) {
        if let originX = originX {
            self.frame.origin.x = originX
        }
        
        if let originY = originY {
            self.frame.origin.y = originY
        }
        
        if let centerX = centerX {
            self.center.x = centerX
        }
        
        if let centerY = centerY {
            self.center.y = centerY
        }
        
        if let center = center {
            self.center = center
        }
    }
}
