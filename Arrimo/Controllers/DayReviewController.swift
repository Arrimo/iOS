//
//  DayReviewController.swift
//  Arrimo
//
//  Created by JJ Zapata on 5/19/21.
//

import UIKit

class DayReviewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Variables
    
    var runningInfo = RunningInfo.shared
    
    var events = RunningInfo.shared.events
    
    // MARK: - View Objects
    
    private let overviewImage : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "check-complete")!
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        return imageView
    }()
    
    private let taskView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let taskLabel : UILabel = {
        let label = UILabel()
        label.text = "Day Review".localized()
        label.textColor = UIColor.darkBlue
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.kufamBold(size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let taskDivider : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkBlue
        view.alpha = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let taskTableView : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ReviewCell.self, forCellReuseIdentifier: ReviewCell.identifier)
        return tableView
    }()
    
    private let mainButton : MainButton = {
        let button = MainButton(title: "Close".localized())
        button.addTarget(self, action: #selector(mainButtonPressed), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    private let tasksTextView : UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isSelectable = false
        textView.textColor = UIColor.white
        textView.backgroundColor = UIColor.orange
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    // MARK: - Overriden Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pullTasks()
        updateViewConstraints()
        
        view.backgroundColor = .white
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = "Day Review".localized()
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = UIColor.darkBlue
        navigationController?.navigationItem.backButtonTitle = ""
        navigationItem.hidesBackButton = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        view.addSubview(overviewImage)
        overviewImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 28).isActive = true
        overviewImage.widthAnchor.constraint(equalToConstant: 120).isActive = true
        overviewImage.heightAnchor.constraint(equalToConstant: 120).isActive = true
        overviewImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(mainButton)
        mainButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        mainButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        mainButton.rightAnchor.constraint(equalTo: view.rightAnchor,  constant: -25).isActive = true
        mainButton.heightAnchor.constraint(equalToConstant: 47).isActive = true
        
        view.addSubview(taskView)
        taskView.topAnchor.constraint(equalTo: overviewImage.bottomAnchor, constant: 28).isActive = true
        taskView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        taskView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        taskView.bottomAnchor.constraint(equalTo: mainButton.topAnchor, constant: -40).isActive = true
        
        taskView.addSubview(taskLabel)
        taskLabel.topAnchor.constraint(equalTo: taskView.topAnchor, constant: 15).isActive = true
        taskLabel.leftAnchor.constraint(equalTo: taskView.leftAnchor, constant: 14).isActive = true
        taskLabel.rightAnchor.constraint(equalTo: taskView.rightAnchor, constant: -14).isActive = true
        taskLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        taskView.addSubview(taskDivider)
        taskDivider.topAnchor.constraint(equalTo: taskLabel.bottomAnchor, constant: 14).isActive = true
        taskDivider.leftAnchor.constraint(equalTo: taskView.leftAnchor).isActive = true
        taskDivider.rightAnchor.constraint(equalTo: taskView.rightAnchor).isActive = true
        taskDivider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        taskView.addSubview(taskTableView)
        taskTableView.delegate = self
        taskTableView.dataSource = self
        taskTableView.topAnchor.constraint(equalTo: taskDivider.bottomAnchor, constant: 4.5).isActive = true
        taskTableView.leftAnchor.constraint(equalTo: taskView.leftAnchor).isActive = true
        taskTableView.rightAnchor.constraint(equalTo: taskView.rightAnchor).isActive = true
        taskTableView.bottomAnchor.constraint(equalTo: taskView.bottomAnchor, constant: -14).isActive = true
        
        // VIEW CONSTRAINTS HERE
    }
    
    // MARK: - Private Functions
    
    private func pullTasks() {
        // BACKEND WORK HERE
    }
    
    private func estimateFrameForText(text: String) -> CGRect {
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font : UIFont.kufam(size: 12)!, NSAttributedString.Key.foregroundColor : UIColor.white], context: nil)
    }
    
    private func resetDataAndPop() {
        RunningInfo.shared.events = nil
        RunningInfo.shared.routeIndex = 0
        navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - Objective-C Functions
    
    @objc func mainButtonPressed() {
        // start loading
        showLoading()
        add3DMotion(withFeedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle.light)
        hideLoading()
        // ACTION
        resetDataAndPop()
    }
    
    // MARK: - UITableView Delegation
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReviewCell.identifier, for: indexPath) as! ReviewCell
        cell.event = events![indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let generalHeight = 50
        if let tasksCompleted = events![indexPath.row].tasks?.filter({ task in
            if task.isChecked! {
                return true
            } else {
                return false
            }
        }) {
            let attributedText = NSMutableAttributedString()
            for task in tasksCompleted {
                attributedText.append(NSMutableAttributedString(string: "• \(task.title!)\n", attributes: [NSAttributedString.Key.font : UIFont.kufam(size: 12)!, NSAttributedString.Key.foregroundColor : UIColor.white]))
            }
            tasksTextView.attributedText = attributedText
            tasksTextView.heightAnchor.constraint(equalToConstant: estimateFrameForText(text: tasksTextView.text).height).isActive = true
            let heightOfTaskTextView = estimateFrameForText(text: tasksTextView.text).height
            return CGFloat(generalHeight + 10) + heightOfTaskTextView
        } else {
            return 200
        }
    }

}
