// the Typescript version of this test has conficting test cases compared to the instruction.
// The tests expect special characters to remain in words and can count as words.
// For example, according to the tests, 'The : dog' should return a Map containing { 'the' => 1, ':' => 1, 'dog' => 1 }

function splitPhrase(phrase: string): Array<string> {
  return phrase.toLowerCase().trim().split(/\s+/g);
}

export function count(input: string) {
  let wordCount = new Map<string, number>();
  splitPhrase(input).forEach((word: string) => {
    wordCount.set(word, (wordCount.get(word) ?? 0) + 1);
  });
  return wordCount;
}
