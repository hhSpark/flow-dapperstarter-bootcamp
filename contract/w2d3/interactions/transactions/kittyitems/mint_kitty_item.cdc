import NonFungibleToken from Flow.NonFungibleToken
import KittyItems from Project.KittyItems

// This transction uses the NFTMinter resource to mint a new NFT.
//
// It must be signed by the account that has the minter resource
// stored at path 'KittyItems.MinterStoragePath'.

transaction(recipient: Address, typeID: UInt64) {
    
    // local variable for storing the minter reference
    let minter: &KittyItems.NFTMinter
    // local variable for a reference to the recipient's Kitty Items Collection
    let receiver: &{NonFungibleToken.CollectionPublic}

    prepare(signer: AuthAccount) {

        // 1) borrow a reference to the NFTMinter resource in the signer's storage
        self.minter = signer.borrow<&KittyItems.NFTMinter>(from: KittyItems.MinterStoragePath)
                                ?? panic("Signer can't fetch NFTMinter resource.")
        
        // 2) borrow a public reference to the recipient's Kitty Items Collection
        self.receiver = getAccount(recipient).getCapability(KittyItems.CollectionPublicPath)
                                .borrow<&{NonFungibleToken.CollectionPublic}>()
                                ?? panic("Unable to borrow receiver's kitty item Collection")
    }

    execute {

        // 3) mint the NFT and deposit it into the recipient's Collection
        self.minter.mintNFT(recipient: self.receiver, typeID: typeID)
    }    
}