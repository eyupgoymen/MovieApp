//
//  CALayerExtensions.swift
//  MovieApp
//
//  Created by Eyup Kazım Göymen on 13.07.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import UIKit

extension CALayer {
    func addBorder(color: UIColor, width: CGFloat = 1.5) {
        borderColor = color.cgColor
        borderWidth = width
    }
    
    func addShadow(radius: CGFloat) {
        shadowOffset = CGSize(width: 0, height: 2)
        shadowOpacity = 0.16
        shadowRadius = radius
        shadowColor = UIColor.black.cgColor
        masksToBounds = false
        if cornerRadius != 0 {
            addShadowWithRoundedCorners()
        }
    }
    
    func roundCorners(radius: CGFloat) {
        cornerRadius = radius
        if shadowOpacity != 0 {
            addShadowWithRoundedCorners()
        }
    }
    
    private func addShadowWithRoundedCorners() {
        if let contents = self.contents {
            masksToBounds = false
            sublayers?.filter{ $0.frame.equalTo(self.bounds) }
                .forEach{ $0.roundCorners(radius: self.cornerRadius) }
            self.contents = nil
            if let sublayer = sublayers?.first, sublayer.name == "ContentLayer" {
                sublayer.removeFromSuperlayer()
            }
            let contentLayer = CALayer()
            contentLayer.name = "ContentLayer"
            contentLayer.contents = contents
            contentLayer.frame = bounds
            contentLayer.cornerRadius = cornerRadius
            contentLayer.masksToBounds = true
            insertSublayer(contentLayer, at: 0)
        }
    }
}
