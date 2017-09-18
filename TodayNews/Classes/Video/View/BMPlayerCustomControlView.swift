//
//  BMPlayerCustomControlView.swift
//  TodayNews
//
//  Created by 杨蒙 on 2017/8/23.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit
import BMPlayer

class BMPlayerCustomControlView: BMPlayerControlView {
    
    var playTimeUIProgressView = UIProgressView()
    
    override func customizeUIComponents() {
        
        // If needs to change position remake the constraint
        progressView.snp.remakeConstraints { (make) in
            make.bottom.left.right.equalTo(bottomMaskView)
            make.height.equalTo(2)
        }
        
        // Add new items and constraint
        bottomMaskView.addSubview(playTimeUIProgressView)
        playTimeUIProgressView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(bottomMaskView)
            make.height.equalTo(2)
        }
        
        playTimeUIProgressView.tintColor      = UIColor.red
        playTimeUIProgressView.trackTintColor = UIColor.clear
    }
    
    override func updateUI(_ isForFullScreen: Bool) {
        topMaskView.isHidden = true
        chooseDefitionView.isHidden = true
    }
    
    override func playTimeDidChange(currentTime: TimeInterval, totalTime: TimeInterval) {
        currentTimeLabel.text = BMPlayerCustomControlView.formatSecondsToString(currentTime)
        totalTimeLabel.text = BMPlayerCustomControlView.formatSecondsToString(totalTime)
        timeSlider.value = Float(currentTime/totalTime)
        playTimeUIProgressView.setProgress(Float(currentTime/totalTime), animated: true)
    }
    
    override func onTapGestureTapped(_ gesture: UITapGestureRecognizer) {
        // redirect tap action to play button action
        delegate?.controlView(controlView: self, didPressButton: playButton)
    }
    
    override func playStateDidChange(isPlaying: Bool) {
        super.playStateDidChange(isPlaying: isPlaying)
    }
    
    override func controlViewAnimation(isShow: Bool) {
        
    }
    
}

extension BMPlayerCustomControlView {
    static func formatSecondsToString(_ secounds: TimeInterval) -> String {
        let Min = Int(secounds / 60)
        let Sec = Int(secounds.truncatingRemainder(dividingBy: 60))
        return String(format: "%02d:%02d", Min, Sec)
    }
}
