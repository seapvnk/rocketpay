defmodule RocketpayWeb.AccountsView do
    alias Rocketpay.Account
    alias Rocketpay.Accounts.Transactions.Reponse, as: TransactionResponse
    
    def render("update.json", %{account: %Account{ id: account_id, balance: balance } }) do
        %{
            message: "Balance changed successfully",
            account: %{
                account_id: account_id,
                balance: balance
            }
        }
    end

    def render("transaction.json", %{transaction: %{to_account: to_account, from_account: from_account} }) do
        %{
            message: "Transaction done successfully",
            transaction: %TransactionResponse{
                from_account: %{
                    id: from_account.id,
                    balance: from_account.balance
                },
                to_account: %{
                    id: to_account.id,
                    balance: to_account.balance
                }
            }
        }
    end
end