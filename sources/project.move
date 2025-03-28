module MyModule::MultiLingualKB {

    use aptos_framework::signer;
    use std::string;
    use std::table;

    /// Struct representing a decentralized knowledge base.
    struct KnowledgeBase has store, key {
        entries: table::Table<u8, string::String>, // Language code -> Entry mapping
    }

    /// Function to initialize a knowledge base for an account.
    public entry fun init_kb(account: &signer) {
        move_to(account, KnowledgeBase { entries: table::new<u8, string::String>() });
    }

    /// Function to add a new knowledge entry in a specific language.
    public fun add_entry(account: &signer, lang: u8, content: string::String) acquires KnowledgeBase {
        let kb = borrow_global_mut<KnowledgeBase>(signer::address_of(account));
        table::add(&mut kb.entries, lang, content);
    }

    /// Function to retrieve a stored knowledge entry for a given language.
    public fun get_entry(account: &signer, lang: u8): string::String acquires KnowledgeBase {
        let kb = borrow_global<KnowledgeBase>(signer::address_of(account));
        *(table::borrow(&kb.entries, lang)) // Dereferencing to return a `string::String`
    }
}
