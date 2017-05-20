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
        
        
        let userDefaults = UserDefaults(suiteName: "group.com.lukejmann.foo")
        if let userDefaults = userDefaults {
            userDefaults.set(url, forKey: "foo")
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

