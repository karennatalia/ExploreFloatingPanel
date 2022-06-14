//
//  ContentViewController.swift
//  ExploreFloatingPanel
//
//  Created by Karen Natalia on 13/06/22.
//

import UIKit
import FloatingPanel

class ContentViewController: UIViewController {

    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var label: UILabel!
    
    weak var delegate: FloatingPanelDelegate?
//    var vc :ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        vc = ViewController()
//        vc!.delegate = self
        label.text = "did load"
        
        delegate = self
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func test() {
        print("test")
    }
//
//    init(coder: ) {
//        vc = ViewController()
//        super.init()
//        vc.delegate = self
//    }
}

extension ContentViewController: FloatingPanelDelegate {
    func stateChanged(newState: Int) {
        print("masok")
        switch newState {
        case 3:
//            navBar.isHidden = false
            label.text = "full"
        case 2:
//            navBar.isHidden = true
            label.text = "half"
        case 1:
//            navBar.isHidden = true
            label.text = "tip"
        default:
//            navBar.isHidden = false
            label.text = "default"
        }
    }
}
