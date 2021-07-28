import Artist from 0x02

transaction() {
  
  let pixels: String
  let name: String   
  
  prepare(account: AuthAccount) {
    self.name = account.address.toString()

    let printerRef = getAccount(0x02)
        .getCapability<&Artist.Printer>(/public/ArtistPicturePrinter)
        .borrow()
        ?? panic("Couldn't borrow printer reference.")
    
    let collectionRef = getAccount(0x02)
        .getCapability<&Artist.Collection>(/public/ArtistPictureCollection)
        .borrow()
        ?? panic("Couldn't borrow collection reference. ")
    
    // Replace with your own drawings.
    self.pixels = "*   * * *   *   * * *   *"
    let canvas = Artist.Canvas(
      width: printerRef.width,
      height: printerRef.height,
      pixels: self.pixels
    )    
    
    collectionRef.deposit(picture: <- printerRef.print(canvas: canvas)!)
    
  }
  
  execute {
    //TODO: Need something here?
    //log("transaction is executed")       
  }
}