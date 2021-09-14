//
//  EKButtonView.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 12/8/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

final class EKButtonView: UIView {

    // MARK: - Properties
    
    private let button = UIButton()
    private let titleLabel = UILabel()
    private let gradientView = GradientView.init()
    
    private let content: EKProperty.ButtonContent
    
    private let zoomScale: CGFloat = 0.9
    private let zoomDuration = 0.15
    private var zoomIsFinished = true
    
    // MARK: - Setup
    
    init(content: EKProperty.ButtonContent) {
        self.content = content
        super.init(frame: .zero)
        layer.borderWidth = content.borderWidth
        layer.borderColor = content.borderColor.cgColor
        setupGradientView()
        setupTitleLabel()
        setupButton()
        setupAcceessibility()
        setupInterfaceStyle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if content.cornerRadius >= 0 {
            layer.cornerRadius = content.cornerRadius
        } else {
            layer.cornerRadius = bounds.size.height / 2.0
        }
    }
    
    private func setupAcceessibility() {
        isAccessibilityElement = false
        button.isAccessibilityElement = true
        button.accessibilityIdentifier = content.accessibilityIdentifier
        button.accessibilityLabel = content.label.text
    }
    
    private func setupGradientView() {
        switch content.backgroundStyle {
        case let .gradient(gradient):
            gradientView.style = GradientView.Style(
                gradient: gradient,
                displayMode: content.displayMode
            )
            addSubview(gradientView)
            gradientView.fillSuperview()
        default:
            break
        }
    }
    
    private func setupButton() {
        addSubview(button)
        button.fillSuperview()
        if content.zoomAnimatedly {
            button.addTarget(self, action: #selector(buttonTouchUp),
                             for: [.touchUpOutside, .touchCancel])
            button.addTarget(self, action: #selector(buttonTouchDown),
                             for: .touchDown)
            button.addTarget(self, action: #selector(buttonTouchUpInside),
                             for: .touchUpInside)
        } else {
            button.addTarget(self, action: #selector(buttonTouchUp),
                             for: [.touchUpInside, .touchUpOutside, .touchCancel])
            button.addTarget(self, action: #selector(buttonTouchDown),
                             for: .touchDown)
            button.addTarget(self, action: #selector(buttonTouchUpInside),
                             for: .touchUpInside)
        }
    }
    
    private func setupTitleLabel() {
        titleLabel.numberOfLines = content.label.style.numberOfLines
        titleLabel.font = content.label.style.font
        titleLabel.text = content.label.text
        titleLabel.textAlignment = .center
        titleLabel.lineBreakMode = .byWordWrapping
        addSubview(titleLabel)
        titleLabel.layoutToSuperview(axis: .horizontally,
                                     offset: content.contentEdgeInset)
        titleLabel.layoutToSuperview(axis: .vertically,
                                     offset: content.contentEdgeInset)
    }
    
    private func setBackground(by content: EKProperty.ButtonContent,
                               isHighlighted: Bool) {
        if isHighlighted {
            backgroundColor = content.highlightedBackgroundColor(for: traitCollection)
        } else {
            backgroundColor = content.backgroundColor(for: traitCollection)
        }
    }
    
    private func setupInterfaceStyle() {
        layer.masksToBounds = true
        backgroundColor = content.backgroundColor(for: traitCollection)
        titleLabel.textColor = content.label.style.color(for: traitCollection)
    }
    
    // MARK: - Selectors
    
    @objc func buttonTouchUpInside() {
        if content.zoomAnimatedly {
            content.action?()
            self.buttonTouchUp()
        } else {
            content.action?()
        }
    }
    
    @objc func buttonTouchDown() {
        if content.zoomAnimatedly {
            if self.zoomIsFinished != true {
                return
            }
            self.zoomIsFinished = false
            UIView.animate(withDuration: self.zoomDuration) { [weak self] in
                guard let `self` = self else { return }
                self.transform = CGAffineTransform(scaleX: self.zoomScale, y: self.zoomScale)
            } completion: { [weak self] finised in
                guard let `self` = self else { return }
                self.zoomIsFinished = finised
            }
        } else {
            setBackground(by: content, isHighlighted: true)
        }
    }
    
    @objc func buttonTouchUp() {
        if content.zoomAnimatedly {
            var delay = self.zoomDuration
            if self.zoomIsFinished {
                delay = 0.01
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
                guard let `self` = self else { return }
                self.endZoomAnimation()
            }
        } else {
            setBackground(by: content, isHighlighted: false)
        }
    }
    
    func endZoomAnimation() {
        UIView.animate(withDuration: self.zoomDuration) { [weak self] in
            guard let `self` = self else { return }
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setupInterfaceStyle()
    }
}
