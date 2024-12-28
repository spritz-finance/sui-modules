module 0x0::memo_module {
    use sui::event;

    /// Custom error for invalid memo length
    const EInvalidMemoLength: u64 = 1;

    /// Represents a memo event that will be emitted when a memo is created
    /// Contains the sender's address and the memo content
    /// 
    /// # Fields
    /// * `sender`: The address of the account that created the memo
    /// * `memo`: The content of the memo as a byte vector (must be 12 bytes)
    public struct MemoEvent has drop, store, copy {
        sender: address,
        memo: vector<u8>,
    }

    /// Emits a memo event with the provided memo content
    /// The memo must be exactly 12 bytes long
    /// 
    /// # Arguments
    /// * `memo`: The content of the memo as a byte vector
    /// * `ctx`: The transaction context
    /// 
    /// # Errors
    /// * `EInvalidMemoLength`: If the memo is not exactly 12 bytes
    public entry fun emit_memo(
        memo: vector<u8>, 
        ctx: &TxContext
    ) {
        // Validate memo length - must be exactly 12 bytes
        assert!(vector::length(&memo) == 12, EInvalidMemoLength);
    
        let sender = tx_context::sender(ctx);

        // Emit the memo event
        event::emit(MemoEvent { 
            sender, 
            memo 
        });
    }

    // === Test Functions ===
    #[test_only]
    /// Function used for testing memo creation
    public fun test_emit_memo(
        memo: vector<u8>, 
        ctx: &TxContext
    ): MemoEvent {
        MemoEvent { 
            sender: tx_context::sender(ctx), 
            memo 
        }
    }
}