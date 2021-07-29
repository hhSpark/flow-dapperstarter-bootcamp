import Artist from "./contract.cdc"

// Return an array of formatted Pictures that exist in the account with the a specific address.
// Return nil if that account doesn't have a Picture Collection.
pub fun main(address: Address): [String]? {
   var results: [String] = []

    let collectionRef = getAccount(address)
        .getCapability<&Artist.Collection>(/public/ArtistPictureCollection)
        .borrow()
        ?? panic("Couldn't borrow collection reference. ")

   if collectionRef != nil {
        if collectionRef.pictures.length == 0 {
            //log("empty collection for this account")
            return nil
        } else {
            var index = 0
            var pictureStr = ""
            while index < collectionRef.pictures.length {                
                pictureStr = getPictureString(canvas: collectionRef.pictures[index].canvas)
                results.append(pictureStr)
                index = index + 1
            }
            return results            
        }
    } else {
        //log("no collection is setup for this account.")
        return nil
    }
}


pub fun getPictureString(canvas: Artist.Canvas): String {
    let width = Int(canvas.width)
    let height = Int(canvas.height)

    var height_index : Int = 0
    var previous_height_index : Int = 0
    var line: String = ""
    
    var total_string: String= ""    

    
    while height_index <= height+1 {                
        switch height_index {
            case 0:
                //top frame
                //log("+-----+")
                total_string = total_string.concat("+-----+")
            case height+1:
                //bottom frame
                //log("+-----+")
                total_string = total_string.concat("+-----+")
            default: 
                //picture line 1,2,3,4,5
                line = canvas.pixels.slice(from: previous_height_index*width, upTo: height_index*width)
                //log("|".concat(line).concat("|"))                
                total_string = total_string.concat("|".concat(line).concat("|"))
        }

            height_index = height_index + 1        
            previous_height_index = height_index - 1
    } 

    

    return total_string    
}
         