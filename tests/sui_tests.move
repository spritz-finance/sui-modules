#[test_only]
module 0x8ec6b122474ff451ab1e0559e2c7afe74a76b8f795c7e7ebe00b6c1c9f98f7d0::memo_tests {
    use sui::test_scenario;
    use 0x8ec6b122474ff451ab1e0559e2c7afe74a76b8f795c7e7ebe00b6c1c9f98f7d0::memo_module;

    #[test]
    fun test_valid_memo() {
        let mut scenario = test_scenario::begin(@0x1);
        let ctx = test_scenario::ctx(&mut scenario);
        
        // Create a valid 12-byte memo
        let mut memo = vector::empty();
        let mut i = 0;
        while (i < 12) {
            vector::push_back(&mut memo, i as u8);
            i = i + 1;
        };
        
        memo_module::emit_memo(memo, ctx);
        test_scenario::end(scenario);
    }

    #[test]
    #[expected_failure(abort_code = memo_module::EInvalidMemoLength)]
    fun test_invalid_memo_length() {
        let mut scenario = test_scenario::begin(@0x1);
        let ctx = test_scenario::ctx(&mut scenario);
        
        let mut memo = vector::empty();
        vector::push_back(&mut memo, 0);
        
        memo_module::emit_memo(memo, ctx);
        test_scenario::end(scenario);
    }
}
