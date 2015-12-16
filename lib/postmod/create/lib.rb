Postmod::Create::Lib = Postmod::Action.new(:lib_root_path) do

  def call
    Postmod::Generate::Module.(lib_root_path)
  end

  private

  def lib_path
    root_module_path

  end


end
