defmodule ReverseProxy.RunnerTest do
  use ExUnit.Case
  use Plug.Test

  test "retreive/2 - plug - success" do
    conn = conn(:get, "/")

    conn = ReverseProxy.Runner.retreive(
      conn,
      {ReverseProxyTest.SuccessPlug, []}
    )

    assert conn.status == 200
    assert conn.resp_body == "success"
  end

  test "retreive/2 - plug - failure" do
    conn = conn(:get, "/")

    conn = ReverseProxy.Runner.retreive(
      conn,
      {ReverseProxyTest.FailurePlug, []}
    )

    assert conn.status == 500
    assert conn.resp_body == "failure"
  end

  test "retreive/3 - http - success" do
    conn = conn(:get, "/")

    conn = ReverseProxy.Runner.retreive(
      conn,
      ["localhost"],
      ReverseProxyTest.SuccessHTTP
    )

    assert conn.status == 200
    assert conn.resp_body == "success"
  end

  test "retreive/3 - http - failure" do
    conn = conn(:get, "/")

    conn = ReverseProxy.Runner.retreive(
      conn,
      ["localhost"],
      ReverseProxyTest.SuccessHTTP
    )

    assert conn.status == 502
    assert conn.resp_body == "Bad Gateway"
  end
  end
end
