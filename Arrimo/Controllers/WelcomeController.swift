//
//  WelcomeController.swift
//  Arrimo
//
//  Created by JJ Zapata on 4/20/21.
//

import UIKit
import CoreLocation
import SwiftKeychainWrapper

class WelcomeController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Variables
    
    var locationManager : CLLocationManager!
    
    var runningInfo = RunningInfo.shared
    
    var visits : [Visit]?
    
    // MARK: - View Objects
    
    private let appIcon : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "home-icon")!
        imageView.contentMode = UIView.ContentMode.scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let welcomeLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.darkBlue
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.tekturBold(size: 22)
        return label
    }()
    
    private let divider1 : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let mainButton : MainButton = {
        let button = MainButton(title: "Run My Day".localized())
        button.addTarget(self, action: #selector(mainButtonPressed), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    let calendarButton : MainButton = {
        let button = MainButton(title: "Calendar".localized())
        button.addTarget(self, action: #selector(calendarButtonPressed), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    let settingsButton : MainButton = {
        let button = MainButton(title: "Settings".localized())
        button.addTarget(self, action: #selector(settingsButtonPressed), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    let todayView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.aestheticGray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        return view
    }()
    
    let todayLabel : UILabel = {
        let label = UILabel()
        label.text = "Today's Overview".localized()
        label.textColor = UIColor.darkBlue
        label.font = UIFont.kufamBold(size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.left
        return label
    }()
    
    let todaySepView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 8/255, green: 59/255, blue: 102/255, alpha: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let todayTableView : UITableView = {
        let tableView = UITableView()
        tableView.register(TodayOverviewCell.self, forCellReuseIdentifier: TodayOverviewCell.identifier)
        tableView.backgroundColor = UIColor.clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Overriden Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        backend()
        
        view.backgroundColor = .white
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = UIColor.darkBlue
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        view.addSubview(appIcon)
        appIcon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 14).isActive = true
        appIcon.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        appIcon.widthAnchor.constraint(equalToConstant: 70).isActive = true
        appIcon.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        view.addSubview(welcomeLabel)
        welcomeLabel.topAnchor.constraint(equalTo: appIcon.bottomAnchor, constant: 27).isActive = true
        welcomeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        welcomeLabel.heightAnchor.constraint(equalToConstant: 28).isActive = true
        welcomeLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        
        view.addSubview(divider1)
        divider1.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 23).isActive = true
        divider1.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        divider1.heightAnchor.constraint(equalToConstant: 1).isActive = true
        divider1.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        
        view.addSubview(mainButton)
        mainButton.topAnchor.constraint(equalTo: divider1.bottomAnchor, constant: 24).isActive = true
        mainButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        mainButton.heightAnchor.constraint(equalToConstant: 47).isActive = true
        mainButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        
        view.addSubview(calendarButton)
        calendarButton.topAnchor.constraint(equalTo: mainButton.bottomAnchor, constant: 14).isActive = true
        calendarButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        calendarButton.heightAnchor.constraint(equalToConstant: 62).isActive = true
        calendarButton.widthAnchor.constraint(equalToConstant: (view.frame.size.width - 63) / 2).isActive = true
        
        view.addSubview(settingsButton)
        settingsButton.topAnchor.constraint(equalTo: mainButton.bottomAnchor, constant: 14).isActive = true
        settingsButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        settingsButton.heightAnchor.constraint(equalToConstant: 62).isActive = true
        settingsButton.widthAnchor.constraint(equalToConstant: (view.frame.size.width - 63) / 2).isActive = true
        
        view.addSubview(todayView)
        todayView.topAnchor.constraint(equalTo: settingsButton.bottomAnchor, constant: 24).isActive = true
        todayView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        todayView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        todayView.heightAnchor.constraint(equalToConstant: 325).isActive = true
        
        todayView.addSubview(todayLabel)
        todayLabel.topAnchor.constraint(equalTo: todayView.topAnchor, constant: 15).isActive = true
        todayLabel.leftAnchor.constraint(equalTo: todayView.leftAnchor, constant: 14).isActive = true
        todayLabel.rightAnchor.constraint(equalTo: todayView.rightAnchor, constant: -14).isActive = true
        todayLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        todayView.addSubview(todaySepView)
        todaySepView.topAnchor.constraint(equalTo: todayLabel.bottomAnchor, constant: 15).isActive = true
        todaySepView.leftAnchor.constraint(equalTo: todayView.leftAnchor).isActive = true
        todaySepView.rightAnchor.constraint(equalTo: todayView.rightAnchor).isActive = true
        todaySepView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        todayView.addSubview(todayTableView)
        todayTableView.topAnchor.constraint(equalTo: todaySepView.bottomAnchor, constant: 11.5).isActive = true
        todayTableView.rightAnchor.constraint(equalTo: todayView.rightAnchor).isActive = true
        todayTableView.leftAnchor.constraint(equalTo: todayView.leftAnchor).isActive = true
        todayTableView.bottomAnchor.constraint(equalTo: todayView.bottomAnchor, constant: -12).isActive = true
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
    
    private func backend() {
        // fetch employee information
        EmployeeAPI.shared.fetchEmployeeInformation { employee in
            DispatchQueue.main.async {
                RunningInfo.shared.employee = employee
                if let firstName = employee.firstName {
                    self.welcomeLabel.text = "Hello".localized() + ", " + firstName
                } else {
                    self.welcomeLabel.text = "Hello".localized()
                }

                // on success
                self.locationServices()
                self.updateViewConstraints()
                self.delegations()
                
                // fetch today's visits
                let patient1 = Patient()
                patient1.firstName = "John"
                patient1.lastName = "Doe"
                patient1.notes = "Loves apples"
                patient1.id = "PATIENT-ID-2021"
                patient1.streetAddress = "Bayernstraße 18, Haimhausen 85778 Deutschland"
                patient1.birthday = Date()
                patient1.gender = "male"
                
                let task1 = Task1()
                task1.title = "Wash the Dishes"
                task1.duration = 10
                
                let task2 = Task1()
                task2.title = "Clean Bedroom"
                task2.duration = 5
                
                let task3 = Task1()
                task3.title = "Cook Dinner"
                task3.duration = 30
                
                let visit = Visit()
                visit.employee = RunningInfo.shared.employee
                visit.patient = patient1
                visit.startTime = Date()
                visit.tasks = [task1, task2, task3]
                
                self.visits = [visit]
                self.todayTableView.reloadData()
            }
        }
    }
    
    private func fetchRoute() {
        showLoading()
        
        // FAKE BACKEND DATA
        let task1 = Task()
        task1.duration = 5
        task1.id = "task1ID"
        task1.isChecked = false
        task1.title = "Buy Groceries"
        
        let task2 = Task()
        task2.duration = 15
        task2.id = "task2ID"
        task2.isChecked = false
        task2.title = "Sweep Floors"
        
        let task3 = Task()
        task3.duration = 60
        task3.id = "task3ID"
        task3.isChecked = false
        task3.title = "Read a book"
        
        let patient1 = Patient()
        patient1.firstName = "John"
        patient1.lastName = "Doe"
        patient1.notes = "Loves apples"
        patient1.id = "PATIENT-ID-2021"
        patient1.streetAddress = "Bayernstraße 18, Haimhausen 85778 Deutschland"
        patient1.birthday = Date()
        patient1.gender = "male"
        
        let patient2 = Patient()
        patient2.firstName = "Angela"
        patient2.lastName = "Pearlman"
        patient2.notes = "Loves Alabama"
        patient2.id = "PATIENT-ID-2021-ALAMABA"
        patient2.streetAddress = "Bayernstraße 18, Haimhausen 85778 Deutschland"
        patient2.birthday = Date()
        patient2.gender = "female"
        
        let event1 = Event()
        event1.employee = RunningInfo.shared.employee
        event1.patient = patient1
        event1.startTime = 256265223
        event1.endTime = 256265632
        event1.tasks = [task1]
        
        let event2 = Event()
        event2.employee = RunningInfo.shared.employee
        event2.patient = patient2
        event2.startTime = 256265223
        event2.endTime = 256265632
        event2.tasks = [task2, task3]
        
        RunningInfo.shared.events = [event1, event2]
        RunningInfo.shared.routeIndex = 0
        
        let controller = StartCommuteController()
        controller.events = RunningInfo.shared.events
        controller.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        hideLoading()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func sendDictionary() {
        if locationManager.location?.coordinate == nil {
            locationManager.requestWhenInUseAuthorization()
        } else {
            sendJSON(action: "runMyDayStart", long: locationManager.location!.coordinate.longitude, lat: locationManager.location!.coordinate.latitude, user: nil, caretaker: RunningInfo.shared.employee!.id!, tasks: nil)
            fetchRoute()
        }
    }
    
    private func delegations() {
        todayTableView.delegate = self
        todayTableView.dataSource = self
    }
    
    // MARK: - Objective-C Functions
    
    @objc func mainButtonPressed() {
        // start loading
        showLoading()
        add3DMotion(withFeedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle.light)
        hideLoading()
        sendDictionary()
    }
    
    @objc func calendarButtonPressed() {
        let controller = CalendarController()
        add3DMotion(withFeedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle.light)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func settingsButtonPressed() {
        let controller = SettingsController()
        add3DMotion(withFeedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle.light)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: - UITableView Delegation
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let visits = visits else {
            return 0
        }
        return visits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TodayOverviewCell.identifier, for: indexPath) as! TodayOverviewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 114 + 9
    }

}
