



flow keys generate  --sig-algo=ECDSA_secp256k1

flow accounts create --key <Fill Public Key> --sig-algo "ECDSA_secp256k1" --signer "emulator-account"

flow project deploy --update

flow transactions send ./artist/createCollection.transaction.cdc --signer "emulator-artist"

flow transactions send ./artist/print.transaction.cdc --args-json='[{"type": "UInt8", "value": "5"}, {"type": "UInt8", "value": "5"},{"type": "String", "value":"*   * * *   *   * * *   *"}]' --signer "emulator-artist"

flow scripts execute ./artist/displayCollection.script.cdc --arg Address:"0x01cf0e2f2f715450"