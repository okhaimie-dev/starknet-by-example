use starknet::ContractAddress;

#[starknet::interface]
trait IGlobalExample<TContractState> {
    fn foo(ref self: TContractState) -> ContractAddress;
}

#[starknet::contract]
mod GlobalExample {
    use starknet::get_caller_address;
    use starknet::ContractAddress;

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl GlobalExampleImpl of super::IGlobalExample<ContractState> {
        fn foo(ref self: ContractState) -> ContractAddress {
            let caller = get_caller_address();
            return caller;
        }
    }
}