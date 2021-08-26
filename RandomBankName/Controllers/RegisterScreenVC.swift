//
//  RegisterScreenVC.swift
//  RegisterScreenVC
//
//  Created by Ali on 8/26/21.
//

import UIKit
import AVFaceDetectionCam
class RegisterScreenVC: UIViewController {
    
    private let headerLabel: CHeaderUILabel = {
        let label = CHeaderUILabel()
        label.text = "Register"
        label.font = Fonts.Bold.twentyFour
        label.textColor = .white
        
        return label
    }()
    private let containerView: UIView =  {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        view.addViewShadow()
        return view
    }()
    
    
    private let nameTextField: CITextField =  {
        let textField = CITextField()
        textField.placeholder = "User Name"
        return textField
    }()
    
    private let selfieDescription: CBodyUILabel =  {
        let label = CBodyUILabel()
        label.text = "App wants you to provide a selfie please."
        return label
    }()
    
    private let selfieImage: UIImageView =  {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "icon_user_gray")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 30
        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let passwordTextField: CITextField =  {
        let textField = CITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        
        return textField
    }()
    
    private let emailTextField: CITextField =  {
        let textField = CITextField()
        textField.placeholder = "Email Address"
        
        return textField
    }()
    
    private let submitButton: CUIButton =  {
        let button = CUIButton(title: "Register", backgroundColor: .gray)
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(submitAction), for: .touchUpInside)
        button.isEnabled = false
        
        return button
    }()
    
    private let stackView: UIStackView =  {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 20
        stackView.axis = .vertical
        return stackView
    }()
    
    
    private let logoImageView: UIImageView =  {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "bankIcon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true

        view.createGradientLayer()
        // Do any additional setup after loading the view.
        logoImageView.alpha = 0
        headerLabel.alpha = 0
        containerView.alpha = 0
        nameTextField.alpha = 0
        passwordTextField.alpha = 0
        emailTextField.alpha = 0
        submitButton.alpha = 0
        setupUI()
        animateInViews()

    }
    
    var isFieldsValid = false {
        didSet {
            if isFieldsValid {
                reloadView()
            }
        }
    }
    
    var userImage: UIImage?
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        reloadView()
        
    }
    
    func setupUI(){
        view.addSubview(containerView)
        view.addSubview(headerLabel)
        containerView.addSubview(submitButton)
        containerView.addSubview(logoImageView)
        containerView.addSubview(selfieDescription)
        containerView.addSubview(selfieImage)
        containerView.addSubview(logoImageView)
        setupStackView()
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: 400),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: 30),
            
            headerLabel.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: -20),
            headerLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            
            selfieDescription.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            selfieDescription.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            selfieDescription.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            
            selfieImage.topAnchor.constraint(equalTo: selfieDescription.bottomAnchor, constant: 15),
            selfieImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selfieImage.heightAnchor.constraint(equalToConstant: 60),
            selfieImage.widthAnchor.constraint(equalToConstant: 60),
            
            submitButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            submitButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 50),
            submitButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -50),
            submitButton.heightAnchor.constraint(equalToConstant: 60),
            
            
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
        ])
        let gesuteRecognizer = UITapGestureRecognizer(target: self, action: #selector(logoAction))
        selfieImage.addGestureRecognizer(gesuteRecognizer)
        nameTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.delegate = self
    }
    
    func setupStackView(){
        containerView.addSubview(stackView)
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
    }
    
    
    @objc func submitAction() {
        let vc = ThankYouScreenVC()
        vc.setupView(name: nameTextField.text ?? "", image: selfieImage.image ?? UIImage())
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func logoAction(){
        let vc = AVFaceDetectionCamVC()
        vc.delegate = self
        let nc = UINavigationController(rootViewController: vc)
        nc.modalPresentationStyle = .fullScreen
        present(nc, animated: true, completion: nil)
//        navigationController?.pushViewController(nc, animated: true)
    }
    
    
    func reloadView() {
        guard let _ = userImage else {
            return
        }
        if isFieldsValid {
            submitButton.isEnabled = true
            UIView.animate(withDuration: 1) { [weak self] in
                self?.submitButton.backgroundColor = .orange
            }
        } else {
            submitButton.isEnabled = false
            UIView.animate(withDuration: 1) { [weak self] in
                self?.submitButton.backgroundColor = .gray
            }
        }
        
    }
    
    /// Animate all the views in
    func animateInViews() {
        logoImageView.alpha = 0
        headerLabel.alpha = 0
        containerView.alpha = 0
        nameTextField.alpha = 0
        passwordTextField.alpha = 0
        emailTextField.alpha = 0
        submitButton.alpha = 0
        
        let views = [logoImageView,headerLabel,containerView,nameTextField,emailTextField,passwordTextField,selfieDescription,selfieImage,submitButton]
        for (i,view) in views.enumerated() {
            animateInView(with: view, delay: Double(i) * 0.2)
        }
        
    }
    /// Animate all the views out
    func animateOutViews(completionHandler: @escaping () -> Void) {
        let views = [logoImageView,headerLabel,containerView,nameTextField,emailTextField,passwordTextField,selfieDescription,selfieImage,submitButton]
        var completionHandlerToUse: (()-> Void)? = nil
        for (i,view) in views.enumerated() {
            if view == views.last {
                completionHandlerToUse = completionHandler
            }
            animateOutView(with: view, delay: Double(i) * 0.2, completionHandler: completionHandlerToUse)
        }
        
    }
    
    
    ///Animate One view In
    private func animateInView(with view: UIView, delay: TimeInterval) {
        view.alpha = 0
        if view != containerView {
            view.transform = CGAffineTransform(translationX: 0, y: -20)
            
        }
        
        let animate = UIViewPropertyAnimator(duration: 0.2, curve: .easeInOut) {
            view.alpha = 1
            view.transform = .identity
        }
        animate.startAnimation(afterDelay: delay)
    }
    
    ///Animate One view out
    private func animateOutView(with view: UIView, delay: TimeInterval, completionHandler: (() -> Void)?) {
        
        let animate = UIViewPropertyAnimator(duration: 0.2, curve: .easeInOut) {
            view.alpha = 0
            view.transform = CGAffineTransform(translationX: 0, y: -20)
        }
        
        animate.addCompletion { _ in
            completionHandler?()
        }
        animate.startAnimation(afterDelay: delay)
    }
}


extension RegisterScreenVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let name = nameTextField.text, !name.isEmpty ,let pass = passwordTextField.text, !pass.isEmpty ,let email = emailTextField.text, !email.isEmpty else {
            isFieldsValid = false
            return true
        }
        isFieldsValid = true
        
        return true
    }
}

extension RegisterScreenVC: AVFaceDetectionCamVCDelegate {
    func didReturnUserFaceImage(image: UIImage?) {
        userImage = image
        selfieImage.image = image
    }
    
}
