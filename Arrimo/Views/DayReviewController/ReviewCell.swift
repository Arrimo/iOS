//
//  ReviewCell.swift
//  Arrimo
//
//  Created by JJ Zapata on 5/19/21.
//

import UIKit
import Foundation

class ReviewCell: UITableViewCell {
    
    // MARK: - Constants
    
    static let identifier = "reviewCellIdentifier"
    
    // MARK: - Variables
    
    var heightAnchorForTaskTextViewHeight : NSLayoutConstraint?
    
    var event : Event? {
        didSet {
            if let event = event {
                
                // image view
                profileImageView.image = UIImage(named: event.patient!.gender!)!
                
                // info textview
                let startTime = Date(timeIntervalSince1970: Double(event.startTime!))
                let formatter = DateFormatter()
                formatter.dateFormat = "HH:mm"
                let attributedText = NSMutableAttributedString(string: event.patient!.firstName! + " " + event.patient!.lastName!, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.kufamBold(size: 14)!])
                let appendedText = NSMutableAttributedString(string: "\n gu", attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkBlue, NSAttributedString.Key.font : UIFont.kufamBold(size: 3)!])
                let appendedText2 = NSMutableAttributedString(string: "\n\(formatter.string(from: startTime)) | \(event.patient!.streetAddress!)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.kufam(size: 10)!])
                attributedText.append(appendedText)
                attributedText.append(appendedText2)
                infoTextView.attributedText = attributedText
                
                // tasks textview
                if let tasksCompleted = event.tasks?.filter({ task in
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
    
    let profileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.backgroundColor = UIColor.white
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    let infoTextView : UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isSelectable = false
        textView.textColor = UIColor.white
        textView.backgroundColor = UIColor.clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let tasksTextView : UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isSelectable = false
        textView.textColor = UIColor.white
        textView.backgroundColor = UIColor.clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
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
        
        mainView.addSubview(profileImageView)
        profileImageView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 9).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 9).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        mainView.addSubview(infoTextView)
        infoTextView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        infoTextView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 5).isActive = true
        infoTextView.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -9).isActive = true
        infoTextView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        mainView.addSubview(tasksTextView)
        tasksTextView.topAnchor.constraint(equalTo: infoTextView.bottomAnchor, constant: 8).isActive = true
        tasksTextView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 5).isActive = true
        tasksTextView.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -9).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Private Functions
    
    private func estimateFrameForText(text: String) -> CGRect {
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font : UIFont.kufam(size: 12)!, NSAttributedString.Key.foregroundColor : UIColor.white], context: nil)
    }

}
