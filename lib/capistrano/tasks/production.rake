namespace :staging do
  desc 'Stop application'
  task :stop do
    within current_path do
      execute 'sudo service production stop'
    end
  end

  desc 'Start application'
  task :start do
    within current_path do
      execute 'sudo service production start'
    end
  end

  desc 'Restart application'
  task :restart do
    within current_path do
      execute 'sudo service production restart'
    end
  end
end
