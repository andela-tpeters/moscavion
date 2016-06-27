namespace :moscavion do
	desc "Task description"
	task :referesh do
		bundle exec "rake db:rollback STEP=6 && rake db:migrate && rake db:seed"
	end
end
