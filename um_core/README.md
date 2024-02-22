# Unified Money frontend API

## `unified_money.account_exists(name)`

Ask if the account of the given `name` exists. Return boolean indicating existence.

## `unified_money.ensure_exists(name)`

Create an account of the given `name` if one did not exist. Return `true` if the creation was successful or there were one.

## `unified_money.create_account(name,default_value)`

Create an account of the given `name` and set its default value. If one already exists, it is identical as `unified_money.set_balance(name,default_value)`.

## `unified_money.delete_account(name)`

Delete the account of the given `name`. Return `true` if the account was successfully deleted or there weren't one.

## `unified_money.list_accounts()`

Return a list of account names.

## `unified_money.get_balance(name)`

Return account balance of the account of the given `name`. Return `false` if the account is not found.

## `unified_money.get_balance_safe(name)`

Return account balance of the account of the given `name`. A `0` will be returned in case if the account is not found.

## `unified_money.set_balance(name,val[, forced])`

Set the balance of the account of the given `name`. If `forced` is `true`, create and account if not exist. Return `false` if the account is not found.

## `unified_money.set_balance_safe(name,val)`

Set the balance of the account of the given `name`. An account is created if one is not found.

## `unified_money.add_balance(name,val)`, `unified_money.add_balance_safe(name,val)`

Add balance of the account of the given `name`. Refer to their `set_balance` variant for more detail.

## `unified_money.del_balance(name,val)`, `unified_money.del_balance_safe(name,val)`

Delete balance of the account of the given `name`. Refer to their `set_balance` variant for more detail.

## `unified_money.transaction(from,to,amount)`

Do a transaction from the account `from` to the account `to`. The `amount` must be positive.

This function checks for remaining balance of the `from` account, so use this function instead of crafting API calls yourself.

Return boolean indicating success. If failed, the second returned value can be one of the following:

* `"AMOUNT_NEG"`: The given `amount` is negative.
* `"ACCOUNT_NF"`: One or both of the `from` and/or `to` account(s) do(es) not exist.
* `"FROM_NO_MONEY"`: The `from` account have not enough money to complete the transaction.
