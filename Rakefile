require 'rake'

@excluded = %w[Rakefile README README.textile LICENSE]
@replace_all = false

desc "install the dot files into user's home directory"
task :install do
  Dir['*'].each do |file|
    next if @excluded.include?(file) || File.directory?(file)
    
    if File.exist?(File.join(ENV['HOME'], ".#{file}"))	
      replace_file(file) if @replace_file
			replace_file(file) if ask?(file)
    else
      link_file(file)
    end
  end

  link_file('vim')

  # Vim plugins by tpope
  %w[vim-autoclose vim-cucumber vim-surround vim-rails vim-ruby].each do |dir|
    puts "installing #{dir}"
    system %Q{cp -f git-vimscript-installer/Rakefile #{dir}/Rakefile && cd #{dir} && rake install && cd ..}
  end

  # NERDtree gotta be all cool
  system %Q{cd "$PWD/vim-nerdtree" && rake deploy_local & cd ..}
end

desc "update the bundled git repos"
task :update do
  %w[vim-autoclose vim-cucumber vim-surround vim-rails vim-ruby].each do |dir|
    puts "updating #{dir}"
    system %Q{cd #{dir} && rake update}
  end
end

desc "remove the symlinks in $HOME"
task :uninstall do
  Dir['*'].each do |file|
    if File.exist?(File.join(ENV['HOME'], ".#{file}"))
      if @replace_all || ask?(file)
        puts "removing ~/.#{file}"
        system %Q{rm -r #{File.join(ENV['HOME'], ".#{file}") }} 
      end
    end
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
