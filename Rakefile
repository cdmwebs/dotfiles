require 'rake'

desc "install the dot files into user's home directory"
task :install do
  system %Q{git submodule update --init}

  replace_all = false
  Dir['*'].each do |file|
    next if %w[Rakefile README README.textile LICENSE git-vimscript-installer vim-autoclose vim-cucumber 
	       vim-nerdtree vim-rails vim-surround vim-ruby].include? file
    
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

  # Vim plugins
  %w[vim-autoclose vim-cucumber vim-nerdtree vim-surround vim-ruby].each do |dir|
    system %Q{ln -s "$PWD/git-vimscript-installer/Rakefile" "#{dir}/Rakefile"}
    system %Q{cd "$PWD/#{dir}" && rake install && cd ..}
  end

  # rails.vim includes it's own rake task
  system %Q{cd "$PWD/vim-rails" && rake install && cd ..}
end

def replace_file(file)
  system %Q{rm "$HOME/.#{file}"}
  link_file(file)
end

def link_file(file)
  puts "linking ~/.#{file}"
  system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
end
