//
//  RepositoryCell.swift
//  GithubGraphQL
//
//  Created by Avanade on 14/03/22.
//  Copyright © 2022 test. All rights reserved.
//

import UIKit
import Kingfisher

final class RepositoryCell: UITableViewCell {
    
    private let baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = false
        view.layer.borderWidth = 1
        view.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let avatar: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 35
        img.clipsToBounds = true
        return img
    }()
    
    private let repoNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor =  #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ownerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.backgroundColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let urlLabel: UITextView = {
        let txtView = UITextView()
        txtView.tintColor = .black
        txtView.font = UIFont.boldSystemFont(ofSize: 14)
        txtView.isEditable = false
        txtView.translatesAutoresizingMaskIntoConstraints = false
        txtView.contentInsetAdjustmentBehavior = .automatic
        txtView.textAlignment = .left
        txtView.linkTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.underlineStyle.rawValue): NSUnderlineStyle.single.rawValue] as [NSAttributedString.Key: Any]?
        return txtView
    }()
        
    private let starImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        img.image = UIImage(systemName: "star.fill")
        img.tintColor = .systemYellow
        return img
    }()
    
    private let starCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor(red: 200/255.0, green: 200/255.0, blue: 200/255.0, alpha: 1.0)
        
        self.contentView.addSubview(baseView)
        baseView.addSubview(avatar)
        self.baseView.addSubview(repoNameLabel)
        self.baseView.addSubview(ownerLabel)
        self.baseView.addSubview(urlLabel)
        self.baseView.addSubview(starImage)
        self.baseView.addSubview(starCountLabel)
        setupCellContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup(object: RepositoryObjectDetails?) {
        if let avatarUrl = object?.avatarUrl {
            avatar.kf.setImage(with: avatarUrl)
        }
        
        repoNameLabel.text = object?.repoNameText
        ownerLabel.text = object?.owner
        urlLabel.text = object?.urlText
        starCountLabel.text = object?.stars
        createClickableLink(textUrl: urlLabel.text)
    }
    
    private func createClickableLink(textUrl: String?) {
        let linkedText = NSMutableAttributedString(attributedString: urlLabel.attributedText)
        let hyperlinked = linkedText.setAsLink(textToFind: textUrl ?? "Url not found", linkURL: textUrl ?? "")
                
        if hyperlinked {
            urlLabel.attributedText = NSAttributedString(attributedString: linkedText)
        }
    }
    
   private func setupCellContraints() {
        baseView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8).isActive = true
        baseView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12).isActive = true
        baseView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12).isActive = true
        baseView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8).isActive = true
        
        avatar.centerYAnchor.constraint(equalTo: self.baseView.centerYAnchor).isActive = true
        avatar.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 10).isActive = true
        avatar.widthAnchor.constraint(equalToConstant: 70).isActive = true
        avatar.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        repoNameLabel.topAnchor.constraint(equalTo: self.avatar.topAnchor, constant: -8 ).isActive = true
        repoNameLabel.leadingAnchor.constraint(equalTo: self.avatar.trailingAnchor, constant: 8).isActive = true
        repoNameLabel.trailingAnchor.constraint(equalTo: self.starImage.leadingAnchor, constant: -10).isActive = true
        
        ownerLabel.leadingAnchor.constraint(equalTo: self.avatar.trailingAnchor, constant: 8).isActive = true
        ownerLabel.topAnchor.constraint(equalTo: self.repoNameLabel.bottomAnchor).isActive = true
        
        urlLabel.topAnchor.constraint(equalTo: ownerLabel.bottomAnchor, constant: 0).isActive = true
        urlLabel.leadingAnchor.constraint(equalTo: self.avatar.trailingAnchor, constant: 6).isActive = true
        urlLabel.trailingAnchor.constraint(equalTo: self.starImage.leadingAnchor, constant: -10).isActive = true
        urlLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        starImage.widthAnchor.constraint(equalToConstant: 26).isActive = true
        starImage.heightAnchor.constraint(equalToConstant: 26).isActive = true
        starImage.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20).isActive = true
        starImage.centerYAnchor.constraint(equalTo: self.baseView.centerYAnchor).isActive = true
        
        starCountLabel.topAnchor.constraint(equalTo: starImage.bottomAnchor, constant: 4).isActive = true
        starCountLabel.centerXAnchor.constraint(equalTo: starImage.centerXAnchor).isActive = true
    }
}
