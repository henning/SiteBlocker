import SwiftyJSON

extension JSON{
    
    static func getTemplate() -> JSON {
        let file = Bundle.main.path(forResource: "template", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: file!))
        return JSON(data!)
    }
    
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


