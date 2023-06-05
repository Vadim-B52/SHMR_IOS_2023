//
//  ViewController.swift
//  MyFisrstApp4
//
//  Created by Vadim Belotitskiy on 22.05.2023.
//

import UIKit

class CourseViewController: UITableViewController {

    private var token: Any?
    private let lectureCellId = "lectureCellId"

    private lazy var today = Date()
    private lazy var calendar = Calendar.current
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM"
        return dateFormatter
    }()

    private lazy var course: Course = {
        return CourseStorage().load()
    }()

    deinit {
        if let token {
            NotificationCenter.default.removeObserver(token)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = course.name

        token = NotificationCenter.default.addObserver(
            forName: UIApplication.significantTimeChangeNotification,
            object: nil,
            queue: nil,
            using: { [unowned self] _ in
                today = Date()
                self.tableView.reloadData()
            })
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        course.lectures.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: lectureCellId, for: indexPath)
        let lecture = course.lectures[indexPath.row]
//        let prefix = String(format: "%02d", indexPath.row + 1)
        let prefix = dateFormatter.string(from: lecture.date)
        cell.textLabel?.text = "\(prefix) - \(lecture.name)"
        cell.accessoryType = .disclosureIndicator

        let comparisonResult = compareDates(today: today, lecture: lecture.date)
        cell.textLabel?.textColor = textColor(with: comparisonResult)
        cell.textLabel?.font = font(with: comparisonResult)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let lecture = course.lectures[indexPath.row]
        let lectureViewController = LectureViewController()
        lectureViewController.lecture = lecture
        navigationController?.pushViewController(lectureViewController, animated: true)
    }

    private func compareDates(today: Date, lecture: Date) -> ComparisonResult {
        let todayComponents = calendar.dateComponents([.year, .month, .day], from: today)
        let lectureComponents = calendar.dateComponents([.year, .month, .day], from: lecture)
        if todayComponents.year! == lectureComponents.year! &&
            todayComponents.month! == lectureComponents.month! &&
            todayComponents.day! == lectureComponents.day!
        {
            return .orderedSame
        }
        return today < lecture ? .orderedAscending : .orderedDescending
    }

    private func textColor(with result: ComparisonResult) -> UIColor {
        if result == .orderedDescending {
            return .lightGray
        } else {
            return .black
        }
    }

    private func font(with result: ComparisonResult) -> UIFont {
        if result == .orderedSame {
            return UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
        } else {
            return UIFont.systemFont(ofSize: UIFont.systemFontSize)
        }
    }
}

