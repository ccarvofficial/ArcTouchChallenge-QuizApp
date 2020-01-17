//
//  HomeViewController.swift
//  Quiz
//
//  Created by claudiocarvalho on 16/01/20.
//  Copyright © 2020 claudiocarvalho. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Propreties
    
    var contentView: HomeView?
    let viewModel: HomeViewModel
    var timer: Timer?
    let initalTimer: TimeInterval = 300
    var timeLeft: TimeInterval = 0
    var formatter: DateComponentsFormatter
    
    var isPlaying = false {
        didSet {
            contentView?.inputTextField.isEnabled = isPlaying
            contentView?.detailsView.button.setTitle(isPlaying ? Constants.reset : Constants.start, for: .normal)
            contentView?.inputTextField.becomeFirstResponder()
            
            if (!isPlaying) {
                timer?.invalidate()
            }
        }
    }
    
    // MARK: - View Lifecyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = contentView
        viewModel.getQuiz { (result) in
            print(Constants.ok)
        }
    }
    
    // MARK: - Lifecyle Methods
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setupTextFieldObservers()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.removeObservers()
    }
   
    // MARK: - Methods
    
    private func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupTextFieldObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            contentView?.moveTextfieldUp(height: keyboardSize.height)
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        contentView?.moveTextfieldDown()
    }
    
    // MARK: - Init
    
    init() {
        self.viewModel = HomeViewModel()
        self.formatter = DateComponentsFormatter()
        super.init(nibName: nil, bundle: nil)
        
        self.contentView = HomeView(frame: .zero, viewController: self)
        self.viewModel.viewController = self
        self.timeLeft = initalTimer
        
        self.formatter.unitsStyle = .positional
        self.formatter.allowedUnits = [.minute, .second]
        self.formatter.zeroFormattingBehavior = [.pad]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let currentValue = textField.text,
              let quiz = viewModel.quiz else { return }
        
        if (quiz.answer.contains(currentValue.lowercased()) && !viewModel.addedAnswers.contains(currentValue.lowercased())) {
            contentView?.inputTextField.text = ""
            viewModel.addedAnswers.insert(currentValue, at: 0)
        }
    }
    
    @objc func startTimer(_ sender: UITapGestureRecognizer? = nil) {
        if (isPlaying) {
            isPlaying = false
            reset()
        } else {
            isPlaying = true
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFire), userInfo: nil, repeats: true)
        }
    }
    
    @objc func onTimerFire() {
        timeLeft -= 1
        let timeString = formatter.string(from: timeLeft)
        contentView?.detailsView.timerLabel.text = timeString ?? "00:00"
        
        if timeLeft <= 0 {
            timer?.invalidate()
            isPlaying = false
            presentAlert(type: .failure, count: viewModel.addedAnswers.count, max: viewModel.quiz?.answer.count)
        }
    }
    
    // MARK: - Methods
    
    func presentAlert(type: Constants.AlertType, count: Int?, max: Int?) {
        var title = ""
        var message = ""
        
        switch type{
        case .sucess:
            title = Constants.congratulations
            message = Constants.finishGameText
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: Constants.playAgain, style: .default) { (action) in
                self.reset()
            }
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
        case .failure:
            title = Constants.timeFinished
            message = "Sorry, time is up! You got \(count ?? 0) out of \(max ?? 0) answers."
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: Constants.tryAgain, style: .default) { (action) in
                self.reset()
            }
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    func reset() {
        self.viewModel.resetAnswers()
        timeLeft = initalTimer
        let timeString = formatter.string(from: timeLeft)
        contentView?.detailsView.timerLabel.text = timeString ?? "00:00"
    }
}



