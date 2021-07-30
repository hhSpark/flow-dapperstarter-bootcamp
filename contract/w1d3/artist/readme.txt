



flow keys generate  --sig-algo=ECDSA_secp256k1

flow accounts create --key <Fill Public Key> --sig-algo "ECDSA_secp256k1" --signer "emulator-account"

flow project deploy --update

flow transactions send ./artist/createCollection.transaction.cdc --signer "emulator-artist"

flow transactions send ./artist/print.transaction.cdc --args-json='[{"type": "UInt8", "value": "5"}, {"type": "UInt8", "value": "5"},{"type": "String", "value":"*   * * *   *   * * *   *"}]' --signer "emulator-artist"

flow scripts execute ./artist/displayCollection.script.cdc --arg Address:"0x01cf0e2f2f715450"


# Day 3 Review

- Flow Emulator provides a full blockchain experience hosted on your local computer.
    - Create cryptographic key pairs.
    - Create and modify accounts.
    - Build, sign, and send transactions.
    - Execute scripts.
    - Deploy as many contracts as you like.
- The flow-cli uses a configuration file flow.json to store information about your project.
    - Create aliases for your accounts.
    - Link contract names with source files.
    - Assign contract deployment to individual accounts on a per network basis.
- Cadence events allow the contract to communicate when certain things happen.
    - Transactions don't return results to senders, but using emit EventName in your contract, you can receive information about what happend as part of the .events field of the transaction result.
