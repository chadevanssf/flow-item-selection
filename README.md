# flow-item-selection

Wondering how you can present your users with a set of options, and have them select one or more, and process the result? This is a set of Flow Templates and associated Lightning Component that will help solve those use cases for you.

## Setup

## Scratch Org Deployment

```sh
sfdx force:user:permset:assign -n ItemSelector
sfdx force:data:tree:import -p ./data/Account-plan.json
```

## Development

```sh
sfdx force:user:permset:assign -n ItemSelector
sfdx force:data:tree:export -q ./data/accounts.soql -p -d ./data/
```
