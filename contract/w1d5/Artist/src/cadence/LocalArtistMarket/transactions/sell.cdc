import LocalArtist from 0xdced77a314381a15
import LocalArtistMarket from 0xdced77a314381a15

transaction(pixels: String, price: UFix64) {

    let picture: @LocalArtist.Picture?
    let seller: Address
    let marketRef: &{LocalArtistMarket.MarketInterface}

    prepare(account: AuthAccount) {
        // TODO: Change to your contract account address.
        self.marketRef = getAccount(${process.env.REACT_APP_ARTIST_CONTRACT_HOST_ACCOUNT})
        .getCapability(/public/LocalArtistMarket)
        .borrow<&{LocalArtistMarket.MarketInterface}>()
        ?? panic("Couldn't borrow market reference.")
        
        let collection <- account.load<@LocalArtist.Collection>(from: /storage/LocalArtistPictureCollection)!
        self.picture <- collection.withdraw(pixels: pixels)
        account.save<@LocalArtist.Collection>(<- collection, to: /storage/LocalArtistPictureCollection)

        self.seller = account.address
    }


    execute {
        if self.picture == nil {
        destroy self.picture
        } else {
        self.marketRef.sell(picture: <- self.picture!, seller: self.seller, price: price)
        }
    }

}