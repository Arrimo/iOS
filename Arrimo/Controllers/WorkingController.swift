//
//  WorkingController.swift
//  Arrimo
//
//  Created by JJ Zapata on 4/24/21.
//

import UIKit
import CoreLocation

class WorkingController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource, TaskCellDelegate {
    
    // MARK: - Variables
    
    var tasks = [Task]() {
        didSet {
            taskLabel.text = "Tasks".localized() + " (\(tasks.count))"
        }
    }
    
    var events : [Event]? {
        didSet {
            if let patient = events![RunningInfo.shared.routeIndex].patient {
                self.patient = patient
                if let tasks = events![RunningInfo.shared.routeIndex].tasks {
                    self.tasks = tasks
                }
            }
        }
    }
    
    var patient : Patient?
    
    var locationManager : CLLocationManager!
    
    // MARK: - View Objects
    
    private let currentTimeLabel : UILabel = {
        let label = UILabel()
        label.text = "Current Time".localized()
        label.textColor = UIColor.darkBlue
        label.font = UIFont.kufam(size: 10)
        label.textAlignment = NSTextAlignment.center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timeLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.darkBlue
        label.font = UIFont.tekturBold(size: 30)
        label.textAlignment = NSTextAlignment.center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        label.text = "Hi there"
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
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.identifier)
        return tableView
    }()
    
    private let mainButton : MainButton = {
        let button = MainButton(title: "FERTIGSTELLEN BESUCH".localized())
        button.backgroundColor = UIColor.mainOrange
        button.addTarget(self, action: #selector(mainButtonPressed), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    private let divider : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.secondaryGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let orLabel : UILabel = {
        let label = UILabel()
        label.text = "OR".localized()
        label.font = UIFont.kufamBold(size: 15)!
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.secondaryGray
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pauseButton : MainButton = {
        let button = MainButton(title: "PAUSE".localized())
        button.addTarget(self, action: #selector(pauseButtonPressed), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    // MARK: - Overriden Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViewConstraints()
        locationServices()
        timer()
//        stubBackend()
        
        view.backgroundColor = .white
        navigationItem.title = "You're Currently Working".localized()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.backIndicatorImage = UIImage()
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage()
        navigationController?.navigationItem.backButtonTitle = ""
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = UIColor.darkBlue
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        view.addSubview(currentTimeLabel)
        currentTimeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 31).isActive = true
        currentTimeLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        currentTimeLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        currentTimeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(timeLabel)
        timeLabel.topAnchor.constraint(equalTo: currentTimeLabel.bottomAnchor, constant: 3).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(pauseButton)
        pauseButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        pauseButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        pauseButton.rightAnchor.constraint(equalTo: view.rightAnchor,  constant: -25).isActive = true
        pauseButton.heightAnchor.constraint(equalToConstant: 47).isActive = true
        
        view.addSubview(divider)
        divider.bottomAnchor.constraint(equalTo: pauseButton.topAnchor, constant: -45).isActive = true
        divider.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        divider.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        view.addSubview(orLabel)
        orLabel.centerYAnchor.constraint(equalTo: divider.centerYAnchor).isActive = true
        orLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        orLabel.widthAnchor.constraint(equalToConstant: 66).isActive = true
        orLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(mainButton)
        mainButton.bottomAnchor.constraint(equalTo: divider.topAnchor, constant: -45).isActive = true
        mainButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        mainButton.rightAnchor.constraint(equalTo: view.rightAnchor,  constant: -25).isActive = true
        mainButton.heightAnchor.constraint(equalToConstant: 47).isActive = true
        
        view.addSubview(taskView)
        taskView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 49).isActive = true
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
    }
    
    // MARK: - Private Functions
    
    private func locationServices() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if !CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    private func timer() {
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimeLabel), userInfo: nil, repeats: true)
    }
    
    private func allBoxesAreChecked() -> Bool {
        let numOfTasks = RunningInfo.shared.events![RunningInfo.shared.routeIndex].tasks!.count
        var currentNum = 0
        for task in RunningInfo.shared.events![RunningInfo.shared.routeIndex].tasks! {
            if task.isChecked! {
                currentNum += 1
            }
        }
        if currentNum == numOfTasks {
            return true
        } else {
            return false
            
        }
    }
    
    private func continueWithTasks() {
        if self.locationManager.location?.coordinate == nil {
            self.locationManager.requestWhenInUseAuthorization()
            self.addErrorNotification()
        } else {
            self.sendJSON(action: "finishVisit", long: self.locationManager.location!.coordinate.longitude, lat: self.locationManager.location!.coordinate.latitude, user: self.patient!.id!, caretaker: RunningInfo.shared.caretaker!.id!, tasks: RunningInfo.shared.events![RunningInfo.shared.routeIndex].tasks!)
            print(RunningInfo.shared.events![RunningInfo.shared.routeIndex].tasks!)
            self.continueToNextScreen()
        }
    }
    
    private func continueToNextScreen() {
        // show loading
        showLoading()
        let numberOfEvents = RunningInfo.shared.events!.count - 1
        if RunningInfo.shared.routeIndex == numberOfEvents {
            // hide loading
            let controller = DayReviewController()
            hideLoading()
            navigationController?.pushViewController(controller, animated: true)
        } else {
            RunningInfo.shared.routeIndex += 1
            let controller = StartCommuteController()
            controller.events = RunningInfo.shared.events
            controller.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            hideLoading()
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    // MARK: - Objective-C Functions
    
    @objc func pauseButtonPressed() {
        add3DMotion(withFeedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle.soft)
        print("are you sure you want to pause")
        let alert = UIAlertController(title: "Why are you pausing?".localized(), message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Lunch".localized(), style: UIAlertAction.Style.default, handler: { (alert) in
            if self.locationManager.location?.coordinate == nil {
                self.addErrorNotification()
                self.locationManager.requestWhenInUseAuthorization()
            } else {
                self.sendJSON(action: "lunchStart", long: self.locationManager.location!.coordinate.longitude, lat: self.locationManager.location!.coordinate.latitude, user: self.patient!.id!, caretaker: RunningInfo.shared.caretaker!.id!, tasks: nil)
                self.sendToPauseScreen(withAction: "LUNCH BREAK".localized())
            }
        }))
        alert.addAction(UIAlertAction(title: "Break / Personal".localized(), style: UIAlertAction.Style.default, handler: { (alert) in
            if self.locationManager.location?.coordinate == nil {
                self.addErrorNotification()
                self.locationManager.requestWhenInUseAuthorization()
            } else {
                self.sendJSON(action: "pauseStart", long: self.locationManager.location!.coordinate.longitude, lat: self.locationManager.location!.coordinate.latitude, user: self.patient!.id!, caretaker: RunningInfo.shared.caretaker!.id!, tasks: nil)
                self.sendToPauseScreen(withAction: "PAUSE".localized())
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel".localized(), style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func mainButtonPressed() {
        // start loading
        showLoading()
        add3DMotion(withFeedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle.light)
        
        // what happens if not all checkboxes are complete?
        if allBoxesAreChecked() {
            hideLoading()
            continueWithTasks()
        } else {
            let alert = UIAlertController.customActionWithCancel(title: "Wait! Not all tasks have been completed.".localized(), message: "Are you sure you want to continue?".localized()) {
                self.continueWithTasks()
            }
            hideLoading()
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func updateTimeLabel() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        timeLabel.text = formatter.string(from: Date())
    }
    
    // MARK: - UITableView Delegation
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.identifier, for: indexPath) as! TaskCell
        cell.task = tasks[indexPath.row]
        cell.delegate = self
        cell.indexPath = indexPath
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 61
    }
    
    // MARK: - TaskCell Delegation
    
    func taskCellCheckmarkChecked(_ tableViewCell: TaskCell, tappedIndexAt index: Int) {
        RunningInfo.shared.events![RunningInfo.shared.routeIndex].tasks![index].isChecked!.toggle()
    }

}
