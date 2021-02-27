defmodule RocketpayWeb.UsersViewTest do
    use RocketpayWeb.ConnCase, async: true

    import Phoenix.View

    alias Rocketpay.{User, Account}
    
    test "renders create.json" do
        params = %{
            name: "Pedro",
            password: "123456789",
            nickname: "seapvnk",
            email: "www.psro@gmail.com",
            age: 19
        }

        {:ok, %User{id: user_id, account: %Account{id: account_id}} = user} = Rocketpay.create_user(params)
        
        response = render(RocketpayWeb.UsersView, "create.json", user: user)

        expected_response = %{
            message: "User created", 
            user: %{
                account: %{
                    account_id: account_id, 
                    balance: Decimal.new("0.00")
                }, 
                id: user_id, 
                name: "Pedro", 
                nickname: "seapvnk"
            }
        }

        assert expected_response == response
    end
    
end