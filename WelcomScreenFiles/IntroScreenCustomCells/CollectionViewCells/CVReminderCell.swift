//
//  CVReminderCell.swift
//  Arabic-Language
//
//  Created by Zohair on 20/11/2024.
//

import UIKit

class CVReminderCell: UICollectionViewCell {
    
    @IBOutlet var timingSlider: UISlider!
    @IBOutlet var timingLabel: UILabel!
    @IBOutlet var viewWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    private func configure(){
        timingSlider.minimumValue = 1.0
        timingSlider.maximumValue = 24.0
        timingSlider.value = 12.0
        timingSlider.minimumTrackTintColor = .systemGreen
        timingSlider.maximumTrackTintColor = .systemGreen
        timingSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    }
    
    
    @objc func sliderValueChanged(_ slider: UISlider){
        updateTimeLabel(for: slider.value)
    }
    
    
    func updateTimeLabel(for value: Float) {
        // Break value into hours and fractional minutes
        let totalMinutes =  Int(round(value * 60 / 5) * 5)
        let hour = (totalMinutes / 60) % 24 // Extract hour (mod 24 for wrapping)
        let minutes = totalMinutes % 60 // Extract remaining minutes

        // Convert to 12-hour format
        let hourString: String
        let period: String

        if hour == 0 || hour == 24 { // Special case for midnight
            hourString = "12"
            period = "AM"
        } else if hour == 12 { // Special case for noon
            hourString = "12"
            period = "PM"
        } else if hour < 12 { // Morning hours
            hourString = "\(hour)"
            period = "AM"
        } else { // Afternoon/evening hours
            hourString = "\(hour - 12)"
            period = "PM"
        }

        // Format minutes with leading zero
        let minuteString = String(format: "%02d", minutes)
        timingLabel.text = "\(hourString):\(minuteString) \(period)"
    }

}
