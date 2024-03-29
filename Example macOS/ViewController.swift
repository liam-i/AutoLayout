//
//  ViewController.swift
//  Example macOS
//
//  Created by liam on 2024/2/6.
//  Copyright © 2024 Liam. All rights reserved.
//

import AppKit
import AutoFlex

class ViewController: NSViewController {
    private lazy var label = makeLabel(title: "演示 constant 和 multiplier 的使用")
    private lazy var label2 = makeLabel(title: "演示 constant 和 multiplier 的使用（size是label.size的0.5倍）")

    private lazy var label3 = makeLabel(title: "演示 constant 和 Priority 的使用（width:250）")
    private lazy var label4 = makeLabel(title: "演示 constant 和 Priority 的使用（width被压缩）")

    override func viewDidLoad() {
        super.viewDidLoad()

        label.af.constraints {
            $0.top.equal(to: view.af.safeGuide, options: .constant(20))
            $0.leading.trailing.equal(to: view, options: .constant(20))
            $0.centerX.equal(to: view)
            $0.height.equal(toOptions: .constant(50))
            //$0.height.equal(to: label.widthAnchor, options: .multiplier(0.7))
        }
        label2.af.constraints {
            $0.top.equal(to: label.bottomAnchor, options: .constant(20))
            $0.leading.equal(to: label)
            $0.size.equal(to: label, options: .multiplier(0.5))
        }

        label3.af.constraints {
            $0.top.equal(to: label2.bottomAnchor, options: .constant(50))
            $0.leading.equal(to: label)
            $0.width.equal(toOptions: .constant(250))
        }
        label4.af.constraints {
            $0.top.equal(to: label3.firstBaselineAnchor)
            $0.trailing.equal(to: view.trailingAnchor, constant: 20)
            if let constraint = $0.leading.equal(to: label3.trailingAnchor, constant: 10).first {
                // 因为 label4.width.priority 小于 label3.width.priority 所以 label4.width 会被压缩
                $0.width.equal(toOptions: .constant(250), .priority(constraint.advancedPriority(by: -1)))
            } else {
                assertionFailure()
            }
        }
    }

    private func makeLabel(title: String) -> NSTextField {
        let label = NSTextField(string: title)
        label.maximumNumberOfLines = 5
        label.textColor = .black
        label.backgroundColor = .clear
        label.isBezeled = false
        label.isEditable = false
        view.addSubview(label)
        return label
    }
}
