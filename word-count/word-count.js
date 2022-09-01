const splitPhrase = (phrase) => {

  // Remove all non a-z, 0-9, or ' characters.
  // Cannot use \w\d because \w will not remove the _ character
  phrase = phrase.toLowerCase().replace(/[^a-z0-9']/g, ' ').trim();

  // split on any whitespace character, greedy in case of multiple spaces in a row
  return phrase.split(/\s+/g).map(word => {
   
    // the first replace left the ' character in case of contractions.
    // remove any being used as quotation marks at the start or end of the word
    return word.replace(/^'|'$/g, '');
  });
}

export const countWords = (input) => {
  let wordCount = new Map();
  splitPhrase(input).forEach(word => {
    wordCount.set(word, (wordCount.get(word) ?? 0) + 1);
  });
  return Object.fromEntries(wordCount);
};
