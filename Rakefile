require 'rake'

desc "install the dot files into user's home directory"
task :install do
  puts "updating rails.vim submodule"
  system %Q{git submodule update --init}

  replace_all = false
  Dir['*'].each do |file|
    next if %w[Rakefile README LICENSE vim-rails].include? file
    
    if File.exist?(File.join(ENV['HOME'], ".#{file}"))
      if replace_all
        replace_file(file)
      else
        print "overwrite ~/.#{file}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(file)
        when 'y'
          replace_file(file)
        when 'q'
          exit
        else
          puts "skipping ~/.#{file}"
        end
      end
    else
      link_file(file)
    end
  end

  # install rails.vim
  system %Q{ln -sf "$PWD/vim-rails/autoload/rails.vim" "vim/autoload/"}
  system %Q{ln -sf "$PWD/vim-rails/doc/rails.txt" "vim/doc/"}
  system %Q{ln -sf "$PWD/vim-rails/plugin/rails.vim" "vim/plugin/"}
end

def replace_file(file)
  system %Q{rm "$HOME/.#{file}"}
  link_file(file)
end

def link_file(file)
  puts "linking ~/.#{file}"
  system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
end
