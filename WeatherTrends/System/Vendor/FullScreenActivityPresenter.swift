//
// FullScreenActivityPresenter.swift
// SPRKit
//
// Copyright (c) 2017 SPR Consulting <info@spr.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to
// deal in the Software without restriction, including without limitation the
// rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
// sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
// IN THE SOFTWARE.
//

import UIKit


fileprivate let fadeDuration: TimeInterval = 0.2
fileprivate let spinDuration: TimeInterval = 0.8

fileprivate let fullSpin: CGFloat = .pi * 2.0

fileprivate let spinnerTransform0000To0250 = CATransform3DGetAffineTransform(CATransform3DMakeRotation(0.250 * fullSpin, 0, 0, 1)) // rotate to  90 degrees position
fileprivate let spinnerTransform0250To0500 = CATransform3DGetAffineTransform(CATransform3DMakeRotation(0.500 * fullSpin, 0, 0, 1)) // rotate to 180 degrees position
fileprivate let spinnerTransform0500To0750 = CATransform3DGetAffineTransform(CATransform3DMakeRotation(0.750 * fullSpin, 0, 0, 1)) // rotate to 270 degrees position
fileprivate let spinnerTransform0750To1000 = CATransform3DGetAffineTransform(CATransform3DIdentity)                                // return to initial position


/// An implmentation of `SPRViewControllerActivityPresenter` that places a
/// UIWindow over the entire app and shows a spinner in the center of that 
/// window. 
public final class FullScreenActivityPresenter: SPRViewControllerActivityPresenter {
    
    private enum State {
        case hidden
        case visible
        case fadingOut
    }
    
    private class DefaultSpinnerView: UIView {
        public override var intrinsicContentSize: CGSize {
            get { return CGSize(width: 44.0, height: 44.0) }
        }
        
        public override init(frame: CGRect) {
            super.init(frame: frame)
            self.backgroundColor = UIColor.clear
        }
        
        public required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            self.backgroundColor = UIColor.clear
        }
        
        override public func draw(_ rect: CGRect) {
            //// Color Declarations
            let color = self.tintColor ?? UIColor.darkGray
            
            //// circle Drawing
            let circlePath = UIBezierPath()
            circlePath.move(to: CGPoint(x: 41, y: 22))
            circlePath.addCurve(to: CGPoint(x: 22, y: 41), controlPoint1: CGPoint(x: 41, y: 32.49), controlPoint2: CGPoint(x: 32.49, y: 41))
            circlePath.addCurve(to: CGPoint(x: 3, y: 22), controlPoint1: CGPoint(x: 11.51, y: 41), controlPoint2: CGPoint(x: 3, y: 32.49))
            circlePath.addCurve(to: CGPoint(x: 22, y: 3), controlPoint1: CGPoint(x: 3, y: 11.51), controlPoint2: CGPoint(x: 11.51, y: 3))
            circlePath.addCurve(to: CGPoint(x: 33.91, y: 7.19), controlPoint1: CGPoint(x: 26.51, y: 3), controlPoint2: CGPoint(x: 30.65, y: 4.57))
            color.setStroke()
            circlePath.lineWidth = 2
            circlePath.lineCapStyle = .round
            circlePath.lineJoinStyle = .bevel
            circlePath.stroke()
        }
    }
    
    public static let shared = FullScreenActivityPresenter()
    
    public var spinnerFactory: () -> UIView = { return DefaultSpinnerView(frame: CGRect(x: 0, y: 0, width: 44, height: 44)) }
    public var backgroundColor: UIColor = UIColor.white.withAlphaComponent(0.9)
    public var tintColor: UIColor = UIColor.black
    
    private var viewControllersWithActivity = Set<UIViewController>()
    private var window: UIWindow?
    
    // MARK: - SPRViewControllerActivityPresenter
    
    public func hideActivityIndicator(forViewController viewController: UIViewController) {
        let beforeCount = self.viewControllersWithActivity.count
        self.viewControllersWithActivity.remove(viewController)
        let afterCount = self.viewControllersWithActivity.count
        
        if beforeCount == 1 && afterCount == 0 {
            fadeOutAndHideWindow(self.window)
            self.window = nil
        }
    }
    
    public func layoutActivityIndicator(forViewController viewController: UIViewController) {
        // do nothing
    }
    
    public func showActivityIndicator(forViewController viewController: UIViewController) {
        let beforeCount = self.viewControllersWithActivity.count
        self.viewControllersWithActivity.insert(viewController)
        let afterCount = self.viewControllersWithActivity.count
        
        if beforeCount == 0 && afterCount == 1 {
            let window = createWindow()
            let spinner = createSpinner(inWindow: window)
            window.makeKeyAndVisible()
            self.window = window
            animateSpinner(spinner)
        }
    }
    
    // MARK: - Private Helpers
    
    private func animateSpinner(_ spinner: UIView) {
        guard self.window == spinner.superview else { return }
        
        // An animation sequence using keyframes, rotating the spinner 90
        // degrees each step, returning the view to its original angle, thereby
        // allowing the animation to be repeated.
        let animations = {
            UIView.setAnimationCurve(.linear)
            
            UIView.addKeyframe(withRelativeStartTime: 0.000, relativeDuration: 0.250) {
                spinner.transform = spinnerTransform0000To0250
            }
            UIView.addKeyframe(withRelativeStartTime: 0.250, relativeDuration: 0.250) {
                spinner.transform = spinnerTransform0250To0500
            }
            UIView.addKeyframe(withRelativeStartTime: 0.500, relativeDuration: 0.250) {
                spinner.transform = spinnerTransform0500To0750
            }
            UIView.addKeyframe(withRelativeStartTime: 0.750, relativeDuration: 0.250) {
                spinner.transform = spinnerTransform0750To1000
            }
        }
        
        UIView.animateKeyframes(withDuration: spinDuration, delay: 0.0, options: [.repeat], animations: animations, completion: nil)
    }
    
    private func createSpinner(inWindow window: UIWindow) -> UIView {
        let spinner = self.spinnerFactory()
        spinner.center = window.center
        spinner.tintColor = self.tintColor
        
        window.addSubview(spinner)
        
        return spinner
    }
    
    private func createWindow() -> UIWindow {
        let window = UIWindow()
        window.backgroundColor = self.backgroundColor
        window.isUserInteractionEnabled = false
        window.tintColor = self.tintColor
        
        window.windowLevel = UIWindowLevelAlert - 1.0
        
        return window
    }
    
    private func fadeOutAndHideWindow(_ window: UIWindow?) {
        guard let window = window else { return }
        
        let animations = { window.alpha = 0.0 }
        let completion = { (_: Bool) in
            window.isHidden = true
        }
        
        UIView.animate(withDuration: fadeDuration, animations: animations, completion: completion)
    }
    
    
}
