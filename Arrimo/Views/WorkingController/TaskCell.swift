//
//  TaskCell.swift
//  Arrimo
//
//  Created by JJ Zapata on 5/6/21.
//

import UIKit

class TaskCell: UITableViewCell {
    
    // MARK: - Constants
    
    static let identifier = "taskCellIdentifier"
    
    // MARK: - Variables
    
    var delegate : TaskCellDelegate?
    
    var indexPath : IndexPath?
    
    var taskId : String?
    
    var task : Task! {
        didSet {
            if let task = task, let taskTitle = task.title, let taskDuration = task.duration {
                taskId = task.id
                let string = NSMutableAttributedString(string: taskTitle, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.kufamBold(size: 14)!])
                string.append(NSAttributedString(string: "\n\(taskDuration) " + "Minutes".localized(), attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.kufam(size: 10)!]))
                label.attributedText = string
                
                if task.isChecked == nil {
                    task.isChecked = false
                }
            }
        }
    }
    
    // MARK: - View Objects
    
    private let mainView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkBlue
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let checkBox : CheckBox = {
        let view = CheckBox()
        view.style = .tick
//        view.addTarget(self, action: #selector(onThursdayCheck(_:)), for: .valueChanged)
        view.borderStyle = .rounded
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let label : UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        return label
    }()
    
    // MARK: - Overriden Functions
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // MARK: - Defaults
        
        backgroundColor = UIColor.clear
        selectionStyle = SelectionStyle.none
        
        // MARK: - Constraints
        
        addSubview(mainView)
        mainView.topAnchor.constraint(equalTo: topAnchor, constant: 4.5).isActive = true
        mainView.leftAnchor.constraint(equalTo: leftAnchor, constant: 19).isActive = true
        mainView.rightAnchor.constraint(equalTo: rightAnchor, constant: -19).isActive = true
        mainView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4.5).isActive = true
        
        contentView.addSubview(checkBox)
        checkBox.addTarget(self, action: #selector(checkedCheckmark(_:)), for: UIControl.Event.valueChanged)
        checkBox.centerYAnchor.constraint(equalTo: mainView.centerYAnchor).isActive = true
        checkBox.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 9).isActive = true
        checkBox.widthAnchor.constraint(equalToConstant: 30).isActive = true
        checkBox.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        addSubview(label)
        label.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 9).isActive = true
        label.leftAnchor.constraint(equalTo: checkBox.rightAnchor, constant: 9).isActive = true
        label.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -9).isActive = true
        label.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -9).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Objective-C Functions
    
    @objc func checkedCheckmark(_ sender: CheckBox) {
        delegate?.taskCellCheckmarkChecked(self, tappedIndexAt: (indexPath?.row)!)
    }

}

protocol TaskCellDelegate {
    func taskCellCheckmarkChecked(_ tableViewCell: TaskCell, tappedIndexAt index: Int)
}
