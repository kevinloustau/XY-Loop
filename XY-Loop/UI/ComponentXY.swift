//
//  ComponentXY.swift
//  componentXY
//
//  Created by kevinloustau on 06/01/2018.
//  Copyright © 2018 kl. All rights reserved.
//
//  Generated by PaintCode
//  http://www.paintcodeapp.com
//



import UIKit

public class ComponentXY : NSObject {

    //// Drawing Methods

    @objc dynamic public class func drawXY(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 269, height: 269), resizing: ResizingBehavior = .aspectFit, xPosition: CGFloat = 0, yPosition: CGFloat = 0, widthCanvas: CGFloat = 267, heighCanvas: CGFloat = 267, selectorSize: CGFloat = 24, labelLeft: String = "Simple", labelRight: String = "Complexe", labelTop: String = "Loud", labelBottom: String = "Soft", strokeWidthCanvas: CGFloat = 2) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 269, height: 269), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 269, y: resizedFrame.height / 269)


        //// Color Declarations
        let canvasStrokeColor = UIColor(red: 0.137, green: 0.137, blue: 0.137, alpha: 1.000)
        let canvasColor = UIColor(red: 0.165, green: 0.165, blue: 0.165, alpha: 1.000)
        let labelColor = UIColor(red: 0.318, green: 0.318, blue: 0.318, alpha: 1.000)
        let selectorColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        let gridLine = UIColor(red: 0.125, green: 0.125, blue: 0.125, alpha: 1.000)

        //// Variable Declarations
        let gridPositionHozitontal_div4: CGFloat = heighCanvas / 4.0
        let gridPositionHozitontal_div2: CGFloat = heighCanvas / 2.0
        let gridPositionHozitontal_mult3_div4: CGFloat = heighCanvas * 3 / 4.0
        let xCalcul: CGFloat = xPosition * widthCanvas > selectorSize ? xPosition * widthCanvas - selectorSize + strokeWidthCanvas : 0
        let yCalcul: CGFloat = yPosition * widthCanvas > selectorSize ? yPosition * widthCanvas - selectorSize + strokeWidthCanvas : 0

        //// Background Drawing
        context.saveGState()
        context.translateBy(x: 0, y: 269)

        let backgroundPath = UIBezierPath(roundedRect: CGRect(x: 1, y: -268, width: widthCanvas, height: heighCanvas), cornerRadius: 13)
        canvasColor.setFill()
        backgroundPath.fill()
        canvasStrokeColor.setStroke()
        backgroundPath.lineWidth = strokeWidthCanvas
        backgroundPath.stroke()

        context.restoreGState()


        //// gridLineMiddle Drawing
        let gridLineMiddlePath = UIBezierPath(rect: CGRect(x: 2, y: gridPositionHozitontal_div2, width: 265, height: 1))
        gridLine.setFill()
        gridLineMiddlePath.fill()


        //// gridLineMiddle 2 Drawing
        let gridLineMiddle2Path = UIBezierPath(rect: CGRect(x: 0, y: gridPositionHozitontal_div4, width: 265, height: 1))
        gridLine.setFill()
        gridLineMiddle2Path.fill()


        //// gridLineMiddle 3 Drawing
        let gridLineMiddle3Path = UIBezierPath(rect: CGRect(x: 0, y: gridPositionHozitontal_mult3_div4, width: 265, height: 1))
        gridLine.setFill()
        gridLineMiddle3Path.fill()


        //// gridLineMiddle 4 Drawing
        context.saveGState()
        context.translateBy(x: gridPositionHozitontal_div4, y: 134.5)
        context.rotate(by: -90 * CGFloat.pi/180)

        let gridLineMiddle4Path = UIBezierPath(rect: CGRect(x: -132.5, y: -0.5, width: 265, height: 1))
        gridLine.setFill()
        gridLineMiddle4Path.fill()

        context.restoreGState()


        //// gridLineMiddle 5 Drawing
        context.saveGState()
        context.translateBy(x: gridPositionHozitontal_div2, y: 133.5)
        context.rotate(by: -90 * CGFloat.pi/180)

        let gridLineMiddle5Path = UIBezierPath(rect: CGRect(x: -132.5, y: -0.5, width: 265, height: 1))
        gridLine.setFill()
        gridLineMiddle5Path.fill()

        context.restoreGState()


        //// gridLineMiddle6 Drawing
        context.saveGState()
        context.translateBy(x: gridPositionHozitontal_mult3_div4, y: 134.5)
        context.rotate(by: -90 * CGFloat.pi/180)

        let gridLineMiddle6Path = UIBezierPath(rect: CGRect(x: -132.5, y: -0.5, width: 265, height: 1))
        gridLine.setFill()
        gridLineMiddle6Path.fill()

        context.restoreGState()


        //// RightText Drawing
        context.saveGState()
        context.translateBy(x: 260, y: 134.5)
        context.rotate(by: -90 * CGFloat.pi/180)

        let rightTextRect = CGRect(x: -35.5, y: -8, width: 71, height: 16)
        let rightTextStyle = NSMutableParagraphStyle()
        rightTextStyle.alignment = .center
        let rightTextFontAttributes = [
            .font: UIFont.systemFont(ofSize: 12, weight: .medium),
            .foregroundColor: labelColor,
            .paragraphStyle: rightTextStyle,
        ] as [NSAttributedStringKey: Any]

        let rightTextTextHeight: CGFloat = labelRight.boundingRect(with: CGSize(width: rightTextRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: rightTextFontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: rightTextRect)
        labelRight.draw(in: CGRect(x: rightTextRect.minX, y: rightTextRect.minY + (rightTextRect.height - rightTextTextHeight) / 2, width: rightTextRect.width, height: rightTextTextHeight), withAttributes: rightTextFontAttributes)
        context.restoreGState()

        context.restoreGState()


        //// TopText 2 Drawing
        let topText2Rect = CGRect(x: 99, y: 0, width: 71, height: 16)
        let topText2Style = NSMutableParagraphStyle()
        topText2Style.alignment = .center
        let topText2FontAttributes = [
            .font: UIFont.systemFont(ofSize: 12, weight: .medium),
            .foregroundColor: labelColor,
            .paragraphStyle: topText2Style,
        ] as [NSAttributedStringKey: Any]

        let topText2TextHeight: CGFloat = labelTop.boundingRect(with: CGSize(width: topText2Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: topText2FontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: topText2Rect)
        labelTop.draw(in: CGRect(x: topText2Rect.minX, y: topText2Rect.minY + (topText2Rect.height - topText2TextHeight) / 2, width: topText2Rect.width, height: topText2TextHeight), withAttributes: topText2FontAttributes)
        context.restoreGState()


        //// BottomText 2 Drawing
        let bottomText2Rect = CGRect(x: 99, y: 253, width: 71, height: 16)
        let bottomText2Style = NSMutableParagraphStyle()
        bottomText2Style.alignment = .center
        let bottomText2FontAttributes = [
            .font: UIFont.systemFont(ofSize: 12, weight: .medium),
            .foregroundColor: labelColor,
            .paragraphStyle: bottomText2Style,
        ] as [NSAttributedStringKey: Any]

        let bottomText2TextHeight: CGFloat = labelBottom.boundingRect(with: CGSize(width: bottomText2Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: bottomText2FontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: bottomText2Rect)
        labelBottom.draw(in: CGRect(x: bottomText2Rect.minX, y: bottomText2Rect.minY + (bottomText2Rect.height - bottomText2TextHeight) / 2, width: bottomText2Rect.width, height: bottomText2TextHeight), withAttributes: bottomText2FontAttributes)
        context.restoreGState()


        //// LeftText Drawing
        context.saveGState()
        context.translateBy(x: 8, y: 134.5)
        context.rotate(by: -90 * CGFloat.pi/180)

        let leftTextRect = CGRect(x: -35.5, y: -8, width: 71, height: 16)
        let leftTextStyle = NSMutableParagraphStyle()
        leftTextStyle.alignment = .center
        let leftTextFontAttributes = [
            .font: UIFont.systemFont(ofSize: 12, weight: .medium),
            .foregroundColor: labelColor,
            .paragraphStyle: leftTextStyle,
        ] as [NSAttributedStringKey: Any]

        let leftTextTextHeight: CGFloat = labelLeft.boundingRect(with: CGSize(width: leftTextRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: leftTextFontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: leftTextRect)
        labelLeft.draw(in: CGRect(x: leftTextRect.minX, y: leftTextRect.minY + (leftTextRect.height - leftTextTextHeight) / 2, width: leftTextRect.width, height: leftTextTextHeight), withAttributes: leftTextFontAttributes)
        context.restoreGState()

        context.restoreGState()


        //// Selector Drawing
        let selectorPath = UIBezierPath(ovalIn: CGRect(x: xCalcul, y: yCalcul, width: selectorSize, height: selectorSize))
        selectorColor.setFill()
        selectorPath.fill()
        
        context.restoreGState()

    }




    @objc(ComponentXYResizingBehavior)
    public enum ResizingBehavior: Int {
        case aspectFit /// The content is proportionally resized to fit into the target rectangle.
        case aspectFill /// The content is proportionally resized to completely fill the target rectangle.
        case stretch /// The content is stretched to match the entire target rectangle.
        case center /// The content is centered in the target rectangle, but it is NOT resized.

        public func apply(rect: CGRect, target: CGRect) -> CGRect {
            if rect == target || target == CGRect.zero {
                return rect
            }

            var scales = CGSize.zero
            scales.width = abs(target.width / rect.width)
            scales.height = abs(target.height / rect.height)

            switch self {
                case .aspectFit:
                    scales.width = min(scales.width, scales.height)
                    scales.height = scales.width
                case .aspectFill:
                    scales.width = max(scales.width, scales.height)
                    scales.height = scales.width
                case .stretch:
                    break
                case .center:
                    scales.width = 1
                    scales.height = 1
            }

            var result = rect.standardized
            result.size.width *= scales.width
            result.size.height *= scales.height
            result.origin.x = target.minX + (target.width - result.width) / 2
            result.origin.y = target.minY + (target.height - result.height) / 2
            return result
        }
    }
}
