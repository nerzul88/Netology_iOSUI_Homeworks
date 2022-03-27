//
//  LogInViewController.swift
//  Navigation
//
//  Created by Александр Касьянов on 08.03.2022.
//

import UIKit

class LogInViewController: UIViewController {
    
    private lazy var validationData = ValidationData()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        return contentView
        }()
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var loginPasswordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .systemGray6
        stackView.clipsToBounds = true
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.layer.borderWidth = 0.5
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.cornerRadius = 10
        return stackView
    }()
    
    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemGray6
        textField.textColor = .black
        textField.autocapitalizationType = .none
        textField.font = .systemFont(ofSize: 16)
        textField.placeholder = "Email or phone number"
        textField.layer.borderWidth = 0.5
        textField.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.layer.borderColor = UIColor.lightGray.cgColor
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemGray6
        textField.isSecureTextEntry = true
        textField.textColor = .black
        textField.autocapitalizationType = .none
        textField.font = .systemFont(ofSize: 16)
        textField.placeholder = "Password"
        textField.layer.borderWidth = 0.5
        textField.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.layer.borderColor = UIColor.lightGray.cgColor
        return textField
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var invalidDataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 8
        label.contentMode = .scaleToFill
        label.isHidden = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureSubviews()
        self.setupConstraints()
        
        

    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.navigationController?.navigationBar.isHidden = true
