# flow-dapperstarter-bootcamp
Flow &amp; Cadence

Bootcamp Materials
https://github.com/decentology/fast-floward-1

Youtube
https://www.youtube.com/channel/UCzoEZCV_DPbwVDBK6G6CmuQ

Flow Doc
https://docs.onflow.org/cadence/tutorial/07-resources-compose/#gatsby-focus-wrapper

Flow Faucet
https://testnet-faucet.onflow.org/

Flow TestNet
https://flow-view-source.com/testnet/account/0xdced77a314381a15



# Mistakes To Avoid
-----------------------------------------------------------------------------
- strong data type checking at compiling time, need explict type casting.
- use "pub" not "public"
- use "label: type" to specify function params
- use "label: input" to map function params
- no need to use () for if condition or while condition
- use "<-" for resource assignment or pass-in
- for optional variable use ?, when need to convert using force !
- use @Resource, @[Resource] for resource type declaration
- use &Contract.Reseource for resource capability declaration
- how to get capability? use a brorrowing from actual resource (saved in storage)
- struct doesn't need "new", but resource will need "new".
- storage (actual data) is associated with each account. 
- In flow.json, 3 things (contract, account-keys, deployment setup)


# Coding To Remember
-----------------------------------------------------------------------------
1. account: AuthAccount | account.address.toString() | getAccount(address)
2. return nil
3. dictionary let prints: {string }
4. let collectionRef = getAccount(address)
        .getCapability<&Artist.Collection>(/public/ArtistPictureCollection)
        .borrow()
        ?? panic("Couldn't borrow collection reference. ")
5. string operations: .length | .slice(from: to:) | .concat()
6. acct.save(
            <- Artist.createCollection(),
            to: /storage/ArtistPictureCollection
        )
7. acct.link<&Artist.Collection>(
            /public/ArtistPictureCollection,
            target: /storage/ArtistPictureCollection
        )

# Architecture Thinking
-----------------------------------------------------------------------------
1. Think about object A with pure data (no functions yet)
2. Think about object B = A + functions (may have its storage for inputs & outputs for functions)
3. Think about object B is "saved" into blockchain crypto account C. 
4. Crypto account C is the truth for ownership. Holding the keys meaning holding acct & asset mgmt. 
5. It is about resource ownership management. (Responsible for authentication issuing & delivery)
6. It is about resource access control management. (Responsible for providing rights for M parties)
7. resource is a programmable asset. (asset + program functions + input/output)

