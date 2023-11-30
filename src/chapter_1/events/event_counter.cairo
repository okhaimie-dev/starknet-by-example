#[starknet::interface]
trait IEventCounter<TContractState> {
    fn increment(ref self: TContractState);
}

#[starknet::contract]
mod EventCounter {
    use starknet::{get_caller_address, ContractAddress};
    #[storage]
    struct Storage {
        counter: u128,
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        CounterIncreased: CounterIncreased,
        UserIncreaseCounter: UserIncreaseCounter
    }

    #[derive(Drop, starknet::Event)]
    struct CounterIncreased {
        amount: u128,
    }

    #[derive(Drop, starknet::Event)]
    struct UserIncreaseCounter {
        #[key]
        user: ContractAddress,
        new_value: u128 
    }

    #[abi(embed_v0)]
    impl EventCounter of super::IEventCounter<ContractState> {
        fn increment(ref self: ContractState) {
            let mut counter = self.counter.read();
            counter += 1;
            self.counter.write(counter);

            self.emit(Event::CounterIncreased(CounterIncreased { amount: 1 }));
            self
                .emit(
                    Event::UserIncreaseCounter(
                        UserIncreaseCounter { 
                            user: get_caller_address(), new_value: self.counter.read() }));
        }
    }
}