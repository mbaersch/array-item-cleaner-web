# Array Item Cleaner (Web GTM)

**Custom Variable Template for Google Tag Manager**

Cleanup for array items with RegEx 

![Template Status](https://img.shields.io/badge/Community%20Template%20Gallery%20Status-submitted-orange) ![Repo Size](https://img.shields.io/github/repo-size/mbaersch/array-item-cleaner-web) ![License](https://img.shields.io/github/license/mbaersch/array-item-cleaner-web)

---

## Usage
- define any array or JSON string as input for a string value cleanup in selected keys (only first level keys possible).  

- define at least one RegEx for searching text to replace and a replacement text (can be blank). Multiple lines are processed in the order of definition (which might be relevant in order to get the desired result). 

- specify at least one array key for a string field to process

The return value will be an array with all source information but "redacted" string values in all keys specified. 

## Examples
- in order to replace characters like & (or &amp; in HTML notation), use `(&amp;|&)` as rule and a replacement like "and" or "+" 
- delete special characters or single or double quotes: `(®|'|"|&#39;)` , leave the replacement text blank