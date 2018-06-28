namespace :staging do
  desc 'Stop application'
  task :stop do
    within current_path do
      execute 'sudo service staging stop'
    end
  end

  desc 'Start application'
  task :start do
    within current_path do
      execute 'sudo service staging start'
    end
  end

  desc 'Restart application'
  task :restart do
    within current_path do
      execute 'sudo service staging restart'
    end
  end
end
