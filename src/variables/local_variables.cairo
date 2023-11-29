#[starknet::interface]
trait ILocalVariablesExample<TContractState> {
    fn do_something (self: @TContractState, value: u32) -> u32;
}

#[starknet::contract]
mod LocalVariablesExample {
    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl LocalVariablesExample of super::ILocalVariablesExample<ContractState> {
        fn do_something(self: @ContractState, value: u32) -> u32 {
            let increment = 10;
            {
                let sum = value + increment;
                sum
            }
        }
    }
}