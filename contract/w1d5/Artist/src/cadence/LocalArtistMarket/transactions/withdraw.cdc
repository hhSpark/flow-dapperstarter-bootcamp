import LocalArtist from 0xdced77a314381a15
import LocalArtistMarket from 0xdced77a314381a15

transaction(listingIndex: Int, to seller: Address) {

    let listingIndex: Int
    let seller: Address
    let marketRef: &{LocalArtistMarket.MarketInterface}

    prepare(account: AuthAccount) {
        self.marketRef = getAccount(0xdced77a314381a15)
        .getCapability(/public/LocalArtistMarket)
        .borrow<&{LocalArtistMarket.MarketInterface}>()
        ?? panic("Couldn't borrow market reference.")
        
        self.listingIndex = listingIndex
        self.seller = account.address        
    }


    execute {
        if self.picture == nil {
        destroy self.picture
        } else {
            self.marketRef.withdraw(listingIndex: self.listingIndex, to sell: self.seller.address) 
        }
    }

}