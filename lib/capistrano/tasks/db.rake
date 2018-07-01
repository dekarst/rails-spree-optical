namespace :db do
    desc "Seed the database."
    task :seed do
        on roles(:web) do
            within current_path do
                with rails_env: fetch(:rails_env) do
                    execute :rake, 'db:seed'
                end
            end
        end
    end

    desc "Clear the database."
    task :clear do
        raise Exception.new("Not allowed in production environment") if fetch(:rails_env) == :production

        on roles(:web) do
            within current_path do
                with rails_env: fetch(:rails_env) do
                    execute :rake, 'db:drop'
                    execute :rake, 'db:create'
                    execute :rake, 'db:migrate'
                end
            end
        end
    end
end
