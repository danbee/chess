defmodule Chess.FeatureCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Chess.ConnCase

      use Hound.Helpers
      hound_session()
    end
  end
end
