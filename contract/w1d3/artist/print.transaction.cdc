import Artist from "./contract.cdc"

// Print a Picture and store it in the authorizing account's Picture Collection.
transaction(width: UInt8, height: UInt8, pixels: String) {
  
  prepare(account: AuthAccount) {
    //self.name = account.address.toString()

    let printerRef = getAccount(account.address)
        .getCapability<&Artist.Printer>(/public/ArtistPicturePrinter)
        .borrow()
        ?? panic("Couldn't borrow printer reference.")
    
    let collectionRef = getAccount(account.address)
        .getCapability<&Artist.Collection>(/public/ArtistPictureCollection)
        .borrow()
        ?? panic("Couldn't borrow collection reference. ")
    
    // Replace with your own drawings.
    let canvas = Artist.Canvas(
      width: width,
      height: height,
      pixels: pixels
    )    
    
    collectionRef.deposit(picture: <- printerRef.print(canvas: canvas)!)
    
  }
  
  execute {      
  }
}