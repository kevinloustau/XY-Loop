//
//  SettingsViewController.swift
//  EASY-X
//
//  Created by kl on 30/11/2017.
//  Copyright © 2017 kl. All rights reserved.
//

import UIKit
import CoreAudioKit.CABTMIDILocalPeripheralViewController

class SettingsViewController: UIViewController {

    @IBOutlet weak var switchAudio: UISwitch!
    @IBOutlet weak var midiChannelTextField: UITextField!
    @IBOutlet weak var bpmTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initUIControlValues()
    }
    
    func initUIControlValues(){
        switchAudio.setOn(AudioMidiEngine.sharedInstance.audioEnable, animated: true)
        midiChannelTextField.text = String(AudioMidiEngine.sharedInstance.midiChannel)
        bpmTextField.text = String(AudioMidiEngine.sharedInstance.currentTempo)
    }

    @IBAction func enableAudio(_ sender: UISwitch) {
        if sender.isOn {
            AudioMidiEngine.sharedInstance.mixer.volume = 0
            sender.setOn(false, animated: true)
        } else {
            AudioMidiEngine.sharedInstance.mixer.volume = 1
            sender.setOn(true, animated: true)
        }
    }
    
    @IBAction func setMidiChannel(_ sender: UITextField) {
        if let newMidiChannel = sender.text {
            AudioMidiEngine.sharedInstance.midiChannel = UInt8(newMidiChannel)!
        }
    }
    
    @IBAction func setBPM(_ sender: UITextField) {
        if let newBPM = sender.text {
            var BPMInt = Double(newBPM)
            if BPMInt! < 0 {
                BPMInt = 60
                sender.text = String(describing: BPMInt!)
            } else if BPMInt! > 180 {
                BPMInt = 180
                sender.text = String(describing: BPMInt!)
            }
            AudioMidiEngine.sharedInstance.currentTempo = BPMInt!
        }
    }
    
    @IBAction func dismissVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
