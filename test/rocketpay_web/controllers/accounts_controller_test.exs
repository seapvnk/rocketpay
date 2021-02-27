defmodule RocketpayWeb.AccountsControllerTest do
    use RocketpayWeb.ConnCase, async: true

    alias Rocketpay.{Account, User}

    describe "deposit/2" do
        setup %{conn: conn} do
            params = %{
                name: "Pedro",
                password: "123456789",
                nickname: "seapvnk",
                email: "www.psro@gmail.com",
                age: 19
            }

            {:ok, %User{account: %Account{id: account_id}}} = Rocketpay.create_user(params)

            conn = put_req_header(conn, "authorization", "Basic cm9ja2V0cGF5OnJwMTIz")

            {:ok, conn: conn, account_id: account_id}
        end

        test "when all params are valid, make the deposit", %{conn: conn, account_id: account_id} do
            params = %{"value" => "50.00"}
            
            response = 
                conn
                |> post(Routes.accounts_path(conn, :deposit, account_id, params))
                |> json_response(:ok)

            assert %{
                "account" => %{"balance" => "50.00"},
                "message" => "Balance changed successfully"
            } = response
        end

        test "when there are invalid params, returns an error", %{conn: conn, account_id: account_id} do
            params = %{"value" => "hmm"}
            
            response = 
                conn
                |> post(Routes.accounts_path(conn, :deposit, account_id, params))
                |> json_response(:bad_request)

            expected_response = %{"message" => "Invalid deposit value!"}
            assert expected_response == response
        end
    end
    
end