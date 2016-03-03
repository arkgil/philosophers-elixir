defmodule Chopstick do
  use GenServer

  # API
  def start_link do
    GenServer.start_link(__MODULE__, :free)
  end

  def get_state(pid) do
    GenServer.call(pid, :get_state)
  end

  def take(pid) do
    GenServer.call(pid, :take)
  end

  def free(pid) do
    GenServer.cast(pid, :free)
  end

  # GenServer callbacks
  def handle_call(:get_state, _from, state) do
    {:reply, state, state}
  end

  def handle_call(:take, _from, :free) do
    {:reply, :ok, :taken}
  end

  def handle_call(:take, _from, :taken) do
    {:reply, {:not_ok, :taken}, :taken}
  end

  def handle_cast(:free, _) do
    {:noreply, :free}
  end
end
