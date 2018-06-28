namespace :staging do
  desc 'Stop staging application'
  task :stop do
    on roles(:app), in: :sequence, wait: 5 do
      within current_path do
        execute 'sudo service staging stop'
      end
    end
  end

  desc 'Start staging application'
  task :start do
    on roles(:app), in: :sequence, wait: 5 do
      within current_path do
        execute 'sudo service staging start'
      end
    end
  end

  desc 'Restart staging application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      within current_path do
        execute 'sudo service staging restart'
      end
    end
  end
end
