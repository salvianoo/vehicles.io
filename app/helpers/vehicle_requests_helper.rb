helpers do
  def foo(bar, attribute)
    bar[:request].send(attribute) unless bar.empty?
  end
end
