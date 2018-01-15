defmodule ChessWeb.FeatureCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use ChessWeb.ConnCase

      use Hound.Helpers
      hound_session()
    end
  end
end
