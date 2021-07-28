pub contract Artist {

  pub struct Canvas {

    pub let width: UInt8
    pub let height: UInt8
    pub let pixels: String

    init(width: UInt8, height: UInt8, pixels: String) {
      self.width = width
      self.height = height
      // The following pixels
      // 123
      // 456
      // 789
      // should be serialized as
      // 123456789
      self.pixels = pixels
    }
  }

  pub resource Picture {

    pub let canvas: Canvas
    
    init(canvas: Canvas) {
      self.canvas = canvas
    }    
    
  }

  pub resource Collection {
    pub let pictures: @[Picture]    
    
    init() {
      self.pictures <- []
      
    }

    destroy() {
      destroy self.pictures
    }

    pub fun deposit(picture: @Picture) {      
      self.pictures.append( <- picture)      
    }

    pub fun display_frame() {
      var index = 0
      while index < self.pictures.length {
        self.display(canvas: self.pictures[index].canvas)
        index = index + 1
      }      
    }

    pub fun display(canvas: Canvas) {
      let width = Int(canvas.width)
      let height = Int(canvas.height)

      var height_index : Int = 0
      var previous_height_index : Int = 0
      var line: String = ""

      while height_index <= height+1 {                

          switch height_index {
              case 0:
                  //top frame
                  log("+-----+")                
              case height+1:
                  //bottom frame
                  log("+-----+")
              default: 
                  //picture line 1,2,3,4,5
                  line = canvas.pixels.slice(from: previous_height_index*width, upTo: height_index*width)
                  log("|".concat(line).concat("|"))                
          }

          height_index = height_index + 1        
          previous_height_index = height_index - 1
      }    
    }
    
  }

  // creates a new empty Collection resource and returns it 
  pub fun createCollection(): @Collection {
      return <- create Collection()
  }  

  pub resource Printer {

    pub let width: UInt8
    pub let height: UInt8
    pub let prints: {String: Canvas}

    init(width: UInt8, height: UInt8) {
      self.width = width;
      self.height = height;
      self.prints = {}
    }

    pub fun print(canvas: Canvas): @Picture? {
      // Canvas needs to fit Printer's dimensions.
      if canvas.pixels.length != Int(self.width * self.height) {
        return nil
      }

      // Canvas can only use visible ASCII characters.
      for symbol in canvas.pixels.utf8 {
        if symbol < 32 || symbol > 126 {
          return nil
        }
      }

      // Printer is only allowed to print unique canvases.
      if self.prints.containsKey(canvas.pixels) == false {
        let picture <- create Picture(canvas: canvas)
        self.prints[canvas.pixels] = canvas

        return <- picture
      } else {
        return nil
      }
    }
  }

  
  init() {
    self.account.save(
      <- create Printer(width: 5, height: 5),
      to: /storage/ArtistPicturePrinter
    )
    self.account.link<&Printer>(
      /public/ArtistPicturePrinter,
      target: /storage/ArtistPicturePrinter
    )

    self.account.save(
      <- self.createCollection(),
      to: /storage/ArtistPictureCollection
    )
    self.account.link<&Collection>(
      /public/ArtistPictureCollection,
      target: /storage/ArtistPictureCollection
    )
  }
}
