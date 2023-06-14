//
//  UIView+Constrain.swift
//  Simpsons
//
//  Created by Admin on 6/13/23.
//

import UIKit

/**
 Custom defined constraints used for creating constraints of views.
 */
enum Constraint {
    case leading(CGFloat = 0.0)
    case trailing(CGFloat = 0.0)
    case top(CGFloat = 0.0)
    case bottom(CGFloat = 0.0)
    case centerX(CGFloat = 0.0)
    case centerY(CGFloat = 0.0)
    case topToBottom(CGFloat = 0.0)
    case leadingToTrailing(CGFloat = 0.0)

    func constrainView(mainView: UIView, parentView: UIView) -> NSLayoutConstraint {
        switch(self) {
        case .top(let constant):
            return mainView.topAnchor.constraint(equalTo: parentView.topAnchor,
                                                 constant: constant)
        case .leading(let constant):
            return mainView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor,
                                                     constant: constant)
        case .trailing(let constant):
            return mainView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor,
                                                      constant: constant)
        case .bottom(let constant):
            return mainView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor,
                                                    constant: constant)
        case .centerX(let constant):
            return mainView.centerXAnchor.constraint(equalTo: parentView.centerXAnchor,
                                                     constant: constant)
        case .centerY(let constant):
            return mainView.centerYAnchor.constraint(equalTo: parentView.centerYAnchor,
                                                     constant: constant)
        case .topToBottom(let constant):
            return mainView.topAnchor.constraint(equalTo: parentView.bottomAnchor,
                                                 constant: constant)
        case .leadingToTrailing(let constant):
            return mainView.leadingAnchor.constraint(equalTo: parentView.trailingAnchor,
                                                     constant: constant)
        }
    }
}

extension UIView {
    /**
     Constrains a view with the passed in parent view.
     - Parameters:
     - parentView: (UIView) The parent view you want to constrain the view against.
     - constraints: [Constraint] The constraints you want to set between both views.
     */
    func constrain(to parentView: UIView, constraints: [Constraint]) {
        self.translatesAutoresizingMaskIntoConstraints = false
        var layoutConstraints = [NSLayoutConstraint]()
        for constraint in constraints {
            layoutConstraints.append(constraint.constrainView(mainView: self,
                                                              parentView: parentView))
        }
        NSLayoutConstraint.activate(layoutConstraints)
    }

    /**
     An extension of Swift's addSubview, in order to give developers the ability to constrain while adding subview.
     - Parameters:
     - childView: (UIView) The view you want to add to the view.
     - constraints: [Constraint] The constraints you want the view to have releative to it's parent view.
     */
    func addSubview(_ childView: UIView, constraints: [Constraint]) {
        childView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(childView)
        var layoutConstraints = [NSLayoutConstraint]()
        for constraint in constraints {
            layoutConstraints.append(constraint.constrainView(mainView: childView,
                                                              parentView: self))
        }
        NSLayoutConstraint.activate(layoutConstraints)
    }
}
