//
//  ViewController.swift
//  ExploreFloatingPanel
//
//  Created by Karen Natalia on 13/06/22.
//

import UIKit
import FloatingPanel

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dummyList = ["Transcription 1", "Transcription 2", "Transcription 3", "Transcription 4", "Transcription 5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    @IBAction func show(_ sender: Any) {
        let fpc = FloatingPanelController(delegate: self)
        let floatingPanel = MyFloatingPanelLayout()
        fpc.layout = floatingPanel
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "ContentVC") as? ContentViewController else {return}
        
        fpc.set(contentViewController: vc)
        
        let appearance = SurfaceAppearance()
        appearance.cornerRadius = 10.0
        fpc.surfaceView.appearance = appearance

        self.present(fpc, animated: true, completion: nil)
    }

}

extension ViewController: FloatingPanelControllerDelegate {
    
    func floatingPanelDidChangeState(_ fpc: FloatingPanelController) {

        let vc = fpc.contentViewController as? ContentViewController
        
        if fpc.state == .full {
            vc?.stateChanged(newState: 3)
        }
        else if fpc.state == .half {
            vc?.stateChanged(newState: 2)
        }
        else if fpc.state == .tip {
            vc?.stateChanged(newState: 1)
        }
    }
}

class MyFloatingPanelLayout: FloatingPanelLayout {
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .full
    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .full: FloatingPanelLayoutAnchor(absoluteInset: 16.0, edge: .top, referenceGuide: .safeArea),
            .half: FloatingPanelLayoutAnchor(fractionalInset: 0.35, edge: .bottom, referenceGuide: .safeArea),
            .tip: FloatingPanelLayoutAnchor(absoluteInset: 44.0, edge: .bottom, referenceGuide: .safeArea),
        ]
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dummyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transcriptionCell", for: indexPath)
        
        cell.textLabel?.text = dummyList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetail", sender: self)
    }
}
