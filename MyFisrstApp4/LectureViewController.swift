//
//  LectureViewController.swift
//  MyFisrstApp4
//
//  Created by Vadim Belotitskiy on 22.05.2023.
//

import UIKit

class LectureViewController: UIViewController {

    private var textView: UITextView!

    var lecture: Lecture? {
        didSet {
            if isViewLoaded {
                setup(with: lecture)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        textView = UITextView()
        textView.isEditable = false
        textView.font = .systemFont(ofSize: 16)
        textView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textView)

        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
        ])
//        textView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        textView.frame = view.bounds.insetBy(dx: 16, dy: 16)

        setup(with: lecture)
    }
    
    private func setup(with lecture: Lecture?) {
        if let lecture {
            textView.text = lecture.description
            navigationItem.title = lecture.name
        } else {
            textView.text = nil
            navigationItem.title = nil
        }
    }
}
