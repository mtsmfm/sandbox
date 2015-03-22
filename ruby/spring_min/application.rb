class Application
  def preloaded?
    !!@preloaded
  end

  def preload(&block)
    block.call

    @preloaded = true
  end

  def serve(&block)
    preload unless preloaded?

    pid = fork {
      block.call
    }
    Process.waitpid(pid)
  end
end

app = Application.new
app.preload { load 'csv.rb' }
app.serve { p %w(a b c).to_csv }
# "a,b,c\n"
app.serve { $foo = true; p $foo }
# true
p $foo
# nil
