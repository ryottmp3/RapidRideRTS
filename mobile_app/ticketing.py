# Ticketing

import json, base64, sys
from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey
from cryptography.hazmat.primitives import serialization


if __name__ == "__main__":

    if sys.argv[1] == "--init":
        print("Initialization Protocol: Generating Private ED25519 Key... \n")
        private_key = Ed25519PrivateKey.generate()
        key_bytes = private_key.private_bytes(
            encoding=serialization.Encoding.Raw,
            format=serialization.PrivateFormat.Raw,
            encryption_algorithm=serialization.NoEncryption()
        )
        print("Base64 Private Key: ")
        print(base64.b64encode(key_bytes).decode())
        exit()
