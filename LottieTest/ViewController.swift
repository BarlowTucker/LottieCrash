//
//  ViewController.swift
//  LottieTest
//
//  Created by Barlow Tucker on 11/1/17.
//  Copyright © 2017 Jane. All rights reserved.
//

import UIKit
import Lottie

class ViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var lottieView: UIView!
    
    var animation:LOTAnimationView!
    var iterations = 3000
    var isRunning = false
    var goBack = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.webView.loadHTMLString("<ul><li><strong>Easy setup:</strong>  Just add a PhotoBrowserView to your ViewController and implement the datasource and delegate</li><li><strong>Full Screen Browser:</strong> Tap on an image in the PhotoView to launch the full screen browser.</li><li><strong>Swipe Gestures:</strong> Close the full screen browser by tapping the close button, tapping the image, or swiping up.</li><li><strong>Swift:</strong> This project was writen completely in Swift.</li></ul>", baseURL: nil)
        self.startAnimation()
        guard goBack else { self.push(); return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            self.navigationController?.popViewController(animated: false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func startAnimation() {
        let animation = LOTAnimationView(name: "load")
        self.animation = animation
        self.lottieView.subviews.forEach{ $0.removeFromSuperview() }
        self.lottieView.addSubview(self.animation)
        
        self.animation.loopAnimation = true
        self.animation.play()
    }
    
    @IBAction func goTapped(_ sender: Any) {
        self.isRunning = true
        self.iterations = 3000
        self.push()
    }
    
    func push() {
        guard self.isRunning && self.iterations > 0 else { return }
        self.iterations -= 1
        self.navigationItem.title = "\(self.iterations)"
        
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "lottieView") as? ViewController else { return }
        viewController.goBack = true
        viewController.iterations = self.iterations
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            self.navigationController?.pushViewController(viewController, animated: false)
        }
    }
    
}

