#[starknet::interface]
trait IExampleContract<TContractState> {
    fn set(ref self: TContractState, value: u32);
    fn get(self: @TContractState) -> u32;
}

#[starknet::contract]
mod ExampleContract {
    #[storage]
    struct Storage {
        value: u32,
    }

    #[abi(embed_v0)]
    impl ExampleContract of super::IExampleContract<ContractState> {
        fn set(ref self: ContractState, value: u32) {
            self.value.write(value);
        }

        fn get(self: @ContractState) -> u32 {
            PrivateFunctions::_read_value(self)
        }
    }

    #[generate_trait]
    impl PrivateFunctions of PrivateFunctionTrait {
        fn _read_value(self: @ContractState) -> u32 {
            self.value.read()
        }
    }
}