class MyFirstJob
  include Sidekiq::Job

  sidekiq_options retry: 3, queue: 'critical'

  def perform(name, age)
    puts "I am #{name} and my age is #{age}"
  end
end
