//
//  ViewController.swift
//  XY-Music
//
//  Created by kl on 25/11/2017.
//  Copyright © 2017 kl. All rights reserved.
//

import UIKit
import AudioKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, ComponentXYViewDelegate {
    
    var pickerInstrument:[String] = MidiFilesController.sharedInstance.getInstrumentList()
    
    let instrumentAndStyleDictionary = MidiFilesController.sharedInstance.instrumentAndStyleDictionary
    
    var pickerStyle:[String]?
    
    var currentMidiCount: Int? {
        didSet {
            print("Current Midi Count: \(currentMidiCount!))")
        }
    }
    
    var currentInstrument: String = "Drums" {
        didSet {
            currentMidiCount = MidiFilesController.sharedInstance.getMidiFileNumber(instrument: self.currentInstrument, style: self.currentStyle)
        }
    }
    var currentStyle: String = "HipHop" {
        didSet {
            currentMidiCount = MidiFilesController.sharedInstance.getMidiFileNumber(instrument: self.currentInstrument, style: self.currentStyle)
        }
    }
    
    var dragGesture = UIPanGestureRecognizer()
    
    //MARK: IBOutlet
    @IBOutlet weak var componentXY: ComponentXYView!
    
    @IBOutlet weak var instrumentPickerView: UIPickerView!
    @IBOutlet weak var stylePickerView: UIPickerView!
    
    //MARK: btn Play Pause
    @IBOutlet weak var btnPlayPause: UIButton!
    let playImage:UIImage = UIImage(named: "play")!
    let stopImage:UIImage = UIImage(named: "stop")!
    
    var xPositionPrevious: Int = 0
    var yPositionPrevious: Double = 0
    
    //MARK: viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        instrumentPickerView.delegate = self
        stylePickerView.delegate = self
        componentXY.delegate = self
        
        //Init values
        currentInstrument = "Drums"
        pickerStyle = instrumentAndStyleDictionary[currentInstrument]!
        
        updateXYValue()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Select drums when the view did appear
        instrumentPickerView.selectRow(0, inComponent: 0, animated: false)
        stylePickerView.selectRow(2, inComponent: 0, animated: false)
    }
    
    
    @IBAction func btnPlayPause(_ sender: Any) {
        playPauseToggle()
    }
    
    func playPauseToggle() {
        AudioMidiEngine.sharedInstance.playPauseSequence()
        if  !AudioMidiEngine.sharedInstance.sequencer.isPlaying  {
            btnPlayPause.setImage(playImage, for: UIControlState.normal)
        } else {
            btnPlayPause.setImage(stopImage, for: UIControlState.normal)
        }
    }
    
    
    
    
    @IBAction func configureLocalPeripheral(_ sender: UIButton) {
        let cabMIDILocalPeripheralViewController = CABTMIDILocalPeripheralViewController()
        let navController = UINavigationController(rootViewController: cabMIDILocalPeripheralViewController)
        let btn = UIButton(type: .roundedRect)
        btn.frame = CGRect(x: UIScreen.main.bounds.width - 60, y: 60, width: 60, height: 40)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
        btn.setTitle("Done", for: .normal)
        btn.addTarget(self, action: #selector(self.doneAction), for: .touchDown)
        navController.view.addSubview(btn)
        present(navController, animated: false) {() -> Void in }
    }
    //because the windows won't close automaticaly...
    @objc func doneAction(_ sender: Any) {
        dismiss(animated: false) {() -> Void in }
    }
    
    //MARK: START PICKERVIEW
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == self.instrumentPickerView) {
            return instrumentAndStyleDictionary.count
        } else if (pickerView == self.stylePickerView) {
            return instrumentAndStyleDictionary[currentInstrument]!.count
        } else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        pickerView.backgroundColor = UIColor.black
        let pickerLabel: UILabel = UILabel()
        pickerLabel.textColor = UIColor.white
        if (pickerView == self.instrumentPickerView) {
            pickerLabel.text = pickerInstrument[row]
        } else if (pickerView == self.stylePickerView) {
            pickerLabel.text = pickerStyle![row]
        } else {
            pickerLabel.text = ""
        }
        pickerLabel.font = UIFont.boldSystemFont(ofSize: 20)
        pickerLabel.textAlignment = NSTextAlignment.center
        return pickerLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView == self.instrumentPickerView) {
            currentInstrument = pickerInstrument[row]
            AudioMidiEngine.sharedInstance.midiFileInstrument = currentInstrument
            pickerStyle = instrumentAndStyleDictionary[currentInstrument]!
            playPauseToggle()
            self.stylePickerView.reloadAllComponents()
        } else if (pickerView == self.stylePickerView) {
            currentStyle = pickerStyle![row]
            AudioMidiEngine.sharedInstance.midiFileStyle = currentStyle
            playPauseToggle()
        }
    }
    //MARK: END PICKERVIEW
    
    func componentXYdidTouch(_ view: ComponentXYView, didTouch: Bool) {
        if (didTouch == true) {
            btnPlayPause.setImage(playImage, for: UIControlState.normal)
            AudioMidiEngine.sharedInstance.sequencer.stop()
        } else {
            btnPlayPause.setImage(stopImage, for: UIControlState.normal)
            AudioMidiEngine.sharedInstance.sequencer.play()
        }
    }
    
    func updateXYValue() {
        componentXY.callback = { valueX,valueY in
            let valueXInt = Int(valueX * self.currentMidiCount!)
            let valueYformated = 127 - (valueY*100)
            if (valueXInt != self.xPositionPrevious) {
                self.updateMidiFileFromXY(xPosition: valueXInt)
                self.xPositionPrevious = valueXInt
            }
            if (valueYformated != self.yPositionPrevious) {
                let valueYformated = 127 - (valueY*100)
                self.updateVelocityFromXY(yPosition: valueYformated)
                self.yPositionPrevious = valueYformated
            }
        }
    }
    
    func updateMidiFileFromXY(xPosition: Int) {
        print("xPosition : \(xPosition)")
        AudioMidiEngine.sharedInstance.midiFileSelectedNumber = String(xPosition)
    }
    
    func updateVelocityFromXY(yPosition: Double) {
        AudioMidiEngine.sharedInstance.velocityFactor = yPosition
    }
    
    
}

