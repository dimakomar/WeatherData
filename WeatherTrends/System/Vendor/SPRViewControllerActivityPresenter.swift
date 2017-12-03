//
// SPRViewControllerActivityPresenter.swift
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


/// The `SPRViewControllerActivityIndicator` protocol defines the methods that 
/// `SPR*ViewController` classes use to manage the presentation of spinners or 
/// other activity indicators while performing asynchronous activities.
/// 
/// Implementations must allow calls to `show` and `hide` _from the same view
/// controller_ to be unbalanced; i.e., when a view controller calls `show` 
/// twice (without an intervening `hide`), it only counts once and when a view 
/// controller calls `hide` twice (without an intervening `show`) it only 
/// counts once. Basically, this means that implementations cannot simply keep 
/// a count that increments on each call to `show` and decrements on each call 
/// to `hide` — the implementation must track which VCs have asked to show and 
/// hide. 
/// 
///     activityPresenter.showActivityIndicator(forViewController: theVC)
///     // -> shows the activity indicator
///     activityPresenter.showActivityIndicator(forViewController: theVC)
///     // -> does nothing; the activity indicator stays on screen
///     activityPresenter.hideActivityIndicator(forViewController: theVC)
///     // -> hides the activity indicator
///     activityPresenter.hideActivityIndicator(forViewController: theVC)
///     // -> hides the activity indicator
public protocol SPRViewControllerActivityPresenter {
    
    /// Update the UI to indicate the view controller is performing a task,
    /// such as loading its content.
    ///
    /// This function may be called multiple times without intervening calls to 
    /// `hideActivity(…)` if the view controller's view was reloaded while the 
    /// task was running.
    ///
    /// An example use of this method is show a `UIActivityIndicatorView`.
    func showActivityIndicator(forViewController viewController: UIViewController)
    
    /// Layout the views or layers that are indicating activity.
    /// 
    /// This method will be called _at least once_ for each invocation of
    /// `showActivity(…)`. 
    func layoutActivityIndicator(forViewController viewController: UIViewController)
    
    /// Update the UI to indicate this view controller has completed loading
    /// its content. Generally, this function reverses whatever changes
    /// `showActivity()` made to the view, such as hiding or removing views.
    ///
    /// This function is called before the view controller invokes its methdos 
    /// related to the model being loaded, such as `didReload*View(:)` or 
    /// `handleError(:)`.
    func hideActivityIndicator(forViewController viewController: UIViewController)
    
}
