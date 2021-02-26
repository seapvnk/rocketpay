defmodule Rocketpay.Accounts.Withdraw do
    alias Rocketpay.Repo
    alias Rocketpay.Accounts.Operation
    
    def call(params) do
        params
        |> Operation.call(:withdraw)
        |> run_transaction()
    end

    defp run_transaction(multi) do
        case Repo.transaction(multi) do
            {:error, __operation, reason, _changes} -> {:error, reason}
            {:ok, %{account_withdraw: account}} -> {:ok, account}
        end
    end
end