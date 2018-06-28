namespace :production do
  desc 'Stop production application'
  task :stop do
    on roles(:app), in: :sequence, wait: 5 do
      within current_path do
        execute 'sudo service production stop'
      end
    end
  end

  desc 'Start production application'
  task :start do
    on roles(:app), in: :sequence, wait: 5 do
      within current_path do
        execute 'sudo service production start'
      end
    end
  end

  desc 'Restart production application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      within current_path do
        execute 'sudo service production restart'
      end
    end
  end
end
