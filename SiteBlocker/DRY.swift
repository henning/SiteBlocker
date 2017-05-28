import SwiftyJSON
import SafariServices

extension JSON{
    
    static func makeProperFormat(json: JSON) -> String {
        var string = json.description
            .replacingOccurrences(of: "\n", with: "")
            .replacingOccurrences(of: "", with: "")
            .replacingOccurrences(of: "\"", with: "")
        
        
        string=string.replacingOccurrences(of: " ", with: "")
        var newWords = [String]()
        for character in string.characters {
            let char = String(character)
            if newWords.count>=1 && !self.isOtherCharacter(character: char){
                
                if isOtherCharacter(character: newWords.last!) && !isOtherCharacter(character: char){
                    newWords.append("\"")
                    newWords.append(char)
                    
                }
                else if !isOtherCharacter(character: newWords.last!) && isOtherCharacter(character: char){
                    newWords.append(char)
                    newWords.append("\"")
                }
                else {
                    newWords.append(char)
                }
            }
            else {
                if newWords.count>=1 {
                    if !isOtherCharacter(character: newWords.last!)  {
                        newWords.append("\"")
                        newWords.append(char)
                        
                    }else {
                        newWords.append(char)
                    }
                }
                else {
                    newWords.append(char)
                }
            }
            
        }
        return  newWords.joined(separator: "")
        
        
    }
    
    mutating func appendIfArray(json:JSON){
        if var arr = self.array{
            arr.append(json)
            self = JSON(arr);
        }
    }
    static func isOtherCharacter(character: String) -> Bool{
        if character == "[" || character == "]" || character == "{" || character == "}" || character == ":" || character == ","{
            return true
        }
        return false
    }
    
    
    
}

struct ExtensionManager {
    static func setupJSON() {
        
        if UserDefaults.standard.bool(forKey: "hasLoaded"){ return }
        else {
            UserDefaults.standard.set(true, forKey: "hasLoaded")
            let data = try! Data(contentsOf: (Bundle.main.url(forResource: "blockerList", withExtension: "json")!))
            let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.lukejmann.foo")?.appendingPathComponent("blockerList.json")
            
            do {
                try data.write(to: url!)
            } catch let error as NSError {
                print("Failed writing to URL: \(String(describing: url)), Error: " + error.localizedDescription)
            }
            
            let url2 = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.lukejmann.foo")?.appendingPathComponent("empty.json")
            
            do {
                try data.write(to: url2!)
            } catch let error as NSError {
                print("Failed writing to URL: \(String(describing: url2)), Error: " + error.localizedDescription)
            }
            
            let url3 = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.lukejmann.foo")?.appendingPathComponent("lockIn.json")
            
            do {
                try data.write(to: url3!)
            } catch let error as NSError {
                print("Failed writing to URL: \(String(describing: url3)), Error: " + error.localizedDescription)
            }

            

            let userDefaults = UserDefaults(suiteName: "group.com.lukejmann.foo")
            if let userDefaults = userDefaults {
                userDefaults.set(url, forKey: "blockerList")
                userDefaults.set(url3, forKey: "lockIn")
                userDefaults.set(url2, forKey: "empty")
            }
        }
        
    }
    static func reload() {
        let identifierHosts = "com.lukejmann.SiteBlocker.Extension"
        SFContentBlockerManager.reloadContentBlocker(withIdentifier: identifierHosts) { (error) -> Void in
            print(error ?? "")
            print("Reloaded.")
        }
    }
}


extension UIColor {
    static func customWhite()->UIColor {
        return UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1.0)
    }
    static func customWhite(alpha: CGFloat)->UIColor {
        return UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: alpha)
    }
    static func customBlack()->UIColor {
        return UIColor(red: 43/255, green: 43/255, blue: 43/255, alpha: 1.0)
    }
    static func customPurple() -> UIColor {
        return UIColor(red: 94/255, green: 53/255, blue: 93/255, alpha: 1)
    }
    static func customBlue() -> UIColor {
        return UIColor(red: 52/255, green: 73/255, blue: 93/255, alpha: 1.0)
    }
    static func customGreen() ->UIColor {
        return UIColor(red: 101/255, green: 201/255, blue: 122/255, alpha: 1)
    }
    static func customLightPurple() -> UIColor {
        return UIColor(red: 88/255, green: 54/255, blue: 92/255, alpha: 1)
    }
    static func customLightBlue() -> UIColor {
        return UIColor(red: 67/255, green: 126/255, blue: 180/255, alpha: 1)
    }
    static func customOrange() -> UIColor {
        return UIColor(red: 216/255, green: 132/255, blue: 58/255, alpha: 1)
    }
}