//        let nc = NotificationCenter.default
//        nc.addObserver(self, selector: #selector(kbdShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        nc.addObserver(self, selector: #selector(kbdHide), name: UIResponder.keyboardWillHideNotification, object: nil)
//        addTapGestureToHideKeyboard()
//    }
//
    override func viewWillAppear(_ animated: Bool) {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        addTapGestureToHideKeyboard()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let nc = NotificationCenter.default
        nc.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func configureSubviews() {
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.contentView)
        self.contentView.addSubview(self.logInButton)
        self.contentView.addSubview(self.logoImageView)
        self.contentView.addSubview(self.loginPasswordStackView)
        self.contentView.addSubview(self.invalidDataLabel)
        self.loginPasswordStackView.addArrangedSubview(self.loginTextField)
        self.loginPasswordStackView.addArrangedSubview(self.passwordTextField)
    }
    
    private func setupConstraints() {
        
        let topConstraint = self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        let leftConstraint = self.scrollView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor)
        let rightConstraint = self.scrollView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor)
        let bottomConstraint = self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        
        let contentViewTopConstraint = self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor)
        let contentViewBottomConstraint = self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)
        let contentViewCenterXConstraint = self.contentView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor)
        let contentViewWidthConstraint = self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
        let contentViewHeightConstraint = self.contentView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor)
        
        let topLogoImageViewConstraint = self.logoImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 120)
        let centerXLogoImageViewConstraint = self.logoImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
        let widthLogoImageViewConstraint = self.logoImageView.widthAnchor.constraint(equalToConstant: 100)
        let heightLogoImageViewConstraint = self.logoImageView.heightAnchor.constraint(equalToConstant: 100)
        
        let topLoginPasswordStackViewConstraint = self.loginPasswordStackView.topAnchor.constraint(equalTo: self.logoImageView.bottomAnchor, constant: 120)
        let leftLoginPasswordStackViewConstraint = self.loginPasswordStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16)
        let rightLoginPasswordStackViewConstraint = self.loginPasswordStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        let heightLoginPasswordStackViewConstraint = self.loginPasswordStackView.heightAnchor.constraint(equalToConstant: 100)
        
        let topLogInButtonConstraint = self.logInButton.topAnchor.constraint(equalTo: self.loginPasswordStackView.bottomAnchor, constant: 16)
        let leadingLogInButtonConstraint = self.logInButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16)
        let trailingLogInButtonConstraint = self.logInButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
        let heightLogInButtonConstraint = self.logInButton.heightAnchor.constraint(equalToConstant: 50)
        
        let topInvalidDataLabelConstraint = self.invalidDataLabel.topAnchor.constraint(equalTo: self.logInButton.bottomAnchor, constant: 10)
        let leadingInvalidDataLabelConstraint = self.invalidDataLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20)
        let trailingInvalidDataLabelConstraint = self.invalidDataLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20)
            
        
        NSLayoutConstraint.activate([
            topConstraint,
            leftConstraint,
            rightConstraint,
            bottomConstraint,
            
            contentViewTopConstraint,
            contentViewBottomConstraint,
            contentViewWidthConstraint,
            contentViewHeightConstraint,
            contentViewCenterXConstraint,
            topLogoImageViewConstraint,
            
            centerXLogoImageViewConstraint,
            widthLogoImageViewConstraint,
            heightLogoImageViewConstraint,
            
            topLoginPasswordStackViewConstraint,
            leftLoginPasswordStackViewConstraint,
            rightLoginPasswordStackViewConstraint,
            heightLoginPasswordStackViewConstraint,
            
            topLogInButtonConstraint,
            leadingLogInButtonConstraint,
            trailingLogInButtonConstraint,
            heightLogInButtonConstraint,
            
            topInvalidDataLabelConstraint,
            leadingInvalidDataLabelConstraint,
            trailingInvalidDataLabelConstraint
        ])
    }
    
    private func validEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let validEmail = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return validEmail.evaluate(with: email)
    }
    
    private func validPassword(password : String) -> Bool {
        let passwordReg =  ("(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z])(?=.*[@#$%^&*]).{8,}")
        let passwordTesting = NSPredicate(format: "SELF MATCHES %@", passwordReg)
        return passwordTesting.evaluate(with: password) && password.count > 6
    }
    
    private func longPassword(password : String) -> Bool {
        return password.count > 6
    }
    
    private func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func buttonClicked() {
//        let profileViewController = ProfileViewController()
//        navigationController?.pushViewController(profileViewController, animated: true)
        
        guard let enteredEmail = loginTextField.text else {return}
        guard let enteredPassword = passwordTextField.text else {return}

        let login = validEmail(email: enteredEmail)
        let password = validPassword(password: enteredPassword)

        if enteredEmail.isEmpty && enteredPassword.isEmpty {
            loginTextField.shake()
            passwordTextField.shake()
        } else if enteredEmail.isEmpty {
            loginTextField.shake()
        } else if enteredPassword.isEmpty {
            passwordTextField.shake()
        } else {
            if !password && !login {
                invalidDataLabel.text = validationData.invalidEmailAndPassword
                invalidDataLabel.textAlignment = .center
                invalidDataLabel.isHidden = false
                passwordTextField.shake()
                loginTextField.shake()
            } else if !password {
                invalidDataLabel.text = validationData.invalidPasswordText
                invalidDataLabel.textAlignment = .left
                invalidDataLabel.isHidden = false
                passwordTextField.shake()
            } else if !login {
                invalidDataLabel.text = validationData.invalidEmailText
                invalidDataLabel.textAlignment = .center
                invalidDataLabel.isHidden = false
                loginTextField.shake()
            } else {
                if loginTextField.text != validationData.defaultLogin || passwordTextField.text != validationData.defaultPassword {
                    let ac = UIAlertController(title: "Incorrect login or password", message: nil, preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(ac, animated: true)
                } else {
                    let profileViewController = ProfileViewController()
                    navigationController?.pushViewController(profileViewController, animated: true)
                }
            }
        }
        
    }
    
    @objc func adjustForKeyboard (notification: Notification){
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            let contentOffset: CGPoint = notification.name == UIResponder.keyboardWillHideNotification
            ? .zero
            : CGPoint(x: 0, y: keyboardHeight / 2)
            self.scrollView.contentOffset = contentOffset // .setContentOffset()
        }
    }
    
//    @objc private func kbdShow(notification: NSNotification) {
//        if let kbdSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
//            let heightOfContent = loginPasswordStackView.bounds.height + logInButton.bounds.height + logInButton.bounds.height + invalidDataLabel.bounds.height
//            scrollView.contentInset.bottom = kbdSize.height
//            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbdSize.height, right: 0)
//
//            if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
//                let keyboardRectangle = keyboardFrame.cgRectValue
//                let keyboardHeight = keyboardRectangle.height
//                let frame = self.view.safeAreaLayoutGuide.layoutFrame
//                let contentOffset: CGPoint = notification.name == UIResponder.keyboardWillHideNotification ? .zero: CGPoint(x: 0, y: heightOfContent - keyboardHeight * 1.5)
//                if heightOfContent + keyboardHeight >= frame.height {
//                self.scrollView.contentOffset = contentOffset
//            }
//            }
//        }
//    }
//
    @objc private func kbdHide(notification: NSNotification) {
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }

    
}

extension UIView {
    func shake(count : Float = 3,for duration : TimeInterval = 0.3,withTranslation translation : Float = 3) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = count
        animation.duration = duration/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.values = [translation, -translation]
        layer.add(animation, forKey: "shake")
    }
}
