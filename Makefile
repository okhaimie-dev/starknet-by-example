starkli-declare:
	starkli declare $(target) --rpc https://limited-rpc.nethermind.io/goerli-juno --account ~/.starkli-wallets/deployer/account.json --keystore ~/.starkli-wallets/deployer/keystore.json

starkli-deploy:
	starkli deploy $(hash) --watch --rpc https://limited-rpc.nethermind.io/goerli-juno --account ~/.starkli-wallets/deployer/account.json --keystore ~/.starkli-wallets/deployer/keystore.json
