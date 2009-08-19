require 'rake'

desc "install the dot files into user's home directory"
task :install do
  system %Q{git submodule update --init}

  @replace_all = false
  Dir['*'].each do |file|
    next if %w[Rakefile README README.textile LICENSE].include?(file) || File.directory?(file)
    
    if File.exist?(File.join(ENV['HOME'], ".#{file}"))
      if @replace_all
        replace_file(file)
      else
        replace_file(file) if ask?(file)
      end
    else
      link_file(file)
    end
  end

  # NERDtree gotta be all cool
  system %Q{cd "$PWD/vim-nerdtree" && rake deploy_local & cd ..}

  # Vim plugins by tpope
  %w[vim-autoclose vim-cucumber vim-surround vim-rails vim-ruby].each do |dir|
    system %Q{cd "$PWD/#{dir}" && rake install && cd ..}
  end
end

def replace_file(file)
  system %Q{rm "$HOME/.#{file}"}
  link_file(file)
end

def link_file(file)
  puts "linking ~/.#{file}"
  system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
end

def ask?(file)
  print "overwrite ~/.#{file}? [ynaq] "
  case $stdin.gets.chomp
  when 'a'
    @replace_all = true
    return true
  when 'y'
    return true
  when 'q'
    exit
  else
    puts "skipping ~/.#{file}"
  end
end
