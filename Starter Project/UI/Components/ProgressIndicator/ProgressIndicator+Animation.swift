//
//  ProgressIndicator+Animation.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 10/31/23.
//

import Foundation
import UIKit

extension ProgressIndicator {
    func animateBorder() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            guard !animationInProgress else { return }
            self.animationInProgress = true
            let animationTime: TimeInterval = 1.34
            let pause: TimeInterval = 0 / 30

            self.isCurrentlyDrawingItselfForTheFirstTime = !self.isCurrentlyDrawingItselfForTheFirstTime

            if self.isCurrentlyDrawingItselfForTheFirstTime {

                CATransaction.begin()
                CATransaction.setAnimationDuration(animationTime)
                CATransaction.setDisableActions(true)
                CATransaction.setCompletionBlock { [weak self] in
                    guard let self = self else { return }
                    self.animationInProgress = false
                    if self.animateTillCompletion {
                        self.onProgressChangedAnimationComplete?()
                    } else if self.animationIsActive {
                        self.animateBorder()
                    }
                }

                // Set animation end state
                let loopOneStart = CABasicAnimation(keyPath: "strokeStart")
                loopOneStart.toValue = 0
                loopOneStart.fromValue = 0
                let loopOneEnd = CABasicAnimation(keyPath: "strokeEnd")
                loopOneEnd.fromValue = 0
                loopOneEnd.toValue = 1

                // Play Animation Repetitively
                let group = CAAnimationGroup()
                group.animations = [loopOneStart, loopOneEnd]
                group.duration = animationTime
                group.timingFunction = CAMediaTimingFunction(controlPoints: 0.86, 0, 0.07, 1)
                group.autoreverses = false
                group.fillMode = .forwards
                group.repeatCount = 1 // repeat 0 times
                group.isRemovedOnCompletion = false

                self.circle.add(group, forKey: nil)

                CATransaction.commit()
            } else {

                CATransaction.begin()
                CATransaction.setAnimationDuration(animationTime)
                CATransaction.setDisableActions(true)
                CATransaction.setCompletionBlock {
                    _ = Timer.scheduledTimer(withTimeInterval: pause, repeats: false, block: { [weak self] (timer) in
                        guard let self = self else {
                            timer.invalidate()
                            return
                        }
                        timer.invalidate()
                        DispatchQueue.main.async { [weak self] in
                            guard let self = self else { return }
                            self.animationInProgress = false
                            if self.animationIsActive {
                                self.animateBorder()
                            }
                        }
                    })
                }

                // Set animation end state
                let loopOneStart = CABasicAnimation(keyPath: "strokeStart")
                loopOneStart.toValue = 1
                loopOneStart.fromValue = 0
                let loopOneEnd = CABasicAnimation(keyPath: "strokeEnd")
                loopOneEnd.fromValue = 1
                loopOneEnd.toValue = 1

                // Play Animation Repetitively
                let group = CAAnimationGroup()
                group.animations = [loopOneStart, loopOneEnd]
                group.duration = animationTime
                group.autoreverses = false
                group.timingFunction = CAMediaTimingFunction(controlPoints: 0.86, 0, 0.07, 1)
                group.repeatCount = 1 // repeat 0 times
                group.fillMode = .forwards
                group.isRemovedOnCompletion = false

                self.circle.add(group, forKey: "loading")

                CATransaction.commit()
            }
        }
    }
}
