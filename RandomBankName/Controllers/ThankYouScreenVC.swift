//
//  ThankYouScreenVC.swift
//  RandomBankName
//
//  Created by Ali on 8/26/21.
//

import UIKit

class ThankYouScreenVC: UIViewController {

    private let headerLabel: CHeaderUILabel = {
        let label = CHeaderUILabel()
        label.text = "Thank you"
        label.font = Fonts.Bold.twentyFour
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    private let selfieImage: UIImageView =  {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "icon_user_gray")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 100
        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.createGradientLayer()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true

    }
    private func setupUI(){
        view.addSubview(headerLabel)
        view.addSubview(selfieImage)
        
        NSLayoutConstraint.activate([
            headerLabel.bottomAnchor.constraint(equalTo: selfieImage.topAnchor,constant: -20),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            selfieImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            selfieImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selfieImage.heightAnchor.constraint(equalToConstant: 200),
            selfieImage.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    
    public func setupView(name: String, image: UIImage) {
        headerLabel.text = "Thank you so much \(name) for Registering with us"
        selfieImage.image = image
    }
    

}
