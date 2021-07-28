import Artist from 0x02

pub fun showCollection(collectionRef: &Artist.Collection) {
    if collectionRef != nil {
        if collectionRef.pictures.length == 0 {
            log("empty collection for this account")
        } else {
            collectionRef.display_frame()
        }
    } else {
        log("no collection is setup for this account.")
    }
}


pub fun main() {       
    
    let acct1 = getAccount(0x01)
    log("account ".concat(acct1.address.toString()))

    let collection1 = acct1
        .getCapability<&Artist.Collection>(/public/ArtistPictureCollection)
        .borrow()
        ?? panic("Couldn't borrow collection reference. ")

    showCollection(collectionRef: collection1)

    let acct2 = getAccount(0x02)
    log("account ".concat(acct2.address.toString()))

    let collection2 = acct2
        .getCapability<&Artist.Collection>(/public/ArtistPictureCollection)
        .borrow()
        ?? panic("Couldn't borrow collection reference. ")

    showCollection(collectionRef: collection2)

    let acct3 = getAccount(0x03)
    log("account ".concat(acct3.address.toString()))

    let collection3 = acct3
        .getCapability<&Artist.Collection>(/public/ArtistPictureCollection)
        .borrow()
        ?? panic("Couldn't borrow collection reference. ")

    showCollection(collectionRef: collection3)

    let acct4 = getAccount(0x04)
    log("account ".concat(acct4.address.toString()))

    let collection4 = acct4
        .getCapability<&Artist.Collection>(/public/ArtistPictureCollection)
        .borrow()
        ?? panic("Couldn't borrow collection reference. ")

    showCollection(collectionRef: collection4)

    let acct5 = getAccount(0x05)
    log("account ".concat(acct5.address.toString()))

    let collection5 = acct5
        .getCapability<&Artist.Collection>(/public/ArtistPictureCollection)
        .borrow()
        ?? panic("Couldn't borrow collection reference. ")

    showCollection(collectionRef: collection5)
    
}