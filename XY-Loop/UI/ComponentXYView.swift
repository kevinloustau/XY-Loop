//
//  ComponentXYView.swift
//  XY-Music
//
//  Created by kl on 25/11/2017.
//  Copyright © 2017 kl. All rights reserved.
//

import UIKit

@IBDesignable class ComponentXYView: UIControl {
    
    var delegate: ComponentXYViewDelegate?
    
    var callback: (Double,Double)->Void = { _,_  in }
    
    var componentXYisTouch: Bool = false
    
    var minimum: Double = 0.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    var maximum: Double = 1.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var valueX: Double = 0.5 {
        didSet {
            if valueX > maximum {
                valueX = maximum
            }
            if valueX < minimum {
                valueX = minimum
            }
            self.valueX = (valueX - minimum) / (maximum - minimum)
        }
    }
    
    var valueY: Double = 0.5 {
        didSet {
            if valueY > maximum {
                valueY = maximum
            }
            if valueY < minimum {
                valueY = minimum
            }
            valueY = (valueY - minimum) / (maximum - minimum)
        }
    }
    
    // Init / Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentMode = .redraw
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.isUserInteractionEnabled = true
        contentMode = .redraw
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        contentMode = .scaleAspectFit
        clipsToBounds = true
    }
    
    class override var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    override func draw(_ rect: CGRect) {
        ComponentXY.drawXY(frame: CGRect(x:0,y:0, width: self.bounds.width, height: self.bounds.height), xPosition: CGFloat(valueX), yPosition: CGFloat(valueY))
    }
    
    
    //MARK: Touches Functions
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let currentLocation = touch.location(in: self)
        componentXYisTouch = true
        delegate?.componentXYdidTouch(self, didTouch: componentXYisTouch)
        updatePosition(location: currentLocation)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let currentLocation = touch.location(in: self)        
        componentXYisTouch = false
        delegate?.componentXYdidTouch(self, didTouch: componentXYisTouch)
        updatePosition(location: currentLocation)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let currentLocation = touch.location(in: self)
        updatePosition(location: currentLocation)
    }
    
    //24 is the size of the roundded cursor
    func updatePosition(location: CGPoint) {
        valueX = Double(((location.x + 12) / self.bounds.width))
        valueY = Double(((location.y + 12) / self.bounds.height))
        callback(valueX,valueY)
        setNeedsDisplay()
    }
}

protocol ComponentXYViewDelegate {
    func componentXYdidTouch(_ view:ComponentXYView, didTouch: Bool)
}


