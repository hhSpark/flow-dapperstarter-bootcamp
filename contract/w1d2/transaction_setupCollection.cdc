import Artist from 0x02

transaction {
    prepare(acct: AuthAccount) {

        log("account ".concat(acct.address.toString()))
        acct.save(
            <- Artist.createCollection(),
            to: /storage/ArtistPictureCollection
        )

        log("deploy collection storage for this account")
        
        acct.link<&Artist.Collection>(
            /public/ArtistPictureCollection,
            target: /storage/ArtistPictureCollection
        )

        log("create a link reference for this account storage")
        
    }

}