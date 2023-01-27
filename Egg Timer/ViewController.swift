import UIKit
import AVFoundation
class ViewController: UIViewController {

    @IBOutlet weak var eggLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    var secondsRemaining = 60
    var eggCountdown: Float = 0
    var timer = Timer()
    let eggTimes: [String : Float] = ["Soft": 5, "Medium": 420, "Hard": 720]
    let maxTime: Float = 720
    var secondsOfEveryEgg: Float = 0
    var player: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func selected(_ sender: UIButton) {

        timer.invalidate()

        let hardness = (sender.titleLabel?.text)!
        let secondsInEggSender = eggTimes[hardness]!
        secondsOfEveryEgg = secondsInEggSender
        let pecentOfEgg =  secondsOfEveryEgg / maxTime
        eggCountdown = pecentOfEgg

        switch hardness {
        case "Soft":
            progressBar.progress = eggCountdown
        case "Medium":
            progressBar.progress = eggCountdown
        case "Hard":
            progressBar.progress = eggCountdown
        default:
            break
        }

        timer =  Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if self.secondsOfEveryEgg > 0 {
                print ("\(self.secondsOfEveryEgg) seconds.")
                self.progressBar.progress -= self.eggCountdown / self.secondsOfEveryEgg
                self.secondsOfEveryEgg -= 1.0
            } else {
                Timer.invalidate()
                self.eggLabel.text = "Done"
                self.playSound()
            }
        }
    }

    func playSound() {
       let url = Bundle.main.url(forResource: "readySound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
    }
}
