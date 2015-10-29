//
//  BBPullToRefresh.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 10/29/15.
//  Copyright © 2015 BooYah. All rights reserved.
//

import UIKit

class Animator: RefreshViewAnimator {
    private let refreshView: BBRefreshView
    
    init(refreshView: BBRefreshView) {
        self.refreshView = refreshView
    }
    
    func animateState(state: State) {
        // animate refreshView according to state
        switch state {
        case .Inital:
            break // do inital layout for elements
        case .Releasing( _):
            refreshView.refreshImageView?.startAnimatingGif()
            break // animate elements according to progress
        case .Loading:
            break // start loading animations
        case .Finished:
            refreshView.refreshImageView?.stopAnimatingGif()
            break // show some finished state if needed
        }
    }
}

class BBPullToRefresh: PullToRefresh {

    convenience init() {
        let refreshView = NSBundle.mainBundle().loadNibNamed("BBRefreshView", owner: nil, options: nil).first as! BBRefreshView
        let animator = Animator(refreshView: refreshView)
        self.init(refreshView: refreshView, animator: animator)
    }
}
