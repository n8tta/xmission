//
//  RecordsScene.swift
//  XMission
//
//  Created by Natallia Valadzko on 23.01.21.
//

import Foundation
import SpriteKit
import UIKit

class GameRoomTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Variables
    var records = RecordsManager.shared.loadRecords()

    //MARK: - Lifecycle Functions
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecordTableViewCell", for: indexPath) as? RecordTableViewCell else {
            return UITableViewCell()
        }
        if let recordDate = records[indexPath.row].date {
            cell.dateLabel.text = "\(recordDate)"
        }

        if let recordScore = records.sorted(by: {$0.score ?? 0 > $1.score ?? 0})[indexPath.row].score {
            cell.scoreLabel.text = "\(recordScore)"
        }
        cell.dateLabel.textColor = .white
        cell.dateLabel.font = UIFont(name: "Quadaptor", size: 25)
        cell.dateLabel.textAlignment = .center
        cell.scoreLabel.textColor = .white
        cell.scoreLabel.font = UIFont(name: "Quadaptor", size: 26)
        cell.scoreLabel.textAlignment = .center
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let rowHeight: CGFloat = 50
        return rowHeight
    }
}

    //MARK: - RecordsScene
class RecordsScene: SKScene {
    
    //MARK: - Constants
    let gameTableViewSize = CGSize(width: 350, height: 400)
    let cell = UITableViewCell()
    let recordsLabel = SKLabelNode(fontNamed: "Quadaptor")
    let backToMainMenuLabel = SKLabelNode(fontNamed: "Quadaptor")
    
    //MARK: - Variables
    var gameTableView = GameRoomTableView()
    var records = [Record]()
   
    //MARK: - Lifecycle Functions
    override func didMove(to view: SKView) {
        backgroundSetUp()
        recordsLabelSetUp()
        backToMainMenuLabelSetUp()
        tableSetUp()
        registerNibs()

        records = RecordsManager.shared.loadRecords()
    }
    
    //MARK: - Flow Functions
    func backgroundSetUp() {
        let background = SKSpriteNode(imageNamed: "starfield")
        background.size = self.frame.size
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.zPosition = 0
        addChild(background)
    }
    
    func recordsLabelSetUp() {
        recordsLabel.text = "Records"
        recordsLabel.fontColor = SKColor.white
        recordsLabel.fontSize = 40
        recordsLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.8)
        recordsLabel.zPosition = 1
        addChild(recordsLabel)
    }
    
    func backToMainMenuLabelSetUp() {
        backToMainMenuLabel.text = "Back To Menu"
        backToMainMenuLabel.fontColor = SKColor.white
        backToMainMenuLabel.fontSize = 30
        backToMainMenuLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.1)
        backToMainMenuLabel.zPosition = 1
        addChild(backToMainMenuLabel)
    }
    
    func tableSetUp() {
        self.gameTableView.backgroundColor = .clear
        self.gameTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.gameTableView.frame = CGRect(x: self.frame.width * 0.085,
                                     y: self.frame.height * 0.3,
                                     width: self.gameTableViewSize.width,
                                     height: self.gameTableViewSize.height)
        self.scene?.view?.addSubview(gameTableView)
        self.gameTableView.reloadData()
    }
    
    private func registerNibs() {
        let recordCell = UINib(nibName: "RecordTableViewCell", bundle: nil)
        gameTableView.register(recordCell, forCellReuseIdentifier: "RecordTableViewCell")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: UITouch in touches {
            let pointOfTouch = touch.location(in: self)
            
            if backToMainMenuLabel.contains(pointOfTouch) {
                self.gameTableView.removeFromSuperview()
                let menuScene = MainMenuScene(size: UIScreen.main.bounds.size)
                let sceneTransition = SKTransition.fade(withDuration: 1)
                self.view?.presentScene(menuScene, transition: sceneTransition)
            }
        }
    }
}
