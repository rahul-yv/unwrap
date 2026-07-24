use std::collections::HashMap;

fn group_anagrams(words: &[&str]) -> Vec<Vec<String>> {
    let mut groups: HashMap<String, Vec<String>> = HashMap::new();
    for &word in words {
        let mut chars: Vec<char> = word.chars().collect();
        chars.sort();
        let key: String = chars.into_iter().collect();
        groups.entry(key).or_default().push(word.to_string());
    }
    groups.into_values().collect()
}

fn main() {
    let result = group_anagrams(&["eat", "tea", "tan", "ate", "nat", "bat"]);
    assert_eq!(result.len(), 3);

    let total_words: usize = result.iter().map(|g| g.len()).sum();
    assert_eq!(total_words, 6);

    println!("ok");
}
