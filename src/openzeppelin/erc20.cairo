#[starknet::contract]
mod MyToken {
    use openzeppelin::access::ownable::ownable::OwnableComponent::InternalTrait;
use openzeppelin::token::erc20::ERC20Component;
    use openzeppelin::access::ownable::OwnableComponent;
    use starknet::ContractAddress;

    component!(path: ERC20Component, storage: erc20, event: ERC20Event);
    component!(path: OwnableComponent, storage: ownable, event: OwnableEvent);

    #[abi(embed_v0)]
    impl ERC20Impl = ERC20Component::ERC20Impl<ContractState>;
    #[abi(embed_v0)]
    impl ERC20MetadataImpl = ERC20Component::ERC20MetadataImpl<ContractState>;
    #[abi(embed_v0)]
    impl ERC20CamelOnlyImpl = ERC20Component::ERC20CamelOnlyImpl<ContractState>;
    impl InternalImpl = ERC20Component::InternalImpl<ContractState>;
    #[abi(embed_v0)]
    impl OwnableImpl = OwnableComponent::OwnableImpl<ContractState>;

    #[storage]
    struct Storage {
        #[substorage(v0)]
        erc20: ERC20Component::Storage,
        #[substorage(v0)]
        ownable: OwnableComponent::Storage
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        ERC20Event: ERC20Component::Event,
        OwnableEvent: OwnableComponent::Event
    }

    #[constructor]
    fn constructor(ref self: ContractState, owner: ContractAddress) {
        let name = 'Okhaimie Token';
        let symbol = 'OKHAI';
        self.ownable.initializer(owner);
        self.erc20.initializer(name, symbol);
    }

    #[external(v0)]
    fn mint(
        ref self: ContractState,
        recipient: ContractAddress,
        amount: u256
    ) {
        self.ownable.assert_only_owner();
        self.erc20._mint(recipient, amount);
    }
}