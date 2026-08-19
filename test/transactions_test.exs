defmodule TansactionsTest do
  use ExUnit.Case
  import Transactions


    test "test successful transactions" do
      transactions = [
        %{id: 1, type: :debit, amount: 500, status: :failed},
        %{id: 2, type: :credit, amount: 1000, status: :failed},
        %{id: 3, type: :debit, amount: 2000, status: :failed},
        %{id: 4, type: :debit, amount: 1500, status: :success},
        %{id: 5, type: :credit, amount: 3000, status: :success},
        %{id: 6, type: :debit, amount: 1000, status: :failed},
        %{id: 7, type: :credit, amount: 500, status: :success},
        %{id: 8, type: :debit, amount: 2000, status: :failed},
        %{id: 9, type: :credit, amount: 1500, status: :success},
        %{id: 10, type: :debit, amount: 2500, status: :success}
      ]
      assert successful_transactions(transactions) == [
        %{id: 4, type: :debit, amount: 1500, status: :success},
        %{id: 5, type: :credit, amount: 3000, status: :success},
        %{id: 7, type: :credit, amount: 500, status: :success},
        %{id: 9, type: :credit, amount: 1500, status: :success},
        %{id: 10, type: :debit, amount: 2500, status: :success}
      ]
    end

    test "test failed transactions" do
      transactions = [
        %{id: 1, type: :debit, amount: 500, status: :failed},
        %{id: 2, type: :credit, amount: 1000, status: :failed},
        %{id: 3, type: :debit, amount: 2000, status: :failed},
        %{id: 4, type: :debit, amount: 1500, status: :success},
        %{id: 5, type: :credit, amount: 3000, status: :success},
        %{id: 6, type: :debit, amount: 1000, status: :failed},
        %{id: 7, type: :credit, amount: 500, status: :success},
        %{id: 8, type: :debit, amount: 2000, status: :failed},
        %{id: 9, type: :credit, amount: 1500, status: :success},
        %{id: 10, type: :debit, amount: 2500, status: :success}
      ]
      assert failed_transactions(transactions) == [
        %{id: 1, type: :debit, amount: 500, status: :failed},
        %{id: 2, type: :credit, amount: 1000, status: :failed},
        %{id: 3, type: :debit, amount: 2000, status: :failed},
        %{id: 6, type: :debit, amount: 1000, status: :failed},
        %{id: 8, type: :debit, amount: 2000, status: :failed}
      ]
    end

    test "test update successful transactions" do
      transactions = [
        %{id: 1, type: :debit, amount: 500, status: :failed},
        %{id: 2, type: :credit, amount: 1000, status: :failed},
        %{id: 3, type: :debit, amount: 2000, status: :failed},
        %{id: 4, type: :debit, amount: 1500, status: :success},
        %{id: 5, type: :credit, amount: 3000, status: :success},
        %{id: 6, type: :debit, amount: 1000, status: :failed},
        %{id: 7, type: :credit, amount: 500, status: :success},
        %{id: 8, type: :debit, amount: 2000, status: :failed},
        %{id: 9, type: :credit, amount: 1500, status: :success},
        %{id: 10, type: :debit, amount: 2500, status: :success}
      ]
      assert update_successful_transactions(transactions) == [
        %{id: 4, type: :debit, amount: 6500, status: :success},
        %{id: 5, type: :credit, amount: 3000, status: :success},
        %{id: 7, type: :credit, amount: 5500, status: :success},
        %{id: 9, type: :credit, amount: 6500, status: :success},
        %{id: 10, type: :debit, amount: 2500, status: :success}
      ]
    end

    test "test total amount of successful and failed transactions" do
      transactions = [
        %{id: 1, type: :debit, amount: 500, status: :failed},
        %{id: 2, type: :credit, amount: 1000, status: :failed},
        %{id: 3, type: :debit, amount: 2000, status: :failed},
        %{id: 4, type: :debit, amount: 1500, status: :success},
        %{id: 5, type: :credit, amount: 3000, status: :success},
        %{id: 6, type: :debit, amount: 1000, status: :failed},
        %{id: 7, type: :credit, amount: 500, status: :success},
        %{id: 8, type: :debit, amount: 2000, status: :failed},
        %{id: 9, type: :credit, amount: 1500, status: :success},
        %{id: 10, type: :debit, amount: 2500, status: :success}
    ]

    assert total_success_amount(successful_transactions(transactions)) == 9000
    assert total_failed_amount(failed_transactions(transactions)) == 6500

  end

  test "test print successful transactions" do
    transactions = [
      %{id: 1, type: :debit, amount: 500, status: :failed},
      %{id: 2, type: :credit, amount: 1000, status: :failed},
      %{id: 3, type: :debit, amount: 2000, status: :failed},
      %{id: 4, type: :debit, amount: 1500, status: :success},
      %{id: 5, type: :credit, amount: 3000, status: :success},
      %{id: 6, type: :debit, amount: 1000, status: :failed},
      %{id: 7, type: :credit, amount: 500, status: :success},
      %{id: 8, type: :debit, amount: 2000, status: :failed},
      %{id: 9, type: :credit, amount: 1500, status: :success},
      %{id: 10, type: :debit, amount: 2500, status: :success}
    ]

    assert print_successful_transactions(transactions) == :ok
  end



end
