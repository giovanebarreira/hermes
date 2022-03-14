//
//  RepositoryCell.swift
//  GithubGraphQL
//
//  Created by Avanade on 14/03/22.
//  Copyright © 2022 test. All rights reserved.
//

import UIKit

final class RepositoryCell: UITableViewCell {
    
    private let baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.4).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.8
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
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor =  #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ownerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.backgroundColor =  #colorLiteral(red: 0.2431372549, green: 0.7647058824, blue: 0.8392156863, alpha: 1)
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let urlLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    
    private let starImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 13
        img.clipsToBounds = true
        img.image = UIImage(systemName: "star.fill")
        img.tintColor = .systemYellow
        
        return img
    }()
    
    private let starCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor =  #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        
        self.contentView.addSubview(baseView)
        baseView.addSubview(avatar)
        
        containerView.addSubview(repoNameLabel)
        containerView.addSubview(ownerLabel)
        
        self.baseView.addSubview(containerView)
        self.baseView.addSubview(urlLabel)
        self.baseView.addSubview(starImage)
        
        setupCellContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup(object: RepositoryObjectDetails?) {
        if let thumbnailString = object?.thumbnailString {
            thumbnail.kf.setImage(with: URL(string: thumbnailString))
        }
        repoNameLabel.text = object?.repoNameText
        idLabel.text = object?.idText
        descriptionLabel.text = object?.descriptionText
    }
    
    func setupCellContraints() {
        baseView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8).isActive = true
        baseView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12).isActive = true
        baseView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12).isActive = true
        baseView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8).isActive = true
        
        avatar.centerYAnchor.constraint(equalTo: self.baseView.centerYAnchor).isActive = true
        avatar.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 10).isActive = true
        avatar.widthAnchor.constraint(equalToConstant: 70).isActive = true
        avatar.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        containerView.centerYAnchor.constraint(equalTo: self.baseView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.avatar.trailingAnchor, constant: 10).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -10).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        repoNameLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true
        repoNameLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        repoNameLabel.trailingAnchor.constraint(equalTo:self.starImage.leadingAnchor, constant: -10).isActive = true
        
        ownerLabel.topAnchor.constraint(equalTo:self.repoNameLabel.bottomAnchor).isActive = true
        ownerLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        ownerLabel.topAnchor.constraint(equalTo:self.repoNameLabel.bottomAnchor).isActive = true
        
        urlLabel.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 2).isActive = true
        urlLabel.leadingAnchor.constraint(equalTo: self.avatar.trailingAnchor, constant: 10).isActive = true
        urlLabel.trailingAnchor.constraint(equalTo: self.starImage.leadingAnchor, constant: -10).isActive = true
        
        starImage.widthAnchor.constraint(equalToConstant: 26).isActive = true
        starImage.heightAnchor.constraint(equalToConstant: 26).isActive = true
        starImage.trailingAnchor.constraint(equalTo:self.baseView.trailingAnchor, constant: -20).isActive = true
        starImage.centerYAnchor.constraint(equalTo:self.baseView.centerYAnchor).isActive = true
    }
}




