___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Array Item Cleaner",
  "categories": [
    "UTILITY"
  ],
  "description": "Cleanup array string values with RegEx",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "inputArray",
    "displayName": "Input Array",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  },
  {
    "type": "PARAM_TABLE",
    "name": "rules",
    "displayName": "Replacement Rules",
    "paramTableColumns": [
      {
        "param": {
          "type": "TEXT",
          "name": "rule",
          "displayName": "RegEx",
          "simpleValueType": true
        },
        "isUnique": true
      },
      {
        "param": {
          "type": "TEXT",
          "name": "replacement",
          "displayName": "Replacement Text",
          "simpleValueType": true
        },
        "isUnique": false
      }
    ],
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  },
  {
    "type": "SIMPLE_TABLE",
    "name": "keyNames",
    "displayName": "Item Cleanup Keys",
    "simpleTableColumns": [
      {
        "defaultValue": "",
        "displayName": "Field / Key",
        "name": "keyName",
        "type": "TEXT"
      }
    ],
    "help": "Specify one or more keys for string values to clean up",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const Object = require('Object');
const cleanUpString = function(s) {
  var rs = s;
  data.rules.forEach(function(r){
    const found = rs.match(r.rule);
    if(found) {
      if (typeof(found) === 'string') rs = rs.replace(found, r.replacement||"");
      else found.forEach(f => {
        rs = rs.replace(f, r.replacement||"");
      });
    }
  });
  return rs;
};

var it = data.inputArray;
if (typeof(it) === "string") it = require('JSON').parse(it);
for(var i=0;i<it.length;i++){
  var itm = it[i];
  data.keyNames.forEach(kn => {
    if (itm[kn.keyName]) itm[kn.keyName] = cleanUpString(itm[kn.keyName]);
  });
}
return it;


___TESTS___

scenarios:
- name: Multiple instances
  code: "const mockData = {\n  inputArray: '[{\"item_name\":\"This & That | A Foo\
    \ & Bar Product\", \"item_id\":\"123\"}]',\n  rules: [{rule: '(&)', replacement:\
    \ '+'}],\n  keyNames: [{keyName: 'item_name'}]  \n};\n\nlet variableResult = runCode(mockData);\n\
    assertThat(variableResult).isEqualTo([{\"item_name\":\"This + That | A Foo + Bar\
    \ Product\",\"item_id\":\"123\"}]);"


___NOTES___

Created on 21.8.2022, 16:46:54
