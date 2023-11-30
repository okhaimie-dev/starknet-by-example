#[starknet::interface]
trait ISerdeCustomType<TContractState> {
    fn person_input(ref self: TContractState, person: SerdeCustomType::Person);
    fn person_output(self: @TContractState) -> SerdeCustomType::Person;
}

#[starknet::contract]
mod SerdeCustomType {
    #[storage]
    struct Storage {}

    #[derive(Drop, Serde)]
    struct Person {
        age: u8,
        name: felt252
    }

    #[abi(embed_v0)]
    impl SerdeCustomType of super::ISerdeCustomType<ContractState> {
        fn person_input(ref self: ContractState, person: Person) {
        }

        fn person_output(self: @ContractState) -> Person {
            Person {
                age: 30,
                name: 'Okhai'
            }
        }
    }
}